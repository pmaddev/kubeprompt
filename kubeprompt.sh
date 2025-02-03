# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc
export PATH="$PATH:/usr/local/bin/:/usr/sbin/"
# ===[ KUBERNETES MULTI-CLUSTER CONFIGURATION ]=== #

# defaults to default namespace
export CURRENT_NAMESPACE="default"
# Enable kubectl autocompletion (if available)
if command -v kubectl &>/dev/null; then
    source <(kubectl completion bash)
fi

# Define the kubeconfig path
export KUBECONFIG=""

# Directory containing kubeconfigs
KUBE_CONFIG_DIR="$HOME/.kube"

# Function to get the short name for a kubeconfig (maps clusters)
function get_kube_short_name() {
    case "$(basename "$KUBECONFIG")" in
        config1) echo "[k-1]" ;;
        config2) echo "[k-2]" ;;
        config3) echo "[k-3]" ;;
        config4) echo "[k-4]" ;;
	*) echo "[k-1]" ;;
    esac
}

# Function to get the default namespace for the current cluster
function get_kube_namespace() {
    local kube_namespace
    kube_namespace="$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)"
    [[ -z "$kube_namespace" ]] && kube_namespace="default"  # Default to "default" if none is set
    echo "$kube_namespace"
}

# Function to get the current Kubernetes context (cluster)
function get_kube_context() {
    local kube_context
    kube_context="$(kubectl config current-context 2>/dev/null)"
    [[ -z "$kube_context" ]] && kube_context="none"
    echo "$kube_context"
}

# Function to update the shell prompt dynamically (both Cluster & Namespace)
function update_kube_prompt() {
    local kube_short_name
    local kube_namespace

    # Get short cluster name
    kube_short_name=$(get_kube_short_name)

    # Get the current namespace
    #kube_namespace=$(get_kube_namespace)
    kube_namespace=$CURRENT_NAMESPACE

    # Update the prompt with both cluster and namespace
    export PS1="\[\033[1;32m\]\u@\h \[\033[1;34m\][\W] \[\033[1;33m\]$kube_short_name | $CURRENT_NAMESPACE\[\033[0m\] \$ "
}

# Function to switch clusters and reset to its default namespace
function use_kubeconfig() {
    local config_file="$KUBE_CONFIG_DIR/$1"
    if [[ -f "$config_file" ]]; then
        export KUBECONFIG="$config_file"
        kubectl config use-context "$(kubectl config current-context)" 2>/dev/null || echo "No context set in this kubeconfig"

        # Reset namespace to default for this cluster
        kubectl config set-context --current --namespace=$CURRENT_NAMESPACE 2>/dev/null

        update_kube_prompt
        echo "Switched to Kubernetes config: $config_file"
    else
        echo "Error: Config file '$config_file' not found."
    fi
}

# Function to switch Kubernetes namespace and update prompt
# Function to switch Kubernetes namespace and update prompt
function kn() {
	local new_namespace="$@"
	export CURRENT_NAMESPACE="$new_namespace"
	command kubens "$new_namespace" && update_kube_prompt

}

# Function to switch Kubernetes context and reset namespace
function kc() {
    command kubectx "$@" && kubectl config set-context --current --namespace=default && update_kube_prompt
}

# Aliases for quick cluster switching
alias k1="use_kubeconfig config1"
alias k2="use_kubeconfig config2"
alias k3="use_kubeconfig config3"
alias k4="use_kubeconfig config4"

# Dynamic alias to list available kubeconfigs
alias klist='ls -1 $HOME/.kube/config*'

# Display current Kubeconfig
alias kcur='echo "Current KUBECONFIG: $KUBECONFIG"'

# Alias to clear KUBECONFIG
alias kclear='unset KUBECONFIG && echo "KUBECONFIG unset." && update_kube_prompt'

# Shortcut for common kubectl commands
alias k='kubectl'
alias kg='kubectl get'
alias kgp='kubectl get pods'
alias kgd='kubectl get deployments'
alias kgn='kubectl get nodes'
alias kgs='kubectl get services'
alias kga='kubectl get all'

# Enable kubectl autocompletion for aliases
complete -F __start_kubectl k kg kgp kgd kgn kgs kga

# Hook to auto-update namespace and cluster on every command execution
PROMPT_COMMAND="update_kube_prompt"

# Update prompt at shell startup
update_kube_prompt

# Reload the bashrc after modification
alias reload='source ~/.bashrc && echo "Bashrc reloaded!"'

# ===[ END OF KUBERNETES CONFIGURATION ]=== #

# Ensure completion works for kubectl, kubectx, and kubens
complete -F __start_kubectl k
source /opt/kubectx/completion/kubectx.bash
source /opt/kubectx/completion/kubens.bash


# 🚀 kubeprompt - Kubernetes Context & Namespace Aware Shell Prompt

`kubeprompt` is a Bash script that dynamically updates your shell prompt to display the **current Kubernetes cluster and namespace**.  
It enhances usability by providing **quick commands to switch contexts, namespaces, and clusters** efficiently.

---

## 📌 Features
✅ **Dynamic Kubernetes-aware prompt** displaying the active cluster & namespace  
✅ **Quick context switching** with `kc` and **namespace switching** with `kn`  
✅ **Aliases for frequently used `kubectl` commands** (`k`, `kgp`, `kgd`, etc.)  
✅ **Retains last used namespace per cluster** instead of resetting to `default`  
✅ **Autocompletion support for `kubectl`, `kubectx`, and `kubens`  

## 📥 Prerequisites

## To enable Bash completion for kubectl and aliases, run:

```sh
sudo yum install -y bash-completion # For redhat or centos
exec bash    # Restart shell for changes to take effect
type _get_comp_words_by_ref  # Check if Bash completion is working
echo 'source <(kubectl completion bash)' >> ~/.bashrc
source ~/.bashrc  # Reload Bash settings
```

## Enable Shortcuts for kubectl

```sh
alias k='kubectl'  # Set 'k' as a shortcut for kubectl
complete -F __start_kubectl k  # Enable autocompletion for alias 'k'
echo 'complete -F __start_kubectl k' >> ~/.bashrc  # Persist autocompletion
```

## Install kubectx and kubens for Context/Namespace Switching

```sh
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens
echo "source /opt/kubectx/completion/kubectx.bash" >> ~/.bashrc
echo "source /opt/kubectx/completion/kubens.bash" >> ~/.bashrc
source ~/.bashrc
```

## 📥 Installation

### 1️⃣ Clone the Repository
```sh
git clone https://github.com/yourusername/kubeprompt.git
cd kubeprompt
```


# 🚀 kubeprompt

A shell prompt extension for Kubernetes users that displays the current Kubernetes cluster and namespace in your terminal prompt.

## 📌 Installation

### Add to Your `.bashrc` or `.bash_profile`

For Linux (`.bashrc`):

```sh
echo "source ~/kubeprompt/kubeprompt.sh" >> ~/.bashrc
source ~/.bashrc
```

For macOS (`.bash_profile`):

```sh
echo "source ~/kubeprompt/kubeprompt.sh" >> ~/.bash_profile
source ~/.bash_profile
```

## 🖥️ Example Prompt

After installing, your shell prompt will look like this:

```sh
user@machine [~/work] [k-1] | kube-system $
```

- `[k-1]` → Shows the current Kubernetes cluster (config1, config2, etc.).
- `kube-system` → Displays the active namespace.

## ⚡ Usage

### 1️⃣ Switch Clusters

Switch between Kubernetes clusters using:

```sh
k1    # Switch to cluster 1
k2    # Switch to cluster 2
k3    # Switch to cluster 3
k4    # Switch to cluster 4
```

The prompt updates immediately with the new cluster and retains the last used namespace.

Example Scenario:

```sh
user@machine [~/work] [k-1] | default $
$ k2
Switched to Kubernetes config: ~/.kube/config2 with namespace: default
user@machine [~/work] [k-2] | default $
```

### 2️⃣ Switch Kubernetes Context

```sh
kc my-cluster
```

Switches to the given Kubernetes context while preserving the current namespace.

Example Scenario:

```sh
user@machine [~/work] [k-1] | default $
$ kc my-new-cluster
Switched to Kubernetes context: my-new-cluster
user@machine [~/work] [k-3] | default $
```

### 3️⃣ Change Kubernetes Namespace

```sh
kn kube-system
```

Changes the current namespace to `kube-system`.

Example Scenario:

```sh
user@machine [~/work] [k-1] | default $
$ kn kube-system
Switched to namespace: kube-system
user@machine [~/work] [k-1] | kube-system $
```

### 4️⃣ List Available Kubernetes Configs

```sh
klist
```

Shows available kubeconfigs stored in `~/.kube/`.

Example Output:

```sh
config1
config2
config3
config4
```

### 5️⃣ Check Active Kubeconfig

```sh
kcur
```

Displays the currently used Kubernetes configuration.

Example Output:

```sh
Current KUBECONFIG: ~/.kube/config2
```

### 6️⃣ Reset or Clear Kubeconfig

```sh
kclear
```

Unsets the current `KUBECONFIG` variable.

## 🔧 Built-in Aliases

| Command | Description |
|---------|------------|
| `k` | Alias for `kubectl` |
| `kg` | Alias for `kubectl get` |
| `kgp` | Get all pods (`kubectl get pods`) |
| `kgd` | Get all deployments (`kubectl get deployments`) |
| `kgn` | Get all nodes (`kubectl get nodes`) |
| `kgs` | Get all services (`kubectl get services`) |
| `kga` | Get all Kubernetes objects (`kubectl get all`) |

## 🎯 How It Works

### ✅ Automatically Updates Prompt

- Displays current Kubernetes cluster and namespace.
- Uses short names `[k-1]`, `[k-2]` instead of long `kubernetes-admin@cluster-name`.

### ✅ Preserves the Last Used Namespace

- If you switch from `k1` to `k2`, the namespace remains the same.

### ✅ Seamless Integration with `kubectx` and `kubens`

- Uses `kubectx (kc)` for context switching.
- Uses `kubens (kn)` for namespace switching.

### ✅ Full Autocompletion Support

- Works with `kubectl`, `kubectx`, and `kubens`.

## 📌 Requirements

Make sure the following tools are installed:

### Install `kubectl`

```sh
sudo apt install -y kubectl  # Debian/Ubuntu
brew install kubectl         # macOS
```

### Install `kubectx` & `kubens` (For context & namespace switching)

```sh
sudo apt install kubectx    # Debian/Ubuntu
brew install kubectx        # macOS
```

## 🐛 Troubleshooting

### 🔹 Issue: Namespace not updating in the prompt

Try running:

```sh
source ~/.bashrc
kn kube-system
```

If the issue persists, restart your terminal.

## 💡 Contributions

Feel free to fork and submit a Pull Request! 🚀  
If you have ideas for improvements, create an Issue in the repository.

## 📜 License

This project is licensed under the MIT License.

## 🚀 Start Using kubeprompt Today!

Now, you can manage Kubernetes clusters and namespaces efficiently with a single glance at your terminal!  
🔥 **Star the repository on GitHub and spread the word!** 🔥

📌 **GitHub Repository**: [https://github.com/pmaddev/kubeprompt](https://github.com/pmaddev/kubeprompt)

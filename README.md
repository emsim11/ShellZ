# ShellZ

A **modular**, **zero-dependency**, and **high-performance** [*Zsh*](https://www.zsh.org/) framework engineered for maximum control, clarity, and customization. Built for power users who want maintainable, transparent, and auditable shell environments.

---

## 📖 Getting Started

1. **Clone the Framework**

```Bash
git clone https://github.com/emsim11/ShellZ.git ~/ShellZ
```

1. **Source Entrypoint in .zshenv**

```ZSH
source ~/ShellZ/Lib/Init.zsh
```

3. **Run Initial Bootstrap/Setup**

```ZSH
ShellZ bootstrap
```

4. **Restart Shell**

---

## ⚙️ Key Features

- ☑️ One-function-per-file modularity
- ☑️ Autoloading via `fpath`
- ☑️ Dry-run and confirmation flags for safe operation
- ☑️ Timestamped backups before modifying any file
- ☑️ Global logger with color-coded output and severity logging
- ☑️ Persistent log output (`Log/`) with timestamped reports

---

## 📂 Directory Details

### `Backup/`

Timestamped backups of any files the framework overwrites or modifies, such as `~/.zshrc`, `~/.zprofile`, etc. to provide a safety net for reverting to a previous working state if an update or configuration change goes awry.

**Use Case:** Roll back changes safely.

### `Cache/`

Ephemeral data, such as downloaded assets, command outputs, etc. tht are used to speed up repeated operations and improve overall framework performance. The contents are typically considered non-essential and can be cleared without losing core configurations.

**Use Case:** Avoid re-downloading/rehashing on every shell start.

### `Custom/`

A sandbox for users to personalize their Zsh environment beyond what the framework provides out-of-the-box.  Drop in any `.zsh` files here to override and take precedence over the framework's defaults. Use it to add personalized configurations, functions, aliases, and scripts that extend the core framework and external plugins. Files in this directory and loaded and integrated seamlessly.

**Use Case:** Add custom aliases, functions, or weak behaviors without touching core code.

### `Lib/`

**Heart of the framework**. The core code, essential modules, and helper scripts for the Zsh framework itself. Houses the fundamental scripts and functions that define the framework's architecture, manage its components, and provide its core functionalities.

### `Log/`

Structured runtime logs written and output for framework operations (events), error messages, backup reports, install activity, and debugging information. The level of detail in the logs can be configured by the user.

**Use Case:** Track shell behavior over time, debug issues, or audit configuration changes.

### `Plugins/`

Integrations for &mdash; and management of &mdash; external tools, such as Homebrew, Git, Node, etc. to add new features, functionalities, and integrations to the Zsh environment. Drop a folder here to have it auto-loaded and managed.

**Use Case:** Easily enable/disable plugin sets.

### `Templates/`

Skeleton files or blueprints for generating new modules, configurations, custom functions, runcoms, or plugin structures. Run a generator script from `Tools/` to scaffold a new file.

**Use Case:** Quickly create new framework components with consistent headers and structure. Adhere to DRY code.

### `Themes/`

Built-in visual style and theme definitions to customize the look and feel of the terminal prompt. Each theme lives in its own file and is structured consistently to function as a drop-in. Themes can customize the information displayed, the colors used, and the overall aesthetics of the shell.

**Use Case:** Customize the terminal's appearance and behavior using a built-in, custom, or third-party Zsh theme.

### `Tools/`

Standalone shell scripts, such as setup, diagnostics, update, theme selector, etc. that serve as internal helper scripts that enhance the framework's usability.

**Use Case:** One-off utilities invoked from the command line that assist with framework management, perform common tasks, or offer convenient shortcuts for shell operations.

---

## 📄 License

[MIT](https://opensource.org/license/mit) &mdash; &copy; Emily Simone

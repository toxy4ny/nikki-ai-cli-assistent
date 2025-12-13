# 🫡 Nikki — AI Assistant for Red Team & DevOps in the Terminal

> **Nikki** is your local, offline, uncensored AI teammate in the CLI — purpose-built for:
> - generating battle-tested offensive code (PowerShell, C, Rust, Bash),
> - analyzing vulnerabilities and exploits from GitHub repositories,
> - writing and debugging scripts,
> - multi-turn conversations directly from your shell.

All processing happens **locally**, with **no cloud dependency** and **no prompt leakage**.  
Powered by **aichat**, **Ollama**, **RAG**, and curated red team repositories like `PayloadsAllTheThings`, `Atomic Red Team`, and `SharpCollection` and top or new repositories of Github.

---

## 🌟 Key Features

- ✅ **Fully offline** — works without internet after setup  
- ✅ **No censorship** — uses uncensored `base` models  
- ✅ **RAG over GitHub repos** — always up to date with latest offensive techniques  
- ✅ **Multi-turn dialogue** via `--session`  
- ✅ **Fish shell integration** — just type `Nikki ...`  
- ✅ **Ready for [Athena OS](https://athenaos.org)** (Arch-compatible packaging) (https://github.com/Athena-OS)

---

## 🧠 Architecture

```
┌──────────────────────┐
│       Nikki CLI      │ ← fish function: `Nikki`
└──────────┬───────────┘
           │
   ┌───────▼──────────┐
   │     aichat       │ ← Rust CLI frontend
   └───────┬──────────┘
           │
   ┌───────▼──────────┐     ┌───────────────────────┐
   │      Ollama      │◄───►│  RAG: nomic-embed-text│
   │ (LLM + Embedding)│     └───────────────────────┘
   └───────┬──────────┘
           │
   ┌───────▼──────────┐
   │ GitHub Repos     │ ← PayloadsAllTheThings, SharpCollection, Atomic Red Team...
   └──────────────────┘
```

- **LLMs**:  
- `rnj-1-instruct` (uncensored, for red team)
- **Embedding**: `nomic-embed-text` (local, via Ollama)
- **Knowledge base**: cloned repos in `~/rag-data/redteam`
- **Config**: roles, sessions, RAG — all in `~/.config/aichat/`

---

## ⚠️ Why This Isn’t Just “Another Chatbot”

- Nikki **won’t hallucinate APIs** — if a technique isn’t in the source repos, she replies: _“No information found in my sources.”_
- All payloads are **cross-referenced** with real repositories (use `.sources rag` to verify).
- **Zero ethical disclaimers** — only working, executable code.

---

## 🛠 Installation

### Requirements
- **Athena OS** (or any Arch-based distro)
- `aichat` ≥ 0.30.0
- `ollama` ≥ 0.1.33
- `git`, `fish`

### Option 1: PKGBUILD (Recommended for Athena OS)

```bash
git clone https://github.com/toxy4ny/nikki-ai-cli-assistent.git
cd nikki-ai
makepkg -si
```

> After install:
> - `Nikki` is available in your shell,
> - `setup-rag` updates your knowledge base,
> - config template: `/etc/aichat/config.yaml.example`

### Option 2: Manual Install

```bash
./install.sh
```

Installs:
- `nikki.fish` → `~/.config/fish/functions/`
- `setup-rag.fish` → `~/bin/`
- config & role templates

---

## ⚙ Setup

1. **Start Ollama**:
   ```fish
   systemctl --user enable --now ollama
   ```

2. **Pull models**:
   ```fish
   ollama pull rnj-1:latest
   ollama pull nomic-embed-text
   ```

3. **Configure aichat** (manual install only):
   ```fish
   cp config/aichat-config.yaml ~/.config/aichat/config.yaml
   ```

4. **Load knowledge repos**:
   ```fish
   setup-rag
   ```

---

## 💬 Usage

### One-off query
```fish
Nikki Generate a reverse TCP shell in bash?
```

### Multi-turn conversation
```fish
Nikki --session c2 "Generate a reverse TCP shell in C"
Nikki --session c2 "Add XOR encryption with key 0x42"
Nikki --session c2 "Compile it with mingw"
```

### Verify sources (inside `aichat`)
```fish
> .rag nikki-kb
> How does Unicorn do DDE attacks?
> .sources rag
```

---

## 📦 Repository Structure

```
nikki-ai/
├── PKGBUILD                # For Athena OS / AUR
├── install.sh              # Manual install script
├── bin/setup-rag.fish      # RAG update utility
├── config/aichat-config.yaml
├── roles/redteam-ru.yaml
├── fish/nikki.fish
├── LICENSE
└── README.md
```

---

## 🤝 Contribution & Athena OS Integration

Nikki aligns with **Athena OS philosophy**:
- minimalism,
- security,
- offline-first,
- open-source.

We welcome inclusion in the **official Athena OS repositories**.  
The project is audit-ready and supports automated builds.

🔗 [Athena OS](https://athenaos.org)

---

## ⚠️ Ethical Notice

> Nikki is designed for **authorized** penetration testing, red team operations, and closed-lab education.  
> Do not use it for illegal activities.  
> Always review generated code before execution.

---

## 📜 License

MIT © [toxy4ny](https://github.com/toxy4ny)

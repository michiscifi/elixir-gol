# Elixir Game of Life – Devlog

---

## 1️⃣ Projektstart & Setup

- Neues GitHub-Repo: `elixir-gol`
- Verzeichnis lokal ausgecheckt
- ASDF-Umgebung für Elixir & Erlang eingerichtet:

```bash
asdf plugin add erlang
asdf plugin add elixir
asdf install erlang 28.3.1
asdf install elixir 1.20.0-rc.1-otp-28
asdf set erlang 28.3.1
asdf set elixir 1.20.0-rc.1-otp-28
```

### iex 
```
iex
# Erlang/OTP 28 [erts-16.2]
# Interactive Elixir (1.20.0-rc.1) - press Ctrl+C to exit
```

### core module: gol_core/lib/gol_core/core.ex

```elixir
defmodule GolCore.Core do
  def add(a, b) do
    a + b
  end
end
```

### iex
```bash
iex -S mix
```

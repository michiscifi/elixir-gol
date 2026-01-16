# Elixir Game of Life – Devlog

---

## Setup erlang and elixir using asdf

---

```bash
brew install asdf
```

---

```bash
asdf plugin add erlang
asdf plugin add elixir
asdf install erlang 28.3.1
asdf install elixir 1.20.0-rc.1-otp-28
asdf set erlang 28.3.1
asdf set elixir 1.20.0-rc.1-otp-28
```

---


### test with iex 
```
iex
# Erlang/OTP 28 [erts-16.2]
# Interactive Elixir (1.20.0-rc.1) - press Ctrl+C to exit
```
---


### create game of life project 

```
mix new conway --sup
```

---

- 'mix' is an elixir tool for managing projects
- option '--sup' means: add supervisor structure

---

```bash
conway
├── lib
│   ├── conway
│   │   └── application.ex
│   └── conway.ex
├── mix.exs
├── README.md
└── test
    ├── conway_test.exs
    └── test_helper.exs
```

---

- applies Elixir’s standard code formatter, ensuring consistent style across the project.

```bash

mix format
```

---

change 'add a simple functio to conway.ex'

```elixir
defmodule Conway do
  @moduledoc """
  Documentation for `Conway`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Conway.hello()
      :world

  """
  def hello do
    :world
  end
  
  @doc """
  Addition of two numbers.
  
  ## Examples
  
      iex> Conway.add(1,2)
      3
      
  """
  def add(a, b) do
    a + b
  end
end
```


---

### run repl: iex


```bash
iex -S mix
```
---

documentation in repl

```
iex(n)> h Conway.add
```

```
def add(a, b)

Addition of two numbers.

## Examples

    iex> Conway.add(1,2)
    3

```

```
iex(n)> Conway.add(1, 2)
3
```

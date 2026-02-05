# Agda Project

This project environment is managed by a Nix Flake toolchain.

## Setup

1. Ensure you have `nix` and `direnv` installed.
2. Run `direnv allow` to load the environment.

## Usage

Use `just` to run tasks:

```sh
just          # Runs typecheck by default
just watch    # Watch for changes and typecheck
just repl     # Start the REPL
```

## Structure

- `src/Main.agda`: Entry point.
- `justfile`: Task definitions.

# Byke

An interactive character sheet for Kids on Bikes.

## Building

This project is built with [Trunk](https://trunkrs.dev).

**Setting up development environment with Nix:**
```sh
nix develop
```

**Setting up development environment otherwise:**
```sh
cargo install trunk
rustup target add wasm32-unknown-unknown
```

**Building static site in `dist/`:**
```sh
trunk build [--release]
```

**Developing:**
```sh
trunk serve --open
```

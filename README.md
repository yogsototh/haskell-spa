> This project has two homes.
> It is ok to work in github, still, for a better decentralized web
> please consider contributing (issues, PR, etc...) throught:
>
> https://gitlab.esy.fun/yogsototh/haskell-spa

---


# Haskell SPA

This is a scaffold for a Haskell single page application.

The front end is in `ui` and setup to build with `stack` and `ghcjs`.
`stack setup` in the `ui` folder will setup `ghcjs` for the project.

## Dependencies:

1. stack
2. nodejs

## Branches:

### `master`

The `master` branch will be minimal -- just a normal Haskell project with a `ui` folder containing a stack-buildable GHCJS project.

### `servant`

The `servant` branch includes a minimal server written in Servant that serves files out of the `ui/assets/` directory.

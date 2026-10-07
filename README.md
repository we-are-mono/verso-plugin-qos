# verso-plugin-qos

Device limits for [Verso](https://github.com/we-are-mono/verso), the web
interface for OpenWrt: what a device on the network may reach, when, and how
fast, set from a Limits tab on every device's panel and enforced by fw4.

It is a non-core Verso plugin: a package of its own, installed only where you
want it. Once installed its tab joins every device's panel; removed, it leaves
it. Like every Verso plugin it runs as its own process, describes its pages
with Verso's widgets, and reads and writes the router only through rpcd and
the access list it ships.

## Install

On a router running Verso, from the Verso package feed:

```sh
apk update
apk add verso-plugin-qos
```

The package depends on `verso` and `firewall4`.

## Build

The plugin is a static Rust binary built on Verso's plugin SDK, which Cargo
fetches from the Verso repository at the release this plugin pins.
`rust-toolchain.toml` provisions the compiler and both musl targets; nothing
else is needed but `rustup` and `make`.

```sh
make test     # unit and page tests
make lint     # clippy, warnings as errors
make build    # build/verso-plugin-qos-{amd64,arm64}
make apk      # a signed package for the router (needs an OpenWrt buildroot)
```

`make apk` takes the apk tool and the signing key from an OpenWrt buildroot:
pass `OPENWRT_DIR=/path/to/openwrt/source`, or set it in a gitignored
`local.mk`. The version is the latest `vX.Y.Z` tag and the commits on it
(`make version`).

## Layout

- `src/` — the plugin: its tab, the router reads behind it, and tests
- `manifest.json` — what the shell discovers: the tab, its socket and the uci
  scopes it writes
- `i18n/` — its translations, one catalog per language
- `rootfs/` — what the package installs as it stands: the init script, the
  rpcd access list, and a default `/etc/config/qos`
- `packaging/post-install.sh` — enables and starts the plugin's service

## License

GPL-2.0-only. See `LICENSE`.

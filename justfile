fmt:
    cargo fmt

release: fmt
    cargo build --release

archive:
    ouch compress dist/sonogram_aarch64-apple-darwin dist/sonogram_aarch64-apple-darwin.zip
    ouch compress dist/sonogram_aarch64-unknown-linux-gnu dist/sonogram_aarch64-unknown-linux-gnu.zip
    ouch compress dist/sonogram_x86_64-apple-darwin dist/sonogram_x86_64-apple-darwin.zip
    ouch compress dist/sonogram_x86_64-unknown-linux-gnu dist/sonogram_x86_64-unknown-linux-gnu.zip

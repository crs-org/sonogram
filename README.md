# Sonogram

[![build](https://github.com/crs-org/sonogram/actions/workflows/ci.yml/badge.svg)](https://github.com/crs-org/sonogram/actions/workflows/ci.yml)
[![release windows aarch64](https://github.com/crs-org/sonogram/actions/workflows/release-win_aarch64.yml/badge.svg)](https://github.com/crs-org/sonogram/actions/workflows/release-win_aarch64.yml)
[![release windows x86_64](https://github.com/crs-org/sonogram/actions/workflows/release-win_x86_64.yml/badge.svg)](https://github.com/crs-org/sonogram/actions/workflows/release-win_x86_64.yml)

Create a sonogram\* from an wave form, or importing a `.wav` file.

The spectrogram can be saved as a `.png` file, a `.csv` file, or
stored in memory. An example command line application is included
that converts `.wav` files to `.png` spectrograms.

_Example output `.png`:_

![Sample sonogram](https://raw.githubusercontent.com/psiphi75/sonogram/master/samples/Globular-PoppingOut.png)

\*Note: sonogram, spectrograph, spectrogram, or power spectral density
plots are common names of similar things.

## Build and run the command line appplication

```sh
cargo build --release

./target/release/sonogram --wav samples/trumpet.wav --png output.png
```

## Saving to a `.png` file

```Rust
let waveform: Vec<i16> = vec![/* ... some data ... */];

// Build the model
let spectrograph = SpecOptionsBuilder::new(2048)
  .load_data_from_memory(waveform)
  .build().unwrap();

// Compute the spectrogram giving the number of bins and the window overlap.
spectrograph.compute();

// Specify a colour gradient to use (note you can create custom ones)
let mut gradient = ColourGradient::create(ColourTheme::from(args.gradient));

// Save the spectrogram to PNG.
let png_file = std::path::Path::new("path/to/file.png");
spectrograph.to_png(&png_file, 
            FrequencyScale::Linear,
            &mut gradient,
            512,    // Width
            512,    // Height
        ).unwrap();
```

## Customise the colour gradient

For `.png` images you can customise the colour gradient:

```Rust
let mut gradient = ColourGradient::new();
gradient.add_colour(RGBAColour::new(0, 0, 0, 255));     // Black
gradient.add_colour(RGBAColour::new(55, 0, 110, 255));  // Purple
gradient.add_colour(RGBAColour::new(0, 0, 180, 255));   // Blue
gradient.add_colour(RGBAColour::new(0, 255, 255, 255)); // Cyan
gradient.add_colour(RGBAColour::new(0, 255, 0, 255));   // Green
spec_builder.set_gradient(gradient);
```

Or use a built-in colour gradient theme:

```Rust
let mut gradient = ColourGradient::rainbow_theme();
spec_builder.set_gradient(gradient);
```

## Build

You need: cargo, rustc, cross, podman, goreleaser.

0. build images and increase resources for podman:

```shell
podman build --platform=linux/amd64 -f dockerfiles/Dockerfile.aarch64-unknown-linux-gnu -t aarch64-unknown-linux-gnu:my-edge .
podman build --platform=linux/amd64 -f dockerfiles/Dockerfile.x86_64-unknown-linux-gnu -t x86_64-unknown-linux-gnu:my-edge .
```

1. make binaries:

```shell
goreleaser build --clean --snapshot --id sonogram --timeout 60m
```

## License

This source is released under the GPLv3 license. Read the LICENSE file for legal information.

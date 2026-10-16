I've created a Bash equivalent called convert_for_ps5.sh using AI-assisted (vibe-coded) development. I've tested the script on Linux and confirmed that it works as expected.

It preserves the original FFmpeg encoding settings and supports converting multiple video files in one go, making the workflow more accessible for Linux users.
How to use it

Requirements

Linux

FFmpeg installed on the system or included in the same directory as the script

1. Install FFmpeg

On Ubuntu or Debian-based distributions:

sudo apt update
sudo apt install ffmpeg

2. Make the script executable

chmod +x convert_for_ps5.sh

3. Convert videos

Convert a single video:

./convert_for_ps5.sh video.mkv

Convert multiple videos at once:

./convert_for_ps5.sh video1.mkv video2.mov video3.avi

The converted files are saved alongside the original videos with _ps5.mp4 appended to their filenames.

Output specifications

MP4 container

H.264 video (High Profile, Level 4.2)

1920×1080 resolution

Original aspect ratio preserved, with black bars where necessary

Maximum 60 fps

AAC stereo audio at 48 kHz and 192 kbps

Fast-start MP4 for improved playback compatibility

AI disclosure

The script was created with AI assistance using a vibe-coding approach. I reviewed and tested it on Linux to verify that it works as expected.
<p align="center">
  <img src="assets/icon0.png" width="140" alt="LiveShell Engine">
</p>

<h1 align="center">LiveShell Engine</h1>

<p align="center"><b>Animated video wallpapers for the PS5 home screen.</b></p>

<p align="center">
  <img src="https://img.shields.io/badge/version-1.0-white?style=flat-square" alt="version">
  <img src="https://img.shields.io/badge/platform-PS5-white?style=flat-square" alt="platform">
  <img src="https://img.shields.io/badge/video-H.264%20%7C%20HEVC%20%E2%89%A41080p-white?style=flat-square" alt="video">
  <img src="https://img.shields.io/badge/license-GPL--3.0-white?style=flat-square" alt="license">
</p>

---

## Features

- **Library** tab with all your games and apps, to give each one its own video (experimental).
- **PS Store only**: the video shows only on the PlayStation Store tile, with its own video.
- **Sound**: videos with sound play it.
- **Game music**: a game's own theme keeps playing when its video has no sound or Sound is on Mute
- **Your clips** from internal storage or a USB drive
- **Looks**: Dim, Vignette, Haze, all combinable
- **Hide in Settings**: Settings keeps the normal PS5 background
- **Pause while a game runs**, so games get the video decoder
- **Parallax** effect when moving between games
- **Random video** on every start
- **Rest mode**: comes back on its own after waking the PS5
- **Home-screen app** to pick, delete and control everything
- **Phone / PC page** to upload, play and delete videos

## Install

Needs a jailbroken PS5 with a payload loader.

1. Copy `.mp4` files to `/data/LiveShell/video`, or to a `liveshell` folder on a USB drive.
2. Load `liveshell.elf`.
3. Open the **LiveShell Engine** on the home screen (Media).

Videos: H.264 and HEVC Only 1080p. with or without sound and 4k not supported yet.

## A video for a game (experimental)

1. Open the **Library** tab and pick a game or app.
2. Choose its video. **Reset** gives it back the default background.

Keep all videos in one place (internal **or** USB) for the quickest switching.

Some tiles can't have their own video yet: they show the main video instead.

- **Web-app / homebrew tiles** without a background picture (e.g. Payload Manager etc)
- **Homebrew apps** with only a `pic0.png` and no `pic0.dds`

## Folders on the PS5

| Path | What |
|---|---|
| `/data/LiveShell/video/` | Your videos |
| `<USB>/liveshell/` | Videos on a USB drive |
| `/data/LiveShell/config.txt` | Settings |
| `/data/LiveShell/liveshell.log` | Log |

## Building

Linux or WSL, with the [PS5 payload SDK](https://github.com/ps5-payload-dev/sdk) and the [OnionHEN](https://github.com/aydencharles/onionHEN) v0.9.0-beta2 source tree.

```sh
ONIONHEN=~/onionHEN-beta2 PS5_PAYLOAD_SDK=~/ps5-payload-sdk tools/build.sh
```

`src/` is copied into OnionHEN as `source/liveshell` and built as the `liveshell` target.

## Credits

- **[OnionHEN](https://github.com/aydencharles/onionHEN/)**: payload injector, detour library and ShellUI groundwork
- **[PS5 Payload SDK](https://github.com/ps5-payload-dev/sdk)**: toolchain and PS5 libraries

## License

GPL-3.0. See [LICENSE](LICENSE).

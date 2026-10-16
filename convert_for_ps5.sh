
#!/usr/bin/env bash

# LiveShell Engine video converter for Linux.
# Convert one or more videos to PS5-compatible MP4 files.
# Output: <name>_ps5.mp4 next to the original.
#
# Output:
# H.264, 1920x1080, aspect ratio preserved with black bars,
# max 60 fps, AAC audio, 48 kHz stereo.
#
# Requires ffmpeg installed on the system or in this folder.

set -u

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
FFMPEG="$SCRIPT_DIR/ffmpeg"

# Prefer a local ffmpeg binary if present; otherwise use PATH.
if [[ ! -x "$FFMPEG" ]]; then
    FFMPEG="$(command -v ffmpeg || true)"
fi

if [[ -z "$FFMPEG" ]] || [[ ! -x "$FFMPEG" ]]; then
    echo "Error: ffmpeg was not found."
    echo "Install it using your Linux package manager or place it in this folder."
    exit 1
fi

if [[ $# -eq 0 ]]; then
    echo "Usage: $0 video1.mkv [video2.mov ...]"
    echo "Tip: You can drag video files into a terminal after typing the script path."
    exit 1
fi

FAILED=0

for INPUT in "$@"; do
    if [[ ! -f "$INPUT" ]]; then
        echo
        echo "FAILED: File not found: $INPUT"
        FAILED=1
        continue
    fi

    # Absolute output path beside the input file.
    INPUT_DIR="$(cd -- "$(dirname -- "$INPUT")" && pwd)"
    INPUT_NAME="$(basename -- "$INPUT")"
    BASE_NAME="${INPUT_NAME%.*}"
    OUTPUT="$INPUT_DIR/${BASE_NAME}_ps5.mp4"

    echo
    echo "=== $INPUT_NAME"

    if "$FFMPEG" -hide_banner -loglevel error -stats -y -i "$INPUT" \
        -vf "scale=1920:1080:force_original_aspect_ratio=decrease:flags=lanczos,pad=1920:1080:(ow-iw)/2:(oh-ih)/2,format=yuv420p" \
        -fpsmax 60 -c:v libx264 -preset slow -profile:v high -level 4.2 \
        -b:v 16M -maxrate 20M -bufsize 20M \
        -x264-params "keyint=60:min-keyint=30:scenecut=0:open-gop=0" \
        -colorspace bt709 -color_primaries bt709 -color_trc bt709 -color_range tv \
        -c:a aac -b:a 192k -ar 48000 -ac 2 \
        -movflags +faststart "$OUTPUT"; then
        echo "OK: $(basename -- "$OUTPUT")"
    else
        echo "FAILED: $INPUT_NAME"
        FAILED=1
    fi
done

echo
if [[ "$FAILED" -eq 0 ]]; then
    echo "Done. Copy the _ps5.mp4 files to:"
    echo "  /data/LiveShell/video on the PS5,"
    echo '  a "liveshell" folder on a USB drive,'
    echo "  or upload them using the LiveShell Engine phone / PC page."
else
    echo "Done, but one or more files failed to convert."
fi

exit "$FAILED"

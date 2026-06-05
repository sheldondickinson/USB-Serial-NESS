#!/usr/bin/env bash
set -e

CONFIG_PATH=/data/options.json

SERIAL_DEVICE=$(jq -r '.serial_device' "$CONFIG_PATH")
BAUDRATE=$(jq -r '.baudrate' "$CONFIG_PATH")
BYTESIZE=$(jq -r '.bytesize' "$CONFIG_PATH")
PARITY=$(jq -r '.parity' "$CONFIG_PATH")
STOPBITS=$(jq -r '.stopbits' "$CONFIG_PATH")
RTSCTS=$(jq -r '.rtscts' "$CONFIG_PATH")
XONXOFF=$(jq -r '.xonxoff' "$CONFIG_PATH")
RTS=$(jq -r '.rts' "$CONFIG_PATH")
DTR=$(jq -r '.dtr' "$CONFIG_PATH")
DEBUG_LOGGING=$(jq -r '.debug_logging' "$CONFIG_PATH")

ARGS=(
  "tcp_serial_redirect.py"
  "$SERIAL_DEVICE"
  "$BAUDRATE"
  "--localport" "7777"
  "--bytesize" "$BYTESIZE"
  "--parity" "$PARITY"
  "--stopbits" "$STOPBITS"
)

if [ "$RTSCTS" = "true" ]; then
  ARGS+=("--rtscts")
fi

if [ "$XONXOFF" = "true" ]; then
  ARGS+=("--xonxoff")
fi

if [ "$RTS" != "null" ]; then
  ARGS+=("--rts" "$RTS")
fi

if [ "$DTR" != "null" ]; then
  ARGS+=("--dtr" "$DTR")
fi

if [ "$DEBUG_LOGGING" != "true" ]; then
  ARGS+=("--quiet")
fi

echo "Starting USB Serial Redirect"
echo "Serial device: $SERIAL_DEVICE"
echo "Baudrate: $BAUDRATE"
echo "Serial format: ${BYTESIZE}${PARITY}${STOPBITS}"
echo "TCP listener: 7777"

exec python "${ARGS[@]}"

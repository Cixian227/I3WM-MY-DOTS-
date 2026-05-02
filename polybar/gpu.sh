#!/bin/bash
temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null)

if [ -n "$temp" ]; then
    # Оставляем только число и значок градуса
    echo "$temp°C"
else
    echo "OFF"
fi
#!/bin/bash
# @name: Largest files v2
# @description: A script to find the 10 largest files on the system. Save to file.

@NEXTERM:STEP "Finding the 10 largest unique files on the system, and save to file."

output_file="/tmp/top10_largest_files.txt"

largest_files=$(find / \
  \( -path /proc -o -path /sys -o -path /dev -o -path /tmp -o -path /run -o -path /var/run \) -prune -o \
  -type f -printf '%s %p\n' 2>/dev/null \
  | sort -nr \
  | awk '!seen[$2]++' \
  | head -n 10 \
  | awk '{printf "\"%s,%.2fMB\"\n", $2, $1/1024/1024}')

echo "$largest_files" > "$output_file"

@NEXTERM:TABLE "Top 10 Largest Files" "File Path,Size (MB)" "$largest_files"
@NEXTERM:STEP "Results saved to: $output_file"

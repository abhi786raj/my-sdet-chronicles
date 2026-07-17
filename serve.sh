#!/bin/bash
set -e

export PATH="/opt/homebrew/opt/ruby@3.3/bin:$PATH"

cd "$(dirname "$0")"

echo "Using: $(ruby --version)"
echo "Starting Jekyll at http://127.0.0.1:4000/"
echo "Press Ctrl+C to stop."
echo

# Stop any leftover local Jekyll servers from a previous run
STALE_PIDS=$(lsof -ti:4000 -ti:35729 2>/dev/null | sort -u || true)
if [ -n "$STALE_PIDS" ]; then
  echo "Stopping stale Jekyll process(es): $STALE_PIDS"
  kill $STALE_PIDS 2>/dev/null || true
  sleep 1
fi

bundle install
bundle exec jekyll serve --livereload --baseurl ""

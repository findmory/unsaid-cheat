#!/bin/sh
# Rebuild words.js from the Unsaid game dictionary.
# Usage: ./update-words.sh [path/to/words.txt]
set -e
SRC="${1:-$(dirname "$0")/../unsaid/ios/Unsaid/Resources/words.txt}"
OUT="$(dirname "$0")/words.js"
python3 - "$SRC" "$OUT" <<'PY'
import json, sys
words = [w.strip().lower() for w in open(sys.argv[1]) if w.strip()]
with open(sys.argv[2], "w") as f:
    f.write("window.WORDS=" + json.dumps("\n".join(words)) + ";\n")
print(f"{len(words)} words -> {sys.argv[2]}")
PY

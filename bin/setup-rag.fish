#!/usr/bin/env fish

set -l SOURCES_FILE ~/rag-sources/redteam-repos.txt
set -l RAG_DATA_DIR ~/rag-data/redteam
set -l RAG_NAME nikki-kb
set -l TEMP_SCRIPT /tmp/aichat-rag-setup.$fish_pid

if not pgrep -x ollama > /dev/null
    echo "⚠️ Launching Ollama..."
    systemctl --user start ollama
    sleep 3
end

mkdir -p ~/rag-sources ~/rag-data/redteam

if not test -f "$SOURCES_FILE"
    echo "❌ The $SOURCES_FILE was not found"
    exit 1
end

echo "🔄 The $SOURCES_FILE was not found"
while read -l url
    if test -n "$url"; and not string match -q "#*" -- "$url"
        set -l repo_name (string split / $url)[-1]
        set -l repo_path "$RAG_DATA_DIR/$repo_name"

        if test -d "$repo_path"
            echo "  ↻ Update $repo_name..."
            pushd "$repo_path" > /dev/null; git pull --quiet; popd > /dev/null
        else
            echo "  📥 Cloning $repo_name..."
            git clone --depth=1 --quiet "$url" "$repo_path"
        end

        find "$repo_path" \( -name "*.exe" -o -name "*.dll" -o -name ".git" -o -name "__pycache__" \) -exec rm -rf {} + 2>/dev/null
    end
end < "$SOURCES_FILE"

echo "🗑️ Deleting the old RAG '$RAG_NAME' (if it exists)..."
echo ".delete rag $RAG_NAME" > $TEMP_SCRIPT

echo "🧠 Creating a RAG '$RAG_NAME' from $RAG_DATA_DIR..."
echo ".rag create $RAG_NAME $RAG_DATA_DIR" >> $TEMP_SCRIPT
echo ".exit" >> $TEMP_SCRIPT

if aichat < $TEMP_SCRIPT
    echo "✅ RAG '$RAG_NAME' has been successfully updated!"
else
    echo "❌ Error when creating a RAG. Make sure that the folder is not empty."
    exit 1
end

rm -f $TEMP_SCRIPT

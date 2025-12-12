function Nikki
    set -l args $argv
    
    if contains --session $args
        /usr/bin/aichat --role redteam-ru $args
        return
    end

   
    if test (count $args) -eq 0
        echo "Using:" >&2
        echo "  Nikki <request>                          → one-time request with RAG" >&2
        echo "  Nikki --session <Name> <request>         → continue the dialogue" >&2
        echo "" >&2
        echo "Examples:" >&2
        echo "  Nikki how to bypass AMSI in PowerShell?" >&2
        echo "  Nikki --session exploit1 generate reverse TCP shell in C" >&2
        echo "  Nikki --session exploit1 add XOR encryption" >&2
        return 1
    end

    
    set -l prompt (string join ' ' $args)
    echo -e "\e[35m🫡 Niki, execute: \e[33m$prompt\e[0m" >&2

    
    echo -e ".rag nikki-kb\n$prompt" | ~/.cargo/bin/aichat --role redteam-ru --execute
end

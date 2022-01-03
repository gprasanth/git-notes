NOTES_DIR=~/notes
NOTES_FMT="txt"

if [ ! -d $NOTES_DIR/.git ]; then
    echo "Initialising notes dir..."
    git init $NOTES_DIR
    echo "Run 'git remote add origin ORIGIN' in directory: $NOTES_DIR"
fi

function new_note() {
    local prev_dir=$(pwd)
    local ts=$(date +"%d-%m-%Y_%H:%M")
    cd $NOTES_DIR
    vi "$ts.$NOTES_FMT"
    git add "$ts.$NOTES_FMT"
    git commit -m "Created $ts.$NOTES_FMT"
    git push
    cd "$prev_dir"
}
alias nn="new_note"

function last_note() {
    local prev_dir=$(pwd)
    local l=$(ls -altr1 $NOTES_DIR/*.$NOTES_FMT | tail -n 1)
    cd $NOTES_DIR
    vi "$l"
    git add "$l"
    git commit -m "Edited $(basename $l)"
    git push
    cd "$prev_dir"
}
alias n="last_note"

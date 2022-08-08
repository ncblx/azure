#! /bin/bash

username='whoami'

ls -al /home/${username}/.profile

/home/${username}/.profile

echo "INFO: Using APP_ENV= ${APP_ENV}"

shopt -s nullglob

dircheck() {
    echo "dir11 pointed to ->" $(readlink -e /dir/symlink/dir11)
    echo -e
    for dirpath in /dir1/dir1a/dir1b/*/; do
        if ! [ "$dirpath" -ef /dir1/dir1a/dir1b/ ]; then
            printf 'Would remove "%"\n' "$dirpath"
            # rm-rf "$dirpath"
        fi
    done
}

echo -e
echo "----------------------------------------"
echo "Checking MG EligibilityVisualizationGUI"
echo "----------------------------------------"
if test -d "/dir1/dir1a/dir1b/"; then
    if test -w "/dir1/dir1a/dir1b/"; then
        dircheck
    else
        printf 'No access to /dir1/dir1a/dir1b/, need to request Temporary Root Access\n\n'
    fi
else
    printf 'Directory /dir1/dir1a/dir1b/ not available on host \n\n'
fi

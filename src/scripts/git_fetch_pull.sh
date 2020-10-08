#!/bin/bash

cd ..
git fetch
git reset --hard origin/master
chmod +x src/scripts/git_fetch_pull.sh
systemctl restart kainoadrost

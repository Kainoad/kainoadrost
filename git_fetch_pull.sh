#!/bin/bash

git fetch
git reset --hard origin/master
chmod +x git_fetch_pull.sh
systemctl restart kainoadrost

#!/bin/bash

# Manual backup from lim2024 since not tracking repo with Git yet

#make a clean temp folder
mkdir /tmp/Abil
#copy folder but exclude git, docs and dis
rsync -av --progress /mnt/c/users/az24148/Documents/PhD/Projects/Abil/Abil/studies/ /tmp/Abil/ --exclude .git --exclude dist --exclude docs  --exclude /studies/ --exclude /studies/devries2024 --exclude /studies/wiseman2024 --exclude tests --exclude examples
#copy temp folder to bp
scp -r /tmp/Abil/ az24148@bp1-login.acrc.bris.ac.uk:/user/work/az24148/
#if copy ok, remove temp folder
rm -rf /tmp/Abil

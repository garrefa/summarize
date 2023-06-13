# PumaBrowserSecrets.xcconfig

To store Puma Browser specific secrets, api keys and sensitive data that should not be in git,
there is a file called `PumaBrowserSecrets.xcconfig` created at `${PROJECT_DIR}/Client/Configuration`.

To create this file, run `${PROJECT_DIR}/puma-config-gen.sh`.

> sh ./puma-config-gen.sh

This file is excluded from git. 

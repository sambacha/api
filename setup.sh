#!/bin/bash
mkdir -p .yarn-cache/.repo
yarn config set cache-folder .yarn-cache
yarn install
yarn generate-lock-entry
yarn pack

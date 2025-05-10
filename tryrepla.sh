# Define your search and replace strings
SEARCH="oktbabs"
REPLACE="oktbabs"

# List all branches (customize as needed)
for branch in $(git branch -r | grep -v '\->' | sed 's/origin\///'); do
    echo "Processing branch: $branch"

    # Checkout the branch
    git checkout $branch

    # Replace string in all files (you can limit this to certain files or types)
    grep -rl "$SEARCH" . | xargs sed -i "s/$SEARCH/$REPLACE/g"

    # Commit changes
    git add .
    git commit -m "Replace '$SEARCH' with '$REPLACE' in $branch"
    git push origin $branch
done


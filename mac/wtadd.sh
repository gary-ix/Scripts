#!/usr/bin/env zsh

# adding to zshrc
# alias wtadd="source /Users/garrett/code/dev/Scripts/mac/wtadd.sh"

# Git worktree add function
gwadd() {
    # Check if branch name is provided
    if [[ -z "$1" ]]; then
        echo "Usage: gwadd <branch-name>"
        return 1
    fi

    local branch_name="$1"
    local safe_branch_name="${branch_name//\//__}"
    local current_dir=$(pwd)
    local repo_root=$(git rev-parse --show-toplevel 2>/dev/null)
    
    # Check if we're in a git repository
    if [[ -z "$repo_root" ]]; then
        echo "Error: Not in a git repository"
        return 1
    fi

    # Determine the parent directory and new worktree path
    local parent_dir=$(dirname "$repo_root")
    local worktree_path="$parent_dir/$safe_branch_name"

    # Check if the worktree directory already exists
    if [[ -d "$worktree_path" ]]; then
        echo "Error: Directory '$worktree_path' already exists"
        return 1
    fi

    echo "Creating worktree for branch '$branch_name'..."
    
    # Create the worktree
    if ! git worktree add "$worktree_path" -b "$branch_name"; then
        echo "Error: Failed to create worktree"
        return 1
    fi

    echo "Worktree created successfully at: $worktree_path"

    # Function to get relative path (macOS compatible)
    get_relative_path() {
        local full_path="$1"
        local base_path="$2"
        echo "${full_path#$base_path/}"
    }

    # Function to extract items from .gitignore
    get_gitignore_items() {
        local gitignore_file="$repo_root/.gitignore"
        local items=()
        
        if [[ ! -f "$gitignore_file" ]]; then
            return
        fi

        # Read .gitignore and extract relevant patterns
        while IFS= read -r line; do
            # Skip empty lines and comments
            [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue
            
            # Remove leading/trailing whitespace
            line=$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
            
            # Skip negation patterns (starting with !)
            [[ "$line" =~ ^! ]] && continue
            
            # Skip node_modules specifically
            [[ "$line" =~ ^node_modules ]] && continue
            
            # Remove trailing slashes and wildcards for directory matching
            local clean_item=$(echo "$line" | sed 's|/$||' | sed 's|\*||g' | sed 's|/.*||')
            
            # Skip patterns that are too generic or contain special characters
            if [[ "$clean_item" != "." && "$clean_item" != ".." && 
                  "$clean_item" != "node_modules" &&
                  ! "$clean_item" =~ [*?[\]] && 
                  ! "$clean_item" =~ ^/ &&
                  ${#clean_item} -gt 1 ]]; then
                items+=("$clean_item")
            fi
        done < "$gitignore_file"
        
        # Remove duplicates and return
        printf '%s\n' "${items[@]}" | sort -u
    }

    # Function to copy files/directories preserving structure
    copy_with_structure() {
        local source_path="$1"
        local relative_path="$2"
        local target_base="$3"
        
        # Create parent directory in target if needed
        local target_dir=$(dirname "$target_base/$relative_path")
        mkdir -p "$target_dir"
        
        # Copy the file/directory
        cp -r "$source_path" "$target_base/$relative_path"
    }

    # Get items from .gitignore
    local gitignore_items=($(get_gitignore_items))
    
    # Essential fallback items (no node_modules)
    local fallback_items=(
        ".env"
        ".env.local"
        ".env.development"
        ".env.production"
        ".env.staging"
        ".env.test"
        "vendor"
        "target"
        "dist"
        "build"
        ".next"
        "coverage"
        "__pycache__"
        "venv"
        ".venv"
    )

    # Find all .env files in the repository (preserving paths)
    local env_files=()
    while IFS= read -r -d '' file; do
        local rel_path=$(get_relative_path "$file" "$repo_root")
        env_files+=("$rel_path")
    done < <(find "$repo_root" -name ".env*" -type f -print0)

    echo "Found ${#gitignore_items[@]} items from .gitignore"
    echo "Found ${#env_files[@]} .env files in repository"
    
    # Debug: Show what .env files were found
    echo "DEBUG: .env files found:"
    for env_file in "${env_files[@]}"; do
        echo "  - $env_file"
    done
    
    echo "Copying development environment files and directories..."

    # Copy .env files first (with directory structure)
    local copied_count=0
    for env_file in "${env_files[@]}"; do
        if [[ -f "$repo_root/$env_file" ]]; then
            echo "  Copying .env file: $env_file..."
            copy_with_structure "$repo_root/$env_file" "$env_file" "$worktree_path"
            ((copied_count++))
        else
            echo "  WARNING: .env file not found: $repo_root/$env_file"
        fi
    done

    # Combine gitignore and fallback items for root-level copying
    local items_to_copy=()
    items_to_copy+=("${gitignore_items[@]}")
    items_to_copy+=("${fallback_items[@]}")
    
    # Remove duplicates
    items_to_copy=($(printf '%s\n' "${items_to_copy[@]}" | sort -u))

    # Copy root-level items that exist
    for item in "${items_to_copy[@]}"; do
        if [[ -e "$repo_root/$item" ]]; then
            echo "  Copying root item: $item..."
            cp -r "$repo_root/$item" "$worktree_path/"
            ((copied_count++))
        fi
    done

    if [[ $copied_count -eq 0 ]]; then
        echo "  No development environment files found to copy"
    else
        echo "  Copied $copied_count items total"
    fi

    echo "Worktree setup complete!"
    echo "Switching to new worktree: $worktree_path"
    
    # Change to the new worktree directory
    cd "$worktree_path"
    
    # Update the prompt to show we're in the new location
    echo "Now in: $(pwd)"
    echo "Current branch: $(git branch --show-current)"
}

# Call the function with all arguments
gwadd "$@"
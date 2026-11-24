# MATLAB–GitHub Integration Guide
## Setting up, connecting, synchronising and managing MATLAB projects with GitHub

**Purpose:** This guide explains how to connect MATLAB to a GitHub repository from scratch, upload MATLAB files, download updates, and manage version control.

The instructions cover two methods:
1. Using MATLAB's graphical interface and buttons.
2. Using Git commands directly in the MATLAB Command Window.

The guide assumes that GitHub has not previously been connected to MATLAB.

---

# 1. Prerequisites

Before starting, make sure you have:

- MATLAB installed.
- A GitHub account.
- Access to the GitHub organisation and repository you want to use.
- Git installed on your computer (or available in your MATLAB environment).
- A Fine Grain Token with the appropriate repository permissions.

For this guide, the example repository will be:

`https://github.com/SUSF-Starworks/MATLAB-model-WillnAdi.git`

Replace this with your own repository address if necessary.

# 2. Setting up GitHub access

## 2.1 Create a Fine Grain Token

GitHub uses Personal Access Tokens to authenticate Git operations instead of your normal account password.

1. Log into GitHub.
2. Click your profile picture in the top-right corner.
3. Navigate to **Settings**.
4. Select **Developer settings** at the bottom of the left-hand menu.
5. Select **Personal access tokens**.
6. Select **Fine-grained tokens**.
7. Click **Generate new token**.

Configure the token as follows:

| Setting | Recommended configuration |
|---|---|
| Token name | MATLAB Access |
| Expiration | Choose an appropriate expiry |
| Resource owner | SUSF-Starworks |
| Repository access | Only select repositories |
| Selected repositories | MATLAB-model-WillnAdi |

Under Repository permissions, configure:

| Permission | Access |
|---|---|
| Contents | Read and write |
| Metadata | Read-only (automatically required) |

Other permissions should remain at their default unless specifically required.

8. Click **Generate token**.
9. Copy the generated token and store it somewhere secure.

**IMPORTANT:** The token is only displayed in full when it is generated. Do not share it with other people or commit it to GitHub.

If the organisation requires approval for fine-grained tokens, the token may need to be approved by an organisation administrator before it can access the repository.

# 3. Installing and configuring Git

MATLAB uses Git to communicate with GitHub.

## 3.1 Check whether Git is installed

Open MATLAB and enter:

```matlab
!git --version
```

If Git is installed, you should see something similar to:

```text
git version 2.x.x
```

If MATLAB reports that Git is not recognised, install Git:

https://git-scm.com/downloads

After installation, restart MATLAB and try again.

## 3.2 Configure your Git identity

Git needs to know who is making commits.

In the MATLAB Command Window, enter:

```matlab
!git config --global user.name "Your Name"
```

Then:

```matlab
!git config --global user.email "your-email@example.com"
```

Use the name and email address you want associated with your GitHub commits.

Check the configuration:

```matlab
!git config --global --list
```

# 4. Connecting MATLAB to GitHub for the first time

There are two ways to establish the connection. The recommended approach for a new project is to clone the GitHub repository.

## 4.1 Method A – Using MATLAB buttons (recommended)

1. Open MATLAB.
2. Navigate to the **Home** tab.
3. Find the **New** dropdown.
4. Select **Project > From Git** (the exact menu wording may vary between MATLAB versions).
5. Enter the Git repository URL:

   `https://github.com/SUSF-Starworks/MATLAB-model-WillnAdi.git`

6. Choose a local folder where you want the repository stored.
7. Follow the prompts to clone the repository.

If MATLAB requests authentication:

- Username: Your GitHub username.
- Password: Fine Grain Token.

**Important:** When GitHub requests a password, enter your Fine Grain Token rather than your normal GitHub password.

Once the clone completes, MATLAB should open the project or allow you to open the downloaded folder.

You are now connected to the GitHub repository.

## 4.2 Method B – Using the MATLAB Command Window

Alternatively, you can clone the repository directly using Git.

First, navigate to the folder where you want your repository stored.

For example:

```matlab
cd('C:\Users\YourName\Documents\MATLAB')
```

Clone the repository:

```matlab
!git clone https://github.com/SUSF-Starworks/MATLAB-model-WillnAdi.git
```

This creates a local folder containing the GitHub repository.

Navigate into it:

```matlab
cd('MATLAB-model-WillnAdi')
```

Check the connection:

```matlab
!git remote -v
```

You should see:

```text
origin  https://github.com/SUSF-Starworks/MATLAB-model-WillnAdi.git (fetch)
origin  https://github.com/SUSF-Starworks/MATLAB-model-WillnAdi.git (push)
```

This confirms that your local MATLAB folder is connected to the correct GitHub repository.

# 5. Understanding how GitHub synchronisation works

There are three main operations to understand:

| Operation | Purpose |
|---|---|
| Pull | Download the latest changes from GitHub to MATLAB |
| Commit | Save a snapshot of your local changes in Git |
| Push | Upload your committed changes from MATLAB to GitHub |

The general workflow is:

1. Pull the latest changes from GitHub.
2. Make changes to MATLAB files.
3. Commit your changes.
4. Push your changes to GitHub.

This ensures that everyone working on the repository has access to the latest version.

# 6. Pulling updates FROM GitHub into MATLAB

Pulling downloads changes that other people have uploaded to GitHub.

## 6.1 Using MATLAB buttons

1. Open your MATLAB project.
2. Navigate to the **Project** tab.
3. Find the **Source Control** section.
4. Select **Pull**.

Depending on your MATLAB version, Source Control commands may appear in a different location or in the Project/Source Control interface.

MATLAB will contact GitHub and download the latest changes.

If another person has modified the same files as you, Git may report a merge conflict. Resolve these before continuing.

## 6.2 Using the Command Window

Run:

```matlab
!git pull origin main
```

This downloads and merges the latest changes from the GitHub `main` branch.

Check the result:

```matlab
!git status
```

Ideally, you should see:

```text
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
```

# 7. Pushing updates FROM MATLAB to GitHub

Simple method, just use:

!git pull --rebase origin main

then 

!git add . && git commit -m "whatever message you want" && git push origin main

et voila.

When you modify MATLAB files, you need to commit and push your changes.

## 7.1 Using MATLAB buttons

After making changes to your MATLAB files:

1. Save your files.
2. Open the **Project** tab.
3. Find the **Source Control** section.
4. Review the modified files.
5. Select the files you want to upload (or stage all changes).
6. Select **Commit**.
7. Enter a descriptive commit message.

For example:

`Update simulation model parameters`

8. Confirm the commit.
9. Select **Push** to upload the changes to GitHub.

Your changes should now appear in the online repository.

Note that some MATLAB versions display source control operations through the Source Control panel rather than directly on the Project tab.

## 7.2 Using the MATLAB Command Window

The equivalent process uses three commands.

**Step 1 – Stage your changes**

```matlab
!git add .
```

This adds all new and modified files to the staging area.

**Step 2 – Commit your changes**

```matlab
!git commit -m "Update MATLAB models"
```

The commit message should describe what you have changed.

**Step 3 – Push your changes**

```matlab
!git push origin main
```

This uploads your committed changes to the GitHub `main` branch.

You can check the result:

```matlab
!git status
```

If successful, you should see:

```text
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
```

# 8. Checking synchronisation status

It is useful to check whether your local MATLAB files are synchronised with GitHub.

Run:

```matlab
!git fetch origin
```

This checks GitHub for the latest remote changes without merging them into your working files.

Then run:

```matlab
!git status
```

And:

```matlab
!git diff main origin/main
```

Interpretation:

| Result | Meaning |
|---|---|
| No output from `git diff` | Your tracked files match GitHub |
| `Your branch is up to date` | No outstanding commits to push or pull |
| `Your branch is ahead` | You have local commits waiting to be pushed |
| `Your branch is behind` | GitHub has commits you need to pull |
| `Changes not staged for commit` | You have modified files that need staging |
| `Untracked files` | You have new files that Git does not yet track |

# 9. Recommended daily workflow

For normal MATLAB development, use the following routine.

## When starting work

First, download any changes made by other people:

```matlab
!git pull origin main
```

Then check:

```matlab
!git status
```

You can now begin editing your MATLAB files.

## When finishing work

Save your MATLAB files and run:

```matlab
!git add .
```

Commit your changes:

```matlab
!git commit -m "Describe your changes"
```

Push to GitHub:

```matlab
!git push origin main
```

Your changes are now available to everyone with access to the repository.

# 10. Common problems and troubleshooting

## Problem 1 – Authentication failed

**Possible error:**

```text
remote: Invalid username or token.
fatal: Authentication failed
```

**Solution:**

- Check that your Fine Grain Token has not expired.
- Check that it has access to the correct organisation.
- Check that Contents has Read and write permissions.
- Check whether the organisation requires token approval.
- If required, ensure the token has been authorised for organisation access.
- When prompted for a password, use your Fine Grain Token.

Do not put your token directly into the repository URL or MATLAB scripts.

## Problem 2 – Push rejected (fetch first)

**Possible error:**

```text
! [rejected] main -> main (fetch first)
error: failed to push some refs
```

This means GitHub contains changes that are not present in your local repository.

**Solution:**

First pull the latest changes:

```matlab
!git pull origin main
```

If the pull succeeds, try pushing again:

```matlab
!git push origin main
```

If Git reports merge conflicts, resolve them before committing and pushing.

Do not use `git push --force` to get around this problem, particularly when working in an organisation repository.

## Problem 3 – Untracked files

**Possible output:**

```text
Untracked files:
    new_model.m
```

This means Git has detected a new file but has not yet added it to version control.

**Solution:**

```matlab
!git add new_model.m
!git commit -m "Add new MATLAB model"
!git push origin main
```

## Problem 4 – Permission denied when using git clean

**Possible error:**

```text
warning: failed to remove resources/project/...:
Permission denied
```

This can happen when MATLAB or the operating system protects files or folders.

It does not necessarily indicate a GitHub connection problem.

To check whether your repository is synchronised:

```matlab
!git status
```

If you see:

```text
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
```

Your tracked files are synchronised.

You can also check which untracked files Git would remove without actually deleting anything:

```matlab
!git clean -nd
```

Do not delete MATLAB project resource folders manually unless you know they are safe to remove.

## Problem 5 – Merge conflicts

A merge conflict occurs when two versions of a file have been changed independently and Git cannot automatically combine them.

**Solution:**

1. Run:

   ```matlab
   !git status
   ```

2. Identify the conflicting files.
3. Open each file in MATLAB.
4. Review the conflicting sections.
5. Keep the correct content and remove Git conflict markers.
6. Save the file.
7. Stage the resolved file:

   ```matlab
   !git add filename.m
   ```

8. Complete the merge:

   ```matlab
   !git commit -m "Resolve merge conflict"
   ```

9. Push:

   ```matlab
   !git push origin main
   ```

# 11. Useful Git commands reference

These are the most useful commands to keep handy when working with MATLAB and GitHub.

| Command | Function |
|---|---|
| `!git status` | Check repository status |
| `!git remote -v` | Check GitHub connection |
| `!git fetch origin` | Check for remote updates |
| `!git pull origin main` | Download and merge GitHub changes |
| `!git add .` | Stage all changes |
| `!git add filename.m` | Stage one specific file |
| `!git commit -m "Message"` | Commit changes |
| `!git push origin main` | Upload changes |
| `!git diff` | View unstaged changes |
| `!git diff main origin/main` | Compare local and remote tracked files |
| `!git log --oneline -10` | View the last ten commits |
| `!git clean -nd` | Preview untracked files Git would remove |

# 12. Important recommendations for collaborative projects

When multiple people are working on the same MATLAB repository:

1. Always pull before starting work.
2. Avoid having multiple people edit the same files simultaneously.
3. Commit regularly using meaningful commit messages.
4. Push completed work so everyone can access it.
5. Never force-push to the shared `main` branch.
6. Never commit passwords, access tokens or other sensitive information.
7. Consider using separate branches for larger developments or experimental changes.
8. Make sure all MATLAB files are saved before committing.

For larger collaborative projects, consider using feature branches and pull requests so changes can be reviewed before being merged into `main`.

---

# 13. Quick-start reference

For everyday use, the following is all that is normally required.

**START WORK – Get the latest GitHub version:**

```matlab
!git pull origin main
```

**FINISH WORK – Upload your MATLAB changes:**

```matlab
!git add .
!git commit -m "Describe your changes"
!git push origin main
```

**CHECK – Confirm everything is synchronised:**

```matlab
!git fetch origin
!git status
!git diff main origin/main
```

If the repository is clean and the local and remote branches are up to date, your MATLAB project is synchronised with GitHub.

**Repository:** SUSF-Starworks/MATLAB-model-WillnAdi

**GitHub URL:** https://github.com/SUSF-Starworks/MATLAB-model-WillnAdi

**Branch:** main

**Authentication:** Fine Grain Token

**Primary workflow:** Pull → Develop → Commit → Push

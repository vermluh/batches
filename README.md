# Collection of useful (more or less) batch and script files #
## DelAll.cmd ##
Script used to clear the directory structure beneath the directory defined in variable `%ALLGEMEIN%`. After removing all content the first level of child directories will be rebuilt.

## DelAllV2.cmd ##
Cleaner version of `DelAll.cmd`.

## GetGitVersionInfo.cmd ##
Can be used to extract the current branch and latest commit hash. Can be used as a partial replacement for subversion's `subwcrev` command to include commit hash information into source code.

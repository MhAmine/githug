% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/git_branch_rename.R
\name{git_branch_rename}
\alias{git_branch_rename}
\title{Rename a branch}
\usage{
git_branch_rename(from, to, repo = ".")
}
\arguments{
\item{from}{Name of the existing branch}

\item{to}{New name for the branch}

\item{repo}{Path to a Git repo. If unspecified, current working directory is
checked to see if it is or is inside a Git repo.}
}
\description{
Rename an existing local branch. It's fine to rename the branch you're on.
}
\details{
Convenience wrapper around
\code{\link[git2r:branch_create]{git2r::branch_rename}()}.
}
\examples{
repo <- git_init(tempfile("githug-branches-"))
owd <- setwd(repo)

## commit so that master branch exists
writeLines("Well, we're not in the middle of nowhere...", "nowhere.txt")
git_commit("nowhere.txt", message = "... but we can see it from here.")
git_branch_list()

## rename master
git_branch_rename("master", "louise")
git_branch_list()

setwd(owd)
}


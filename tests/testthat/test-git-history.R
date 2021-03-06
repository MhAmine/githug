context("git history")

test_that("git_history messages when no commits yet", {
  tpath <- init_tmp_repo()
  expect_message(git_history(repo = tpath), "No commits yet")
})

test_that("git_history passes, eg, n and reverse through", {
  tpath <- init_tmp_repo()
  write_file("a", dir = tpath)
  git_commit(all = TRUE, message = "a", repo = tpath)
  write_file("b", dir = tpath)
  git_commit(all = TRUE, message = "b", repo = tpath)
  write_file("c", dir = tpath)
  git_commit(all = TRUE, message = "c", repo = tpath)
  expect_identical(nrow(git_history(repo = tpath, n = 2)), 2L)
  expect_identical(nrow(git_history(repo = tpath, n = 10)), 3L)
  expect_identical(git_history(repo = tpath)$message, c("c", "b", "a"))
  expect_identical(git_history(reverse = TRUE, repo = tpath)$message,
                   c("a", "b", "c"))
})

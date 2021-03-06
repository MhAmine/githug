context("gh PATs & usernames")

test_that("we can retrieve github PAT from env var", {

  ## default to GITHUB_PAT
  withr::with_envvar(
    c("GITHUB_PAT" = "GITHUB_PAT", "GITHUB_TOKEN" = "GITHUB_TOKEN"), {
      pat <- gh_pat()
    })
  expect_identical(pat, c("GITHUB_PAT" = "GITHUB_PAT"))

  ## if no GITHUB_PAT, then GITHUB_TOKEN
  withr::with_envvar(
    c("GITHUB_PAT" = NA, "GITHUB_TOKEN" = "GITHUB_TOKEN"), {
      pat <- gh_pat()
    })
  expect_identical(pat, c("GITHUB_TOKEN" = "GITHUB_TOKEN"))

  ## if user specifies, that takes precedence
  withr::with_envvar(
    c("GITHUB_PAT" = "GITHUB_PAT", "GITHUB_TOKEN" = "GITHUB_TOKEN",
      "a" = "a"), {
        pat <- gh_pat("a")
      })
  expect_identical(pat, c("a" = "a"))

})

test_that("we don't retrieve github PAT when we should not", {

  ## none of defaults exist?
  withr::with_envvar(c("GITHUB_PAT" = NA, "GITHUB_TOKEN" = NA), {
    pat <- gh_pat()
  })
  expect_identical(pat, "")

  ## no defaults and user-specified env var doesn't exist either
  withr::with_envvar(c("GITHUB_PAT" = NA, "GITHUB_TOKEN" = NA), {
    pat <- gh_pat("a")
  })
  expect_identical(pat, "")

  ## defaults exist but user is asking for something else
  withr::with_envvar(c("GITHUB_PAT" = "GITHUB_PAT",
                       "GITHUB_TOKEN" = "GITHUB_TOKEN"), {
    pat <- gh_pat("a")
  })
  expect_identical(pat, "")

})

test_that("we can get authenticated username from valid PAT", {
  skip_if_no_GitHub_API
  ## TO PONDER: for tests to work for others, this should be less specific
  expect_true(gh_username() %in% c("jennybc", "githugci"))
})

test_that("we can't get authenticated username from bad or empty PAT", {
  skip_if_no_GitHub_API
  expect_error(gh_username("nope"), "Bad credentials")
  expect_error(gh_username(gh_pat("nope")), "Requires authentication")
})

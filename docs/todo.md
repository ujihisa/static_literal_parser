# TODO

## Parser correctness

- [ ] Treat explicitly supplied `false` and `nil` constants as present values.
  - **Why:** Constant lookup currently uses a truthiness check, so valid values can be mistaken for missing constants. This affects both top-level and nested constant lookup.
  - **Done when:** Lookup distinguishes a missing key from a key whose value is `false` or `nil`, and regression tests cover both values at the top level and in nested constants.

## Ruby compatibility

- [ ] Define the supported Ruby version range and align CI with it.
  - **Why:** The CI matrix currently covers Ruby 3.0 through 3.4, while project history and documentation imply support for older versions. The supported range should be clear to users and checked automatically.
  - **Done when:** The minimum and maximum supported Ruby versions are stated in project documentation, and CI tests the declared range, including its endpoints and the newest supported Ruby version.

## Release information

- [ ] Reconcile the gemspec release metadata with the project changelog and published releases.
  - **Why:** The gemspec date is `2020-11-01`, while the changelog ends at version 1.3.1 and later commits contain compatibility updates. Inconsistent metadata makes it difficult to tell what has actually been released and supported.
  - **Done when:** The gem version, release date (if retained), and changelog entries accurately describe the published releases; unreleased changes are clearly distinguished from released changes.

## CI improvements

- [ ] Add a gem build check to GitHub Actions.
  - **Why:** The existing workflow runs the test script but does not check that the gem can be packaged from the repository contents.
  - **Done when:** CI successfully builds the gem from the checked-out source, and a packaging failure causes the workflow to fail.


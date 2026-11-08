# Todos

## Release information

* [x] Reconcile the gemspec release metadata with the project changelog and published releases.
  * **Why:** The gemspec previously listed `2020-11-01`, while the changelog omitted published version 1.3.0. Inconsistent metadata made it difficult to tell what had actually been released and supported.
  * **Done when:** The gemspec version and date (if retained) are checked against the published gem history, the changelog accurately describes released versions, and any unreleased changes are clearly labeled as unreleased.

## CI improvements

* [x] Add a gem build check to GitHub Actions.
  * **Why:** The workflow previously ran the test script without checking whether the gem could be packaged from the repository contents.
  * **Done when:** CI successfully builds the gem from the checked-out source, and a packaging failure causes the workflow to fail.

* [x] Upgrade the GitHub Actions checkout action from its legacy major version.
  * **Why:** The workflow previously used `actions/checkout@v2`, an old major that risked incompatibility with current GitHub-hosted runners and missed upstream fixes.
  * **Done when:** The workflow uses a supported `actions/checkout` major version and its push and pull request runs complete successfully.

## Ruby compatibility

* [x] Define the supported Ruby version range and align CI with it.
  * **Why:** The changelog says Ruby 2.6.6 or later is supported, but the CI matrix originally covered Ruby 3.0 through 3.4. Users need a clear minimum version, and CI should check both that minimum and a current Ruby version.
  * **Done when:** The minimum supported Ruby version and the CI compatibility policy are stated in project documentation, and CI tests the declared minimum plus the current Ruby version(s) the project chooses to support.

## Parser correctness

* [x] Treat explicitly supplied `false` and `nil` constants as present values.
  * **Why:** Constant lookup currently uses a truthiness check, so valid values can be mistaken for missing constants. This affects both top-level and nested constant lookup.
  * **Done when:** Lookup distinguishes a missing key from a key whose value is `false` or `nil`, and regression tests cover both values at the top level and in nested constants.


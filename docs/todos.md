# Todos

## Release information

* [x] Release version 1.3.2 with the false/nil constant lookup fix.
  * **Why:** Users need a published gem containing the false/nil constant lookup fix, and the release should be verifiable on RubyGems.org.
  * **Done when:** The gemspec and changelog identify version 1.3.2, the gem builds successfully, version 1.3.2 is published on RubyGems, and RubyGems.org confirms it as the latest version.

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

* [ ] Test the built gem as an installed package in CI.
  * **Why:** The workflow builds the gem, but the test suite loads the library directly from `lib/`, so it would not catch a package that builds but cannot be installed or loaded correctly.
  * **Done when:** CI installs the generated gem into an isolated gem home and successfully requires and exercises the installed package, separately from the source-tree test run.

* [ ] Limit GitHub Actions to the permissions required by the test workflow.
  * **Why:** The workflow only checks out source, runs tests, and builds the gem, but the repository currently grants `GITHUB_TOKEN` write permissions by default and allows Actions to approve pull requests.
  * **Done when:** The workflow explicitly grants only `contents: read`, the repository default token permission is read-only, and Actions is not allowed to create or approve pull requests; the workflow still succeeds.

* [ ] Require successful CI checks before merging changes to `master`.
  * **Why:** There is no branch protection rule or ruleset, so pull requests can be merged even when the Ruby matrix fails.
  * **Done when:** A rule targets `master`, requires pull requests and the Ruby matrix checks to pass before merging, and its bypass policy matches the repository's intended maintenance workflow.

## Security documentation

* [ ] Clarify the security guarantees and limits of parsing untrusted Ruby strings.
  * **Why:** The repository description says parsing without `eval` makes the parser safe, but the array-based constants API uses `Object.const_get`, which follows Ruby's normal constant lookup behavior and may invoke autoloading or `const_missing`; the parser also has no resource limits for hostile inputs.
  * **Done when:** The repository description and README explain that source expressions are parsed rather than evaluated, describe side effects possible through array-based constant lookup, avoid presenting the gem as a general sandbox, and document any input-size or trust assumptions.

## Ruby compatibility

* [x] Define the supported Ruby version range and align CI with it.
  * **Why:** The changelog says Ruby 2.6.6 or later is supported, but the CI matrix originally covered Ruby 3.0 through 3.4. Users need a clear minimum version, and CI should check both that minimum and a current Ruby version.
  * **Done when:** The minimum supported Ruby version and the CI compatibility policy are stated in project documentation, and CI tests the declared minimum plus the current Ruby version(s) the project chooses to support.

## Parser correctness

* [x] Treat explicitly supplied `false` and `nil` constants as present values.
  * **Why:** Constant lookup currently uses a truthiness check, so valid values can be mistaken for missing constants. This affects both top-level and nested constant lookup.
  * **Done when:** Lookup distinguishes a missing key from a key whose value is `false` or `nil`, and regression tests cover both values at the top level and in nested constants.


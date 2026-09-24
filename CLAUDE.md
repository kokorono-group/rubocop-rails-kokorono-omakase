# rubocop-rails-kokorono-omakase

Kokorono's shared RuboCop configuration, layered on rubocop-rails-omakase. See `README.md` for what it adds and how apps consume it.

## This repository is public

Anyone on the internet can read every commit, issue, PR body and comment here, and history is permanent even after a force-push. Never write any of the following into files, commit messages, PR descriptions or comments:

- Secrets: tokens, API keys, passwords, credentials, private URLs.
- Internal company information: customer or employee data, internal hostnames, private repo contents, business details, or links to internal documents.
- Local machine details, such as absolute paths from a developer's checkout.

Referring to a private `kokorono-group` repo by name is fine; quoting or summarizing its contents is not.

## Gemfile

- **Never version-constrain a gem in the `Gemfile`.** `Gemfile.lock` carries the resolved versions, so the `Gemfile` lists `gem "name"` only. A routine upgrade is then a `Gemfile.lock`-only diff, and Dependabot raises each unreviewed major as its own PR.
- **Constrain only for a very good reason**, such as avoiding a known-breaking release or enforcing a required floor. When you do, explain the reason in a comment on the same or preceding line (e.g. `gem "pagy", "< 43" # Too many breaking changes in v43`). A constraint with no stated reason leaves the next reader unable to tell whether it is safe to drop.
- **Every gem carries a comment explaining its purpose.** A gem with no stated purpose cannot be judged safe to remove once it stops being used.

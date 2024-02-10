# Contributing

## Introduction

This document outlines the process for updating the charter of the
Newcastle Cybersecurity Group (NCSG) using a pull request (PR) and approval
from another organiser, with all status checks configured to pass before
merging the changes.

Additionally, it includes guidance on optionally
applying pre-commit hooks using Nix. Required code for
this process exists in the repository already and can be leveraged
to ensure consistent check processes as the status checks configured.

## Change Process

To propose changes to the charter, follow these steps:

1. **Fork the Repository**

   - Fork the repository containing the NCSG charter to your own GitHub
     account.

2. **Create a New Branch**

   - Create a new branch on your forked repository. Use a descriptive name
     for the branch related to the changes you are proposing.

3. **Make Changes**

   - Make the necessary updates to the charter document in your branch.
     Ensure that the changes comply with the guidelines outlined in the
     charter update process.

4. **Submit a Pull Request (PR)**

   - Once the changes are made, submit a PR from your branch to the main
     repository's master branch. Provide a clear and concise description of
     the proposed changes in the PR description.

5. **Status Checks**

   - All status checks configured for the repository must pass before the PR
     can be merged. These status checks may include automated tests, code
     formatting checks, and other quality assurance measures.

6. **Approval**

   - Request approval for your PR from an organiser of the NCSG. The
     approving organiser should review the proposed changes to ensure they
     align with the group's objectives and principles.

7. **Address Feedback (if any)**

   - If any feedback or suggested modifications are provided during the
     review process, address them promptly in your PR. Make the necessary
     adjustments to the charter document as needed.

8. **Merge PR**

   - Once the PR has been approved by another organiser and all status checks
     are passing, the PR can be merged into the main repository's master
     branch.

9. **Update Documentation (if necessary)**

   - If significant changes were made to the charter, ensure that the
     documentation outlining the update process is also updated accordingly.

10. **Announce Changes**
    - Communicate the approved changes to the NCSG members through
      appropriate channels, such as group meetings, email, or messaging
      platforms.

## Status Checks

The status checks applied on this repository match the
pre-commit controls applied via nix; you can avoid status failures
by ensuring you've checked locally ahead of time for any changes.

Two paths exist to do this as described below depending on your
tooling preferences.

## Using Pre-commit Hooks via Nix Natively (Optional)

Using the pre-commit hooks from nix natively can be achieved by the below
steps:

1. **Install Nix**

   - Utilise the most suitable method of installing nix for
     your configuration. We'd recommend the [DeterminateSystems Installer](https://github.com/DeterminateSystems/nix-installer)
     however a number of avenues exist.

2. **Activate Ephemeral Shell**

   - Activate an ephemeral shell via the below command:

   ```sh
   nix develop
   ```

   - Loading the above shell will generate a
     `.pre-commit-config.yaml` file in the root of your repository

3. **Run All Checks**

   - Running the following command will apply all checks:

   ```sh
   nix flake check
   ```

   - Optionally, the ephemeral shell will include the `pre-commit`
     tool also, run any of the following checks in isolation if you require:

   ```sh
   pre-commit run actionlint
   pre-commit run deadnix
   pre-commit run nixfmt
   pre-commit run prettier
   pre-commit run statix
   pre-commit run statix-write
   pre-commit run typos
   ```

4. **Commit Changes**
   - Now, every time you commit changes to the repository, the pre-commit
     hooks will automatically format and validate the charter document
     according to the defined rules.

## Using Pre-commit Hooks via Docker (Optional)

Using the pre-commit hooks from docker can be achieved by the below
steps:

1. **Pull Image**

   - Pull the latest nixpkgs flake image via the following command:

   ```sh
   docker pull nixpkgs/nix-flakes:latest
   ```

2. **Utilise Docker Image in Current Directory**

   - Enter the docker instance via the following command:

   ```sh
   docker run --rm -it -v $(pwd):/tmp -w /tmp nixpkgs/nix-flakes:latest
   ```

3. **Activate Ephemeral Shell**

   - Activate an ephemeral shell via the below command:

   ```sh
   nix develop
   ```

   - Loading the above shell will generate a
     `.pre-commit-config.yaml` file in the root of your repository

4. **Run All Checks**

   - Running the following command will apply all checks:

   ```sh
   nix flake check
   ```

   - Optionally, the ephemeral shell will include the `pre-commit`
     tool also, run any of the following checks in isolation if you require:

   ```sh
   pre-commit run actionlint
   pre-commit run deadnix
   pre-commit run nixfmt
   pre-commit run prettier
   pre-commit run statix
   pre-commit run statix-write
   pre-commit run typos
   ```

5. **Commit Changes**
   - Now, every time you commit changes to the repository, the pre-commit
     hooks will automatically format and validate the charter document
     according to the defined rules.

## Shortcut Method

For both the docker and nix routes, you can do the following commands
to run checks without some of the intermediate steps:

### Nix

```sh
nix flake check
```

### Docker

```sh
docker run --rm -it -v $(pwd):/tmp -w /tmp nixpkgs/nix-flakes:latest nix flake check
```

## Conclusion

Following this process ensures transparency, collaboration, and
accountability in updating the repository.

By leveraging pull requests and approvals, along with rigorous status checks
and optional pre-commit hooks, the integrity and quality of the charter can be
maintained while accommodating necessary updates and improvements.

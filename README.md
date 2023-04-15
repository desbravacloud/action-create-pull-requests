Action Auto Create Pull Requests
===========================

This action automates the creation of Pull Requests from source branch to target branch if it does not exists.

## Inputs

### `origin-branch`
**Not-Required:** The source branch name.

### `target-branch`
**Required:** The target branch name.

### `custom-title`
**Not-Required:** The PR title. Default `"PR created automatically."`.

### `custom-body`
**Not-Required:** The PR body message.

## Example usage

Simple usage:

```yaml
uses: actions/action-create-pull-requests@v1
with:
  target-branch: 'main'
```

Full usage:
```yaml
uses: actions/action-create-pull-requests@v1
with:
  origin-branch: 'develop'
  target-branch: 'main'
  custom-title: 'PR created'
  custom-body: 'Please, check thease changes'
```

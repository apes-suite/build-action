# build-action
Github action to build an APES solver

This action utilizes the apes-pyenv docker container to run the
build phase with waf.

## Inputs

### `waf-args`

**Required** The arguments to pass to waf. Default `"configure build"`.
Note, that the mpicmd is preset to run mpiexec with oversubscription.

### `path`

**Required** The (relative) path in the project to run the bin/waf
command in. This directory will be copied into the home of the
apes user, and `bin/waf` will be executed inside this directory.
Default is `"."`.

### `obtain`

**Required** The (relative) path in the `path` directory to copy
back from the users workspace into the github workspace.
Default is `"build"`.


## Example usage

```
    uses: apes-suite/build-action@v1
    with:
      waf-args: 'configure build --targets=ateles'
      path: '.'
      obtain: 'build'
```

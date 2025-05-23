# build-action
Github action to build an APES solver

This action utilizes the apes-pyenv docker container to run the
build phase with waf.

[![Run test](https://github.com/apes-suite/build-action/actions/workflows/test.yml/badge.svg)](https://github.com/apes-suite/build-action/actions/workflows/test.yml)

## Inputs

### `waf-args`

**Required** The arguments to pass to waf. Default `"configure build"`.
Note, that the mpicmd is preset to run mpiexec with oversubscription.

### `path`

**Required** The (relative) path in the project to run the bin/waf
command in.
Default is `"."`.


## Example usage

```
    uses: apes-suite/build-action@v1
    with:
      waf-args: 'configure build --targets=ateles'
      path: '.'
```

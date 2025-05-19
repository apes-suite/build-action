# build-action
Github action to build an APES solver

## Inputs

### `waf-args`

**Required** The arguments to pass to waf. Default `"build"`.
Note, that the mpicmd is preset to run mpiexec with oversubscription.

## Example usage

```
    uses: apes-suite/build-action@v1
    with:
      waf-args: 'build --targets=ateles'
```

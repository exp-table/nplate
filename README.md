<img align="right" width="150" height="150" top="100" src="./assets/readme.png">

# nplate • ![license](https://img.shields.io/github/license/abigger87/femplate?label=license) ![solidity](https://img.shields.io/badge/solidity-^0.8.15-lightgrey)

A **Simple**, **Minimalist** Template for Noir Projects.

## Getting Started

Click [`use this template`](https://github.com/whitenois3/nplate/generate) to create a new repository with this repo as the initial state.

## Development

**Setup**

You need both `nargo` and `foundry` installed.

Regarding the installation of `nargo`, please refer to its repo [here](https://github.com/noir-lang/noir).

**Building**

```bash
cd circuits
# generates the Solidity contract
nargo codegen-verifier
# generates a file "p.proof" in circuits/proofs
nargo prove p
```

**Testing**

Before testing, be sure you have generated the updated Solidity verifier contract as well as a valid proof!

```bash
forge test --ffi
```

## License

[AGPL-3.0-only](https://github.com/abigger87/femplate/blob/master/LICENSE)

## Acknowledgements

- [femplate](https://github.com/abigger87/femplate)
- [basic_mul_noir_example](https://github.com/vezenovm/basic_mul_noir_example)
- [foundry-noir](https://github.com/Maddiaa0/foundry-noir)

## Disclaimer

_These smart contracts are being provided as is. No guarantee, representation or warranty is being made, express or implied, as to the safety or correctness of the user interface or the smart contracts. They have not been audited and as such there can be no assurance they will work as intended, and users may experience delays, failures, errors, omissions, loss of transmitted information or loss of funds. The creators are not liable for any of the foregoing. Users should proceed with caution and use at their own risk._

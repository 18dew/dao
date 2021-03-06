# The DAO framework

This is the a light-weight framework for modular systems of [Ethereum](https://ethereum.org/) contracts. It is meant to be used with Ethereum, or other chains that supports Ethereum contracts. It will get a better name.

The contracts are written in the [Solidity](http://solidity.readthedocs.org/en/latest/index.html) language. The purpose of this library as of now is to act as a template for extending, or just as an example of how to write Solidity contracts. This is a **contracts-only library**, but there are some javascript utilities for deploying and testing.

The architecture is a new iteration of the architecture that I outlined in [these tutorials](https://docs.erisindustries.com/tutorials/solidity/solidity-1/), and that I had implemented in a now outdated LLL DApp named [The People's Republic of Doug](https://github.com/androlo/EthereumContracts).  

NOTE: Ethereum is still experimental, and so is this code. Using this on a chain where Ether has real value, or in any form of production environment is **not** recommended.

## Table of Content

- [Getting Started](#getting-started)
- [Dependencies and Tools](#dependencies-and-tools)
- [Building, Testing and Documentation](#btd)
- [Structure](#structure)
- [Javascript Utilities](#javascript-utilities)
- [DAO framework?](#dao-framework)
- [Troubleshooting](#troubleshooting)
- [Business](#business)
- [Licence](#licence)

## Getting started

A good demo will become available during February.

There are [Tutorials](./docs/Tutorials.md). 

Each module has a README file that explains what it does, which is also useful. They are all referenced in the [Structure](#structure) section of this document.

HTML documentation for the contracts in each module can be found in `<module name>/doc/index.html`. This goes for the standard library code as well.

To understand how systems are kept intact, maybe take a look at the document on [Permission Analysis](./docs/Permission_Analysis.md).

## Dependencies and Tools

The tools are only tested on 64 bit Ubuntu 14.04+

[node.js](https://nodejs.org/en/) is a requirement for most of the scripts. The scripts are based on the official javascript APIs, such as the [Ethereum web3.js library](https://github.com/ethereum/web3.js), and are used for deployment and testing etc.

Command-line [Gulp](http://gulpjs.com/) is optional, but has tasks for building and deploying.

You need [solc](https://github.com/ethereum/solidity) on your path to compile locally (latest dev).

You need [NaturalDocs](http://www.naturaldocs.org/) on your path to build html documentation (shell script version, not .bat).

**Formal proofs**

You need [why3](http://why3.lri.fr/) (latest release).

Solidity to why3 is still experimental, and is not required for normal usage.

<a name="btd">
## Building, Testing, and Documentation

Building, testing and doc generation can be done for each module separately. Check the README in each folder for instructions. It can also be done for the entire framework at once using Gulp.

NOTE: This requires that the dependencies are in place.

##### Building

NOTE: You need `solc` on path. If this fails it will mess up the build folders, so you need to download again, or `git stash`.

Gulp: `$ gulp build:all`

##### Testing

Gulp: `$ gulp test:all`

##### Docs

NOTE: You need [NaturalDocs](http://www.naturaldocs.org/) on your path to build html documentation (shell script version, not .bat).

Gulp: `$ gulp htmldoc:all`

## Structure

These are the different parts of the framework.

**Modules**

- [dao-core](https://github.com/smartcontractproduction/dao/blob/master/dao-core/README.md) - core contracts.
- [dao-currency](https://github.com/smartcontractproduction/dao/blob/master/dao-currency/README.md) - a basic sub-currency.
- [dao-users](https://github.com/smartcontractproduction/dao/blob/master/dao-users/README.md) - some basic user management.
- [dao-votes](https://github.com/smartcontractproduction/dao/blob/master/dao-votes/README.md) - contracts for public voting.

**Utilities**

- [dao-stl](https://github.com/smartcontractproduction/dao/blob/master/dao-stl/README.md) - shared, standard contracts.

## Javascript Utilities

There are a number of utilities that comes with this library, even though it is a contracts-only library.

Getting these utilities documented and properly tested is part of the `0.2.0` milestone.

#### Deployer

`Deployer` is in the script folder. It can deploy contracts, and keeps records of the contracts it deploys. It also automatically links contracts with libraries, provided those libraries can be found in the same folder as the contracts (.bin and .abi files).
 
#### ContractService

`ContractService` is a base class for contract services, which is wrappers for web3 contracts. The wrappers does any extra conversion that's needed, for example `bytes32` <-> ASCII, timestamps to Date objects, and such. It can be found in the scripts folder as well.

Contract services also use solidity events to hold transactions until the event is fired. This is the most secure way of dealing with return values from non-constant functions in Ethereum, because the events are specific to not only the contract in question and the event type, but the hash of the transaction as well. This in combination with the contract systems of events and error codes makes it possible to see exactly what the result of a transaction were, and to know when it was processed.
  
Sometimes it is smart to do some calls to check the state of a contract before trying a costly transaction. If that is the case, then those functions can be added to the service as well and run before the actual transaction.
  
#### Errors
 
`Errors` is in the script folder, and can be used to convert error codes (numbers) to the name that is used in the errors contract in `dao-stl`, e.g. `error(2000) = 'ACCESS_DENIED'`. Good for logging and such.

#### Module specific utilities

If a module has its own specific utilities, then it is found in the script-folder of the module, e.g. `dao-core/scripts`. They can contain contract services for the solidity contracts, deployment scripts, small utilities, and tests.

## DAO framework

Yes, this is a framework for DAOs (Decentralized Autonomous Organizations), although one could argue that it is not, because if there are administrator accounts then the organization is not really autonomous. This is correct, but it is *possible* to create autonomous systems, or those that are "somewhat autonomous" (through the use of voting and other mechanisms).

It really works like Ethereum contracts. Ethereum contracts are often called smart-contracts even though they don't have to be smart, and they don't have to be [legal] contracts; the Ethereum protocol can't be used to check if that is indeed what they are. Similarly, the DAO framework lets you create DAOs, but they don't have to be distributed, autonomous, or organizations. You can create a fully managed single user system and deploy it on an offline block-chain node, nothing in this framework will prevent you from doing that, but if you want to create a DAO you can do that too.

## Troubleshooting

This library is open source only to show some working Solidity code, because there is not a lot of resources around. I look into issues, but there's no official support or feature-request system. 

This library is only officially supported on 64 bit Ubuntu 14.04+, although it should work on recent OSX versions. I will look into building on Windows when I have time.

**I don't know what any of this is**

https://ethereum.org/

**I don't know how to read the contract code**

http://solidity.readthedocs.org/en/latest/index.html

**I understand Solidity syntax, but not the purpose of the contracts**

This is probably because this is a framework, and much of the code are architectural elements. Also there is lots of imports and such. To understand it, you might want to read the overview section of the [User Manual](./docs/Manual.md#overview), and the README for each component. There are explanations and diagrams that shows how it works. The [Permission Analysis](./docs/Permission_Analysis.md) is a good read as well.

If you have checked it out and still don't get it, then it's probably because the documentation is not clear. It will improve over time.

**I understand what the code does, but I don't understand why I should use it**

The framework is useful because it is fairly simple, but has most of the fundamentals like permissions structures, registries, tests, docs, etc. The quality requirements both in terms of code and design are very high. It pushes the limits on what you can do with Ethereum contracts and Solidity. Finally, it is essentially a more well-engineered version of a framework that has been worked on since before Solidity existed, so there's been time to find mistakes, and to correct them.

The bad thing is it's a framework that I (the author) made to use in my own projects, which have higher priority then the framework itself. This means that development can be slow at times, and support might not be good.

Maybe it's good for someone, maybe not.

**I can't build the contracts**

This is normally because you don't have [solc](https://github.com/ethereum/solidity) installed and on your path. `solc` is a C++ library but they are thinking about building a command-line version in javascript, that extends the Emscripten compiled version, which will make it easier to install and use.

**I can't test the contracts**

This is normally because the contract build folders has been tampered with, or because sol-unit can't be installed. The reason for sol-unit failure could be missing dependencies. sol-unit uses javascript ethereum which depends on C libraries, which you may not be able to build. 

**I can't build html documentation**

This could be because you don't have [NaturalDocs](http://www.naturaldocs.org/) on your path.


## Business

**Hiring Me**

I work with Ethereum contracts and various different block-chain clients, and is available for projects.

To contact me, send a personal message on linkedin: https://www.linkedin.com/in/andreas-olofsson-69465ba4

**Me Hiring**

I'm not hiring as of right now.

I will likely soon be looking for a node.js developer that is familiar with Ethereum and Ethereum-like tech and their javascript APIs/tools. If the position opens I will announce it.

## Licence

The entire framework is licensed under MIT.
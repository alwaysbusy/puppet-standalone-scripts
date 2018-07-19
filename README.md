# puppet-standalone-scripts

Script that install puppet standalone along with (possibly multiple) configurations. This is a companion to [vagrant-setup-puppet](https://github.com/alwaysbusy/vagrant-setup-puppet), being able to deploy the `/puppet` directory from a repository making use of this script onto a server, even if that server is already using puppet managed by a server. This is handled by not using the `puppet.conf` file.

## Scripts

### `puppet-install`

Installs the latest version of the puppet agent onto a machine. The script accepts a single positional argument, the directory that contains the root of the puppet code. A flag, `--conf` can be specified after the positional which will set the default `puppet.conf` file to be the one in the specified puppet root.

### `puppet-modules`

Installs the modules specified in the `forge-modules` files. This requires two positional arguments: the path to the puppet code directory, and the name of the environment for which modules should be made available.

### `puppet-apply`

Applies the configurations to the machine. This requires two positional arguments: the path to the puppet code directory, and the name of the environment for which modules should be made available.

## Puppet Code Directory

A well formed puppet code directory follows the format below:

``` plain:
puppet
- modules
| - module1
| | - manifests
| | | - init.pp
| | | | ...
| | | ...
| - module2
| | - manifests
| | | - init.pp
| | | | ...
| | | ...
| | ...
- environments
| - production
| | - manifests
| | | - site.pp
| | | | ...
| | - modules
| | - environment.conf
| | - forge-modules
| - development
| | -manifests
| | | - site.pp
| | | | ...
| | - modules
| | - environment.conf
| | - forge-modules
| | ...
- forge-modules
```

The root directory should contain both `modules` and `environments` directories. `modules` hosts custom modules which would be reused across all environments, and would be checked into version control. Each module is a directory containing (as a minimum) a `manifests` directory with an `init.pp` file. Please see the [puppet language specification](https://puppet.com/docs/puppet/5.5/lang_visual_index.html) for writing puppet manifests (`.pp` files). The `environments` directory should include a folder for each environment that will be confgured; `production` is the default and so is advisable to include. Within the individual environment there should be `modules` and `manifests` directories, with a `site.pp` manifest included. This is the initial manifest that will be run for an environment, with all other manifests and modules being called from it. `forge-modules` files can be placed at the root and in each environment, containing a newline separated list of modules to install from [Forge](https://forge.puppet.com/).

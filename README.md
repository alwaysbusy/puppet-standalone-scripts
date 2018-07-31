# puppet-standalone-scripts

Script that install puppet standalone along with (possibly multiple) configurations. This is a companion to [vagrant-setup-puppet](https://github.com/alwaysbusy/vagrant-setup-puppet), being able to deploy the `/puppet` directory from a repository making use of this script onto a server, even if that server is already using puppet managed by a server. This is handled by not using the `puppet.conf` file.

## Scripts

### `puppet-install`

Installs the latest version of the puppet agent onto a machine. The script accepts a single positional argument, the directory that contains the root of the puppet code. A flag, `--conf` can be specified after the positional which will set the default `puppet.conf` file to be the one in the specified puppet root.

### `puppet-modules`

Installs the modules specified in the `forge-modules` files. This requires two positional arguments: the path to the puppet code directory, and the name of the environment for which modules should be made available.

### `puppet-apply`

Applies the configurations to the machine. This requires two positional arguments: the path to the puppet code directory, and the name of the environment for which modules should be made available.

### Helper scripts

The helper scripts are additional files which are not used as part of the puppet setup process but perform other functions that are useful in the creation of puppet configurations.

These scripts are generally written for Windows, whereas the install scripts are provided for *nix systems. This is due to the expectation that development work takes place on a Windows system whereas the deployed server is more likely to be running a linux distribution.

#### `hiera-eyaml-install`

Install the `hiera-eyaml` gem locally. This is not necessary when a machine is configured with puppet as the following resource can be included in the configuration:

``` puppet
package { 'hiera-eyaml':
    ensure   => installed,
    provider => 'puppet_gem'
}
```

#### `hiera-eyaml-keygen`

Generates new eyaml keys and stores them in the default location (`./keys`).

#### `hiera-eyaml-new-password`

Runs 'hiera-eyaml' to generate a new password and then encrypt in a format that can be used in a hiera configuration.

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

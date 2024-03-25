# Monitoring for Unity

[![Asset Store](https://img.shields.io/badge/npm-available-blue.svg?logo=npm)](https://www.npmjs.com/package/games.javier.upm.monitoring)
[![Donate](https://img.shields.io/badge/support-available-blue.svg?logo=paypal)](https://www.paypal.com/donate/?hosted_button_id=QY4PCGA8FMCC4)

Monitoring for Unity is the package made for the Unity's package manager to monitoring the device's performance.

## Features

- **iOS Support** : Get the CPU, GPU and RAM usage for iOS Devices.
- **Usage Samples** : Find samples directly from the UPM.

## Requirements

- `Unity 2022.3.22f1 [LTS] or later.`

## Installation

There are several methods available to install Monitoring for Unity into your project. Choose the one that best suits your needs. It's recommended to install via npm if you wish to keep the package up-to-date easily, as future releases and updates will be readily available.

### Installation via npm

To add Monitoring for Unity from a npm registry in Unity, follow the steps below:

1. Open your Unity project and navigate to `Edit > Project Settings > Package Manager`.
2. In the `Scoped Registries` section, click on the `+` button to add a new scoped registry.
3. Fill in the required fields:
    - Name: Enter `JavierGames`.
    - URL: Enter `https://registry.npmjs.org`.
    - Scope(s): Enter `games.javier.upm.monitoring`.
4. Click `Save` and close the Project Settings window.
5. Navigate to `Window > Package Manager`.
6. In the package manager window, select `Packages: My Registries`.
7. You should see the `games.javier.upm.monitoring` package listed there. Click `Install` to install the package.

Alternatively, you can directly modify your `Packages/manifest.json` file to add the new scoped registry and the dependency:

1. Add the following scope to the `scopedRegistries` in your `manifest.json` file:
```json
{
  "scopedRegistries": [
    {
      "name": "JavierGames",
      "url": "https://registry.npmjs.org",
      "scopes": ["games.javier.upm.monitoring"]
    }
  ]
}
```
2.	Then, add `games.javier.upm.monitoring` to the dependencies section of your `manifest.json` file:
```json
{
  "dependencies": {
    "games.javier.upm.monitoring": "0.0.0"
  }
}
```
Ensure to replace 0.0.0 with the version number of the Monitoring for Unity package you intend to install. Save your manifest.json file after making these changes.

### Installation via Cloning

To install Monitoring for Unity by cloning the repository and adding the package from disk, follow these steps:

1. Clone this repository to your local machine.
```shell
git clone https://github.com/javier-games/monitoring-for-unity.git
```
2. Open your Unity project and navigate to `Window > Package Manager`.
3. In the Package Manager window, click on the `+` icon in the top-left corner.
4. From the dropdown, select `Add package from disk...`.
5. A file explorer window will open. Navigate to the location where you cloned the repository.
6. Find and select the `package.json` file within the cloned repository and click `Open`.

Unity will automatically detect and install the package. The package should now be listed in the Package Manager.

### Install Specific Versions

Alternatively if you only need a specific version of the project you can select the `Add package from git URL...` and introduce the url of this repository.
```
https://github.com/javier-games/monitoring-for-unity
```
Also you can download the tarball file (`games.javier.upm.monitoring-{version}.tgz`) from the [releases section](https://github.com/javier-games/monitoring-for-unity/releases) of this repository and add it throw the `Add package from tarball...` option.

## Usage

Monitoring for Unity is designed with an intuitive interface to ensure a seamless and user-friendly experience. To use Monitoring for Unity in your projects, use the DeviceMonitor component methods to start and stop the tracking process. You can find a usage sample at the Unity Package Manage section of the package.

## License

Monitoring for Unity is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Contribution

Please read our [Contributing Guide](Documentation~/CONTRIBUTING.md) before submitting a Pull Request to the project.

## Support

For any questions or issues, please open a [new issue](https://github.com/javier-games/monitoring-for-unity/issues/new) on this repository.

## Donations

Monitoring for Unity is a open source project, and it's because of your support that we can stay up and running. If you find this project useful, please consider [making a donation](https://www.paypal.com/donate/?hosted_button_id=QY4PCGA8FMCC4). Your contribution will help us to maintain the project, and continue to develop new features. We appreciate your generosity!

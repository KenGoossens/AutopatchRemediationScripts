# Autopatch Remediation Scripts

This repository contains scripts designed to address and remediate policy conflicts that might prevent Windows Autopatch from deploying updates successfully. 
These scripts are intended for use with Microsoft Intune, aiding IT Administrators in ensuring that devices managed through Configuration Manager, GPO, WSUS, or co-managed with Intune are kept up to date without interference from conflicting policies.

## Overview

Windows Autopatch service aims to keep Windows devices up to date automatically, but policy conflicts can impede its functionality. 
The scripts in this repository detect such conflicts and remediate them, facilitating smoother operation of the Windows Autopatch service.

- **Detection Script**: Identifies policy conflicts that could prevent updates.
- **Remediation Script**: Applies necessary changes to resolve conflicts detected by the Detection Script.
- **Logging**: Both scripts generate logs in the Intune Management Extension Log folder for easy diagnostics via Intune.

## Prerequisites

Before implementing these scripts, ensure you have:

- Access to Microsoft Endpoint Manager (Intune).
- Appropriate permissions to add and assign PowerShell scripts in Intune.
- Tested the scripts in a non-production environment.

## Getting Started

1. **Clone the Repository**: Clone this repository to your local machine or download the scripts directly.

2. **Review and Test the Scripts**: Familiarize yourself with the script logic and test them in a controlled environment to understand their effects.

3. **Deploy via Intune**:
- Read more about the implementation and monitoring 

## Usage

- **Detection Script**: Run this script to scan for policy conflicts. It generates a log indicating whether any conflicts were detected.
- **Remediation Script**: If conflicts are detected, run this script to apply fixes. It modifies registry settings or policies that are causing conflicts.

## Contributing

Contributions to improve AutopatchRemediationScripts are welcome. Please feel free to submit issues, fork the repository, and send pull requests!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you encounter any problems or have suggestions, please open an issue on this repository.

---

We hope these scripts assist in making your Windows Autopatch deployment more effective and seamless. Thank you for using or contributing to Autopatch Remediation Scripts!

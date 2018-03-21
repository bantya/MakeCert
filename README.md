# MakeCert
💻 Make self-signed openssl certificates with ease on Windows OS!

This project is based on a gist by  [**Vikas Kapadiya @vikas5914**](https://gist.github.com/vikas5914/f4384d12866fd572bfc5bcf389e756e8#file-makecert-bat)

Using this file (makecert.bat) you can create a custom self-signed ssl certificates with ease.

## ⚡ Features:
1. Provide your own meta-data fields.
2. If you dont want to provide your own info, you can use the default values just by pressing enter.
3. Info preview before actual ssl certs generation.
4. If you dont approve the previewed info to be used, you can enter new info again.
5. Confirmation to generate your ssl certs.
6. Provide secondary fields (Country, State, Email etc.) in a single config file. **(v2.0.0)**

## 📃 Changelog:
**v2.0.0**:

1. Added support to set the Country, State, City, Organization, Organization Unit, Email in a config file.
2. Added support to use the config file for providing the above mentioned fields.
3. Command help added.
4. Functionality for generating `.key` and `.cert` files without `.cnf` file added.

## 🤔 How to use:
Download the [makecert.bat](https://raw.githubusercontent.com/bantya/MakeCert/master/makecert.bat) file to your desired folder and [add it to the system  path](https://www.howtogeek.com/118594/how-to-edit-your-system-path-for-easy-command-line-access/).

Sign out if required.

Use it from anywhere!

## ⚙ Options:
**--no-cfg** or **-n**: Use this option if you dont want `.cnf` file to be outputted.

**--set-config** or **-s**: Use this option to populate the config fields interactively.
The config file is stored at `%USERPROFILE%\makecert-config.ini`

The makecert-config.ini example:
```ini
COUNTRY=IN
STATE=MH
CITY=Mumbai
ORGANIZATION=example.com
ORGANIZATION_UNIT=Backend
EMAIL=administrator@example.com
```
The given config file does not exist out of the box. You have to generate it using this option.

**--use-config** or **-c**: Using this option you will have to provide the hostname and domain extension only. All the other data is grabbed from the config file.

**--open-repo** or **-o**: Open the project github repository in your browser.

**--help** or **-h**: Display the help regarding the options used.

## 📷 Screenshots:
![image](https://user-images.githubusercontent.com/16685565/35646358-f918b94a-06f4-11e8-8895-b4644edbf9b9.png)

![image](https://user-images.githubusercontent.com/16685565/35646371-08a947bc-06f5-11e8-85a9-e54b3c53f55c.png)

![image](https://user-images.githubusercontent.com/16685565/37725806-d0829f06-2d59-11e8-9fd8-edb744a21c8d.png)


### NOTE: The info to be provided must not contain any blank-space ( ), use hyphen (-) or underscore (_) instead!
### NOTE: This project assumes that the [openssl](https://github.com/openssl/openssl) is available on your system.

👍

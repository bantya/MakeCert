# MakeCert
Make self-signed openssl certificates with ease!

This project is based on a gist by  [**Vikas Kapadiya @vikas5914**](https://gist.github.com/vikas5914/f4384d12866fd572bfc5bcf389e756e8#file-makecert-bat)

Using this file (makecert.bat) you can create a custom self-signed ssl certificates with ease.

## Features:
1. Provide your own meta-data fields.
2. If you dont want to provide your own info, you can use the default values just by pressing enter.
3. Info preview before actual ssl certs generation.
4. If you dont approve the previewed info to be used, you can enter new info again.
5. Confirmation to generate your ssl certs.

![image](https://user-images.githubusercontent.com/16685565/35646358-f918b94a-06f4-11e8-8895-b4644edbf9b9.png)
![image](https://user-images.githubusercontent.com/16685565/35646371-08a947bc-06f5-11e8-85a9-e54b3c53f55c.png)

### NOTE: The info to be provided must not contain any blank-space ( ), use hyphen (-) or underscore (_) instead!
### NOTE: This project assumes that the [openssl](https://github.com/openssl/openssl) is available on your system.

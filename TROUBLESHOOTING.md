Troubleshooting
===============

## My laptop won't connect to the internet

First, check the date on your laptop. In some cases, we've seen laptops that
have somehow had their dates set to the far future. When this happens, it
[exposes a bug](http://crunchbang.org/forums/viewtopic.php?pid=394678#p394678)
in the networking layer that prevents it from connecting to the internet. If you
manually correct the date, it should connect fine.

If the date is correct, it's possible that your `/etc/resolv.conf` file has been
overwritten. To see if that's the case, do the following:

1. Hit **ctrl + alt + t** to open a terminal window.
1. Type `cat /etc/resolv.conf` and hit **enter**. You should see the following
   printed out:

```
nameserver 208.67.222.123
nameserver 208.67.220.123
```

If you don't see that, then you can fix the problem by correcting that file:

1. In the terminal window type `sudo echo -e "nameserver 208.67.222.123\nnameserver 208.67.220.123" > /etc/resolv.conf`
1. Triple check that you entered it EXACTLY as above. Then hit **enter**.
1. At the prompt, enter your password.
1. Reboot your computer.

Try connecting to the internet again, and hopefully it will be fixed.

## My web browser is having trouble showing some sites (specifically SSL sites)

This can sometimes happen when the laptop's date is set to a few years in the
future (we've seen this on some of our laptops after shipping them). If you
manually correct the date, your browser will no longer complain about expired
certificates.

## Worst case scenario

If all else fails, and you can't get your laptop working, a fresh reinstall of
Ubuntu will usually work. To reinstall, follow the [reinstallation instructions](https://github.com/codestarterorg/ubuntu-chromebook-installer#reinstall)
in the README.

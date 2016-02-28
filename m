From: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Subject: [PATCH v4 0/5] LG Optimus Black codename sniper support series
Date: Sun, 28 Feb 2016 13:39:40 +0100
Message-ID: <1456663185-14170-1-git-send-email-contact@paulk.fr>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This series requires lp872x regulator patches from the regulator tree[0] to work
at run-time but can be applied as-is.

Changes since v3:
* Switch to the already-defined devicetree vendor prefix for LG
* Enable the lp872x regulator in omap2plus_defconfig

Changes since v2:
* Add USB OTG support
* Add TWL4030 keypad support
* Drop references to P970 since other devices (e.g. KU5900) are supported too

Changes since v1:
* Remove lp872x patches that were accepted already from the series
* Explain why removing the invalid DVS GPIO warning is enough
* Update copyright notice on omap3-sniper.dts
* Rename the devicetree property for the enable GPIO to enable-gpios
* Rename function to enable GPIO to lp872x_hw_enable
* Add enable delays after requesting the enable GPIO
* Use IOPAD macros for pinmux description
* Mux the dp3t uart selection pins to gpio
* Restrict not-reset gpio controllers to only avoid reset when needed

This series introduces support for the LG Optimus Black, as described in the
patch adding devicetree support for the device.

In order to power the external mmc (mmc1), the lp872x regulator is used.
Its code had to be improved a bit to work on the device.

Note that the patch adding devicetree support for the device requires the
changes applied to the lp872x regulator, so all this is sent in one series
despite the fact they're different parts of the code.

[0]: https://git.kernel.org/cgit/linux/kernel/git/broonie/regulator.git/log/?h=topic/lp872x

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

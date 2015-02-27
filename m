From: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: [PATCH v3 0/3] ARM: dts: add openpandora device support
Date: Fri, 27 Feb 2015 22:26:36 +0100
Message-ID: <1425072399-23152-1-git-send-email-marek@goldelico.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

changes from v2:
- fix missing PIN_INPUT for penirq node
- added Reviewed-by and Tested-by

changes from v1:
- add new boards to makefile in patch 2,3 (don't add them
in separate commit together), fix gpmc issues (reported by Tony Lindgren)

- fix various issues reported by Grazvydas Ignotas
(drop internal pullups from pinmux as external are in place,
fix gpio buttons active state ...)

This series of patches adds initial device tree support for the
OpenPandora. The most important parts are working (display, keyboard,
touch, charging, fuel gauge, musb port, sd/mmc ports, leds, buttons).
Not yet supported are: usb host port, nubs, wifi, bluetooth, audio.

First patch add common dtsi file which is then used in 600mhz and 1ghz
variants of openpandora which support is added in patches 2 and 3.

H. Nikolaus Schaller (3):
  ARM: dts: omap3-pandora: add common device tree
  ARM: dts: omap3-pandora: add OMAP3530 600 MHz version
  ARM: dts: omap3-pandora: add DM3730 1 GHz version

 arch/arm/boot/dts/Makefile                  |   2 +
 arch/arm/boot/dts/omap3-pandora-1ghz.dts    |  70 +++
 arch/arm/boot/dts/omap3-pandora-600mhz.dts  |  65 +++
 arch/arm/boot/dts/omap3-pandora-common.dtsi | 640 ++++++++++++++++++++++++++++
 4 files changed, 777 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-pandora-1ghz.dts
 create mode 100644 arch/arm/boot/dts/omap3-pandora-600mhz.dts
 create mode 100644 arch/arm/boot/dts/omap3-pandora-common.dtsi

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

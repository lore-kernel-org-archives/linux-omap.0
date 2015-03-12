From: Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v6 0/6] wlcore: add device-tree support
Date: Thu, 12 Mar 2015 14:09:08 +0200
Message-ID: <1426162154-8716-1-git-send-email-eliad@wizery.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add device-tree support to the wlcore (wl12xx/wl18xx)
driver.

Update the current users to use the bindings instead
of pdata-quirks.

Finally, remove the deprecated wl12xx_platform_data
struct (along with the da850 board file code that
still uses it)

NOTE: all the platform patches were compile-tested
only. I'm looking for some wl12xx card (that i should
have somewhere) to test the wl12xx changes (wrt. clocks),
but haven't found it yet.

v6:
* Add Luca's patches to pass irq_trigger/freq
* Support wl12xx as well
* Update all relevant platforms

Eliad Peller (4):
  dt: bindings: add TI's wilink wireless device
  wlcore: add device-tree support
  ARM: dts: add wl12xx/wl18xx bindings
  wlcore: remove wl12xx_platform_data

Luciano Coelho (2):
  wlcore: set irq_trigger in board files instead of hiding behind a
    quirk
  wl12xx: use frequency instead of enumerations for pdata clocks

 .../devicetree/bindings/net/wireless/ti,wlcore.txt |  47 +++++++++
 arch/arm/boot/dts/am335x-evmsk.dts                 |  11 ++
 arch/arm/boot/dts/omap3-cm-t3517.dts               |  10 ++
 arch/arm/boot/dts/omap3-cm-t3730.dts               |  10 ++
 arch/arm/boot/dts/omap3-evm-common.dtsi            |  10 ++
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts         |   9 ++
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts         |   9 ++
 arch/arm/boot/dts/omap3-zoom3.dts                  |  10 ++
 arch/arm/boot/dts/omap4-panda-common.dtsi          |  10 ++
 arch/arm/boot/dts/omap4-sdp.dts                    |  11 ++
 arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi     |  10 ++
 arch/arm/mach-davinci/Kconfig                      |  11 --
 arch/arm/mach-davinci/board-da850-evm.c            | 112 ---------------------
 arch/arm/mach-omap2/pdata-quirks.c                 |  79 ---------------
 drivers/net/wireless/ti/wilink_platform_data.c     |  25 -----
 drivers/net/wireless/ti/wl12xx/main.c              |  63 ++++++++++--
 drivers/net/wireless/ti/wl12xx/wl12xx.h            |  28 ++++++
 drivers/net/wireless/ti/wlcore/boot.c              |   1 -
 drivers/net/wireless/ti/wlcore/debugfs.c           |   2 +-
 drivers/net/wireless/ti/wlcore/main.c              |  31 +++---
 drivers/net/wireless/ti/wlcore/sdio.c              |  64 ++++++++++--
 drivers/net/wireless/ti/wlcore/wlcore.h            |   5 +-
 drivers/net/wireless/ti/wlcore/wlcore_i.h          |   8 +-
 include/linux/wl12xx.h                             |  49 ---------
 24 files changed, 313 insertions(+), 312 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt

-- 
1.8.5.2.229.g4448466.dirty

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

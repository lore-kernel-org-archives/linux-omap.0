From: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: [PATCH 0/9] ARM: dts: omap3-gta04: Various devicetree updates.
Date: Sat, 25 Jan 2014 22:28:54 +0100
Message-ID: <1390685343-11663-1-git-send-email-marek@goldelico.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neilb-l3A5Bk7waGM@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This pathes fix some wrong property issues and add some new devices to
devicetree. This was tested on linux-next (next-20140124).

Marek Belisko (6):
  ARM: dts: omap3-gta04: Fix mmc1 properties.
  ARM: dts: omap3-gta04: Add basic sound support.
  ARM: dts: omap3-gta04: Add twl4030 charger.
  ARM: dts: omap3-gta04: Add touchscreen properties.
  ARM: dts: omap3-gta04: Add support for magnetometer.
  ARM: dts: omap3-gta04: Add ti,omap36xx to compatible property to avoid
    problems with booting.

NeilBrown (3):
  ARM: dts: omap3-gta04: Fix 'aux' gpio key flags.
  ARM: dts: omap3-gta04: Add bma180 accelerometer.
  ARM: dts: omap3-gta04: Enable mmc2 for wifi.

 arch/arm/boot/dts/omap3-gta04.dts | 58 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 4 deletions(-)

-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

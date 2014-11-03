From: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: [PATCH 0/4] omapdss: Add video output support for gta04 board
Date: Mon,  3 Nov 2014 22:59:24 +0100
Message-ID: <1415051968-4878-1-git-send-email-marek@goldelico.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch series add support for video output on gta04 board. It consist
from opa362 video amplifier driver + DT bindings, adding venc -> opa362 -> svideo-connecor
setup in DT and finally static setup for tvbypass anc acbias bin in devconf1 register
via pinctrl subsystem.

Marek Belisko (4):
  video: omapdss: Add opa362 driver
  Documentation: DT: Add documentation for ti,opa362 bindings
  arm: dts: omap3-gta04: Add handling for tv output
  arm: dts: omap3-gta04: Add static configuration for devconf1 register

 .../devicetree/bindings/video/ti,opa362.txt        |  38 +++
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  70 +++++
 drivers/video/fbdev/omap2/displays-new/Kconfig     |   6 +
 drivers/video/fbdev/omap2/displays-new/Makefile    |   1 +
 .../fbdev/omap2/displays-new/amplifier-opa362.c    | 347 +++++++++++++++++++++
 5 files changed, 462 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/ti,opa362.txt
 create mode 100644 drivers/video/fbdev/omap2/displays-new/amplifier-opa362.c

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

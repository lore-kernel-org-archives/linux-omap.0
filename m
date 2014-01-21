From: Christoph Fritz <chf.fritz-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [PATCH 0/6] ARM: add omap3 INCOstartec board support
Date: Tue, 21 Jan 2014 20:47:34 +0100
Message-ID: <1390333660-30573-1-git-send-email-chf.fritz@googlemail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Archit Taneja <archit-l0cyMroinI0@public.gmane.org>, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Hans J. Koch" <hjk-vqZO0P4V72/QD6PfKP4TzA@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This set of patches adds board support for an omap3 system from INCOstartec.
It's based on next-20140115.

Christoph Fritz (6):
  ARM: dts: Add CPU OPP table for omap37xx100
  ARM: dts: omap3: Add support for INCOstartec a83x module
  ARM: dts: omap3: Add support for INCOstartec DBB056 baseboard
  ARM: OMAP2+: add legacy display for omap3 DBB056
  ARM: OMAP2+: Add pdata quirk for sys_clkout2 for omap3 DBB056
  [RFC] omapdss: remove FEAT_DPI_USES_VDDS_DSI from omap3

 arch/arm/boot/dts/Makefile               |    1 +
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi  |  441 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-lilly-dbb056.dts |  160 +++++++++++
 arch/arm/boot/dts/omap37xx100.dtsi       |   44 +++
 arch/arm/mach-omap2/dss-common.c         |   49 ++++
 arch/arm/mach-omap2/dss-common.h         |    1 +
 arch/arm/mach-omap2/pdata-quirks.c       |   45 ++-
 drivers/video/omap2/dss/dss_features.c   |    1 -
 8 files changed, 740 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-lilly-a83x.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-lilly-dbb056.dts
 create mode 100644 arch/arm/boot/dts/omap37xx100.dtsi

-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

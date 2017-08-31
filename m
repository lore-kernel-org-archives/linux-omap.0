From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: [PATCH v3 0/4] fixes for latest bq27xxx driver and OpenPandora DT nodes
Date: Thu, 31 Aug 2017 10:21:48 +0200
Message-ID: <cover.1504167711.git.hns@goldelico.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: afd-l0cyMroinI0@public.gmane.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Latest bq27xxx drivers allow to write RAM/NVRAM parameters
of the fuel gauge chip from values defined in board specific
device tree.

This allows to specify the battery properties of a standard
battery.

This patch set enables this for two chips where I have tested
it on real devices:

bq27421: Pyra handheld prototype
bq27500: OpenPandora 600 Mhz standard device

Since the Pyra DT is not yet mainlined, there are only DT
patches for the OpenPandora.

H. Nikolaus Schaller (4):
  power: supply: bq27xxx: enable writing capacity values for bq27421
  power: supply: bq27xxx: enable writing capacity values for bq27500
  DT: OpenPandora: add battery node to describe OpenPandora battery
  DT: OpenPandora: fix for configuration of bq27500 fuel gauge

 arch/arm/boot/dts/omap3-pandora-common.dtsi | 11 ++++++++++-
 drivers/power/supply/bq27xxx_battery.c      |  8 --------
 2 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.12.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

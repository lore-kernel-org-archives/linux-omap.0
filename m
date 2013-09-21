From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: [PATCH 0/3] ARM: OMAP: convert N950/N9 to DT
Date: Sat, 21 Sep 2013 16:45:39 +0300
Message-ID: <1379771142-29087-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

This adds DTS for N950/N9 and removes the legacy board file. However,
I guess the HACK in patch 1 needs to be solved somehow before we can
do this...

Aaro Koskinen (3):
  ARM: OMAP2: HACK: hardcode hsmmc2 input clock source for N950/N9
  ARM: dts: add minimal DT support for Nokia N950 & N9 phones
  ARM: OMAP2: delete board-rm680

 arch/arm/boot/dts/Makefile           |   2 +
 arch/arm/boot/dts/omap3-n9.dts       |  18 ++++
 arch/arm/boot/dts/omap3-n950-n9.dtsi | 172 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-n950.dts     |  18 ++++
 arch/arm/mach-omap2/Kconfig          |   7 --
 arch/arm/mach-omap2/Makefile         |   1 -
 arch/arm/mach-omap2/board-generic.c  |  15 +++
 arch/arm/mach-omap2/board-rm680.c    | 167 ----------------------------------
 8 files changed, 225 insertions(+), 175 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-n9.dts
 create mode 100644 arch/arm/boot/dts/omap3-n950-n9.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-n950.dts
 delete mode 100644 arch/arm/mach-omap2/board-rm680.c

-- 
1.8.4.rc3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Subject: [PATCH 0/3] Add additional OnRISC Baltos devices
Date: Tue, 26 Apr 2016 15:00:23 +0200
Message-ID: <1461675626-5818-1-git-send-email-yegorslists@googlemail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

This series splits am335x-baltos.dtsi out of am335x-baltos-ir5221.dts to
consolidate common configuration for Baltos device.

DTS files for Baltos IR3220 and IR2110 will be added using newly created
am335x-baltos.dtsi.

Yegor Yefremov (3):
  ARM: dts: split am335x-baltos-ir5221 into dts and dtsi files
  ARM: dts: add DTS for Baltos IR3220
  ARM: dts: add DTS for Baltos IR2110

 arch/arm/boot/dts/Makefile                 |   2 +
 arch/arm/boot/dts/am335x-baltos-ir2110.dts |  71 +++++
 arch/arm/boot/dts/am335x-baltos-ir3220.dts | 119 +++++++++
 arch/arm/boot/dts/am335x-baltos-ir5221.dts | 387 +--------------------------
 arch/arm/boot/dts/am335x-baltos.dtsi       | 408 +++++++++++++++++++++++++++++
 5 files changed, 601 insertions(+), 386 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-baltos-ir2110.dts
 create mode 100644 arch/arm/boot/dts/am335x-baltos-ir3220.dts
 create mode 100644 arch/arm/boot/dts/am335x-baltos.dtsi

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

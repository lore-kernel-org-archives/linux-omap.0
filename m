From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] ARM: dts: Introduce support for rev BeagleBoard-X15 B1
Date: Fri, 2 Sep 2016 04:05:58 -0500
Message-ID: <20160902090600.27262-1-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


Hi,

Please find the series to cleanup and support Production version of
Beagleboard-X15 rev B1 support.

More  details can be found at https://github.com/beagleboard/beagleboard-x15

Bootlog on B1: http://pastebin.ubuntu.com/23123408/ (sd and hdmi hpd tested)

Nishanth Menon (2):
  ARM: dts: am57xx-beagle-x15: Remove pinmux configurations
  ARM: dts: am57xx-beagle-x15: Add support for rev B1

 arch/arm/boot/dts/Makefile                         |   1 +
 ...eagle-x15.dts => am57xx-beagle-x15-common.dtsi} | 230 +-----
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts      |  24 +
 arch/arm/boot/dts/am57xx-beagle-x15.dts            | 812 +--------------------
 4 files changed, 34 insertions(+), 1033 deletions(-)
 copy arch/arm/boot/dts/{am57xx-beagle-x15.dts => am57xx-beagle-x15-common.dtsi} (60%)
 create mode 100644 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts

-- 
2.9.1.200.gb1ec08f

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

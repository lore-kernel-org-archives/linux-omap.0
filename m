From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] ARM: am335x: Add support for ICEv2 board
Date: Tue, 22 Mar 2016 12:07:35 +0530
Message-ID: <1458628657-30468-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, nm-l0cyMroinI0@public.gmane.org, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This series adds support for AM3359 ICEv2 board.

Boot log: http://pastebin.ubuntu.com/15470564/ 

Lokesh Vutla (2):
  ARM: dts: am335x: Add initial support for ICEv2 board
  ARM: omap2plus_defconfig: Enable GPIO_TPIC2810

 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am335x-icev2.dts                 | 303 +++++++++++++++++++++
 arch/arm/configs/omap2plus_defconfig               |   1 +
 4 files changed, 308 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-icev2.dts

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

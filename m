From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/3] ARM: am57xx: Add support for am574x-idk
Date: Mon, 18 Dec 2017 11:50:00 +0530
Message-ID: <20171218062003.9024-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

am574x-idk board is similar to am572x-idk with am574x SoC.
This series adds support for this board.

Logs: http://pastebin.ubuntu.com/26207045/

Lokesh Vutla (3):
  ARM: dra762: Add support for device package identification
  ARM: dra762: hwmod: Register package specific hwmod
  ARM: dts: am57xx: Add support for am574x-idk

 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/am572x-idk-common.dtsi  | 100 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am572x-idk.dts          |  93 +--------------------------
 arch/arm/boot/dts/am574x-idk.dts          |  22 +++++++
 arch/arm/mach-omap2/id.c                  |  17 ++++-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  27 +++++---
 arch/arm/mach-omap2/soc.h                 |  16 +++++
 7 files changed, 174 insertions(+), 102 deletions(-)
 create mode 100644 arch/arm/boot/dts/am572x-idk-common.dtsi
 create mode 100644 arch/arm/boot/dts/am574x-idk.dts

-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

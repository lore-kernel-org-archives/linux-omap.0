From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/5] ARM: OMAP2+: Add earlycon support
Date: Wed, 18 Jan 2017 09:33:21 +0530
Message-ID: <20170118040326.29259-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This series adds earlycon support for all am33xx, am43xx, am57xx, dra7xx
based TI platforms. With this series just passing "earlycon" in bootargs
is sufficient for early debug.

Tested with omap2plus_defconfig + CONFIG_SERIAL_8250_OMAP.

Changes since v1:
- Dropped searching for /chosen@0 node as pointed out by Mark.

Lokesh Vutla (5):
  ARM: OMAP2+: omap_hwmod: Add support for earlycon
  ARM: dts: am33xx: Add stdout-path property
  ARM: dts: am43xx: Add stdout-path property
  ARM: dts: am57xx: Add stdout-path property
  ARM: dts: dra7xx: Add stdout-path property

 arch/arm/boot/dts/am335x-evm.dts                |  4 +++
 arch/arm/boot/dts/am335x-evmsk.dts              |  4 +++
 arch/arm/boot/dts/am335x-icev2.dts              |  4 +++
 arch/arm/boot/dts/am437x-gp-evm.dts             |  4 +++
 arch/arm/boot/dts/am437x-idk-evm.dts            |  4 +++
 arch/arm/boot/dts/am437x-sk-evm.dts             |  4 +++
 arch/arm/boot/dts/am43x-epos-evm.dts            |  4 +++
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |  4 +++
 arch/arm/boot/dts/am57xx-idk-common.dtsi        |  4 +++
 arch/arm/boot/dts/dra7-evm.dts                  |  4 +++
 arch/arm/boot/dts/dra72-evm-common.dtsi         |  4 +++
 arch/arm/mach-omap2/omap_hwmod.c                | 33 +++++++++++++++++++++++++
 12 files changed, 77 insertions(+)

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

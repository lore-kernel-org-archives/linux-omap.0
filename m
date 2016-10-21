From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/9] ARM: DRA7: Add support for DRA718-evm
Date: Fri, 21 Oct 2016 16:08:32 +0530
Message-ID: <20161021103841.8044-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux ARM Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This series does minor dts cleanup for dra72-evm and adds support for
DRA718-evm.

Changes since v1:
- Updated xxx-supply to xxx-in-supply in Documentation.

Lokesh Vutla (7):
  ARM: dts: dra72-evm: Remove pinmux configurations for erratum i869
  ARM: dra72-evm: Fix modelling of regulators
  ARM: dts: dra72: Add separate dtsi for tps65917
  regulator: lp873x: Add support for populating input supply
  ARM: OMAP2+: board-generic: add support for DRA71x family
  ARM: omap2plus_defconfig: Enable REGULATOR_GPIO
  ARM: omap2plus_defconfig: Enable LP873X support

Nishanth Menon (2):
  ARM: DRA7: hwmod: Do not register RTC on DRA71
  ARM: dts: Add support for dra718-evm

 .../devicetree/bindings/arm/omap/omap.txt          |   6 +
 Documentation/devicetree/bindings/mfd/lp873x.txt   |   8 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/dra71-evm.dts                    | 230 ++++++++++++++
 arch/arm/boot/dts/dra72-evm-common.dtsi            | 348 +++------------------
 arch/arm/boot/dts/dra72-evm-revc.dts               |  21 +-
 arch/arm/boot/dts/dra72-evm-tps65917.dtsi          | 134 ++++++++
 arch/arm/boot/dts/dra72-evm.dts                    |  14 +-
 arch/arm/configs/omap2plus_defconfig               |   3 +
 arch/arm/mach-omap2/board-generic.c                |   1 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  10 +-
 drivers/regulator/lp873x-regulator.c               |   1 +
 12 files changed, 453 insertions(+), 326 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra71-evm.dts
 create mode 100644 arch/arm/boot/dts/dra72-evm-tps65917.dtsi

-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

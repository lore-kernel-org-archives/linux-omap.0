From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 00/12] ARM: omap: mtd: nand: Support GPMC NAND on non-OMAP platforms
Date: Fri, 10 Jul 2015 15:23:27 +0300
Message-ID: <1436531019-18088-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

The OMAP GPMC IP is being used on non-OMAP platforms as well
and this series aims at cleaning up device tree implementation
for GPMC NAND so that it can be used on non-OMAP platforms.

NAND is now treated as any other generic GPMC child and has to
have its own compatible-id and address+interrupt resource.

Tested NAND on following boards
- dra7-evm
- am437x-gp-evm
- beagleboard C4

--
cheers,
-roger

Roger Quadros (12):
  ARM: OMAP2+: gpmc: Add platform data
  ARM: OMAP2+: gpmc: Add gpmc timings and settings to platform data
  mtd: nand: omap: Move IRQ handling from GPMC to NAND driver
  mtd: nand: omap: Move gpmc_update_nand_reg to nand driver
  mtd: nand: omap: Move NAND write protect code from GPMC to NAND driver
  mtd: nand: omap: Copy platform data parameters to omap_nand_info data
  mtd: nand: omap: Clean up device tree support
  mtd: nand: omap: Update DT binding documentation
  memory: omap-gpmc: use module_platform_driver()
  memory: omap-gpmc: Prevent mapping into 1st 16MB
  ARM: dts: OMAP2+: Fix NAND device nodes
  ARM: dts: omap3: Fix gpmc memory resource size

 .../devicetree/bindings/mtd/gpmc-nand.txt          |  16 +-
 arch/arm/boot/dts/am335x-baltos-ir5221.dts         |   9 +-
 arch/arm/boot/dts/am335x-chilisom.dtsi             |   8 +-
 arch/arm/boot/dts/am335x-evm.dts                   |   8 +-
 arch/arm/boot/dts/am335x-igep0033.dtsi             |   8 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                |   8 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |   8 +-
 arch/arm/boot/dts/dm8168-evm.dts                   |   8 +-
 arch/arm/boot/dts/dra7-evm.dts                     |   8 +-
 arch/arm/boot/dts/dra72-evm.dts                    |   8 +-
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi         |   9 +-
 arch/arm/boot/dts/omap3-beagle.dts                 |   7 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |   8 +-
 arch/arm/boot/dts/omap3-devkit8000.dts             |   9 +-
 arch/arm/boot/dts/omap3-evm-37xx.dts               |  10 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |   8 +-
 arch/arm/boot/dts/omap3-igep.dtsi                  |   5 +-
 arch/arm/boot/dts/omap3-igep0020-common.dtsi       |   5 +-
 arch/arm/boot/dts/omap3-igep0030-common.dtsi       |   6 +
 arch/arm/boot/dts/omap3-ldp.dts                    |  10 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |   8 +-
 arch/arm/boot/dts/omap3-lilly-dbb056.dts           |   7 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |   8 +-
 arch/arm/boot/dts/omap3-tao3530.dtsi               |   8 +-
 arch/arm/boot/dts/omap3.dtsi                       |   2 +-
 arch/arm/boot/dts/omap3430-sdp.dts                 |   8 +-
 arch/arm/mach-omap2/gpmc-nand.c                    |  19 +-
 drivers/memory/omap-gpmc.c                         | 427 +++------------------
 drivers/mtd/nand/omap2.c                           | 380 ++++++++++++++----
 include/linux/omap-gpmc.h                          | 148 +------
 include/linux/platform_data/gpmc-omap.h            | 169 ++++++++
 include/linux/platform_data/mtd-nand-omap2.h       |  10 +-
 32 files changed, 705 insertions(+), 655 deletions(-)
 create mode 100644 include/linux/platform_data/gpmc-omap.h

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

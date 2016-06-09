From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH 0/6] ARM: OMAP2+: Don't force select OMAP_GPMC
Date: Thu,  9 Jun 2016 12:02:51 -0500
Message-ID: <1465491777-20033-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, boris.brezillon@free-electrons.com, computersforpeace@gmail.com, linux-arm-kernel@lists.infradead, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

When building random configs a compile failure was detected due to
CONFIG_MEMORY not being selected. This was due to OMAP_GPMC being enabled
by ARCH_OMAP2PLUS which ignores config dependencies. This patchset fixes
this issue and also insures GPMC and NAND is enabled for multi_v7.

Boot tested that NAND works on AM335x EVM using both omap2plus and
multi_v7 config

Franklin S Cooper Jr (6):
  ARM: omap2plus_defconfig: Enable OMAP GPMC
  ARM: multi_v7_defconfig: Enable OMAP GPMC
  ARM: multi_v7_defconfig: Enable OMAP NAND drivers
  mtd: nand: Add OMAP_GPMC as a dependency to MTD_NAND_OMAP2
  memory: omap-gpmc: Enable omap-gpmc by default when dependency is met
  ARM: OMAP2+: Don't force select OMAP_GPMC

 arch/arm/configs/multi_v7_defconfig  | 3 +++
 arch/arm/configs/omap2plus_defconfig | 1 +
 arch/arm/mach-omap2/Kconfig          | 1 -
 drivers/memory/Kconfig               | 1 +
 drivers/mtd/nand/Kconfig             | 2 +-
 5 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.7.0

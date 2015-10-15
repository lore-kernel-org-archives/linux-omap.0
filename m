From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v2 0/5] mtd: nand: Fix support for NAND DMA prefetch
Date: Thu, 15 Oct 2015 12:37:23 -0500
Message-ID: <1444930648-19313-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, rogerq@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, nsekhar@ti.com, computersforpeace@gmail.com, dwmw2@infradead.org, tony@atomide.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

NAND DMA prefetch has been broken for awhile and seems to have only
worked for SDMA based devices

This patchset fixes DMA prefetch to work on both EDMA and SDMA devices

Test on:
am335x gp evm
am437x gp evm
am37x gp evm

This patchset depends on Roger Quadros recent v4 GPMC/NAND patchset
https://github.com/rogerq/linux.git
branch: for-v4.4/gpmc-v4

Franklin S Cooper Jr (5):
  mtd: nand: omap2: Support parsing dma channel information from DT
  mtd: nand: omap2: Start dma request before enabling prefetch
  mtd: nand: omap2: Fix high memory dma prefetch transfer
  ARM: dts: am437x/am33xx/omap/dm816x: Add gpmc dma channel
  ARM: OMAP2+: Update GPMC and NAND DT binding documentation

 .../bindings/memory-controllers/omap-gpmc.txt      |  7 +++++-
 .../devicetree/bindings/mtd/gpmc-nand.txt          |  2 ++
 arch/arm/boot/dts/am33xx.dtsi                      |  2 ++
 arch/arm/boot/dts/am4372.dtsi                      |  2 ++
 arch/arm/boot/dts/dm816x.dtsi                      |  2 ++
 arch/arm/boot/dts/omap3.dtsi                       |  2 ++
 arch/arm/boot/dts/omap4.dtsi                       |  2 ++
 arch/arm/boot/dts/omap5.dtsi                       |  2 ++
 drivers/mtd/nand/omap2.c                           | 27 +++++++++-------------
 9 files changed, 31 insertions(+), 17 deletions(-)

-- 
2.6.1

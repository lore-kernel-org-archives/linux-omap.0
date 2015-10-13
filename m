From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/5] mtd: nand: Fix support for NAND DMA Prefetch
Date: Mon, 12 Oct 2015 20:38:53 -0500
Message-ID: <1444700338-27582-1-git-send-email-fcooper@ti.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

NAND dma prefetch has been broken for awhile and seems to have only
worked for sdma based devices.

This patchset fixes DMA prefetch to work on both edma and sdma devices

Tested on:
am335x general purpose evm
am437x general purpose evm
am37x general purpose evm

This patchset depends on Roger Quadros recent v4 GPMC/NAND patchset

https://github.com/rogerq/linux.git
branch: for-v4.4/gpmc-v4

Franklin S Cooper Jr (5):
  mtd: nand: omap2: Support parsing dma channel information from DT
  mtd: nand: omap2: Start dma request before enabling prefetch
  mtd: nand: omap2: Fix high memory dma prefetch transfer
  ARM: dts: am437x/am33xx/omap3/dm816x: Add gpmc dma channel
  ARM: OMAP2+: Update gpmc and nand DT binding documentation

 .../bindings/memory-controllers/omap-gpmc.txt      |  7 ++++++-
 .../devicetree/bindings/mtd/gpmc-nand.txt          |  2 ++
 arch/arm/boot/dts/am33xx.dtsi                      |  2 ++
 arch/arm/boot/dts/am4372.dtsi                      |  2 ++
 arch/arm/boot/dts/dm816x.dtsi                      |  2 ++
 arch/arm/boot/dts/omap3.dtsi                       |  2 ++
 drivers/mtd/nand/omap2.c                           | 24 ++++++++--------------
 7 files changed, 25 insertions(+), 16 deletions(-)

-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

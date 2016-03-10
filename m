From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/6] mtd: nand: Fix support for NAND DMA prefetch
Date: Wed,  9 Mar 2016 22:07:35 -0600
Message-ID: <1457582861-20619-1-git-send-email-fcooper@ti.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nsekhar-l0cyMroinI0@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

NAND DMA prefetch has been broken for awhile and seems to have only
worked for SDMA based devices

This patchset fixes DMA prefetch to work on both EDMA and SDMA devices

Test on:
am335x gp evm
am437x gp evm
am37x gp evm

This rev is pretty much the same as v2 which was blocked due to
dependencies to Roger's update GPMC/NAND rework.

This updated rev removes this dependency.

Also it fixes an issue that was introduced when the eDMA driver was
recently updated.

Links to rev 2 patchset:
https://patchwork.kernel.org/patch/7408691/
https://patchwork.kernel.org/patch/7408681/
https://patchwork.kernel.org/patch/7408661/
https://patchwork.kernel.org/patch/7408641/
https://patchwork.kernel.org/patch/7408621/

Franklin S Cooper Jr (6):
  memory: omap-gpmc: Store handle to GPMC dev
  ARM: dts: am437x/am33xx: Fix GPMC dma properties
  mtd: nand: omap2: Support parsing dma channel information from DT
  mtd: nand: omap2: Start dma request before enabling prefetch
  mtd: nand: omap2: Fix high memory dma prefetch transfer
  ARM: OMAP2+: Update GPMC and NAND DT binding documentation

 Documentation/devicetree/bindings/bus/ti-gpmc.txt  |  7 +++++-
 .../devicetree/bindings/mtd/gpmc-nand.txt          |  2 +-
 arch/arm/boot/dts/am33xx.dtsi                      |  2 +-
 arch/arm/boot/dts/am4372.dtsi                      |  2 +-
 drivers/memory/omap-gpmc.c                         |  1 +
 drivers/mtd/nand/omap2.c                           | 27 +++++++++-------------
 include/linux/platform_data/mtd-nand-omap2.h       |  2 ++
 7 files changed, 23 insertions(+), 20 deletions(-)

-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

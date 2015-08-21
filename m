From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] mtd: nand: omap2: Rename shippable module to omap2_nand
Date: Fri, 21 Aug 2015 13:45:35 +0300
Message-ID: <1440153935-28927-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: computersforpeace@gmail.com, dwmw2@infradead.org
Cc: ezequiel@vanguardiasur.com.ar, tony@atomide.com, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Robert Nelson <robertcnelson@gmail.com>
List-Id: linux-omap@vger.kernel.org

As both omap2 onenand and omap2 nand driver modules are
named the same i.e. "omap2.ko", only one of them gets shipped
during MODPOST if both are configured as loadable modules.

To avoid this ambiguity let's ship the omap2 nand
driver as "omap2_nand.ko"

Reported by Pierre Neyron via github
https://github.com/beagleboard/linux/issues/40

Cc: Robert Nelson <robertcnelson@gmail.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mtd/nand/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index 1f897ec..075a027 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -26,7 +26,8 @@ obj-$(CONFIG_MTD_NAND_CS553X)		+= cs553x_nand.o
 obj-$(CONFIG_MTD_NAND_NDFC)		+= ndfc.o
 obj-$(CONFIG_MTD_NAND_ATMEL)		+= atmel_nand.o
 obj-$(CONFIG_MTD_NAND_GPIO)		+= gpio.o
-obj-$(CONFIG_MTD_NAND_OMAP2) 		+= omap2.o
+omap2_nand-objs := omap2.o
+obj-$(CONFIG_MTD_NAND_OMAP2) 		+= omap2_nand.o
 obj-$(CONFIG_MTD_NAND_OMAP_BCH_BUILD)	+= omap_elm.o
 obj-$(CONFIG_MTD_NAND_CM_X270)		+= cmx270_nand.o
 obj-$(CONFIG_MTD_NAND_PXA3xx)		+= pxa3xx_nand.o
-- 
2.1.4

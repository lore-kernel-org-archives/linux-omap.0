From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH v4 4/5] mtd: nand: Rename OMAP NAND driver
Date: Sat, 20 Sep 2014 17:53:15 +0100
Message-ID: <1411231996-6387-5-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1411231996-6387-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:57914 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755947AbaITQyj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Sep 2014 12:54:39 -0400
Received: by mail-we0-f172.google.com with SMTP id p10so639058wes.31
        for <linux-omap@vger.kernel.org>; Sat, 20 Sep 2014 09:54:38 -0700 (PDT)
In-Reply-To: <1411231996-6387-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Roger Quadros <rogerq@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Rename it to a less generic name, so the module is built with a meaningful
name instead of the previous 'omap2.ko'.

Acked-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/mtd/nand/Makefile                  | 2 +-
 drivers/mtd/nand/{omap2.c => omap2_nand.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/mtd/nand/{omap2.c => omap2_nand.c} (100%)

diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index b3237b7..4bcdeb0 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -26,7 +26,7 @@ obj-$(CONFIG_MTD_NAND_CS553X)		+= cs553x_nand.o
 obj-$(CONFIG_MTD_NAND_NDFC)		+= ndfc.o
 obj-$(CONFIG_MTD_NAND_ATMEL)		+= atmel_nand.o
 obj-$(CONFIG_MTD_NAND_GPIO)		+= gpio.o
-obj-$(CONFIG_MTD_NAND_OMAP2) 		+= omap2.o
+obj-$(CONFIG_MTD_NAND_OMAP2) 		+= omap2_nand.o
 obj-$(CONFIG_MTD_NAND_OMAP_BCH)		+= omap_elm.o
 obj-$(CONFIG_MTD_NAND_CM_X270)		+= cmx270_nand.o
 obj-$(CONFIG_MTD_NAND_PXA3xx)		+= pxa3xx_nand.o
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2_nand.c
similarity index 100%
rename from drivers/mtd/nand/omap2.c
rename to drivers/mtd/nand/omap2_nand.c
-- 
2.1.0


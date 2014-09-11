From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH 2/3] mtd: nand: Rename OMAP NAND driver
Date: Thu, 11 Sep 2014 10:47:03 -0300
Message-ID: <1410443224-18477-3-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1410443224-18477-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:37790 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319AbaIKNsv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2014 09:48:51 -0400
Received: by mail-qc0-f171.google.com with SMTP id x3so21306821qcv.16
        for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2014 06:48:49 -0700 (PDT)
In-Reply-To: <1410443224-18477-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Brian Norris <computersforpeace@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Rename it to a less generic name, so the module is built with a meaningful
name instead of the previous 'omap2.ko'.

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


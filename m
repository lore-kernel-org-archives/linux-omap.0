From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH v4 3/5] mtd: nand: Move ELM driver and rename as omap_elm
Date: Sat, 20 Sep 2014 17:53:14 +0100
Message-ID: <1411231996-6387-4-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1411231996-6387-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:54074 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215AbaITQyi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Sep 2014 12:54:38 -0400
Received: by mail-wi0-f178.google.com with SMTP id z2so959184wiv.11
        for <linux-omap@vger.kernel.org>; Sat, 20 Sep 2014 09:54:37 -0700 (PDT)
In-Reply-To: <1411231996-6387-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Roger Quadros <rogerq@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

The ELM driver is only used by the OMAP NAND driver, so let's move it
to the nand/ directory. Additionally, let's rename it to a less confusing
name, so the module is built with a meaningful name, instead of the previous
'elm.ko'.

Acked-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/mtd/devices/Makefile                   | 1 -
 drivers/mtd/nand/Makefile                      | 1 +
 drivers/mtd/{devices/elm.c => nand/omap_elm.c} | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/mtd/{devices/elm.c => nand/omap_elm.c} (100%)

diff --git a/drivers/mtd/devices/Makefile b/drivers/mtd/devices/Makefile
index c68868f..f0b0e61 100644
--- a/drivers/mtd/devices/Makefile
+++ b/drivers/mtd/devices/Makefile
@@ -12,7 +12,6 @@ obj-$(CONFIG_MTD_LART)		+= lart.o
 obj-$(CONFIG_MTD_BLOCK2MTD)	+= block2mtd.o
 obj-$(CONFIG_MTD_DATAFLASH)	+= mtd_dataflash.o
 obj-$(CONFIG_MTD_M25P80)	+= m25p80.o
-obj-$(CONFIG_MTD_NAND_OMAP_BCH)	+= elm.o
 obj-$(CONFIG_MTD_SPEAR_SMI)	+= spear_smi.o
 obj-$(CONFIG_MTD_SST25L)	+= sst25l.o
 obj-$(CONFIG_MTD_BCM47XXSFLASH)	+= bcm47xxsflash.o
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index a035e7c..b3237b7 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_MTD_NAND_NDFC)		+= ndfc.o
 obj-$(CONFIG_MTD_NAND_ATMEL)		+= atmel_nand.o
 obj-$(CONFIG_MTD_NAND_GPIO)		+= gpio.o
 obj-$(CONFIG_MTD_NAND_OMAP2) 		+= omap2.o
+obj-$(CONFIG_MTD_NAND_OMAP_BCH)		+= omap_elm.o
 obj-$(CONFIG_MTD_NAND_CM_X270)		+= cmx270_nand.o
 obj-$(CONFIG_MTD_NAND_PXA3xx)		+= pxa3xx_nand.o
 obj-$(CONFIG_MTD_NAND_TMIO)		+= tmio_nand.o
diff --git a/drivers/mtd/devices/elm.c b/drivers/mtd/nand/omap_elm.c
similarity index 100%
rename from drivers/mtd/devices/elm.c
rename to drivers/mtd/nand/omap_elm.c
-- 
2.1.0


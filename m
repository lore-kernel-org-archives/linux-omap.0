From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH 1/3] mtd: nand: Move ELM driver and rename as omap_elm
Date: Thu, 11 Sep 2014 10:47:02 -0300
Message-ID: <1410443224-18477-2-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1410443224-18477-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:36336 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbaIKNsp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2014 09:48:45 -0400
Received: by mail-qc0-f180.google.com with SMTP id c9so21363652qcz.11
        for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2014 06:48:44 -0700 (PDT)
In-Reply-To: <1410443224-18477-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Brian Norris <computersforpeace@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

The ELM driver is only used by the OMAP NAND driver, so let's move it
to the nand/ directory. Additionally, let's rename it to a less confusing
name, so the module is built with a meaningful name, instead of the previous
'elm.ko'.

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


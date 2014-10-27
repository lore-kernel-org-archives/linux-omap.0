From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH typo-resend] mtd: omap: fix mtd devices not showing up
Date: Mon, 27 Oct 2014 14:32:29 +0100
Message-ID: <1414416749-19598-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filter1.ibarracuda.nl ([83.247.7.10]:40309 "EHLO
	filter1.ibarracuda.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbaJ0Nck (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Oct 2014 09:32:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Frans Klaver <frans.klaver@xsens.com>, =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, Roger Quadros <rogerq@ti.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org

Since commit 6d178ef2fd5e ("mtd: nand: Move ELM driver and rename as
omap_elm"), I don't have any mtd devices present on my am335x. This
appears to be related to the link order of the omap_elm and omap2
objects. Fix it by swapping the two in the Makefile.

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
I hoped this wouldn't make a difference, but it very much did. I don't
have a proper explanation for why this actually fixes it for me though.

Resend due to misspelling in ...infradead.org

 drivers/mtd/nand/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index 9c847e4..24b81ec 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -26,8 +26,8 @@ obj-$(CONFIG_MTD_NAND_CS553X)		+= cs553x_nand.o
 obj-$(CONFIG_MTD_NAND_NDFC)		+= ndfc.o
 obj-$(CONFIG_MTD_NAND_ATMEL)		+= atmel_nand.o
 obj-$(CONFIG_MTD_NAND_GPIO)		+= gpio.o
-obj-$(CONFIG_MTD_NAND_OMAP2) 		+= omap2.o
 obj-$(CONFIG_MTD_NAND_OMAP_BCH_BUILD)	+= omap_elm.o
+obj-$(CONFIG_MTD_NAND_OMAP2) 		+= omap2.o
 obj-$(CONFIG_MTD_NAND_CM_X270)		+= cmx270_nand.o
 obj-$(CONFIG_MTD_NAND_PXA3xx)		+= pxa3xx_nand.o
 obj-$(CONFIG_MTD_NAND_TMIO)		+= tmio_nand.o
-- 
2.1.0


From: Sushaanth Srirangapathi <sushaanth.s@ti.com>
Subject: [PATCH] mtd: davinci-nand: disable subpage write for davinci-nand
Date: Tue, 8 Mar 2016 14:38:15 +0530
Message-ID: <1457428095-2801-1-git-send-email-sushaanth.s@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, Sushaanth Srirangapathi <sushaanth.s@ti.com>
List-Id: linux-omap@vger.kernel.org

Commit 28c015a9daabe4e ("mtd: davinci-nand: disable subpage write for
keystone-nand") disables subpage write for Keystone SOCs due to hw
issues.

But subpage writes doesn't work even for DaVinci SOCs due to hw issues.
So set NAND_NO_SUBPAGE_WRITE option for all devices compatible to
this driver.

I tested this patch using DA850 board.

Signed-off-by: Sushaanth Srirangapathi <sushaanth.s@ti.com>
---
 drivers/mtd/nand/davinci_nand.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index 8cb821b..466439c 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -601,11 +601,7 @@ static struct davinci_nand_pdata
 		    of_property_read_bool(pdev->dev.of_node,
 			"ti,davinci-nand-use-bbt"))
 			pdata->bbt_options = NAND_BBT_USE_FLASH;
-
-		if (of_device_is_compatible(pdev->dev.of_node,
-					    "ti,keystone-nand")) {
-			pdata->options |= NAND_NO_SUBPAGE_WRITE;
-		}
+		pdata->options |= NAND_NO_SUBPAGE_WRITE;
 	}
 
 	return dev_get_platdata(&pdev->dev);
-- 
1.7.9.5

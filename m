From: David Anders <x0132446@ti.com>
Subject: [PATCH 3/4] omap4: pandaboard: Adding card detect support for MMC1
Date: Tue, 21 Sep 2010 16:24:03 -0500
Message-ID: <1285104244-32274-4-git-send-email-x0132446@ti.com>
References: <1285104244-32274-1-git-send-email-x0132446@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56082 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756276Ab0IUVYH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 17:24:07 -0400
In-Reply-To: <1285104244-32274-1-git-send-email-x0132446@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jayabharath@ti.com, gadiyar@ti.com, vpasam@ti.com, tony@atomide.com, linux-omap@vger.kernel.org
Cc: David Anders <x0132446@ti.com>

Adding card detect callback function and card detect configuration
function for MMC1 Controller.

Signed-off-by: David Anders <x0132446@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---

patch depends on https://patchwork.kernel.org/patch/189952/

 arch/arm/mach-omap2/board-omap4panda.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 697c0bd..94e819c 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -77,9 +77,14 @@ static int omap4_twl6030_hsmmc_late_init(struct device *dev)
 	struct omap_mmc_platform_data *pdata = dev->platform_data;
 
 	/* Setting MMC1 Card detect Irq */
-	if (pdev->id == 0)
+	if (pdev->id == 0) {
+		ret = twl6030_mmc_card_detect_config();
+		if (ret)
+			pr_err("Failed configuring MMC1 card detect\n");
 		pdata->slots[0].card_detect_irq = TWL6030_IRQ_BASE +
 						MMCDETECT_INTR_OFFSET;
+		pdata->slots[0].card_detect = twl6030_mmc_card_detect;
+	}
 	return ret;
 }
 
-- 
1.7.0.4


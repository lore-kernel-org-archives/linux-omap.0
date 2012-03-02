From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 12/12] ARM: OMAP2+: board-omap4-*: Do not use anymore TWL6030_IRQ_BASE in board files
Date: Fri, 2 Mar 2012 17:50:24 +0100
Message-ID: <1330707024-23730-13-git-send-email-b-cousson@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59583 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030381Ab2CBQv1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Mar 2012 11:51:27 -0500
In-Reply-To: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sameo@linux.intel.com, tony@atomide.com, grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

With the introduction of dynamically allocated IRQ in the twl6030 driver,
the board files can no longer rely of static IRQ defines like before.

Retrieve the value dynamically allocated from the mmc -> twl6030 init
callback.

Note: The Panda board does not seems to use the card detect IRQ.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |   13 +++++++------
 arch/arm/mach-omap2/board-omap4panda.c |   15 ++++++++-------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 4e90715..79c4eba 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -457,21 +457,22 @@ static struct platform_device omap_vwlan_device = {
 
 static int omap4_twl6030_hsmmc_late_init(struct device *dev)
 {
-	int ret = 0;
+	int irq = 0;
 	struct platform_device *pdev = container_of(dev,
 				struct platform_device, dev);
 	struct omap_mmc_platform_data *pdata = dev->platform_data;
 
 	/* Setting MMC1 Card detect Irq */
 	if (pdev->id == 0) {
-		ret = twl6030_mmc_card_detect_config();
-		if (ret)
+		irq = twl6030_mmc_card_detect_config();
+		if (irq < 0) {
 			pr_err("Failed configuring MMC1 card detect\n");
-		pdata->slots[0].card_detect_irq = TWL6030_IRQ_BASE +
-						MMCDETECT_INTR_OFFSET;
+			return irq;
+		}
+		pdata->slots[0].card_detect_irq = irq;
 		pdata->slots[0].card_detect = twl6030_mmc_card_detect;
 	}
-	return ret;
+	return 0;
 }
 
 static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 28fc271..297f30b 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -206,7 +206,7 @@ struct wl12xx_platform_data omap_panda_wlan_data  __initdata = {
 
 static int omap4_twl6030_hsmmc_late_init(struct device *dev)
 {
-	int ret = 0;
+	int irq = 0;
 	struct platform_device *pdev = container_of(dev,
 				struct platform_device, dev);
 	struct omap_mmc_platform_data *pdata = dev->platform_data;
@@ -217,14 +217,15 @@ static int omap4_twl6030_hsmmc_late_init(struct device *dev)
 	}
 	/* Setting MMC1 Card detect Irq */
 	if (pdev->id == 0) {
-		ret = twl6030_mmc_card_detect_config();
-		 if (ret)
+		irq = twl6030_mmc_card_detect_config();
+		if (irq < 0) {
 			dev_err(dev, "%s: Error card detect config(%d)\n",
-				__func__, ret);
-		 else
-			pdata->slots[0].card_detect = twl6030_mmc_card_detect;
+				__func__, irq);
+			return irq;
+		}
+		pdata->slots[0].card_detect = twl6030_mmc_card_detect;
 	}
-	return ret;
+	return 0;
 }
 
 static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
-- 
1.7.0.4


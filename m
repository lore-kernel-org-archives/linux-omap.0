From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] ARM: OMAP2+: Remove legacy omap4_twl6030_hsmmc_init
Date: Tue, 19 Nov 2013 08:31:25 -0800
Message-ID: <1384878685-1515-3-git-send-email-tony@atomide.com>
References: <1384878685-1515-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63790 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997Ab3KSQba (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Nov 2013 11:31:30 -0500
In-Reply-To: <1384878685-1515-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

This is no longer used, omap4 is device tree based now.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/common.h       |  1 -
 arch/arm/mach-omap2/omap4-common.c | 57 --------------------------------------
 2 files changed, 58 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index f7644fe..e30ef67 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -299,7 +299,6 @@ struct omap_sdrc_params;
 extern void omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1);
 struct omap2_hsmmc_info;
-extern int omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers);
 extern void omap_reserve(void);
 
 struct omap_hwmod;
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 5791143..b39efd4 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -35,7 +35,6 @@
 #include "iomap.h"
 #include "common.h"
 #include "mmc.h"
-#include "hsmmc.h"
 #include "prminst44xx.h"
 #include "prcm_mpu44xx.h"
 #include "omap4-sar-layout.h"
@@ -284,59 +283,3 @@ skip_errata_init:
 	omap_wakeupgen_init();
 	irqchip_init();
 }
-
-#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
-static int omap4_twl6030_hsmmc_late_init(struct device *dev)
-{
-	int irq = 0;
-	struct platform_device *pdev = container_of(dev,
-				struct platform_device, dev);
-	struct omap_mmc_platform_data *pdata = dev->platform_data;
-
-	/* Setting MMC1 Card detect Irq */
-	if (pdev->id == 0) {
-		irq = twl6030_mmc_card_detect_config();
-		if (irq < 0) {
-			dev_err(dev, "%s: Error card detect config(%d)\n",
-				__func__, irq);
-			return irq;
-		}
-		pdata->slots[0].card_detect_irq = irq;
-		pdata->slots[0].card_detect = twl6030_mmc_card_detect;
-	}
-	return 0;
-}
-
-static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
-{
-	struct omap_mmc_platform_data *pdata;
-
-	/* dev can be null if CONFIG_MMC_OMAP_HS is not set */
-	if (!dev) {
-		pr_err("Failed %s\n", __func__);
-		return;
-	}
-	pdata = dev->platform_data;
-	pdata->init =	omap4_twl6030_hsmmc_late_init;
-}
-
-int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
-{
-	struct omap2_hsmmc_info *c;
-
-	omap_hsmmc_init(controllers);
-	for (c = controllers; c->mmc; c++) {
-		/* pdev can be null if CONFIG_MMC_OMAP_HS is not set */
-		if (!c->pdev)
-			continue;
-		omap4_twl6030_hsmmc_set_late_init(&c->pdev->dev);
-	}
-
-	return 0;
-}
-#else
-int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
-{
-	return 0;
-}
-#endif
-- 
1.8.1.1


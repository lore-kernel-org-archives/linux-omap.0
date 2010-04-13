From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH 10/11] omap hsmmc: fix the hsmmc driver for am3517.
Date: Tue, 13 Apr 2010 17:34:29 +0800
Message-ID: <1271151270-13038-2-git-send-email-stanley.miao@windriver.com>
References: <1271151118-12999-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:51514 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab0DMJZ6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Apr 2010 05:25:58 -0400
In-Reply-To: <1271151118-12999-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, madhu.cr@ti.com

am3517 don't have the register OMAP343X_CONTROL_PBIAS_LITE and the regulators
like "vmmc", so we don't need set "set_power" function for it.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/mach-omap2/hsmmc.c   |    4 +++-
 drivers/mmc/host/omap_hsmmc.c |   28 +++++++++++++++++-----------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 9ad2295..a6e6c86 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -150,7 +150,7 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 	if (cpu_is_omap2430()) {
 		control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
 		control_devconf1_offset = OMAP243X_CONTROL_DEVCONF1;
-	} else {
+	} else if (!cpu_is_omap3517() && !cpu_is_omap3505()) {
 		control_pbias_offset = OMAP343X_CONTROL_PBIAS_LITE;
 		control_devconf1_offset = OMAP343X_CONTROL_DEVCONF1;
 	}
@@ -216,6 +216,7 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 		 */
 		mmc->slots[0].ocr_mask = c->ocr_mask;
 
+#ifndef CONFIG_MACH_OMAP3517EVM
 		switch (c->mmc) {
 		case 1:
 			/* on-chip level shifting via PBIAS0/PBIAS1 */
@@ -244,6 +245,7 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 			kfree(mmc);
 			continue;
 		}
+#endif
 		hsmmc_data[c->mmc - 1] = mmc;
 	}
 
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 83f0aff..f3c64a2 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -236,7 +236,7 @@ static int omap_hsmmc_resume_cdirq(struct device *dev, int slot)
 
 #endif
 
-#ifdef CONFIG_REGULATOR
+#if defined(CONFIG_REGULATOR) && !defined(CONFIG_MACH_OMAP3517EVM)
 
 static int omap_hsmmc_1_set_power(struct device *dev, int slot, int power_on,
 				  int vdd)
@@ -1086,12 +1086,15 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
 		clk_disable(host->dbclk);
 
 	/* Turn the power off */
-	ret = mmc_slot(host).set_power(host->dev, host->slot_id, 0, 0);
+	if (mmc_slot(host).set_power) {
+		ret = mmc_slot(host).set_power(host->dev, host->slot_id, 0, 0);
+
+		/* Turn the power ON with given VDD 1.8 or 3.0v */
+		if (!ret)
+			ret = mmc_slot(host).set_power(host->dev,
+					host->slot_id, 1, vdd);
+	}
 
-	/* Turn the power ON with given VDD 1.8 or 3.0v */
-	if (!ret)
-		ret = mmc_slot(host).set_power(host->dev, host->slot_id, 1,
-					       vdd);
 	clk_enable(host->iclk);
 	clk_enable(host->fclk);
 	if (host->got_dbclk)
@@ -1478,13 +1481,15 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (ios->power_mode != host->power_mode) {
 		switch (ios->power_mode) {
 		case MMC_POWER_OFF:
-			mmc_slot(host).set_power(host->dev, host->slot_id,
-						 0, 0);
+			if (mmc_slot(host).set_power)
+				mmc_slot(host).set_power(host->dev,
+						host->slot_id, 0, 0);
 			host->vdd = 0;
 			break;
 		case MMC_POWER_UP:
-			mmc_slot(host).set_power(host->dev, host->slot_id,
-						 1, ios->vdd);
+			if (mmc_slot(host).set_power)
+				mmc_slot(host).set_power(host->dev,
+						host->slot_id, 1, ios->vdd);
 			host->vdd = ios->vdd;
 			break;
 		case MMC_POWER_ON:
@@ -1714,7 +1719,8 @@ static int omap_hsmmc_sleep_to_off(struct omap_hsmmc_host *host)
 		return 0;
 	}
 
-	mmc_slot(host).set_power(host->dev, host->slot_id, 0, 0);
+	if (mmc_slot(host).set_power)
+		mmc_slot(host).set_power(host->dev, host->slot_id, 0, 0);
 	host->vdd = 0;
 	host->power_mode = MMC_POWER_OFF;
 
-- 
1.5.4.3


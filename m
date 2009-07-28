From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V2 30/32] omap_hsmmc: ensure all clock enables and disables are paired
Date: Tue, 28 Jul 2009 13:42:15 +0300
Message-ID: <20090728104215.2371.65510.sendpatchset@ahunter-laptop>
References: <20090728103834.2371.65809.sendpatchset@ahunter-laptop>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753716AbZG1Kma@vger.kernel.org>
In-Reply-To: <20090728103834.2371.65809.sendpatchset@ahunter-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Pierre Ossman <pierre@ossman.eu>, Denis Karpov <ext-denis.2.karpov@nokia.com>, Matt Fleming <matt@console-pimps.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

>From 946bac7ddcc387a15c1391e416b54c3041798883 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Sun, 31 May 2009 19:27:36 +0300
Subject: [PATCH] omap_hsmmc: ensure all clock enables and disables are paired

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 32d5aef..abe1fa1 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -735,22 +735,24 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
 	/* Disable the clocks */
 	clk_disable(host->fclk);
 	clk_disable(host->iclk);
-	clk_disable(host->dbclk);
+	if (host->dbclk_enabled)
+		clk_disable(host->dbclk);
 
 	/* Turn the power off */
 	ret = mmc_slot(host).set_power(host->dev, host->slot_id, 0, 0);
-	if (ret != 0)
-		goto err;
 
 	/* Turn the power ON with given VDD 1.8 or 3.0v */
-	ret = mmc_slot(host).set_power(host->dev, host->slot_id, 1, vdd);
+	if (!ret)
+		ret = mmc_slot(host).set_power(host->dev, host->slot_id, 1,
+					       vdd);
+	clk_enable(host->iclk);
+	if (host->dbclk_enabled)
+		clk_enable(host->dbclk);
+	clk_enable(host->fclk);
+
 	if (ret != 0)
 		goto err;
 
-	clk_enable(host->fclk);
-	clk_enable(host->iclk);
-	clk_enable(host->dbclk);
-
 	OMAP_HSMMC_WRITE(host->base, HCTL,
 		OMAP_HSMMC_READ(host->base, HCTL) & SDVSCLR);
 	reg_val = OMAP_HSMMC_READ(host->base, HCTL);
@@ -1901,7 +1903,8 @@ static int omap_hsmmc_suspend(struct platform_device *pdev, pm_message_t state)
 				OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
 			mmc_host_disable(host->mmc);
 			clk_disable(host->iclk);
-			clk_disable(host->dbclk);
+			if (host->dbclk_enabled)
+				clk_disable(host->dbclk);
 		} else {
 			host->suspended = 0;
 			if (host->pdata->resume) {
@@ -1932,9 +1935,8 @@ static int omap_hsmmc_resume(struct platform_device *pdev)
 		if (ret)
 			goto clk_en_err;
 
-		if (clk_enable(host->dbclk) != 0)
-			dev_dbg(mmc_dev(host->mmc),
-					"Enabling debounce clk failed\n");
+		if (host->dbclk_enabled)
+			clk_enable(host->dbclk);
 
 		if (mmc_host_enable(host->mmc) != 0) {
 			clk_disable(host->iclk);
-- 
1.5.6.3

From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH] OMAP: MMC: Add several missing line breaks.
Date: Wed, 26 Mar 2008 11:33:45 -0400
Message-ID: <1206545625-12709-2-git-send-email-edubezval@gmail.com>
References: <1206020243-23355-1-git-send-email-felipe.balbi@nokia.com>
 <1206545625-12709-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:35344 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757347AbYCZPeQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Mar 2008 11:34:16 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2QFYBe9017316
	for <linux-omap@vger.kernel.org>; Wed, 26 Mar 2008 17:34:13 +0200
In-Reply-To: <1206545625-12709-1-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Felipe Balbi <felipe.balbi@nokia.com>

Misc clean up in omap_hsmmc.c to beautify debugging output.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 drivers/mmc/host/omap_hsmmc.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 3d4a7d1..70f6895 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -146,7 +146,7 @@ static void omap_mmc_stop_clock(struct mmc_omap_host *host)
 	OMAP_HSMMC_WRITE(host->base, SYSCTL,
 		OMAP_HSMMC_READ(host->base, SYSCTL) & ~CEN);
 	if ((OMAP_HSMMC_READ(host->base, SYSCTL) & CEN) != 0x0)
-		dev_dbg(mmc_dev(host->mmc), "MMC Clock is not stoped");
+		dev_dbg(mmc_dev(host->mmc), "MMC Clock is not stoped\n");
 }
 
 /*
@@ -401,7 +401,7 @@ static int omap_mmc_switch_opcond(struct mmc_omap_host *host, int vdd)
 
 	return 0;
 err:
-	dev_dbg(mmc_dev(host->mmc), "Unable to switch operating voltage \n");
+	dev_dbg(mmc_dev(host->mmc), "Unable to switch operating voltage\n");
 	return ret;
 }
 
@@ -760,11 +760,11 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 	 * MMC can still work without debounce clock.
 	 */
 	if (IS_ERR(host->dbclk))
-		dev_dbg(mmc_dev(host->mmc), "Failed to get debounce clock \n");
+		dev_dbg(mmc_dev(host->mmc), "Failed to get debounce clock\n");
 	else
 		if (clk_enable(host->dbclk) != 0)
 			dev_dbg(mmc_dev(host->mmc), "Enabling debounce"
-							"clk failed\n");
+							" clk failed\n");
 		else
 			host->dbclk_enabled = 1;
 
@@ -793,7 +793,7 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 	ret = request_irq(host->irq, mmc_omap_irq, IRQF_DISABLED, pdev->name,
 			 host);
 	if (ret) {
-		dev_dbg(mmc_dev(host->mmc), "Unable to grab HSMMC IRQ");
+		dev_dbg(mmc_dev(host->mmc), "Unable to grab HSMMC IRQ\n");
 		goto irq_err;
 	}
 
@@ -820,7 +820,7 @@ err:
 	return ret;
 
 irq_err:
-	dev_dbg(mmc_dev(host->mmc), "Unable to configure MMC IRQs");
+	dev_dbg(mmc_dev(host->mmc), "Unable to configure MMC IRQs\n");
 	clk_disable(host->fclk);
 	clk_disable(host->iclk);
 	clk_put(host->fclk);
@@ -881,7 +881,7 @@ static int omap_mmc_suspend(struct platform_device *pdev, pm_message_t state)
 			if (ret)
 				dev_dbg(mmc_dev(host->mmc),
 					"Unable to handle MMC board"
-					"level suspend\n");
+					" level suspend\n");
 
 			if (!(OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET)) {
 				OMAP_HSMMC_WRITE(host->base, HCTL,
-- 
1.5.4.2


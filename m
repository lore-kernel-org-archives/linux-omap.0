From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] OMAP: MMC: Add several missing line breaks
Date: Thu, 20 Mar 2008 15:37:23 +0200
Message-ID: <1206020243-23355-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35148 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583AbYCTNld (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Mar 2008 09:41:33 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2KDfGVx013789
	for <linux-omap@vger.kernel.org>; Thu, 20 Mar 2008 15:41:30 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Misc clean up in omap_hsmmc.c to beautify debugging output.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 047c64d..3fdd484 100644
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
 
@@ -763,11 +763,11 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
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
 
@@ -796,7 +796,7 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 	ret = request_irq(host->irq, mmc_omap_irq, IRQF_DISABLED, pdev->name,
 			 host);
 	if (ret) {
-		dev_dbg(mmc_dev(host->mmc), "Unable to grab HSMMC IRQ");
+		dev_dbg(mmc_dev(host->mmc), "Unable to grab HSMMC IRQ\n");
 		goto irq_err;
 	}
 
@@ -807,7 +807,7 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 				  host);
 		if (ret) {
 			dev_dbg(mmc_dev(host->mmc),
-				"Unable to grab MMC CD IRQ");
+				"Unable to grab MMC CD IRQ\n", ret);
 			free_irq(host->irq, host);
 			goto irq_err;
 		}
@@ -837,7 +837,7 @@ err:
 	return ret;
 
 irq_err:
-	dev_dbg(mmc_dev(host->mmc), "Unable to configure MMC IRQs");
+	dev_dbg(mmc_dev(host->mmc), "Unable to configure MMC IRQs\n");
 	clk_disable(host->fclk);
 	clk_disable(host->iclk);
 	clk_put(host->fclk);
@@ -900,7 +900,7 @@ static int omap_mmc_suspend(struct platform_device *pdev, pm_message_t state)
 			if (ret)
 				dev_dbg(mmc_dev(host->mmc),
 					"Unable to handle MMC board"
-					"level suspend\n");
+					" level suspend\n");
 
 			if (!(OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET)) {
 				OMAP_HSMMC_WRITE(host->base, HCTL,
-- 
1.5.5.rc0.16.g02b00


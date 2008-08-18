From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Subject: [PATCH] MMC: OMAP: Re-organizing some goto at hsmmc probe
Date: Mon, 18 Aug 2008 18:13:18 +0300
Message-ID: <1219072400-7814-5-git-send-email-jarkko.lavinen@nokia.com>
References: <1219072400-7814-1-git-send-email-jarkko.lavinen@nokia.com>
 <1219072400-7814-2-git-send-email-jarkko.lavinen@nokia.com>
 <1219072400-7814-3-git-send-email-jarkko.lavinen@nokia.com>
 <1219072400-7814-4-git-send-email-jarkko.lavinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:55429 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbYHRPRO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 11:17:14 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7IFGBkg015871
	for <linux-omap@vger.kernel.org>; Mon, 18 Aug 2008 10:17:12 -0500
In-Reply-To: <1219072400-7814-4-git-send-email-jarkko.lavinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>

Re-organizing some goto at hsmmc probe.

Signed-off-by: Francisco Alecrim <francisco.alecrim@indt.org.br>
Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index f5acf91..824e7e9 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -878,7 +878,7 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 			 host);
 	if (ret) {
 		dev_dbg(mmc_dev(host->mmc), "Unable to grab HSMMC IRQ\n");
-		goto irq_err;
+		goto err_irq;
 	}
 
 	/* Request IRQ for card detect */
@@ -888,18 +888,17 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 				  host);
 		if (ret) {
 			dev_dbg(mmc_dev(host->mmc),
-				"Unable to grab MMC CD IRQ");
-			free_irq(host->irq, host);
-			goto irq_err;
+				"Unable to grab MMC CD IRQ\n");
+			goto err_irq_cd;
 		}
 	}
 
 	INIT_WORK(&host->mmc_carddetect_work, mmc_omap_detect);
 	if (pdata->init != NULL) {
 		if (pdata->init(&pdev->dev) != 0) {
-			free_irq(mmc_slot(host).card_detect_irq, host);
-			free_irq(host->irq, host);
-			goto irq_err;
+			dev_dbg(mmc_dev(host->mmc),
+				"Unable to configure MMC IRQs\n");
+			goto err_irq_cd_init;
 		}
 	}
 
@@ -911,8 +910,11 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 
 	return 0;
 
-irq_err:
-	dev_dbg(mmc_dev(host->mmc), "Unable to configure MMC IRQs\n");
+err_irq_cd_init:
+	free_irq(mmc_slot(host).card_detect_irq, host);
+err_irq_cd:
+	free_irq(host->irq, host);
+err_irq:
 	clk_disable(host->fclk);
 	clk_disable(host->iclk);
 	clk_put(host->fclk);
-- 
1.5.6.3


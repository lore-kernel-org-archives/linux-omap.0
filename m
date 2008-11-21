From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: [PATCH 9/9] OMAP: HSMMC: SDBP and missing clock enabled fixes
Date: Fri, 21 Nov 2008 11:25:32 +0200
Message-ID: <49267E8C.8050703@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32988 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186AbYKUJRf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 04:17:35 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Disable SDBP at suspend and enable it resume. Make sure
fclk is running at suspend before touching HCTL.

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   31 ++++++++++++-------------------
 1 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 6058a70..78c5c18 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -897,10 +897,7 @@ static void omap_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		OMAP_HSMMC_WRITE(host->base, CON,
 				OMAP_HSMMC_READ(host->base, CON) | OD);
 
-	if (ios->power_mode == MMC_POWER_OFF)
-		mmc_omap_fclk_state(host, OFF);
-	else
-		mmc_omap_fclk_lazy_disable(host);
+	mmc_omap_fclk_lazy_disable(host);
 }
 
 static int omap_hsmmc_get_cd(struct mmc_host *mmc)
@@ -1207,12 +1204,11 @@ static int omap_mmc_suspend(struct platform_device *pdev, pm_message_t state)
 		return 0;
 
 	if (host) {
-		mmc_omap_fclk_state(host, ON);
-
 		ret = mmc_suspend_host(host->mmc, state);
 		if (ret == 0) {
 			host->suspended = 1;
 
+			mmc_omap_fclk_state(host, ON);
 			OMAP_HSMMC_WRITE(host->base, ISE, 0);
 			OMAP_HSMMC_WRITE(host->base, IE, 0);
 
@@ -1224,19 +1220,8 @@ static int omap_mmc_suspend(struct platform_device *pdev, pm_message_t state)
 						" level suspend\n");
 			}
 
-			if (!(OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET)) {
-				u32 hctl = OMAP_HSMMC_READ(host->base, HCTL) &
-					SDVSCLR;
-
-				if (host->id == OMAP_MMC1_DEVID)
-					hctl |= SDVS30;
-				else
-					hctl |= SDVS18;
-
-				OMAP_HSMMC_WRITE(host->base, HCTL, hctl);
-				OMAP_HSMMC_WRITE(host->base, HCTL, hctl | SDBP);
-			}
-
+			OMAP_HSMMC_WRITE(host->base, HCTL,
+					 OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
 			mmc_omap_fclk_state(host, OFF);
 			clk_disable(host->iclk);
 			clk_disable(host->dbclk);
@@ -1256,6 +1241,7 @@ static int omap_mmc_resume(struct platform_device *pdev)
 		return 0;
 
 	if (host) {
+		int i;
 		if (mmc_omap_fclk_state(host, ON) != 0)
 			goto clk_en_err;
 
@@ -1270,6 +1256,13 @@ static int omap_mmc_resume(struct platform_device *pdev)
 			dev_dbg(mmc_dev(host->mmc),
 					"Enabling debounce clk failed\n");
 
+		OMAP_HSMMC_WRITE(host->base, HCTL,
+				 OMAP_HSMMC_READ(host->base, HCTL) | SDBP);
+
+		for (i = 0; i < 100; i++)
+			if (OMAP_HSMMC_READ(host->base, HCTL) & SDBP)
+				break;
+
 		if (host->pdata->resume) {
 			ret = host->pdata->resume(&pdev->dev, host->slot_id);
 			if (ret)
-- 
1.5.4.3

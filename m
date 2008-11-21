From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: [PATCH 5/9] OMAP: HSMMC: Fix oops in omap_mmc_remove
Date: Fri, 21 Nov 2008 11:24:53 +0200
Message-ID: <49267E65.5030407@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32828 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbYKUJQf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 04:16:35 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Do not access host in omap_mmc_remove() if it is null.  This
occurs when module is removed before its platform data is set.

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4bc25c0..f4b7c30 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1128,15 +1128,17 @@ static int omap_mmc_remove(struct platform_device *pdev)
 	struct resource *res;
 	u16 vdd = 0;
 
-	mmc_omap_fclk_state(host, ON);
-	if (!(OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET)) {
-	/*
-	 * Set the vdd back to 3V,
-	 * applicable for dual volt support.
-	 */
-		vdd = fls(host->mmc->ocr_avail) - 1;
-		if (omap_mmc_switch_opcond(host, vdd) != 0)
-			host->mmc->ios.vdd = vdd;
+	if (host) {
+		mmc_omap_fclk_state(host, ON);
+		if (!(OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET)) {
+			/*
+			 * Set the vdd back to 3V,
+			 * applicable for dual volt support.
+			 */
+			vdd = fls(host->mmc->ocr_avail) - 1;
+			if (omap_mmc_switch_opcond(host, vdd) != 0)
+				host->mmc->ios.vdd = vdd;
+		}
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.5.4.3

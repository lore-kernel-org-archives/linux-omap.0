From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: [PATCH 5/9] OMAP: HSMMC: Fix oops in omap_mmc_remove
Date: Fri, 21 Nov 2008 11:47:26 +0200
Message-ID: <492683AE.9070403@nokia.com>
References: <49267E28.1020303@nokia.com> <49268161.1010304@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:63742 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbYKUJiv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 04:38:51 -0500
In-Reply-To: <49268161.1010304@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Date: Thu, 6 Nov 2008 16:02:29 +0200

Do not access host in omap_mmc_remove() if it is null.  This
occurs when module is removed before its platform data is set.

This fixes the oops part in bug 86677.

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

From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: [PATCH 6/9] OMAP: HSMMC: Fix SDVS values in omap_mmc_switch_opcond
Date: Fri, 21 Nov 2008 11:25:02 +0200
Message-ID: <49267E6E.6040500@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32838 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbYKUJQi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 04:16:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Set only 1.8V as SDVS value in HCTL register for HSMMC2 and HSMMC3.

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index f4b7c30..e329115 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -529,10 +529,13 @@ static int omap_mmc_switch_opcond(struct mmc_omap_host *host, int vdd)
 	 * Only MMC1 supports 3.0V.  MMC2 will not function if SDVS30 is
 	 * set in HCTL.
 	 */
-	if (host->id == OMAP_MMC1_DEVID && (((1 << vdd) == MMC_VDD_32_33) ||
-				((1 << vdd) == MMC_VDD_33_34)))
-		reg_val |= SDVS30;
-	if ((1 << vdd) == MMC_VDD_165_195)
+	if (host->id == OMAP_MMC1_DEVID) {
+		if (((1 << vdd) == MMC_VDD_32_33) ||
+		    ((1 << vdd) == MMC_VDD_33_34))
+			reg_val |= SDVS30;
+		else if ((1 << vdd) == MMC_VDD_165_195)
+			reg_val |= SDVS18;
+	} else
 		reg_val |= SDVS18;
 
 	OMAP_HSMMC_WRITE(host->base, HCTL, reg_val);
-- 
1.5.4.3

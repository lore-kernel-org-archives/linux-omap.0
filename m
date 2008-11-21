From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: [PATCH 4/9] OMAP: HSMMC: Fix suspend/resume for MMCHS2
Date: Fri, 21 Nov 2008 11:24:42 +0200
Message-ID: <49267E5A.1070106@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58321 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbYKUJQg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 04:16:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

For HSMMC2 and HSMMC3 set SDVSS to 1.8V in HCTL before enabling the SDBP bit.

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index a134f76..4bc25c0 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1197,15 +1197,16 @@ static int omap_mmc_suspend(struct platform_device *pdev, pm_message_t state)
 			}
 
 			if (!(OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET)) {
-				OMAP_HSMMC_WRITE(host->base, HCTL,
-					OMAP_HSMMC_READ(host->base, HCTL)
-					& SDVSCLR);
-				OMAP_HSMMC_WRITE(host->base, HCTL,
-					OMAP_HSMMC_READ(host->base, HCTL)
-					| SDVS30);
-				OMAP_HSMMC_WRITE(host->base, HCTL,
-					OMAP_HSMMC_READ(host->base, HCTL)
-					| SDBP);
+				u32 hctl = OMAP_HSMMC_READ(host->base, HCTL) &
+					SDVSCLR;
+
+				if (host->id == OMAP_MMC1_DEVID)
+					hctl |= SDVS30;
+				else
+					hctl |= SDVS18;
+
+				OMAP_HSMMC_WRITE(host->base, HCTL, hctl);
+				OMAP_HSMMC_WRITE(host->base, HCTL, hctl | SDBP);
 			}
 
 			mmc_omap_fclk_state(host, OFF);
-- 
1.5.4.3

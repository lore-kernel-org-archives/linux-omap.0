From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 7/10] OMAP: HSMMC: Disable SDBP at suspend
Date: Thu, 12 Mar 2009 18:23:39 +0200
Message-ID: <20090312162339.19421.84592.sendpatchset@ahunter-laptop>
References: <20090312162252.19421.34019.sendpatchset@ahunter-laptop>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:17390 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757528AbZCLQYB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 12:24:01 -0400
In-Reply-To: <20090312162252.19421.34019.sendpatchset@ahunter-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pierre Ossman <drzeus-mmc@drzeus.cx>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, Grazvydas Ignotas <notasas@gmail.com>, David Brownell <david-b@pacbell.net>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, lkml <linux-kernel@vger.kernel.org>

>From 999afd472603ec1d572c34525e01d5215304addb Mon Sep 17 00:00:00 2001
From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Date: Thu, 12 Mar 2009 15:30:58 +0200
Subject: [PATCH] OMAP: HSMMC: Disable SDBP at suspend

Turn off the bus power at suspend.

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   16 ++--------------
 1 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 7a9ca4f..2832651 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1214,20 +1214,8 @@ static int omap_mmc_suspend(struct platform_device *pdev, pm_message_t state)
 						" level suspend\n");
 			}
 
-			if (host->id == OMAP_MMC1_DEVID
-					&& !(OMAP_HSMMC_READ(host->base, HCTL)
-							& SDVSDET)) {
-				OMAP_HSMMC_WRITE(host->base, HCTL,
-					OMAP_HSMMC_READ(host->base, HCTL)
-					& SDVSCLR);
-				OMAP_HSMMC_WRITE(host->base, HCTL,
-					OMAP_HSMMC_READ(host->base, HCTL)
-					| SDVS30);
-				OMAP_HSMMC_WRITE(host->base, HCTL,
-					OMAP_HSMMC_READ(host->base, HCTL)
-					| SDBP);
-			}
-
+			OMAP_HSMMC_WRITE(host->base, HCTL,
+					 OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
 			clk_disable(host->fclk);
 			clk_disable(host->iclk);
 			clk_disable(host->dbclk);
-- 
1.5.6.3


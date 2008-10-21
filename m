From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Subject: PATCH 1/2 OMAP: HSMMC: Fix HSMMC2 getting stuck with suspend/resume
Date: Tue, 21 Oct 2008 15:43:06 +0300
Message-ID: <20081021124306.GA11845@angel.research.nokia.com>
Reply-To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:54152 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647AbYJUMnf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Oct 2008 08:43:35 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9LCh7Gk025246
	for <linux-omap@vger.kernel.org>; Tue, 21 Oct 2008 15:43:32 +0300
Received: from jlavi by angel.research.nokia.com with local (Exim 4.69)
	(envelope-from <jlavi@angel.research.nokia.com>)
	id 1KsGZm-00035E-OI
	for linux-omap@vger.kernel.org; Tue, 21 Oct 2008 15:43:06 +0300
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap Mailing List <linux-omap@vger.kernel.org>

HSMMC2 was stuck on a test board when resuming from
suspend. After the resume the first command CMD0 is written to
command register and then we wait for an interrupt. After the CMD0 
was written, no interrupt occured. No EOC, no timeout nor other error.
This jammed the request.

The problem was a wrong 3.0V voltage setting being applied into
HCTL before turning SDBP bit on. After fixing the voltage to 1.8V
suspend-resume started to work correctly.

Cheers
Jarkko Lavinen

>From 1be795080e89cca6e637f88a4e14026aee0a75e8 Mon Sep 17 00:00:00 2001
From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Date: Mon, 20 Oct 2008 11:23:45 +0300
Subject: [PATCH] OMAP: HSMMC: Fix HSMMC2 getting stuck with suspend/resume

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 00b1b68..edd1ce0 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1068,15 +1068,16 @@ static int omap_mmc_suspend(struct platform_device *pdev, pm_message_t state)
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
 
 			clk_disable(host->fclk);
-- 
1.5.6.5


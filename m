From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 5/5] mmc: omap_hsmmc: remove unused no_off
Date: Mon, 21 Oct 2013 00:25:22 +0530
Message-ID: <1382295322-18995-5-git-send-email-balajitk@ti.com>
References: <1382295322-18995-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43129 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654Ab3JTSzl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 20 Oct 2013 14:55:41 -0400
In-Reply-To: <1382295322-18995-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

With lazy disable gone, no_off is not used any more in omap_hsmmc

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 60db34d..1646347 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1829,13 +1829,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	mmc->ops	= &omap_hsmmc_ops;
 
-	/*
-	 * If regulator_disable can only put vcc_aux to sleep then there is
-	 * no off state.
-	 */
-	if (mmc_slot(host).vcc_aux_disable_is_sleep)
-		mmc_slot(host).no_off = 1;
-
 	mmc->f_min = OMAP_MMC_MIN_CLOCK;
 
 	if (pdata->max_freq > 0)
-- 
1.7.5.4


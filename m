From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [Resending PATCH 3/3] Fixes required for HSMMC driver to work as
     module
Date: Fri, 8 Aug 2008 09:43:42 +0530 (IST)
Message-ID: <43767.192.168.10.89.1218168822.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:60192 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750695AbYHHENt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Aug 2008 00:13:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

From: Madhusudhan Chikkature<madhu.cr@ti.com>

ARM: OMAP3: Fixes required to make HSMMC driver work as module.Complete the
previously applied patch.

This patch provides the necessary fixes to make the HSMMC driver work as
loadble module.

Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
Signed-off-by: Romit Dasgupta <romit@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+)

Index: linux-omap-2.6/drivers/mmc/host/omap_hsmmc.c
===================================================================
--- linux-omap-2.6.orig/drivers/mmc/host/omap_hsmmc.c	2008-08-07
15:56:52.000000000 +0530
+++ linux-omap-2.6/drivers/mmc/host/omap_hsmmc.c	2008-08-07 16:09:22.000000000
+0530
@@ -901,9 +901,26 @@ err:
 static int omap_mmc_remove(struct platform_device *pdev)
 {
 	struct mmc_omap_host *host = platform_get_drvdata(pdev);
+	struct resource *res;
+	u16 vdd = 0;
+
+	if (!(OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET)) {
+	/*
+	 * Set the vdd back to 3V,
+	 * applicable for dual volt support.
+	 */
+		vdd = fls(host->mmc->ocr_avail) - 1;
+		if (omap_mmc_switch_opcond(host, vdd) != 0)
+			host->mmc->ios.vdd = vdd;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res)
+		release_mem_region(res->start, res->end - res->start + 1);

 	platform_set_drvdata(pdev, NULL);
 	if (host) {
+		mmc_remove_host(host->mmc);
 		if (host->pdata->cleanup)
 			host->pdata->cleanup(&pdev->dev);
 		free_irq(host->irq, host);



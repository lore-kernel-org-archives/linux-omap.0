From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 09/24] omap4: clocks: Make mcbsp driver's clock calls OMAP4 compatible
Date: Tue, 16 Feb 2010 21:28:00 +0530
Message-ID: <1266335895-32741-9-git-send-email-santosh.shilimkar@ti.com>
References: <1266335895-32741-1-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-2-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-3-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-4-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-5-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-6-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-7-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-8-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54298 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757013Ab0BPP6d (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 10:58:33 -0500
In-Reply-To: <1266335895-32741-8-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, ben@fluff.org.uk, sameo@linux.intel.com, lrg@slimlogic.co.uk, paul@pwsan.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Abhijit Pagare <abhijitpagare@ti.com>

The mcbsp driver has been adapted for the OMAP4 way of clock calls.
In OMAP4, the iclk are hw controlled and no sw control is available

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/mcbsp.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 473be3d..72b9694 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -1314,11 +1314,14 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 	mcbsp->dma_rx_sync = pdata->dma_rx_sync;
 	mcbsp->dma_tx_sync = pdata->dma_tx_sync;
 
-	mcbsp->iclk = clk_get(&pdev->dev, "ick");
-	if (IS_ERR(mcbsp->iclk)) {
-		ret = PTR_ERR(mcbsp->iclk);
-		dev_err(&pdev->dev, "unable to get ick: %d\n", ret);
-		goto err_iclk;
+	/* OMAP4 iclk are hw controlled and no sw control is available */
+	if (!cpu_is_omap44xx()) {
+		mcbsp->iclk = clk_get(&pdev->dev, "ick");
+		if (IS_ERR(mcbsp->iclk)) {
+			ret = PTR_ERR(mcbsp->iclk);
+			dev_err(&pdev->dev, "unable to get ick: %d\n", ret);
+			goto err_iclk;
+		}
 	}
 
 	mcbsp->fclk = clk_get(&pdev->dev, "fck");
-- 
1.6.0.4


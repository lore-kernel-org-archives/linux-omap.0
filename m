From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH v3 2/2] USB: DWC3: EXYNOS: Remove platform data for dwc3-exynos
Date: Sat, 03 Nov 2012 18:00:28 +0530
Message-ID: <1351945828-28559-3-git-send-email-gautam.vivek@samsung.com>
References: <1351945828-28559-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:23013 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932075Ab2KCMY5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Nov 2012 08:24:57 -0400
In-reply-to: <1351945828-28559-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org
Cc: gregkh@linuxfoundation.org, balbi@ti.com, rob.herring@calxeda.com, av.tikhomirov@samsung.com, kishon@ti.com

We are removing plat data which was used till now to init and
exit phy. We no longer need this since dwc3-core takes care of
initializing and shutting-down the phy using usb_phy_init()
and usb_phy_shutdown().

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/dwc3/dwc3-exynos.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 6471d78..dc35c54 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -92,7 +92,6 @@ static u64 dwc3_exynos_dma_mask = DMA_BIT_MASK(32);
 
 static int __devinit dwc3_exynos_probe(struct platform_device *pdev)
 {
-	struct dwc3_exynos_data	*pdata = pdev->dev.platform_data;
 	struct platform_device	*dwc3;
 	struct dwc3_exynos	*exynos;
 	struct clk		*clk;
@@ -145,14 +144,6 @@ static int __devinit dwc3_exynos_probe(struct platform_device *pdev)
 
 	clk_enable(exynos->clk);
 
-	/* PHY initialization */
-	if (!pdata) {
-		dev_dbg(&pdev->dev, "missing platform data\n");
-	} else {
-		if (pdata->phy_init)
-			pdata->phy_init(pdev, pdata->phy_type);
-	}
-
 	ret = platform_device_add_resources(dwc3, pdev->resource,
 			pdev->num_resources);
 	if (ret) {
@@ -169,9 +160,6 @@ static int __devinit dwc3_exynos_probe(struct platform_device *pdev)
 	return 0;
 
 err4:
-	if (pdata && pdata->phy_exit)
-		pdata->phy_exit(pdev, pdata->phy_type);
-
 	clk_disable(clk);
 	clk_put(clk);
 err3:
@@ -185,15 +173,11 @@ err0:
 static int __devexit dwc3_exynos_remove(struct platform_device *pdev)
 {
 	struct dwc3_exynos	*exynos = platform_get_drvdata(pdev);
-	struct dwc3_exynos_data *pdata = pdev->dev.platform_data;
 
 	platform_device_unregister(exynos->dwc3);
 	platform_device_unregister(exynos->usb2_phy);
 	platform_device_unregister(exynos->usb3_phy);
 
-	if (pdata && pdata->phy_exit)
-		pdata->phy_exit(pdev, pdata->phy_type);
-
 	clk_disable(exynos->clk);
 	clk_put(exynos->clk);
 
-- 
1.7.6.5


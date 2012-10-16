From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH v2 2/2] USB: DWC3: EXYNOS: Remove platform data for dwc3-exynos
Date: Tue, 16 Oct 2012 14:15:57 +0530
Message-ID: <1350377157-28465-3-git-send-email-gautam.vivek@samsung.com>
References: <1350377157-28465-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:47799 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502Ab2JPIn3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 04:43:29 -0400
In-reply-to: <1350377157-28465-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: gregkh@linuxfoundation.org, balbi@ti.com, rob.herring@calxeda.com, thomas.abraham@linaro.org, kishon@ti.com, av.tikhomirov@samsung.com

We are removing plat data which was used till now to init and
exit phy. We no longer need this since dwc3-core takes care of
initializing and shutting-down the phy using usb_phy_init()
and usb_phy_shutdown().

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/dwc3/dwc3-exynos.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index d11ef49..5a2a73f 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -92,7 +92,6 @@ static u64 dwc3_exynos_dma_mask = DMA_BIT_MASK(32);
 
 static int __devinit dwc3_exynos_probe(struct platform_device *pdev)
 {
-	struct dwc3_exynos_data	*pdata = pdev->dev.platform_data;
 	struct platform_device	*dwc3;
 	struct dwc3_exynos	*exynos;
 	struct clk		*clk;
@@ -150,14 +149,6 @@ static int __devinit dwc3_exynos_probe(struct platform_device *pdev)
 
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
@@ -174,9 +165,6 @@ static int __devinit dwc3_exynos_probe(struct platform_device *pdev)
 	return 0;
 
 err4:
-	if (pdata && pdata->phy_exit)
-		pdata->phy_exit(pdev, pdata->phy_type);
-
 	clk_disable(clk);
 	clk_put(clk);
 err3:
@@ -192,7 +180,6 @@ err0:
 static int __devexit dwc3_exynos_remove(struct platform_device *pdev)
 {
 	struct dwc3_exynos	*exynos = platform_get_drvdata(pdev);
-	struct dwc3_exynos_data *pdata = pdev->dev.platform_data;
 
 	platform_device_unregister(exynos->dwc3);
 	platform_device_unregister(exynos->usb2_phy);
@@ -200,9 +187,6 @@ static int __devexit dwc3_exynos_remove(struct platform_device *pdev)
 
 	dwc3_put_device_id(exynos->dwc3->id);
 
-	if (pdata && pdata->phy_exit)
-		pdata->phy_exit(pdev, pdata->phy_type);
-
 	clk_disable(exynos->clk);
 	clk_put(exynos->clk);
 
-- 
1.7.6.5


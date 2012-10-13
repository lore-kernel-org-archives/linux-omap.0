From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH 1/2] USB: dwc3-exynos: Add support for device tree
Date: Sat, 13 Oct 2012 19:17:31 +0530
Message-ID: <1350136052-25583-2-git-send-email-gautam.vivek@samsung.com>
References: <1350136052-25583-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:52566 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925Ab2JMNmN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Oct 2012 09:42:13 -0400
In-reply-to: <1350136052-25583-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: gregkh@linuxfoundation.org, balbi@ti.com, rob.herring@calxeda.com, thomas.abraham@linaro.org, kishon@ti.com, av.tikhomirov@samsung.com

This patch adds support to parse probe data for
dwc3 driver for exynos using device tree

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/dwc3/dwc3-exynos.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index ca65978..78e6219 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -21,6 +21,7 @@
 #include <linux/clk.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/nop-usb-xceiv.h>
+#include <linux/of.h>
 
 #include "core.h"
 
@@ -87,6 +88,8 @@ err1:
 	return ret;
 }
 
+static u64 dwc3_exynos_dma_mask = DMA_BIT_MASK(32);
+
 static int __devinit dwc3_exynos_probe(struct platform_device *pdev)
 {
 	struct dwc3_exynos_data	*pdata = pdev->dev.platform_data;
@@ -103,6 +106,16 @@ static int __devinit dwc3_exynos_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
+	/*
+	 * Right now device-tree probed devices don't get dma_mask set.
+	 * Since shared usb code relies on it, set it here for now.
+	 * Once we move to full device tree support this will vanish off.
+	 */
+	if (!pdev->dev.dma_mask)
+		pdev->dev.dma_mask = &dwc3_exynos_dma_mask;
+	if (!pdev->dev.coherent_dma_mask)
+		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+
 	platform_set_drvdata(pdev, exynos);
 
 	devid = dwc3_get_device_id();
@@ -200,11 +213,20 @@ static int __devexit dwc3_exynos_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id exynos_dwc3_match[] = {
+	{ .compatible = "samsung,exynos-dwc3" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, exynos_dwc3_match);
+#endif
+
 static struct platform_driver dwc3_exynos_driver = {
 	.probe		= dwc3_exynos_probe,
 	.remove		= __devexit_p(dwc3_exynos_remove),
 	.driver		= {
 		.name	= "exynos-dwc3",
+		.of_match_table = of_match_ptr(exynos_dwc3_match),
 	},
 };
 
-- 
1.7.6.5


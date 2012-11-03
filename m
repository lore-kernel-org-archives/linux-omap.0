From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH v3 1/2] USB: dwc3-exynos: Add support for device tree
Date: Sat, 03 Nov 2012 18:00:27 +0530
Message-ID: <1351945828-28559-2-git-send-email-gautam.vivek@samsung.com>
References: <1351945828-28559-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:23008 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932075Ab2KCMYy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Nov 2012 08:24:54 -0400
In-reply-to: <1351945828-28559-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org
Cc: gregkh@linuxfoundation.org, balbi@ti.com, rob.herring@calxeda.com, av.tikhomirov@samsung.com, kishon@ti.com

This patch adds support to parse probe data for
dwc3-exynos driver using device tree.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/dwc3/dwc3-exynos.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 586f105..6471d78 100644
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
@@ -102,6 +105,14 @@ static int __devinit dwc3_exynos_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
+	/*
+	 * Right now device-tree probed devices don't get dma_mask set.
+	 * Since shared usb code relies on it, set it here for now.
+	 * Once we move to full device tree support this will vanish off.
+	 */
+	if (!pdev->dev.dma_mask)
+		pdev->dev.dma_mask = &dwc3_exynos_dma_mask;
+
 	platform_set_drvdata(pdev, exynos);
 
 	ret = dwc3_exynos_register_phys(exynos);
@@ -191,11 +202,20 @@ static int __devexit dwc3_exynos_remove(struct platform_device *pdev)
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


From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/PATCH 3/7] arm: omap: smartreflex: use dev_get_drvdata()
Date: Mon, 10 Oct 2011 15:26:15 +0300
Message-ID: <1318249579-4089-3-git-send-email-balbi@ti.com>
References: <1318249579-4089-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:37854 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751654Ab1JJM0b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Oct 2011 08:26:31 -0400
Received: by mail-bw0-f45.google.com with SMTP id zv15so8842774bkb.32
        for <linux-omap@vger.kernel.org>; Mon, 10 Oct 2011 05:26:30 -0700 (PDT)
In-Reply-To: <1318249579-4089-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

When we need to fetch struct omap_sr on PM
handlers, there's no need to access platform_data.

Instead, we can use dev_get_drvdata(dev) like
other drivers do.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   51 ++++++------------------------------
 1 files changed, 9 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 55e297e..357363b 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -992,22 +992,9 @@ err_free_devinfo:
 
 static int __devexit omap_sr_remove(struct platform_device *pdev)
 {
-	struct omap_sr_data *pdata = pdev->dev.platform_data;
-	struct omap_sr *sr_info;
+	struct omap_sr *sr_info = platform_get_drvdata(pdev);
 	struct resource *mem;
 
-	if (!pdata) {
-		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
-		return -EINVAL;
-	}
-
-	sr_info = _sr_lookup(pdata->voltdm);
-	if (IS_ERR(sr_info)) {
-		dev_warn(&pdev->dev, "%s: omap_sr struct not found\n",
-			__func__);
-		return -EINVAL;
-	}
-
 	if (sr_info->autocomp_active)
 		sr_stop_vddautocomp(sr_info);
 	if (sr_info->dbg_dir)
@@ -1024,20 +1011,10 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
 
 static int omap_sr_suspend(struct device *dev)
 {
-	struct omap_sr_data *pdata;
-	struct omap_sr *sr_info;
+	struct omap_sr *sr_info = dev_get_drvdata(dev);
 
-	pdata = dev_get_platdata(dev);
-	if (!pdata) {
-		dev_err(dev, "%s: platform data missing\n", __func__);
-		return -EINVAL;
-	}
-
-	sr_info = _sr_lookup(pdata->voltdm);
-	if (IS_ERR(sr_info)) {
-		dev_warn(dev, "%s: omap_sr struct not found\n", __func__);
-		return -EINVAL;
-	}
+	if (!sr_info)
+		return 0;
 
 	if (!sr_info->autocomp_active)
 		return 0;
@@ -1045,7 +1022,7 @@ static int omap_sr_suspend(struct device *dev)
 	if (sr_info->is_suspended)
 		return 0;
 
-	omap_sr_disable_reset_volt(pdata->voltdm);
+	omap_sr_disable_reset_volt(sr_info->voltdm);
 	sr_info->is_suspended = true;
 	/* Flag the same info to the other CPUs */
 	smp_wmb();
@@ -1055,20 +1032,10 @@ static int omap_sr_suspend(struct device *dev)
 
 static int omap_sr_resume(struct device *dev)
 {
-	struct omap_sr_data *pdata;
-	struct omap_sr *sr_info;
+	struct omap_sr *sr_info = dev_get_drvdata(dev);
 
-	pdata = dev_get_platdata(dev);
-	if (!pdata) {
-		dev_err(dev, "%s: platform data missing\n", __func__);
-		return -EINVAL;
-	}
-
-	sr_info = _sr_lookup(pdata->voltdm);
-	if (IS_ERR(sr_info)) {
-		dev_warn(dev, "%s: omap_sr struct not found\n", __func__);
-		return -EINVAL;
-	}
+	if (!sr_info)
+		return 0;
 
 	if (!sr_info->autocomp_active)
 		return 0;
@@ -1079,7 +1046,7 @@ static int omap_sr_resume(struct device *dev)
 	sr_info->is_suspended = false;
 	/* Flag the same info to the other CPUs */
 	smp_wmb();
-	omap_sr_enable(pdata->voltdm);
+	omap_sr_enable(sr_info->voltdm);
 
 	return 0;
 }
-- 
1.7.6.396.ge0613


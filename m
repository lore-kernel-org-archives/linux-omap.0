From: Shweta Gulati <shweta.gulati@ti.com>
Subject: [PATCH] OMAP: Fix Memory Leaks in Smartreflex driver
Date: Tue, 15 Feb 2011 13:40:30 +0530
Message-ID: <1297757430-3059-1-git-send-email-shweta.gulati@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46795 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393Ab1BOILA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 03:11:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Shweta Gulati <shweta.gulati@ti.com>, linux-arm-kernel@lists.infradead.org

This Patch frees all the dynamically allocated memory
which couldn't have been released in some error hitting cases.

Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/mach-omap2/smartreflex.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index a1f532e..5af8829 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -284,6 +284,7 @@ error:
 		dev_err(&sr_info->pdev->dev, "%s: ERROR in registering"
 			"interrupt handler. Smartreflex will"
 			"not function as desired\n", __func__);
+		kfree(name);
 		kfree(sr_info);
 		return ret;
 }
@@ -881,7 +882,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		ret = sr_late_init(sr_info);
 		if (ret) {
 			pr_warning("%s: Error in SR late init\n", __func__);
-			return ret;
+			goto err_release_region;
 		}
 	}
 
@@ -892,14 +893,17 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	 * not try to create rest of the debugfs entries.
 	 */
 	vdd_dbg_dir = omap_voltage_get_dbgdir(sr_info->voltdm);
-	if (!vdd_dbg_dir)
-		return -EINVAL;
+	if (!vdd_dbg_dir) {
+		ret = -EINVAL;
+		goto err_release_region;
+	}
 
 	dbg_dir = debugfs_create_dir("smartreflex", vdd_dbg_dir);
 	if (IS_ERR(dbg_dir)) {
 		dev_err(&pdev->dev, "%s: Unable to create debugfs directory\n",
 			__func__);
-		return PTR_ERR(dbg_dir);
+		ret = PTR_ERR(dbg_dir);
+		goto err_release_region;
 	}
 
 	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUSR, dbg_dir,
@@ -915,7 +919,8 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	if (IS_ERR(nvalue_dir)) {
 		dev_err(&pdev->dev, "%s: Unable to create debugfs directory"
 			"for n-values\n", __func__);
-		return PTR_ERR(nvalue_dir);
+		ret = PTR_ERR(nvalue_dir);
+		goto err_release_region;
 	}
 
 	omap_voltage_get_volttable(sr_info->voltdm, &volt_data);
@@ -924,7 +929,8 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 			" corresponding vdd vdd_%s. Cannot create debugfs"
 			"entries for n-values\n",
 			__func__, sr_info->voltdm->name);
-		return -ENODATA;
+		ret = -ENODATA;
+		goto err_release_region;
 	}
 
 	for (i = 0; i < sr_info->nvalue_count; i++) {
-- 
1.7.0.4


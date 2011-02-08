From: Shweta Gulati <shweta.gulati@ti.com>
Subject: [PATCH] OMAP: Fix Memory Leaks in Smartreflex driver.
Date: Tue,  8 Feb 2011 17:22:28 +0530
Message-ID: <1297165948-28386-1-git-send-email-shweta.gulati@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36008 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753568Ab1BHLwe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Feb 2011 06:52:34 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p18BqVpO016412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 8 Feb 2011 05:52:33 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Shweta Gulati <shweta.gulati@ti.com>

This Patch frees all the dynamically allocated memory
which couldn't have been released in some error hitting cases.

Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index d7deadf..a904625 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -282,6 +282,7 @@ error:
 		dev_err(&sr_info->pdev->dev, "%s: ERROR in registering"
 			"interrupt handler. Smartreflex will"
 			"not function as desired\n", __func__);
+		kfree(name);
 		kfree(sr_info);
 		return ret;
 }
@@ -880,7 +881,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		ret = sr_late_init(sr_info);
 		if (ret) {
 			pr_warning("%s: Error in SR late init\n", __func__);
-			return ret;
+			goto err_release_region;
 		}
 	}
 
@@ -891,14 +892,17 @@ static int __init omap_sr_probe(struct platform_device *pdev)
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
 
 	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUGO, dbg_dir,
@@ -914,7 +918,8 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	if (IS_ERR(nvalue_dir)) {
 		dev_err(&pdev->dev, "%s: Unable to create debugfs directory"
 			"for n-values\n", __func__);
-		return PTR_ERR(nvalue_dir);
+		ret = PTR_ERR(nvalue_dir);
+		goto err_release_region;
 	}
 
 	omap_voltage_get_volttable(sr_info->voltdm, &volt_data);
@@ -923,7 +928,8 @@ static int __init omap_sr_probe(struct platform_device *pdev)
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


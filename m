From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 4/6] arm: mach-omap2: smartreflex: fix ioremap leak on probe error
Date: Thu, 24 Mar 2011 18:35:33 +0200
Message-ID: <1300984535-10530-4-git-send-email-aaro.koskinen@nokia.com>
References: <1300984535-10530-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:29113 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959Ab1CXQiw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Mar 2011 12:38:52 -0400
In-Reply-To: <1300984535-10530-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>

Add missing iounmap() to error paths.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/smartreflex.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 81bd5ed..e72b419 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -904,7 +904,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	vdd_dbg_dir = omap_voltage_get_dbgdir(sr_info->voltdm);
 	if (!vdd_dbg_dir) {
 		ret = -EINVAL;
-		goto err_release_region;
+		goto err_iounmap;
 	}
 
 	sr_info->dbg_dir = debugfs_create_dir("smartreflex", vdd_dbg_dir);
@@ -912,7 +912,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "%s: Unable to create debugfs directory\n",
 			__func__);
 		ret = PTR_ERR(sr_info->dbg_dir);
-		goto err_release_region;
+		goto err_iounmap;
 	}
 
 	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUSR,
@@ -929,7 +929,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "%s: Unable to create debugfs directory"
 			"for n-values\n", __func__);
 		ret = PTR_ERR(nvalue_dir);
-		goto err_release_region;
+		goto err_iounmap;
 	}
 
 	omap_voltage_get_volttable(sr_info->voltdm, &volt_data);
@@ -939,7 +939,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 			"entries for n-values\n",
 			__func__, sr_info->voltdm->name);
 		ret = -ENODATA;
-		goto err_release_region;
+		goto err_iounmap;
 	}
 
 	for (i = 0; i < sr_info->nvalue_count; i++) {
@@ -953,6 +953,8 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 
 	return ret;
 
+err_iounmap:
+	iounmap(sr_info->base);
 err_release_region:
 	release_mem_region(mem->start, resource_size(mem));
 err_free_devinfo:
-- 
1.5.6.5


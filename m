From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 6/6] arm: mach-omap2: smartreflex: delete debugfs entries on probe error
Date: Thu, 24 Mar 2011 18:35:35 +0200
Message-ID: <1300984535-10530-6-git-send-email-aaro.koskinen@nokia.com>
References: <1300984535-10530-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:29118 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187Ab1CXQiw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Mar 2011 12:38:52 -0400
In-Reply-To: <1300984535-10530-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>

Delete created debugfs entries if probe fails.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/smartreflex.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index c8cd1ef..85d8167 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -929,7 +929,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "%s: Unable to create debugfs directory"
 			"for n-values\n", __func__);
 		ret = PTR_ERR(nvalue_dir);
-		goto err_iounmap;
+		goto err_debugfs;
 	}
 
 	omap_voltage_get_volttable(sr_info->voltdm, &volt_data);
@@ -939,7 +939,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 			"entries for n-values\n",
 			__func__, sr_info->voltdm->name);
 		ret = -ENODATA;
-		goto err_iounmap;
+		goto err_debugfs;
 	}
 
 	for (i = 0; i < sr_info->nvalue_count; i++) {
@@ -953,6 +953,8 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 
 	return ret;
 
+err_debugfs:
+	debugfs_remove_recursive(sr_info->dbg_dir);
 err_iounmap:
 	list_del(&sr_info->node);
 	iounmap(sr_info->base);
-- 
1.5.6.5


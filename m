From: jean.pihet@newoldbits.com
Subject: [PATCH] ARM: OMAP: SmartReflex: fix error path in init function
Date: Fri, 14 Sep 2012 12:14:54 +0200
Message-ID: <1347617694-367-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:65502 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758497Ab2INKPH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Sep 2012 06:15:07 -0400
Received: by wibhi8 with SMTP id hi8so8067436wib.1
        for <linux-omap@vger.kernel.org>; Fri, 14 Sep 2012 03:15:06 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: J Keerthy <j-keerthy@ti.com>, Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Fix the error handling path in omap_sr_probe to correctly
de-allocate resources in case of problems.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 drivers/power/avs/smartreflex.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
index 734493d..a802f4c 100644
--- a/drivers/power/avs/smartreflex.c
+++ b/drivers/power/avs/smartreflex.c
@@ -911,7 +911,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	if (!sr_info->base) {
 		dev_err(&pdev->dev, "%s: ioremap fail\n", __func__);
 		ret = -ENOMEM;
-		goto err_release_region;
+		goto err_free_name;
 	}
 
 	if (irq)
@@ -949,7 +949,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "%s: Unable to create debugfs directory\n",
 			__func__);
 		ret = PTR_ERR(sr_info->dbg_dir);
-		goto err_free_name;
+		goto err_debugfs;
 	}
 
 	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUSR,
@@ -993,11 +993,11 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 
 err_debugfs:
 	debugfs_remove_recursive(sr_info->dbg_dir);
-err_free_name:
-	kfree(sr_info->name);
 err_iounmap:
 	list_del(&sr_info->node);
 	iounmap(sr_info->base);
+err_free_name:
+	kfree(sr_info->name);
 err_release_region:
 	release_mem_region(mem->start, resource_size(mem));
 err_free_devinfo:
-- 
1.7.7.6


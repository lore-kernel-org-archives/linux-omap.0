From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 1/2] ARM: OMAP: SmartReflex: fix error path in init function
Date: Thu, 20 Sep 2012 16:47:32 +0200
Message-ID: <1348152453-30532-2-git-send-email-j-pihet@ti.com>
References: <1348152453-30532-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:59619 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108Ab2ITOrq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Sep 2012 10:47:46 -0400
Received: by wgbdr13 with SMTP id dr13so529895wgb.1
        for <linux-omap@vger.kernel.org>; Thu, 20 Sep 2012 07:47:45 -0700 (PDT)
In-Reply-To: <1348152453-30532-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Anton Vorontsov <cbou@mail.ru>, Kevin Hilman <khilman@ti.com>, J Keerthy <j-keerthy@ti.com>
Cc: Jean Pihet <j-pihet@ti.com>

Fix the error handling path in omap_sr_probe to correctly
de-allocate resources in case of problems.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 drivers/power/avs/smartreflex.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
index 44efc6e..92f6728 100644
--- a/drivers/power/avs/smartreflex.c
+++ b/drivers/power/avs/smartreflex.c
@@ -928,7 +928,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	if (!sr_info->base) {
 		dev_err(&pdev->dev, "%s: ioremap fail\n", __func__);
 		ret = -ENOMEM;
-		goto err_release_region;
+		goto err_free_name;
 	}
 
 	if (irq)
@@ -967,7 +967,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "%s: Unable to create debugfs directory\n",
 			__func__);
 		ret = PTR_ERR(sr_info->dbg_dir);
-		goto err_free_name;
+		goto err_debugfs;
 	}
 
 	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUSR,
@@ -1011,11 +1011,11 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 
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


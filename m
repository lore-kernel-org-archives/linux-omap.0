From: <grygorii.strashko@linaro.org>
Subject: [PATCH] drm/omap: tiler: add hibernation callback
Date: Wed, 25 Feb 2015 20:08:20 +0200
Message-ID: <1424887700-5909-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:36465 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbbBYSIZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2015 13:08:25 -0500
Received: by labgq15 with SMTP id gq15so5755927lab.3
        for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2015 10:08:24 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, David Airlie <airlied@linux.ie>
Cc: nm@ti.com, sumit.semwal@linaro.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, Grygorii Strashko <grygorii.strashko@linaro.org>

From: Grygorii Strashko <grygorii.strashko@linaro.org>

Setting a dev_pm_ops resume callback but not a set of
hibernation handler means that pm function will not be
called upon hibernation.
Fix this by using SIMPLE_DEV_PM_OPS, which appropriately
assigns the suspend and hibernation handlers and move
omap_dmm_resume under CONFIG_PM_SLEEP to avoid build warnings.

Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
---
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
index 56c6055..afb8cfc 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -941,7 +941,7 @@ error:
 }
 #endif
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int omap_dmm_resume(struct device *dev)
 {
 	struct tcm_area area;
@@ -965,12 +965,10 @@ static int omap_dmm_resume(struct device *dev)
 
 	return 0;
 }
-
-static const struct dev_pm_ops omap_dmm_pm_ops = {
-	.resume = omap_dmm_resume,
-};
 #endif
 
+SIMPLE_DEV_PM_OPS(omap_dmm_pm_ops, NULL, omap_dmm_resume);
+
 #if defined(CONFIG_OF)
 static const struct of_device_id dmm_of_match[] = {
 	{ .compatible = "ti,omap4-dmm", },
@@ -986,9 +984,7 @@ struct platform_driver omap_dmm_driver = {
 		.owner = THIS_MODULE,
 		.name = DMM_DRIVER_NAME,
 		.of_match_table = of_match_ptr(dmm_of_match),
-#ifdef CONFIG_PM
 		.pm = &omap_dmm_pm_ops,
-#endif
 	},
 };
 
-- 
1.9.1


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/25] OMAPDSS: use platform_driver_probe for core/dispc/dss
Date: Thu,  3 May 2012 16:57:46 +0300
Message-ID: <1336053481-25433-11-git-send-email-tomi.valkeinen@ti.com>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:53069 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756157Ab2ECN6g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 09:58:36 -0400
Received: by lbom4 with SMTP id m4so1523785lbo.2
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 06:58:33 -0700 (PDT)
In-Reply-To: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

The platform devices for omapdss, dss and dispc drivers are always
present, so we can use platform_driver_probe instead of
platform_driver_register.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c  |    3 +--
 drivers/video/omap2/dss/dispc.c |    3 +--
 drivers/video/omap2/dss/dss.c   |    3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index b37b6f4..db45e6a 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -296,7 +296,6 @@ static int omap_dss_resume(struct platform_device *pdev)
 }
 
 static struct platform_driver omap_dss_driver = {
-	.probe          = omap_dss_probe,
 	.remove         = omap_dss_remove,
 	.shutdown	= omap_dss_shutdown,
 	.suspend	= omap_dss_suspend,
@@ -521,7 +520,7 @@ static int __init omap_dss_register_drivers(void)
 {
 	int r;
 
-	r = platform_driver_register(&omap_dss_driver);
+	r = platform_driver_probe(&omap_dss_driver, omap_dss_probe);
 	if (r)
 		return r;
 
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 2aa1fea..68aa566 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3620,7 +3620,6 @@ static const struct dev_pm_ops dispc_pm_ops = {
 };
 
 static struct platform_driver omap_dispchw_driver = {
-	.probe          = omap_dispchw_probe,
 	.remove         = omap_dispchw_remove,
 	.driver         = {
 		.name   = "omapdss_dispc",
@@ -3631,7 +3630,7 @@ static struct platform_driver omap_dispchw_driver = {
 
 int dispc_init_platform_driver(void)
 {
-	return platform_driver_register(&omap_dispchw_driver);
+	return platform_driver_probe(&omap_dispchw_driver, omap_dispchw_probe);
 }
 
 void dispc_uninit_platform_driver(void)
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 24f5429..2bdc400 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -857,7 +857,6 @@ static const struct dev_pm_ops dss_pm_ops = {
 };
 
 static struct platform_driver omap_dsshw_driver = {
-	.probe          = omap_dsshw_probe,
 	.remove         = omap_dsshw_remove,
 	.driver         = {
 		.name   = "omapdss_dss",
@@ -868,7 +867,7 @@ static struct platform_driver omap_dsshw_driver = {
 
 int dss_init_platform_driver(void)
 {
-	return platform_driver_register(&omap_dsshw_driver);
+	return platform_driver_probe(&omap_dsshw_driver, omap_dsshw_probe);
 }
 
 void dss_uninit_platform_driver(void)
-- 
1.7.9.5


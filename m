From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/21] OMAPDSS: use platform_driver_probe for core/dispc/dss
Date: Wed,  7 Mar 2012 14:44:39 +0200
Message-ID: <1331124290-6285-11-git-send-email-tomi.valkeinen@ti.com>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:58843 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758477Ab2CGMpc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 07:45:32 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id j13so9186444lah.5
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 04:45:31 -0800 (PST)
In-Reply-To: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
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
index 3efd473..80fbfd7 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -341,7 +341,6 @@ static int omap_dss_resume(struct platform_device *pdev)
 }
 
 static struct platform_driver omap_dss_driver = {
-	.probe          = omap_dss_probe,
 	.remove         = omap_dss_remove,
 	.shutdown	= omap_dss_shutdown,
 	.suspend	= omap_dss_suspend,
@@ -576,7 +575,7 @@ static int __init omap_dss_init(void)
 	if (r)
 		return r;
 
-	r = platform_driver_register(&omap_dss_driver);
+	r = platform_driver_probe(&omap_dss_driver, omap_dss_probe);
 	if (r) {
 		omap_dss_bus_unregister();
 		return r;
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 5985c3c..c71d4c5 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3431,7 +3431,6 @@ static const struct dev_pm_ops dispc_pm_ops = {
 };
 
 static struct platform_driver omap_dispchw_driver = {
-	.probe          = omap_dispchw_probe,
 	.remove         = omap_dispchw_remove,
 	.driver         = {
 		.name   = "omapdss_dispc",
@@ -3442,7 +3441,7 @@ static struct platform_driver omap_dispchw_driver = {
 
 int dispc_init_platform_driver(void)
 {
-	return platform_driver_register(&omap_dispchw_driver);
+	return platform_driver_probe(&omap_dispchw_driver, omap_dispchw_probe);
 }
 
 void dispc_uninit_platform_driver(void)
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 7d3facc..34cc84f 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -841,7 +841,6 @@ static const struct dev_pm_ops dss_pm_ops = {
 };
 
 static struct platform_driver omap_dsshw_driver = {
-	.probe          = omap_dsshw_probe,
 	.remove         = omap_dsshw_remove,
 	.driver         = {
 		.name   = "omapdss_dss",
@@ -852,7 +851,7 @@ static struct platform_driver omap_dsshw_driver = {
 
 int dss_init_platform_driver(void)
 {
-	return platform_driver_register(&omap_dsshw_driver);
+	return platform_driver_probe(&omap_dsshw_driver, omap_dsshw_probe);
 }
 
 void dss_uninit_platform_driver(void)
-- 
1.7.4.1


From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH 05/20] Move dss platform driver to dss.c
Date: Mon, 23 Aug 2010 21:27:54 +0530
Message-ID: <1282579089-10487-6-git-send-email-svadivu@ti.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
 <1282579089-10487-2-git-send-email-svadivu@ti.com>
 <1282579089-10487-3-git-send-email-svadivu@ti.com>
 <1282579089-10487-4-git-send-email-svadivu@ti.com>
 <1282579089-10487-5-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35123 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754243Ab0HWP6Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Aug 2010 11:58:25 -0400
In-Reply-To: <1282579089-10487-5-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

dsshw_probe and remove functions are moved to dss.c
To maintain the order of init, through the dsshw_probe, omap_dss_init2
is made as device_init_call_sync.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/dss/core.c |   26 +-------------------------
 drivers/video/omap2/dss/dss.c  |   29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 3b6a309..f01e8e6 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -707,17 +707,6 @@ static int omap_dss_resume(struct platform_device *pdev)
 	return dss_resume_all_devices();
 }
 
-/* DSS HW IP initialisation */
-static int omap_dsshw_probe(struct platform_device *pdev)
-{
-	return 0;
-}
-
-static int omap_dsshw_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
 /* DISPC HW IP initialisation */
 static int omap_dispchw_probe(struct platform_device *pdev)
 {
@@ -775,18 +764,6 @@ static struct platform_driver omap_dss_driver = {
 	},
 };
 
-static struct platform_driver omap_dsshw_driver = {
-	.probe          = omap_dsshw_probe,
-	.remove         = omap_dsshw_remove,
-	.shutdown	= NULL,
-	.suspend	= NULL,
-	.resume		= NULL,
-	.driver         = {
-		.name   = "dss",
-		.owner  = THIS_MODULE,
-	},
-};
-
 static struct platform_driver omap_dispchw_driver = {
 	.probe          = omap_dispchw_probe,
 	.remove         = omap_dispchw_remove,
@@ -1100,7 +1077,6 @@ static int __init omap_dss_init(void)
 
 static int __init omap_dss_init2(void)
 {
-	platform_driver_register(&omap_dsshw_driver);
 	platform_driver_register(&omap_dispchw_driver);
 	platform_driver_register(&omap_dsi1hw_driver);
 	platform_driver_register(&omap_rfbihw_driver);
@@ -1109,7 +1085,7 @@ static int __init omap_dss_init2(void)
 }
 
 core_initcall(omap_dss_init);
-device_initcall(omap_dss_init2);
+device_initcall_sync(omap_dss_init2);
 #endif
 
 MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@nokia.com>");
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 24b1825..5f91e37 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -122,6 +122,29 @@ void dss_restore_context(void)
 #undef SR
 #undef RR
 
+/* DSS HW IP initialisation */
+static int omap_dsshw_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int omap_dsshw_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver omap_dsshw_driver = {
+	.probe          = omap_dsshw_probe,
+	.remove         = omap_dsshw_remove,
+	.shutdown	= NULL,
+	.suspend	= NULL,
+	.resume		= NULL,
+	.driver         = {
+		.name   = "dss",
+		.owner  = THIS_MODULE,
+	},
+};
+
 void dss_sdi_init(u8 datapairs)
 {
 	u32 l;
@@ -633,3 +656,9 @@ void dss_exit(void)
 	iounmap(dss.base);
 }
 
+static int __init omap_dss_init1(void)
+{
+	return platform_driver_register(&omap_dsshw_driver);
+}
+
+device_initcall(omap_dss_init1);
-- 
1.6.3.3


From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH 04/20] Create platform_driver for each DSS HW IP
Date: Mon, 23 Aug 2010 21:27:53 +0530
Message-ID: <1282579089-10487-5-git-send-email-svadivu@ti.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
 <1282579089-10487-2-git-send-email-svadivu@ti.com>
 <1282579089-10487-3-git-send-email-svadivu@ti.com>
 <1282579089-10487-4-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37913 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204Ab0HWP6W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Aug 2010 11:58:22 -0400
In-Reply-To: <1282579089-10487-4-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Platform driver of DSS HW IP are to be registered in sequence before
the omapdss platform driver is registered.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/dss/core.c |  121 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 121 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index bcbb077..3b6a309 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -707,6 +707,62 @@ static int omap_dss_resume(struct platform_device *pdev)
 	return dss_resume_all_devices();
 }
 
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
+/* DISPC HW IP initialisation */
+static int omap_dispchw_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int omap_dispchw_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+/* DSI1 HW IP initialisation */
+static int omap_dsi1hw_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int omap_dsi1hw_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+/* RFBI HW IP initialisation */
+static int omap_rfbihw_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int omap_rfbihw_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+/* VENC HW IP initialisation */
+static int omap_venchw_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int omap_venchw_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+
 static struct platform_driver omap_dss_driver = {
 	.probe          = omap_dss_probe,
 	.remove         = omap_dss_remove,
@@ -719,6 +775,66 @@ static struct platform_driver omap_dss_driver = {
 	},
 };
 
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
+static struct platform_driver omap_dispchw_driver = {
+	.probe          = omap_dispchw_probe,
+	.remove         = omap_dispchw_remove,
+	.shutdown	= NULL,
+	.suspend	= NULL,
+	.resume		= NULL,
+	.driver         = {
+		.name   = "dss_dispc",
+		.owner  = THIS_MODULE,
+	},
+};
+
+static struct platform_driver omap_dsi1hw_driver = {
+	.probe          = omap_dsi1hw_probe,
+	.remove         = omap_dsi1hw_remove,
+	.shutdown	= NULL,
+	.suspend	= NULL,
+	.resume		= NULL,
+	.driver         = {
+		.name   = "dss_dsi1",
+		.owner  = THIS_MODULE,
+	},
+};
+
+static struct platform_driver omap_rfbihw_driver = {
+	.probe          = omap_rfbihw_probe,
+	.remove         = omap_rfbihw_remove,
+	.shutdown	= NULL,
+	.suspend	= NULL,
+	.resume		= NULL,
+	.driver         = {
+		.name   = "dss_rfbi",
+		.owner  = THIS_MODULE,
+	},
+};
+
+static struct platform_driver omap_venchw_driver = {
+	.probe          = omap_venchw_probe,
+	.remove         = omap_venchw_remove,
+	.shutdown	= NULL,
+	.suspend	= NULL,
+	.resume		= NULL,
+	.driver         = {
+		.name   = "dss_venc",
+		.owner  = THIS_MODULE,
+	},
+};
+
 /* BUS */
 static int dss_bus_match(struct device *dev, struct device_driver *driver)
 {
@@ -984,6 +1100,11 @@ static int __init omap_dss_init(void)
 
 static int __init omap_dss_init2(void)
 {
+	platform_driver_register(&omap_dsshw_driver);
+	platform_driver_register(&omap_dispchw_driver);
+	platform_driver_register(&omap_dsi1hw_driver);
+	platform_driver_register(&omap_rfbihw_driver);
+	platform_driver_register(&omap_venchw_driver);
 	return platform_driver_register(&omap_dss_driver);
 }
 
-- 
1.6.3.3


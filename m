From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 11/21] OMAPDSS: register dss drivers in module init
Date: Wed,  7 Mar 2012 14:44:40 +0200
Message-ID: <1331124290-6285-12-git-send-email-tomi.valkeinen@ti.com>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:36674 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758490Ab2CGMpe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 07:45:34 -0500
Received: by mail-lpp01m010-f48.google.com with SMTP id u2so9594479lag.35
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 04:45:32 -0800 (PST)
In-Reply-To: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

We do the dss driver registration in a rather strange way: we have the
higher level omapdss driver, and we use that driver's probe function to
register the drivers for the rest of the dss devices.

There doesn't seem to be any reason for that, so this patch changes the
registration for all drivers to happen in the module init.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c |  135 +++++++++++++++++++++++-----------------
 1 files changed, 77 insertions(+), 58 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 80fbfd7..95d312c 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -218,42 +218,6 @@ static int omap_dss_probe(struct platform_device *pdev)
 	dss_init_overlay_managers(pdev);
 	dss_init_overlays(pdev);
 
-	r = dss_init_platform_driver();
-	if (r) {
-		DSSERR("Failed to initialize DSS platform driver\n");
-		goto err_dss;
-	}
-
-	r = dispc_init_platform_driver();
-	if (r) {
-		DSSERR("Failed to initialize dispc platform driver\n");
-		goto err_dispc;
-	}
-
-	r = rfbi_init_platform_driver();
-	if (r) {
-		DSSERR("Failed to initialize rfbi platform driver\n");
-		goto err_rfbi;
-	}
-
-	r = venc_init_platform_driver();
-	if (r) {
-		DSSERR("Failed to initialize venc platform driver\n");
-		goto err_venc;
-	}
-
-	r = dsi_init_platform_driver();
-	if (r) {
-		DSSERR("Failed to initialize DSI platform driver\n");
-		goto err_dsi;
-	}
-
-	r = hdmi_init_platform_driver();
-	if (r) {
-		DSSERR("Failed to initialize hdmi\n");
-		goto err_hdmi;
-	}
-
 	r = dss_initialize_debugfs();
 	if (r)
 		goto err_debugfs;
@@ -281,18 +245,6 @@ static int omap_dss_probe(struct platform_device *pdev)
 err_register:
 	dss_uninitialize_debugfs();
 err_debugfs:
-	hdmi_uninit_platform_driver();
-err_hdmi:
-	dsi_uninit_platform_driver();
-err_dsi:
-	venc_uninit_platform_driver();
-err_venc:
-	dispc_uninit_platform_driver();
-err_dispc:
-	rfbi_uninit_platform_driver();
-err_rfbi:
-	dss_uninit_platform_driver();
-err_dss:
 
 	return r;
 }
@@ -304,13 +256,6 @@ static int omap_dss_remove(struct platform_device *pdev)
 
 	dss_uninitialize_debugfs();
 
-	hdmi_uninit_platform_driver();
-	dsi_uninit_platform_driver();
-	venc_uninit_platform_driver();
-	rfbi_uninit_platform_driver();
-	dispc_uninit_platform_driver();
-	dss_uninit_platform_driver();
-
 	dss_uninit_overlays(pdev);
 	dss_uninit_overlay_managers(pdev);
 
@@ -559,6 +504,80 @@ static int omap_dss_bus_register(void)
 
 /* INIT */
 
+static int __init omap_dss_register_drivers(void)
+{
+	int r;
+
+	r = platform_driver_probe(&omap_dss_driver, omap_dss_probe);
+	if (r)
+		return r;
+
+	r = dss_init_platform_driver();
+	if (r) {
+		DSSERR("Failed to initialize DSS platform driver\n");
+		goto err_dss;
+	}
+
+	r = dispc_init_platform_driver();
+	if (r) {
+		DSSERR("Failed to initialize dispc platform driver\n");
+		goto err_dispc;
+	}
+
+	r = rfbi_init_platform_driver();
+	if (r) {
+		DSSERR("Failed to initialize rfbi platform driver\n");
+		goto err_rfbi;
+	}
+
+	r = venc_init_platform_driver();
+	if (r) {
+		DSSERR("Failed to initialize venc platform driver\n");
+		goto err_venc;
+	}
+
+	r = dsi_init_platform_driver();
+	if (r) {
+		DSSERR("Failed to initialize DSI platform driver\n");
+		goto err_dsi;
+	}
+
+	r = hdmi_init_platform_driver();
+	if (r) {
+		DSSERR("Failed to initialize hdmi\n");
+		goto err_hdmi;
+	}
+
+	return 0;
+
+err_hdmi:
+	dsi_uninit_platform_driver();
+err_dsi:
+	venc_uninit_platform_driver();
+err_venc:
+	rfbi_uninit_platform_driver();
+err_rfbi:
+	dispc_uninit_platform_driver();
+err_dispc:
+	dss_uninit_platform_driver();
+err_dss:
+	platform_driver_unregister(&omap_dss_driver);
+
+	return r;
+}
+
+static void __exit omap_dss_unregister_drivers(void)
+{
+	hdmi_uninit_platform_driver();
+	dsi_uninit_platform_driver();
+	venc_uninit_platform_driver();
+	rfbi_uninit_platform_driver();
+	dispc_uninit_platform_driver();
+	dss_uninit_platform_driver();
+
+	platform_driver_unregister(&omap_dss_driver);
+}
+
 #ifdef CONFIG_OMAP2_DSS_MODULE
 static void omap_dss_bus_unregister(void)
 {
@@ -575,7 +594,7 @@ static int __init omap_dss_init(void)
 	if (r)
 		return r;
 
-	r = platform_driver_probe(&omap_dss_driver, omap_dss_probe);
+	r = omap_dss_register_drivers();
 	if (r) {
 		omap_dss_bus_unregister();
 		return r;
@@ -596,7 +615,7 @@ static void __exit omap_dss_exit(void)
 		core.vdds_sdi_reg = NULL;
 	}
 
-	platform_driver_unregister(&omap_dss_driver);
+	omap_dss_unregister_drivers();
 
 	omap_dss_bus_unregister();
 }
@@ -611,7 +630,7 @@ static int __init omap_dss_init(void)
 
 static int __init omap_dss_init2(void)
 {
-	return platform_driver_register(&omap_dss_driver);
+	return omap_dss_register_drivers();
 }
 
 core_initcall(omap_dss_init);
-- 
1.7.4.1


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 7/7] OMAPDSS: simplify submodule reg/unreg code
Date: Tue, 16 Jun 2015 13:16:29 +0300
Message-ID: <1434449789-13812-8-git-send-email-tomi.valkeinen@ti.com>
References: <1434449789-13812-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34965 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932881AbbFPKRK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Jun 2015 06:17:10 -0400
In-Reply-To: <1434449789-13812-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that we are using components in omapdss, there's no need for
separate handling of dss and dispc driver init. Thus we can move the dss
and dispc init and unit func pointers to the lists we use for the other
dss submodules.

We can now also handle errors returned by the registration functions
properly: if registering a driver fails, we can stop processing and
return the error.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/core.c | 46 ++++++++++++------------------------
 1 file changed, 15 insertions(+), 31 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/core.c b/drivers/video/fbdev/omap2/dss/core.c
index 5c64515de818..54eeb507f9b3 100644
--- a/drivers/video/fbdev/omap2/dss/core.c
+++ b/drivers/video/fbdev/omap2/dss/core.c
@@ -245,6 +245,8 @@ static struct platform_driver omap_dss_driver = {
 
 /* INIT */
 static int (*dss_output_drv_reg_funcs[])(void) __initdata = {
+	dss_init_platform_driver,
+	dispc_init_platform_driver,
 #ifdef CONFIG_OMAP2_DSS_DSI
 	dsi_init_platform_driver,
 #endif
@@ -268,7 +270,7 @@ static int (*dss_output_drv_reg_funcs[])(void) __initdata = {
 #endif
 };
 
-static void (*dss_output_drv_unreg_funcs[])(void) __exitdata = {
+static void (*dss_output_drv_unreg_funcs[])(void) = {
 #ifdef CONFIG_OMAP5_DSS_HDMI
 	hdmi5_uninit_platform_driver,
 #endif
@@ -290,10 +292,10 @@ static void (*dss_output_drv_unreg_funcs[])(void) __exitdata = {
 #ifdef CONFIG_OMAP2_DSS_DSI
 	dsi_uninit_platform_driver,
 #endif
+	dispc_uninit_platform_driver,
+	dss_uninit_platform_driver,
 };
 
-static bool dss_output_drv_loaded[ARRAY_SIZE(dss_output_drv_reg_funcs)];
-
 static int __init omap_dss_init(void)
 {
 	int r;
@@ -303,33 +305,20 @@ static int __init omap_dss_init(void)
 	if (r)
 		return r;
 
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
-	/*
-	 * It's ok if the output-driver register fails. It happens, for example,
-	 * when there is no output-device (e.g. SDI for OMAP4).
-	 */
 	for (i = 0; i < ARRAY_SIZE(dss_output_drv_reg_funcs); ++i) {
 		r = dss_output_drv_reg_funcs[i]();
-		if (r == 0)
-			dss_output_drv_loaded[i] = true;
+		if (r)
+			goto err_reg;
 	}
 
 	return 0;
 
-err_dispc:
-	dss_uninit_platform_driver();
-err_dss:
+err_reg:
+	for (i = ARRAY_SIZE(dss_output_drv_reg_funcs) - i;
+			i < ARRAY_SIZE(dss_output_drv_reg_funcs);
+			++i)
+		dss_output_drv_unreg_funcs[i]();
+
 	platform_driver_unregister(&omap_dss_driver);
 
 	return r;
@@ -339,13 +328,8 @@ static void __exit omap_dss_exit(void)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(dss_output_drv_unreg_funcs); ++i) {
-		if (dss_output_drv_loaded[i])
-			dss_output_drv_unreg_funcs[i]();
-	}
-
-	dispc_uninit_platform_driver();
-	dss_uninit_platform_driver();
+	for (i = 0; i < ARRAY_SIZE(dss_output_drv_unreg_funcs); ++i)
+		dss_output_drv_unreg_funcs[i]();
 
 	platform_driver_unregister(&omap_dss_driver);
 }
-- 
2.1.4


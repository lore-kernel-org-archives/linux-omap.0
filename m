From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/12] OMAPDSS: fix DPI & DSI init order
Date: Tue, 30 Oct 2012 18:10:00 +0200
Message-ID: <1351613409-21186-4-git-send-email-tomi.valkeinen@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56383 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933907Ab2J3QKY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Oct 2012 12:10:24 -0400
In-Reply-To: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: rob@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

DPI may use DSI PLL, so it depends on DSI. However, currently DPI driver
is added first, which causes DPI initialization to fail when it tries to
get the DSI PLL.

This patch changes the init order to fix this.

A better solution would be to separate DSI PLL and DSI drivers. They
have dependencies, though, but we could still have DSI PLL as an
independent entity that we could initialize before any of the output
drivers.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 00aa026..d25374c 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -502,6 +502,9 @@ static int __init omap_dss_bus_register(void)
 
 /* INIT */
 static int (*dss_output_drv_reg_funcs[])(void) __initdata = {
+#ifdef CONFIG_OMAP2_DSS_DSI
+	dsi_init_platform_driver,
+#endif
 #ifdef CONFIG_OMAP2_DSS_DPI
 	dpi_init_platform_driver,
 #endif
@@ -514,15 +517,15 @@ static int (*dss_output_drv_reg_funcs[])(void) __initdata = {
 #ifdef CONFIG_OMAP2_DSS_VENC
 	venc_init_platform_driver,
 #endif
-#ifdef CONFIG_OMAP2_DSS_DSI
-	dsi_init_platform_driver,
-#endif
 #ifdef CONFIG_OMAP4_DSS_HDMI
 	hdmi_init_platform_driver,
 #endif
 };
 
 static void (*dss_output_drv_unreg_funcs[])(void) __exitdata = {
+#ifdef CONFIG_OMAP2_DSS_DSI
+	dsi_uninit_platform_driver,
+#endif
 #ifdef CONFIG_OMAP2_DSS_DPI
 	dpi_uninit_platform_driver,
 #endif
@@ -535,9 +538,6 @@ static void (*dss_output_drv_unreg_funcs[])(void) __exitdata = {
 #ifdef CONFIG_OMAP2_DSS_VENC
 	venc_uninit_platform_driver,
 #endif
-#ifdef CONFIG_OMAP2_DSS_DSI
-	dsi_uninit_platform_driver,
-#endif
 #ifdef CONFIG_OMAP4_DSS_HDMI
 	hdmi_uninit_platform_driver,
 #endif
-- 
1.7.10.4


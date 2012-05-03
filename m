From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 15/25] OMAPDSS: handle output-driver reg/unreg more dynamically
Date: Thu,  3 May 2012 16:57:51 +0300
Message-ID: <1336053481-25433-16-git-send-email-tomi.valkeinen@ti.com>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:39048 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756223Ab2ECN6o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 09:58:44 -0400
Received: by lbbgo11 with SMTP id go11so1946695lbb.17
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 06:58:41 -0700 (PDT)
In-Reply-To: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Initialize and uninitialize the output drivers by using arrays of
pointers to the init/uninit functions. This simplifies the code
slightly.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c |  111 +++++++++++++++++++++-------------------
 drivers/video/omap2/dss/dss.h  |   41 ---------------
 2 files changed, 59 insertions(+), 93 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 77fbd99..2a0cbae 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -515,10 +515,54 @@ static int omap_dss_bus_register(void)
 }
 
 /* INIT */
+static int (*dss_output_drv_reg_funcs[])(void) __initdata = {
+#ifdef CONFIG_OMAP2_DSS_DPI
+	dpi_init_platform_driver,
+#endif
+#ifdef CONFIG_OMAP2_DSS_SDI
+	sdi_init_platform_driver,
+#endif
+#ifdef CONFIG_OMAP2_DSS_RFBI
+	rfbi_init_platform_driver,
+#endif
+#ifdef CONFIG_OMAP2_DSS_VENC
+	venc_init_platform_driver,
+#endif
+#ifdef CONFIG_OMAP2_DSS_DSI
+	dsi_init_platform_driver,
+#endif
+#ifdef CONFIG_OMAP4_DSS_HDMI
+	hdmi_init_platform_driver,
+#endif
+};
+
+static void (*dss_output_drv_unreg_funcs[])(void) __exitdata = {
+#ifdef CONFIG_OMAP2_DSS_DPI
+	dpi_uninit_platform_driver,
+#endif
+#ifdef CONFIG_OMAP2_DSS_SDI
+	sdi_uninit_platform_driver,
+#endif
+#ifdef CONFIG_OMAP2_DSS_RFBI
+	rfbi_uninit_platform_driver,
+#endif
+#ifdef CONFIG_OMAP2_DSS_VENC
+	venc_uninit_platform_driver,
+#endif
+#ifdef CONFIG_OMAP2_DSS_DSI
+	dsi_uninit_platform_driver,
+#endif
+#ifdef CONFIG_OMAP4_DSS_HDMI
+	hdmi_uninit_platform_driver,
+#endif
+};
+
+static bool dss_output_drv_loaded[ARRAY_SIZE(dss_output_drv_reg_funcs)];
 
 static int __init omap_dss_register_drivers(void)
 {
 	int r;
+	int i;
 
 	r = platform_driver_probe(&omap_dss_driver, omap_dss_probe);
 	if (r)
@@ -536,56 +580,18 @@ static int __init omap_dss_register_drivers(void)
 		goto err_dispc;
 	}
 
-	r = dpi_init_platform_driver();
-	if (r) {
-		DSSERR("Failed to initialize dpi platform driver\n");
-		goto err_dpi;
-	}
-
-	r = sdi_init_platform_driver();
-	if (r) {
-		DSSERR("Failed to initialize sdi platform driver\n");
-		goto err_sdi;
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
+	/*
+	 * It's ok if the output-driver register fails. It happens, for example,
+	 * when there is no output-device (e.g. SDI for OMAP4).
+	 */
+	for (i = 0; i < ARRAY_SIZE(dss_output_drv_reg_funcs); ++i) {
+		r = dss_output_drv_reg_funcs[i]();
+		if (r == 0)
+			dss_output_drv_loaded[i] = true;
 	}
 
 	return 0;
 
-err_hdmi:
-	dsi_uninit_platform_driver();
-err_dsi:
-	venc_uninit_platform_driver();
-err_venc:
-	rfbi_uninit_platform_driver();
-err_rfbi:
-	sdi_uninit_platform_driver();
-err_sdi:
-	dpi_uninit_platform_driver();
-err_dpi:
-	dispc_uninit_platform_driver();
 err_dispc:
 	dss_uninit_platform_driver();
 err_dss:
@@ -596,12 +602,13 @@ err_dss:
 
 static void __exit omap_dss_unregister_drivers(void)
 {
-	hdmi_uninit_platform_driver();
-	dsi_uninit_platform_driver();
-	venc_uninit_platform_driver();
-	rfbi_uninit_platform_driver();
-	sdi_uninit_platform_driver();
-	dpi_uninit_platform_driver();
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dss_output_drv_unreg_funcs); ++i) {
+		if (dss_output_drv_loaded[i])
+			dss_output_drv_unreg_funcs[i]();
+	}
+
 	dispc_uninit_platform_driver();
 	dss_uninit_platform_driver();
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index b53b2e6..57853fd 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -263,14 +263,9 @@ int dss_calc_clock_div(bool is_tft, unsigned long req_pck,
 		struct dispc_clock_info *dispc_cinfo);
 
 /* SDI */
-#ifdef CONFIG_OMAP2_DSS_SDI
 int sdi_init_platform_driver(void);
 void sdi_uninit_platform_driver(void);
 int sdi_init_display(struct omap_dss_device *display);
-#else
-static inline int sdi_init_platform_driver(void) { return 0; }
-static inline void sdi_uninit_platform_driver(void) { }
-#endif
 
 /* DSI */
 #ifdef CONFIG_OMAP2_DSS_DSI
@@ -307,13 +302,6 @@ void dsi_wait_pll_hsdiv_dispc_active(struct platform_device *dsidev);
 void dsi_wait_pll_hsdiv_dsi_active(struct platform_device *dsidev);
 struct platform_device *dsi_get_dsidev_from_id(int module);
 #else
-static inline int dsi_init_platform_driver(void)
-{
-	return 0;
-}
-static inline void dsi_uninit_platform_driver(void)
-{
-}
 static inline int dsi_runtime_get(struct platform_device *dsidev)
 {
 	return 0;
@@ -370,14 +358,9 @@ static inline struct platform_device *dsi_get_dsidev_from_id(int module)
 #endif
 
 /* DPI */
-#ifdef CONFIG_OMAP2_DSS_DPI
 int dpi_init_platform_driver(void);
 void dpi_uninit_platform_driver(void);
 int dpi_init_display(struct omap_dss_device *dssdev);
-#else
-static inline int dpi_init_platform_driver(void) { return 0; }
-static inline void dpi_uninit_platform_driver(void) { }
-#endif
 
 /* DISPC */
 int dispc_init_platform_driver(void);
@@ -454,13 +437,6 @@ void venc_dump_regs(struct seq_file *s);
 int venc_init_display(struct omap_dss_device *display);
 unsigned long venc_get_pixel_clock(void);
 #else
-static inline int venc_init_platform_driver(void)
-{
-	return 0;
-}
-static inline void venc_uninit_platform_driver(void)
-{
-}
 static inline unsigned long venc_get_pixel_clock(void)
 {
 	WARN("%s: VENC not compiled in, returning pclk as 0\n", __func__);
@@ -480,13 +456,6 @@ static inline int hdmi_init_display(struct omap_dss_device *dssdev)
 {
 	return 0;
 }
-static inline int hdmi_init_platform_driver(void)
-{
-	return 0;
-}
-static inline void hdmi_uninit_platform_driver(void)
-{
-}
 static inline unsigned long hdmi_get_pixel_clock(void)
 {
 	WARN("%s: HDMI not compiled in, returning pclk as 0\n", __func__);
@@ -504,20 +473,10 @@ int hdmi_panel_init(void);
 void hdmi_panel_exit(void);
 
 /* RFBI */
-#ifdef CONFIG_OMAP2_DSS_RFBI
 int rfbi_init_platform_driver(void);
 void rfbi_uninit_platform_driver(void);
 void rfbi_dump_regs(struct seq_file *s);
 int rfbi_init_display(struct omap_dss_device *display);
-#else
-static inline int rfbi_init_platform_driver(void)
-{
-	return 0;
-}
-static inline void rfbi_uninit_platform_driver(void)
-{
-}
-#endif
 
 
 #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
-- 
1.7.9.5


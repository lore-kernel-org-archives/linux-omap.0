From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v2 1/2] OMAP: DSS2: omap_dss_probe() conditional compilation cleanup
Date: Fri,  7 May 2010 12:58:41 +0300
Message-ID: <a17cc11c19f780bd656ce29b64e60d878e1c6fea.1273222740.git.ext-jani.1.nikula@nokia.com>
References: <1273219659.1978.144.camel@tubuntu.research.nokia.com>
 <cover.1273222740.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:51455 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab0EGJ7S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 05:59:18 -0400
In-Reply-To: <cover.1273222740.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1273222740.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273222740.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com, khilman@deeprootsystems.com
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Move a number of #ifdefs from code into dss.h and elsewhere, and
conditionally define no-op static inline functions, cleaning up the
code. This style is according to Documentation/SubmittingPatches.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/dss/core.c |   35 ++++++++-------------------
 drivers/video/omap2/dss/dss.h  |   50 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 24 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 6d54467..92ee067 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -482,6 +482,14 @@ static void dss_uninitialize_debugfs(void)
 	if (dss_debugfs_dir)
 		debugfs_remove_recursive(dss_debugfs_dir);
 }
+#else /* CONFIG_DEBUG_FS && CONFIG_OMAP2_DSS_DEBUG_SUPPORT */
+static inline int dss_initialize_debugfs(void)
+{
+	return 0;
+}
+static inline void dss_uninitialize_debugfs(void)
+{
+}
 #endif /* CONFIG_DEBUG_FS && CONFIG_OMAP2_DSS_DEBUG_SUPPORT */
 
 /* PLATFORM DEVICE */
@@ -518,56 +526,47 @@ static int omap_dss_probe(struct platform_device *pdev)
 		goto fail0;
 	}
 
-#ifdef CONFIG_OMAP2_DSS_RFBI
 	r = rfbi_init();
 	if (r) {
 		DSSERR("Failed to initialize rfbi\n");
 		goto fail0;
 	}
-#endif
 
-#ifdef CONFIG_OMAP2_DSS_DPI
 	r = dpi_init(pdev);
 	if (r) {
 		DSSERR("Failed to initialize dpi\n");
 		goto fail0;
 	}
-#endif
 
 	r = dispc_init();
 	if (r) {
 		DSSERR("Failed to initialize dispc\n");
 		goto fail0;
 	}
-#ifdef CONFIG_OMAP2_DSS_VENC
+
 	r = venc_init(pdev);
 	if (r) {
 		DSSERR("Failed to initialize venc\n");
 		goto fail0;
 	}
-#endif
+
 	if (cpu_is_omap34xx()) {
-#ifdef CONFIG_OMAP2_DSS_SDI
 		r = sdi_init(skip_init);
 		if (r) {
 			DSSERR("Failed to initialize SDI\n");
 			goto fail0;
 		}
-#endif
-#ifdef CONFIG_OMAP2_DSS_DSI
+
 		r = dsi_init(pdev);
 		if (r) {
 			DSSERR("Failed to initialize DSI\n");
 			goto fail0;
 		}
-#endif
 	}
 
-#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
 	r = dss_initialize_debugfs();
 	if (r)
 		goto fail0;
-#endif
 
 	for (i = 0; i < pdata->num_devices; ++i) {
 		struct omap_dss_device *dssdev = pdata->devices[i];
@@ -595,27 +594,15 @@ static int omap_dss_remove(struct platform_device *pdev)
 	int i;
 	int c;
 
-#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
 	dss_uninitialize_debugfs();
-#endif
 
-#ifdef CONFIG_OMAP2_DSS_VENC
 	venc_exit();
-#endif
 	dispc_exit();
-#ifdef CONFIG_OMAP2_DSS_DPI
 	dpi_exit();
-#endif
-#ifdef CONFIG_OMAP2_DSS_RFBI
 	rfbi_exit();
-#endif
 	if (cpu_is_omap34xx()) {
-#ifdef CONFIG_OMAP2_DSS_DSI
 		dsi_exit();
-#endif
-#ifdef CONFIG_OMAP2_DSS_SDI
 		sdi_exit();
-#endif
 	}
 
 	dss_exit();
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 24326a5..786f433 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -242,11 +242,22 @@ int dss_calc_clock_div(bool is_tft, unsigned long req_pck,
 		struct dispc_clock_info *dispc_cinfo);
 
 /* SDI */
+#ifdef CONFIG_OMAP2_DSS_SDI
 int sdi_init(bool skip_init);
 void sdi_exit(void);
 int sdi_init_display(struct omap_dss_device *display);
+#else
+static inline int sdi_init(bool skip_init)
+{
+	return 0;
+}
+static inline void sdi_exit(void)
+{
+}
+#endif
 
 /* DSI */
+#ifdef CONFIG_OMAP2_DSS_DSI
 int dsi_init(struct platform_device *pdev);
 void dsi_exit(void);
 
@@ -270,11 +281,30 @@ void dsi_pll_uninit(void);
 void dsi_get_overlay_fifo_thresholds(enum omap_plane plane,
 		u32 fifo_size, enum omap_burst_size *burst_size,
 		u32 *fifo_low, u32 *fifo_high);
+#else
+static inline int dsi_init(struct platform_device *pdev)
+{
+	return 0;
+}
+static inline void dsi_exit(void)
+{
+}
+#endif
 
 /* DPI */
+#ifdef CONFIG_OMAP2_DSS_DPI
 int dpi_init(struct platform_device *pdev);
 void dpi_exit(void);
 int dpi_init_display(struct omap_dss_device *dssdev);
+#else
+static inline int dpi_init(struct platform_device *pdev)
+{
+	return 0;
+}
+static inline void dpi_exit(void)
+{
+}
+#endif
 
 /* DISPC */
 int dispc_init(void);
@@ -362,12 +392,23 @@ int dispc_get_clock_div(struct dispc_clock_info *cinfo);
 
 
 /* VENC */
+#ifdef CONFIG_OMAP2_DSS_VENC
 int venc_init(struct platform_device *pdev);
 void venc_exit(void);
 void venc_dump_regs(struct seq_file *s);
 int venc_init_display(struct omap_dss_device *display);
+#else
+static inline int venc_init(struct platform_device *pdev)
+{
+	return 0;
+}
+static inline void venc_exit(void)
+{
+}
+#endif
 
 /* RFBI */
+#ifdef CONFIG_OMAP2_DSS_RFBI
 int rfbi_init(void);
 void rfbi_exit(void);
 void rfbi_dump_regs(struct seq_file *s);
@@ -379,6 +420,15 @@ void rfbi_transfer_area(u16 width, u16 height,
 void rfbi_set_timings(int rfbi_module, struct rfbi_timings *t);
 unsigned long rfbi_get_max_tx_rate(void);
 int rfbi_init_display(struct omap_dss_device *display);
+#else
+static inline int rfbi_init(void)
+{
+	return 0;
+}
+static inline void rfbi_exit(void)
+{
+}
+#endif
 
 
 #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
-- 
1.6.5.2


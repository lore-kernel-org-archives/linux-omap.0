From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 16/25] OMAPDSS: move the creation of debugfs files
Date: Thu,  3 May 2012 16:57:52 +0300
Message-ID: <1336053481-25433-17-git-send-email-tomi.valkeinen@ti.com>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:59041 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756185Ab2ECN6q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 09:58:46 -0400
Received: by lahj13 with SMTP id j13so1255188lah.19
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 06:58:43 -0700 (PDT)
In-Reply-To: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Instead of having an ugly #ifdef mess in the core.c for creating debugfs
files, add a dss_debugfs_create_file() function that the dss drivers
can use to create the debugfs files.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c  |   46 +++++++++++++++------------------------
 drivers/video/omap2/dss/dispc.c |    7 +++++-
 drivers/video/omap2/dss/dsi.c   |   42 ++++++++++-------------------------
 drivers/video/omap2/dss/dss.c   |    4 +++-
 drivers/video/omap2/dss/dss.h   |   11 +---------
 drivers/video/omap2/dss/hdmi.c  |    4 +++-
 drivers/video/omap2/dss/rfbi.c  |    4 +++-
 drivers/video/omap2/dss/venc.c  |    4 +++-
 8 files changed, 48 insertions(+), 74 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 2a0cbae..c54bba0 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -166,34 +166,6 @@ static int dss_initialize_debugfs(void)
 	debugfs_create_file("clk", S_IRUGO, dss_debugfs_dir,
 			&dss_debug_dump_clocks, &dss_debug_fops);
 
-#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
-	debugfs_create_file("dispc_irq", S_IRUGO, dss_debugfs_dir,
-			&dispc_dump_irqs, &dss_debug_fops);
-#endif
-
-#if defined(CONFIG_OMAP2_DSS_DSI) && defined(CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS)
-	dsi_create_debugfs_files_irq(dss_debugfs_dir, &dss_debug_fops);
-#endif
-
-	debugfs_create_file("dss", S_IRUGO, dss_debugfs_dir,
-			&dss_dump_regs, &dss_debug_fops);
-	debugfs_create_file("dispc", S_IRUGO, dss_debugfs_dir,
-			&dispc_dump_regs, &dss_debug_fops);
-#ifdef CONFIG_OMAP2_DSS_RFBI
-	debugfs_create_file("rfbi", S_IRUGO, dss_debugfs_dir,
-			&rfbi_dump_regs, &dss_debug_fops);
-#endif
-#ifdef CONFIG_OMAP2_DSS_DSI
-	dsi_create_debugfs_files_reg(dss_debugfs_dir, &dss_debug_fops);
-#endif
-#ifdef CONFIG_OMAP2_DSS_VENC
-	debugfs_create_file("venc", S_IRUGO, dss_debugfs_dir,
-			&venc_dump_regs, &dss_debug_fops);
-#endif
-#ifdef CONFIG_OMAP4_DSS_HDMI
-	debugfs_create_file("hdmi", S_IRUGO, dss_debugfs_dir,
-			&hdmi_dump_regs, &dss_debug_fops);
-#endif
 	return 0;
 }
 
@@ -202,6 +174,19 @@ static void dss_uninitialize_debugfs(void)
 	if (dss_debugfs_dir)
 		debugfs_remove_recursive(dss_debugfs_dir);
 }
+
+int dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *))
+{
+	struct dentry *d;
+
+	d = debugfs_create_file(name, S_IRUGO, dss_debugfs_dir,
+			write, &dss_debug_fops);
+
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+
+	return 0;
+}
 #else /* CONFIG_DEBUG_FS && CONFIG_OMAP2_DSS_DEBUG_SUPPORT */
 static inline int dss_initialize_debugfs(void)
 {
@@ -210,6 +195,11 @@ static inline int dss_initialize_debugfs(void)
 static inline void dss_uninitialize_debugfs(void)
 {
 }
+static inline int dss_debugfs_create_file(const char *name,
+		void (*write)(struct seq_file *))
+{
+	return 0;
+}
 #endif /* CONFIG_DEBUG_FS && CONFIG_OMAP2_DSS_DEBUG_SUPPORT */
 
 /* PLATFORM DEVICE */
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 1cccd4c..e4b880f 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2765,7 +2765,7 @@ void dispc_dump_irqs(struct seq_file *s)
 }
 #endif
 
-void dispc_dump_regs(struct seq_file *s)
+static void dispc_dump_regs(struct seq_file *s)
 {
 	int i, j;
 	const char *mgr_names[] = {
@@ -3576,6 +3576,11 @@ static int omap_dispchw_probe(struct platform_device *pdev)
 
 	dispc_runtime_put();
 
+	dss_debugfs_create_file("dispc", dispc_dump_regs);
+
+#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+	dss_debugfs_create_file("dispc_irq", dispc_dump_irqs);
+#endif
 	return 0;
 
 err_runtime_get:
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index c365942..b380231 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1852,22 +1852,6 @@ static void dsi2_dump_irqs(struct seq_file *s)
 
 	dsi_dump_dsidev_irqs(dsidev, s);
 }
-
-void dsi_create_debugfs_files_irq(struct dentry *debugfs_dir,
-		const struct file_operations *debug_fops)
-{
-	struct platform_device *dsidev;
-
-	dsidev = dsi_get_dsidev_from_id(0);
-	if (dsidev)
-		debugfs_create_file("dsi1_irqs", S_IRUGO, debugfs_dir,
-			&dsi1_dump_irqs, debug_fops);
-
-	dsidev = dsi_get_dsidev_from_id(1);
-	if (dsidev)
-		debugfs_create_file("dsi2_irqs", S_IRUGO, debugfs_dir,
-			&dsi2_dump_irqs, debug_fops);
-}
 #endif
 
 static void dsi_dump_dsidev_regs(struct platform_device *dsidev,
@@ -1968,21 +1952,6 @@ static void dsi2_dump_regs(struct seq_file *s)
 	dsi_dump_dsidev_regs(dsidev, s);
 }
 
-void dsi_create_debugfs_files_reg(struct dentry *debugfs_dir,
-		const struct file_operations *debug_fops)
-{
-	struct platform_device *dsidev;
-
-	dsidev = dsi_get_dsidev_from_id(0);
-	if (dsidev)
-		debugfs_create_file("dsi1_regs", S_IRUGO, debugfs_dir,
-			&dsi1_dump_regs, debug_fops);
-
-	dsidev = dsi_get_dsidev_from_id(1);
-	if (dsidev)
-		debugfs_create_file("dsi2_regs", S_IRUGO, debugfs_dir,
-			&dsi2_dump_regs, debug_fops);
-}
 enum dsi_cio_power_state {
 	DSI_COMPLEXIO_POWER_OFF		= 0x0,
 	DSI_COMPLEXIO_POWER_ON		= 0x1,
@@ -4735,6 +4704,17 @@ static int omap_dsihw_probe(struct platform_device *dsidev)
 
 	dsi_runtime_put(dsidev);
 
+	if (dsi_module == 0)
+		dss_debugfs_create_file("dsi1_regs", dsi1_dump_regs);
+	else if (dsi_module == 1)
+		dss_debugfs_create_file("dsi2_regs", dsi2_dump_regs);
+
+#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+	if (dsi_module == 0)
+		dss_debugfs_create_file("dsi1_irqs", dsi1_dump_irqs);
+	else if (dsi_module == 1)
+		dss_debugfs_create_file("dsi2_irqs", dsi2_dump_irqs);
+#endif
 	return 0;
 
 err_runtime_get:
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 06fb5dc..7667e4c 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -280,7 +280,7 @@ void dss_dump_clocks(struct seq_file *s)
 	dss_runtime_put();
 }
 
-void dss_dump_regs(struct seq_file *s)
+static void dss_dump_regs(struct seq_file *s)
 {
 #define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, dss_read_reg(r))
 
@@ -794,6 +794,8 @@ static int omap_dsshw_probe(struct platform_device *pdev)
 
 	dss_runtime_put();
 
+	dss_debugfs_create_file("dss", dss_dump_regs);
+
 	return 0;
 
 err_runtime_get:
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 57853fd..3ea0fa9 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -163,6 +163,7 @@ int dss_get_ctx_loss_count(struct device *dev);
 int dss_dsi_enable_pads(int dsi_id, unsigned lane_mask);
 void dss_dsi_disable_pads(int dsi_id, unsigned lane_mask);
 int dss_set_min_bus_tput(struct device *dev, unsigned long tput);
+int dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *));
 
 /* apply */
 void dss_apply_init(void);
@@ -233,7 +234,6 @@ enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void);
 const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src);
 void dss_dump_clocks(struct seq_file *s);
 
-void dss_dump_regs(struct seq_file *s);
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
 void dss_debug_dump_clocks(struct seq_file *s);
 #endif
@@ -280,10 +280,6 @@ int dsi_runtime_get(struct platform_device *dsidev);
 void dsi_runtime_put(struct platform_device *dsidev);
 
 void dsi_dump_clocks(struct seq_file *s);
-void dsi_create_debugfs_files_irq(struct dentry *debugfs_dir,
-		const struct file_operations *debug_fops);
-void dsi_create_debugfs_files_reg(struct dentry *debugfs_dir,
-		const struct file_operations *debug_fops);
 
 int dsi_init_display(struct omap_dss_device *display);
 void dsi_irq_handler(void);
@@ -366,8 +362,6 @@ int dpi_init_display(struct omap_dss_device *dssdev);
 int dispc_init_platform_driver(void);
 void dispc_uninit_platform_driver(void);
 void dispc_dump_clocks(struct seq_file *s);
-void dispc_dump_irqs(struct seq_file *s);
-void dispc_dump_regs(struct seq_file *s);
 void dispc_irq_handler(void);
 void dispc_fake_vsync_irq(void);
 
@@ -433,7 +427,6 @@ void dispc_mgr_setup(enum omap_channel channel,
 #ifdef CONFIG_OMAP2_DSS_VENC
 int venc_init_platform_driver(void);
 void venc_uninit_platform_driver(void);
-void venc_dump_regs(struct seq_file *s);
 int venc_init_display(struct omap_dss_device *display);
 unsigned long venc_get_pixel_clock(void);
 #else
@@ -450,7 +443,6 @@ int hdmi_init_platform_driver(void);
 void hdmi_uninit_platform_driver(void);
 int hdmi_init_display(struct omap_dss_device *dssdev);
 unsigned long hdmi_get_pixel_clock(void);
-void hdmi_dump_regs(struct seq_file *s);
 #else
 static inline int hdmi_init_display(struct omap_dss_device *dssdev)
 {
@@ -475,7 +467,6 @@ void hdmi_panel_exit(void);
 /* RFBI */
 int rfbi_init_platform_driver(void);
 void rfbi_uninit_platform_driver(void);
-void rfbi_dump_regs(struct seq_file *s);
 int rfbi_init_display(struct omap_dss_device *display);
 
 
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index bfbe811..614eaed 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -418,7 +418,7 @@ void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev)
 	}
 }
 
-void hdmi_dump_regs(struct seq_file *s)
+static void hdmi_dump_regs(struct seq_file *s)
 {
 	mutex_lock(&hdmi.lock);
 
@@ -808,6 +808,8 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	hdmi_panel_init();
 
+	dss_debugfs_create_file("hdmi", hdmi_dump_regs);
+
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 01fd9e7..6f28955 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -819,7 +819,7 @@ int omap_rfbi_update(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(omap_rfbi_update);
 
-void rfbi_dump_regs(struct seq_file *s)
+static void rfbi_dump_regs(struct seq_file *s)
 {
 #define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, rfbi_read_reg(r))
 
@@ -976,6 +976,8 @@ static int omap_rfbihw_probe(struct platform_device *pdev)
 
 	rfbi_runtime_put();
 
+	dss_debugfs_create_file("rfbi", rfbi_dump_regs);
+
 	return 0;
 
 err_runtime_get:
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 9f13748..cb6b571 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -693,7 +693,7 @@ int venc_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-void venc_dump_regs(struct seq_file *s)
+static void venc_dump_regs(struct seq_file *s)
 {
 #define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, venc_read_reg(r))
 
@@ -822,6 +822,8 @@ static int omap_venchw_probe(struct platform_device *pdev)
 	if (r)
 		goto err_reg_panel_driver;
 
+	dss_debugfs_create_file("venc", venc_dump_regs);
+
 	return 0;
 
 err_reg_panel_driver:
-- 
1.7.9.5


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 17/21] OMAPDSS: move the creation of debugfs files
Date: Wed,  7 Mar 2012 14:44:46 +0200
Message-ID: <1331124290-6285-18-git-send-email-tomi.valkeinen@ti.com>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:44333 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758545Ab2CGMqN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 07:46:13 -0500
Received: by bkwj10 with SMTP id j10so7035231bkw.24
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 04:46:10 -0800 (PST)
In-Reply-To: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Instead of having an ugly #ifdef mess in the core.c for creating debugfs
files, add a dss_debugfs_create_file() function that the dss drivers
can use to create the debugfs files.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c  |   46 +++++++++++++++-----------------------
 drivers/video/omap2/dss/dispc.c |    7 +++++-
 drivers/video/omap2/dss/dsi.c   |   42 +++++++++--------------------------
 drivers/video/omap2/dss/dss.c   |    4 ++-
 drivers/video/omap2/dss/dss.h   |   11 +--------
 drivers/video/omap2/dss/hdmi.c  |    4 ++-
 drivers/video/omap2/dss/rfbi.c  |    4 ++-
 drivers/video/omap2/dss/venc.c  |    4 ++-
 8 files changed, 48 insertions(+), 74 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index ac4f2cb..a744474 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -156,34 +156,6 @@ static int dss_initialize_debugfs(void)
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
 
@@ -192,6 +164,19 @@ static void dss_uninitialize_debugfs(void)
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
@@ -200,6 +185,11 @@ static inline int dss_initialize_debugfs(void)
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
index 1fbe480..a555e32 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2571,7 +2571,7 @@ void dispc_dump_irqs(struct seq_file *s)
 }
 #endif
 
-void dispc_dump_regs(struct seq_file *s)
+static void dispc_dump_regs(struct seq_file *s)
 {
 	int i, j;
 	const char *mgr_names[] = {
@@ -3387,6 +3387,11 @@ static int omap_dispchw_probe(struct platform_device *pdev)
 
 	dispc_runtime_put();
 
+	dss_debugfs_create_file("dispc", dispc_dump_regs);
+
+#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+	dss_debugfs_create_file("dispc_irq", dispc_dump_irqs);
+#endif
 	return 0;
 
 err_runtime_get:
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 4bee235..0a1c5e3 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1883,22 +1883,6 @@ static void dsi2_dump_irqs(struct seq_file *s)
 
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
@@ -1999,21 +1983,6 @@ static void dsi2_dump_regs(struct seq_file *s)
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
@@ -4768,6 +4737,17 @@ static int omap_dsihw_probe(struct platform_device *dsidev)
 
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
index da528b7..47a4c2a 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -277,7 +277,7 @@ void dss_dump_clocks(struct seq_file *s)
 	dss_runtime_put();
 }
 
-void dss_dump_regs(struct seq_file *s)
+static void dss_dump_regs(struct seq_file *s)
 {
 #define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, dss_read_reg(r))
 
@@ -791,6 +791,8 @@ static int omap_dsshw_probe(struct platform_device *pdev)
 
 	dss_runtime_put();
 
+	dss_debugfs_create_file("dss", dss_dump_regs);
+
 	return 0;
 
 err_runtime_get:
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index af7bed1..5746bed 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -165,6 +165,7 @@ struct regulator *dss_get_vdds_sdi(void);
 int dss_get_ctx_loss_count(struct device *dev);
 int dss_dsi_enable_pads(int dsi_id, unsigned lane_mask);
 void dss_dsi_disable_pads(int dsi_id, unsigned lane_mask);
+int dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *));
 
 /* apply */
 void dss_apply_init(void);
@@ -235,7 +236,6 @@ enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void);
 const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src);
 void dss_dump_clocks(struct seq_file *s);
 
-void dss_dump_regs(struct seq_file *s);
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
 void dss_debug_dump_clocks(struct seq_file *s);
 #endif
@@ -282,10 +282,6 @@ int dsi_runtime_get(struct platform_device *dsidev);
 void dsi_runtime_put(struct platform_device *dsidev);
 
 void dsi_dump_clocks(struct seq_file *s);
-void dsi_create_debugfs_files_irq(struct dentry *debugfs_dir,
-		const struct file_operations *debug_fops);
-void dsi_create_debugfs_files_reg(struct dentry *debugfs_dir,
-		const struct file_operations *debug_fops);
 
 int dsi_init_display(struct omap_dss_device *display);
 void dsi_irq_handler(void);
@@ -368,8 +364,6 @@ int dpi_init_display(struct omap_dss_device *dssdev);
 int dispc_init_platform_driver(void);
 void dispc_uninit_platform_driver(void);
 void dispc_dump_clocks(struct seq_file *s);
-void dispc_dump_irqs(struct seq_file *s);
-void dispc_dump_regs(struct seq_file *s);
 void dispc_irq_handler(void);
 void dispc_fake_vsync_irq(void);
 
@@ -435,7 +429,6 @@ void dispc_mgr_setup(enum omap_channel channel,
 #ifdef CONFIG_OMAP2_DSS_VENC
 int venc_init_platform_driver(void);
 void venc_uninit_platform_driver(void);
-void venc_dump_regs(struct seq_file *s);
 int venc_init_display(struct omap_dss_device *display);
 unsigned long venc_get_pixel_clock(void);
 #else
@@ -452,7 +445,6 @@ int hdmi_init_platform_driver(void);
 void hdmi_uninit_platform_driver(void);
 int hdmi_init_display(struct omap_dss_device *dssdev);
 unsigned long hdmi_get_pixel_clock(void);
-void hdmi_dump_regs(struct seq_file *s);
 #else
 static inline int hdmi_init_display(struct omap_dss_device *dssdev)
 {
@@ -477,7 +469,6 @@ void hdmi_panel_exit(void);
 /* RFBI */
 int rfbi_init_platform_driver(void);
 void rfbi_uninit_platform_driver(void);
-void rfbi_dump_regs(struct seq_file *s);
 int rfbi_init_display(struct omap_dss_device *display);
 
 
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 08a316b..10295fc 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -419,7 +419,7 @@ void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev)
 	}
 }
 
-void hdmi_dump_regs(struct seq_file *s)
+static void hdmi_dump_regs(struct seq_file *s)
 {
 	mutex_lock(&hdmi.lock);
 
@@ -809,6 +809,8 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	hdmi_panel_init();
 
+	dss_debugfs_create_file("hdmi", hdmi_dump_regs);
+
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index b6990ba..b07010b 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -799,7 +799,7 @@ int omap_rfbi_update(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(omap_rfbi_update);
 
-void rfbi_dump_regs(struct seq_file *s)
+static void rfbi_dump_regs(struct seq_file *s)
 {
 #define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, rfbi_read_reg(r))
 
@@ -956,6 +956,8 @@ static int omap_rfbihw_probe(struct platform_device *pdev)
 
 	rfbi_runtime_put();
 
+	dss_debugfs_create_file("rfbi", rfbi_dump_regs);
+
 	return 0;
 
 err_runtime_get:
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 637abcb..a9c7c7c 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -695,7 +695,7 @@ int venc_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-void venc_dump_regs(struct seq_file *s)
+static void venc_dump_regs(struct seq_file *s)
 {
 #define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, venc_read_reg(r))
 
@@ -824,6 +824,8 @@ static int omap_venchw_probe(struct platform_device *pdev)
 	if (r)
 		goto err_reg_panel_driver;
 
+	dss_debugfs_create_file("venc", venc_dump_regs);
+
 	return 0;
 
 err_reg_panel_driver:
-- 
1.7.4.1


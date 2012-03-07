From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 08/21] OMAPDSS: clean up the omapdss platform data mess
Date: Wed,  7 Mar 2012 14:44:37 +0200
Message-ID: <1331124290-6285-9-git-send-email-tomi.valkeinen@ti.com>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:51582 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758468Ab2CGMpa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 07:45:30 -0500
Received: by lagw12 with SMTP id w12so10336137lag.34
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 04:45:27 -0800 (PST)
In-Reply-To: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

The omapdss pdata handling is a mess. This is more evident when trying
to use device tree for DSS, as we don't have platform data anymore in
that case. This patch cleans the pdata handling by:

- Remove struct omap_display_platform_data. It was used just as a
  wrapper for struct omap_dss_board_info.
- Pass the platform data only to omapdss device. The drivers for omap
  dss hwmods do not need the platform data. This should also work better
  for DT, as we can create omapdss device programmatically in generic omap
  boot code, and thus we can pass the pdata to it.
- Create dss functions for get_ctx_loss_count and dsi_enable/disable_pads
  that the dss hwmod drivers can call.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c   |   37 ++++++++++++++++++-------------------
 drivers/video/omap2/dss/core.c  |   35 +++++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dispc.c |   21 ++-------------------
 drivers/video/omap2/dss/dsi.c   |   17 +++--------------
 drivers/video/omap2/dss/dss.h   |    3 +++
 drivers/video/omap2/dss/hdmi.c  |    2 --
 include/video/omapdss.h         |    5 -----
 7 files changed, 61 insertions(+), 59 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 3677b1f..279c124 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -185,10 +185,23 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 	struct omap_hwmod *oh;
 	struct platform_device *pdev;
 	int i, oh_count;
-	struct omap_display_platform_data pdata;
 	const struct omap_dss_hwmod_data *curr_dss_hwmod;
 
-	memset(&pdata, 0, sizeof(pdata));
+	/* create omapdss device */
+
+	board_data->dsi_enable_pads = omap_dsi_enable_pads;
+	board_data->dsi_disable_pads = omap_dsi_disable_pads;
+	board_data->get_context_loss_count = omap_pm_get_dev_context_loss_count;
+
+	omap_display_device.dev.platform_data = board_data;
+
+	r = platform_device_register(&omap_display_device);
+	if (r < 0) {
+		pr_err("Unable to register omapdss device\n");
+		return r;
+	}
+
+	/* create devices for dss hwmods */
 
 	if (cpu_is_omap24xx()) {
 		curr_dss_hwmod = omap2_dss_hwmod_data;
@@ -201,15 +214,6 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 		oh_count = ARRAY_SIZE(omap4_dss_hwmod_data);
 	}
 
-	if (board_data->dsi_enable_pads == NULL)
-		board_data->dsi_enable_pads = omap_dsi_enable_pads;
-	if (board_data->dsi_disable_pads == NULL)
-		board_data->dsi_disable_pads = omap_dsi_disable_pads;
-
-	pdata.board_data = board_data;
-	pdata.board_data->get_context_loss_count =
-		omap_pm_get_dev_context_loss_count;
-
 	for (i = 0; i < oh_count; i++) {
 		oh = omap_hwmod_lookup(curr_dss_hwmod[i].oh_name);
 		if (!oh) {
@@ -219,21 +223,16 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 		}
 
 		pdev = omap_device_build(curr_dss_hwmod[i].dev_name,
-				curr_dss_hwmod[i].id, oh, &pdata,
-				sizeof(struct omap_display_platform_data),
+				curr_dss_hwmod[i].id, oh,
+				NULL, 0,
 				NULL, 0, 0);
 
 		if (WARN((IS_ERR(pdev)), "Could not build omap_device for %s\n",
 				curr_dss_hwmod[i].oh_name))
 			return -ENODEV;
 	}
-	omap_display_device.dev.platform_data = board_data;
 
-	r = platform_device_register(&omap_display_device);
-	if (r < 0)
-		printk(KERN_ERR "Unable to register OMAP-Display device\n");
-
-	return r;
+	return 0;
 }
 
 static void dispc_disable_outputs(void)
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 8613f86..3efd473 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -87,6 +87,41 @@ struct regulator *dss_get_vdds_sdi(void)
 	return reg;
 }
 
+int dss_get_ctx_loss_count(struct device *dev)
+{
+	struct omap_dss_board_info *board_data = core.pdev->dev.platform_data;
+	int cnt;
+
+	if (!board_data || !board_data->get_context_loss_count)
+		return -ENOENT;
+
+	cnt = board_data->get_context_loss_count(dev);
+
+	WARN_ONCE(cnt < 0, "get_context_loss_count failed: %d\n", cnt);
+
+	return cnt;
+}
+
+int dss_dsi_enable_pads(int dsi_id, unsigned lane_mask)
+{
+	struct omap_dss_board_info *board_data = core.pdev->dev.platform_data;
+
+	if (!board_data || !board_data->dsi_enable_pads)
+		return -ENOENT;
+
+	return board_data->dsi_enable_pads(dsi_id, lane_mask);
+}
+
+void dss_dsi_disable_pads(int dsi_id, unsigned lane_mask)
+{
+	struct omap_dss_board_info *board_data = core.pdev->dev.platform_data;
+
+	if (!board_data || !board_data->dsi_enable_pads)
+		return;
+
+	return board_data->dsi_disable_pads(dsi_id, lane_mask);
+}
+
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
 static int dss_debug_show(struct seq_file *s, void *unused)
 {
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index bddd64b..703bb20 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -131,23 +131,6 @@ static inline u32 dispc_read_reg(const u16 idx)
 	return __raw_readl(dispc.base + idx);
 }
 
-static int dispc_get_ctx_loss_count(void)
-{
-	struct device *dev = &dispc.pdev->dev;
-	struct omap_display_platform_data *pdata = dev->platform_data;
-	struct omap_dss_board_info *board_data = pdata->board_data;
-	int cnt;
-
-	if (!board_data->get_context_loss_count)
-		return -ENOENT;
-
-	cnt = board_data->get_context_loss_count(dev);
-
-	WARN_ONCE(cnt < 0, "get_context_loss_count failed: %d\n", cnt);
-
-	return cnt;
-}
-
 #define SR(reg) \
 	dispc.ctx[DISPC_##reg / sizeof(u32)] = dispc_read_reg(DISPC_##reg)
 #define RR(reg) \
@@ -251,7 +234,7 @@ static void dispc_save_context(void)
 	if (dss_has_feature(FEAT_CORE_CLK_DIV))
 		SR(DIVISOR);
 
-	dispc.ctx_loss_cnt = dispc_get_ctx_loss_count();
+	dispc.ctx_loss_cnt = dss_get_ctx_loss_count(&dispc.pdev->dev);
 	dispc.ctx_valid = true;
 
 	DSSDBG("context saved, ctx_loss_count %d\n", dispc.ctx_loss_cnt);
@@ -266,7 +249,7 @@ static void dispc_restore_context(void)
 	if (!dispc.ctx_valid)
 		return;
 
-	ctx = dispc_get_ctx_loss_count();
+	ctx = dss_get_ctx_loss_count(&dispc.pdev->dev);
 
 	if (ctx >= 0 && ctx == dispc.ctx_loss_cnt)
 		return;
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 3e656be..4e2f7ff 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -261,9 +261,6 @@ struct dsi_data {
 	struct clk *dss_clk;
 	struct clk *sys_clk;
 
-	int (*enable_pads)(int dsi_id, unsigned lane_mask);
-	void (*disable_pads)(int dsi_id, unsigned lane_mask);
-
 	struct dsi_clock_info current_cinfo;
 
 	bool vdds_dsi_enabled;
@@ -2396,7 +2393,7 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 
 	DSSDBGF();
 
-	r = dsi->enable_pads(dsi_get_dsidev_id(dsidev), dsi_get_lane_mask(dssdev));
+	r = dss_dsi_enable_pads(dsi_get_dsidev_id(dsidev), dsi_get_lane_mask(dssdev));
 	if (r)
 		return r;
 
@@ -2506,21 +2503,20 @@ err_cio_pwr:
 		dsi_cio_disable_lane_override(dsidev);
 err_scp_clk_dom:
 	dsi_disable_scp_clk(dsidev);
-	dsi->disable_pads(dsi_get_dsidev_id(dsidev), dsi_get_lane_mask(dssdev));
+	dss_dsi_disable_pads(dsi_get_dsidev_id(dsidev), dsi_get_lane_mask(dssdev));
 	return r;
 }
 
 static void dsi_cio_uninit(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	/* DDR_CLK_ALWAYS_ON */
 	REG_FLD_MOD(dsidev, DSI_CLK_CTRL, 0, 13, 13);
 
 	dsi_cio_power(dsidev, DSI_COMPLEXIO_POWER_OFF);
 	dsi_disable_scp_clk(dsidev);
-	dsi->disable_pads(dsi_get_dsidev_id(dsidev), dsi_get_lane_mask(dssdev));
+	dss_dsi_disable_pads(dsi_get_dsidev_id(dsidev), dsi_get_lane_mask(dssdev));
 }
 
 static void dsi_config_tx_fifo(struct platform_device *dsidev,
@@ -4680,8 +4676,6 @@ static void dsi_put_clocks(struct platform_device *dsidev)
 /* DSI1 HW IP initialisation */
 static int omap_dsihw_probe(struct platform_device *dsidev)
 {
-	struct omap_display_platform_data *dss_plat_data;
-	struct omap_dss_board_info *board_info;
 	u32 rev;
 	int r, i, dsi_module = dsi_get_dsidev_id(dsidev);
 	struct resource *dsi_mem;
@@ -4695,11 +4689,6 @@ static int omap_dsihw_probe(struct platform_device *dsidev)
 	dsi_pdev_map[dsi_module] = dsidev;
 	dev_set_drvdata(&dsidev->dev, dsi);
 
-	dss_plat_data = dsidev->dev.platform_data;
-	board_info = dss_plat_data->board_data;
-	dsi->enable_pads = board_info->dsi_enable_pads;
-	dsi->disable_pads = board_info->dsi_disable_pads;
-
 	spin_lock_init(&dsi->irq_lock);
 	spin_lock_init(&dsi->errors_lock);
 	dsi->errors = 0;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index d4b3dff..d37ed80 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -162,6 +162,9 @@ struct platform_device;
 struct bus_type *dss_get_bus(void);
 struct regulator *dss_get_vdds_dsi(void);
 struct regulator *dss_get_vdds_sdi(void);
+int dss_get_ctx_loss_count(struct device *dev);
+int dss_dsi_enable_pads(int dsi_id, unsigned lane_mask);
+void dss_dsi_disable_pads(int dsi_id, unsigned lane_mask);
 
 /* apply */
 void dss_apply_init(void);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index c4b4f69..cacf856 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -63,7 +63,6 @@
 
 static struct {
 	struct mutex lock;
-	struct omap_display_platform_data *pdata;
 	struct platform_device *pdev;
 	struct hdmi_ip_data ip_data;
 
@@ -796,7 +795,6 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 	struct resource *hdmi_mem;
 	int r;
 
-	hdmi.pdata = pdev->dev.platform_data;
 	hdmi.pdev = pdev;
 
 	mutex_init(&hdmi.lock);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 483f67c..b499ccb 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -316,11 +316,6 @@ extern int omap_display_init(struct omap_dss_board_info *board_data);
 /* HDMI mux init*/
 extern int omap_hdmi_init(enum omap_hdmi_flags flags);
 
-struct omap_display_platform_data {
-	struct omap_dss_board_info *board_data;
-	/* TODO: Additional members to be added when PM is considered */
-};
-
 struct omap_video_timings {
 	/* Unit: pixels */
 	u16 x_res;
-- 
1.7.4.1


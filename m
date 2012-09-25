From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH] OMAPDSS: Cleanup DSSDBG with dynamic pr_debug function
Date: Tue, 25 Sep 2012 11:33:18 +0530
Message-ID: <1348552998-6596-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47783 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831Ab2IYGGE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 02:06:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The printk in DSSDBG function definition is replaced with dynamic debug enabled
pr_debug(). The use of dynamic debugging provides more flexiblity as each debug
statement can be enabled or disabled dynamically on basis of source filename,
line number, module name etc. by writing to a control file in debugfs
filesystem. For better undertsanding please refer to
Documentation/dynamic-debug-howto.txt.

The DSSDBGF() differs from DSSDBG() by providing function name. However,
function name, line number, module name and thread ID can be printed through
dynamic debug by setting appropiate flags 'f','l','m' and 't' in the debugfs
control file. So, DSSDBGF instances are replaced with DSSDBG.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/apply.c |    8 ++++----
 drivers/video/omap2/dss/dsi.c   |   12 ++++--------
 drivers/video/omap2/dss/dss.h   |   34 ++++++++--------------------------
 3 files changed, 16 insertions(+), 38 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 6354bb8..cb86d94 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -559,7 +559,7 @@ static void dss_ovl_write_regs(struct omap_overlay *ovl)
 	struct mgr_priv_data *mp;
 	int r;
 
-	DSSDBGF("%d", ovl->id);
+	DSSDBG("%d", ovl->id);
 
 	if (!op->enabled || !op->info_dirty)
 		return;
@@ -594,7 +594,7 @@ static void dss_ovl_write_regs_extra(struct omap_overlay *ovl)
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
 	struct mgr_priv_data *mp;
 
-	DSSDBGF("%d", ovl->id);
+	DSSDBG("%d", ovl->id);
 
 	if (!op->extra_info_dirty)
 		return;
@@ -618,7 +618,7 @@ static void dss_mgr_write_regs(struct omap_overlay_manager *mgr)
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
 	struct omap_overlay *ovl;
 
-	DSSDBGF("%d", mgr->id);
+	DSSDBG("%d", mgr->id);
 
 	if (!mp->enabled)
 		return;
@@ -644,7 +644,7 @@ static void dss_mgr_write_regs_extra(struct omap_overlay_manager *mgr)
 {
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
 
-	DSSDBGF("%d", mgr->id);
+	DSSDBG("%d", mgr->id);
 
 	if (!mp->extra_info_dirty)
 		return;
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 8d815e3..8304cc6b 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1525,8 +1525,6 @@ int dsi_pll_set_clock_div(struct platform_device *dsidev,
 	u8 regn_start, regn_end, regm_start, regm_end;
 	u8 regm_dispc_start, regm_dispc_end, regm_dsi_start, regm_dsi_end;
 
-	DSSDBGF();
-
 	dsi->current_cinfo.clkin = cinfo->clkin;
 	dsi->current_cinfo.fint = cinfo->fint;
 	dsi->current_cinfo.clkin4ddr = cinfo->clkin4ddr;
@@ -2334,8 +2332,6 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 	int r;
 	u32 l;
 
-	DSSDBGF();
-
 	r = dss_dsi_enable_pads(dsi->module_id, dsi_get_lane_mask(dssdev));
 	if (r)
 		return r;
@@ -2686,7 +2682,7 @@ static void dsi_vc_initial_config(struct platform_device *dsidev, int channel)
 {
 	u32 r;
 
-	DSSDBGF("%d", channel);
+	DSSDBG("%d", channel);
 
 	r = dsi_read_reg(dsidev, DSI_VC_CTRL(channel));
 
@@ -2718,7 +2714,7 @@ static int dsi_vc_config_source(struct platform_device *dsidev, int channel,
 	if (dsi->vc[channel].source == source)
 		return 0;
 
-	DSSDBGF("%d", channel);
+	DSSDBG("%d", channel);
 
 	dsi_sync_vc(dsidev, channel);
 
@@ -3475,7 +3471,7 @@ static int dsi_enter_ulps(struct platform_device *dsidev)
 	int r, i;
 	unsigned mask;
 
-	DSSDBGF();
+	DSSDBG("");
 
 	WARN_ON(!dsi_bus_is_locked(dsidev));
 
@@ -4184,7 +4180,7 @@ int omapdss_dsi_set_clocks(struct omap_dss_device *dssdev,
 	unsigned long pck;
 	int r;
 
-	DSSDBGF("ddr_clk %lu, lp_clk %lu", ddr_clk, lp_clk);
+	DSSDBG("ddr_clk %lu, lp_clk %lu", ddr_clk, lp_clk);
 
 	mutex_lock(&dsi->lock);
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 5e9fd769..3a2caab 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -29,38 +29,20 @@
 
 #ifdef DEBUG
 extern bool dss_debug;
-#ifdef DSS_SUBSYS_NAME
-#define DSSDBG(format, ...) \
-	if (dss_debug) \
-		printk(KERN_DEBUG "omapdss " DSS_SUBSYS_NAME ": " format, \
-		## __VA_ARGS__)
-#else
-#define DSSDBG(format, ...) \
-	if (dss_debug) \
-		printk(KERN_DEBUG "omapdss: " format, ## __VA_ARGS__)
 #endif
 
-#ifdef DSS_SUBSYS_NAME
-#define DSSDBGF(format, ...) \
-	if (dss_debug) \
-		printk(KERN_DEBUG "omapdss " DSS_SUBSYS_NAME \
-				": %s(" format ")\n", \
-				__func__, \
-				## __VA_ARGS__)
-#else
-#define DSSDBGF(format, ...) \
-	if (dss_debug) \
-		printk(KERN_DEBUG "omapdss: " \
-				": %s(" format ")\n", \
-				__func__, \
-				## __VA_ARGS__)
+#ifdef pr_fmt
+#undef pr_fmt
 #endif
 
-#else /* DEBUG */
-#define DSSDBG(format, ...)
-#define DSSDBGF(format, ...)
+#ifdef DSS_SUBSYS_NAME
+#define pr_fmt(fmt) DSS_SUBSYS_NAME ": " fmt
+#else
+#define pr_fmt(fmt) fmt
 #endif
 
+#define DSSDBG(format, ...) \
+	pr_debug(format, ## __VA_ARGS__)
 
 #ifdef DSS_SUBSYS_NAME
 #define DSSERR(format, ...) \
-- 
1.7.10


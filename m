From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V4 3/5] OMAPDSS: Cleanup DSSDBG with dynamic pr_debug function
Date: Sat, 29 Sep 2012 16:19:24 +0530
Message-ID: <d125b22d3ca6f2863b3a42426ab395941e8092d8.1348914940.git.cmahapatra@ti.com>
References: <cover.1348826106.git.cmahapatra@ti.com> <cover.1348914940.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45418 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724Ab2I2KwG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 Sep 2012 06:52:06 -0400
In-Reply-To: <cover.1348914940.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The printk in DSSDBG function definition is replaced with dynamic debug enabled
pr_debug(). The use of dynamic debugging provides more flexibility as each debug
statement can be enabled or disabled dynamically on basis of source filename,
line number, module name etc., by writing to a control file in debugfs
filesystem. For better understanding please refer to
Documentation/dynamic-debug-howto.txt.

The DSSDBGF() differs from DSSDBG() by providing function name. However,
function name, line number, module name and thread ID can be printed through
dynamic debug by setting appropriate flags 'f','l','m' and 't' in the debugfs
control file. So, DSSDBGF instances are replaced with DSSDBG.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/apply.c |    8 ++++----
 drivers/video/omap2/dss/dsi.c   |   12 ++++++------
 drivers/video/omap2/dss/dss.h   |   34 ++++++++--------------------------
 3 files changed, 18 insertions(+), 36 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 19d66f4..e923d9f 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -573,7 +573,7 @@ static void dss_ovl_write_regs(struct omap_overlay *ovl)
 	struct mgr_priv_data *mp;
 	int r;
 
-	DSSDBGF("%d", ovl->id);
+	DSSDBG("writing ovl %d regs", ovl->id);
 
 	if (!op->enabled || !op->info_dirty)
 		return;
@@ -608,7 +608,7 @@ static void dss_ovl_write_regs_extra(struct omap_overlay *ovl)
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
 	struct mgr_priv_data *mp;
 
-	DSSDBGF("%d", ovl->id);
+	DSSDBG("writing ovl %d regs extra", ovl->id);
 
 	if (!op->extra_info_dirty)
 		return;
@@ -632,7 +632,7 @@ static void dss_mgr_write_regs(struct omap_overlay_manager *mgr)
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
 	struct omap_overlay *ovl;
 
-	DSSDBGF("%d", mgr->id);
+	DSSDBG("writing mgr %d regs", mgr->id);
 
 	if (!mp->enabled)
 		return;
@@ -658,7 +658,7 @@ static void dss_mgr_write_regs_extra(struct omap_overlay_manager *mgr)
 {
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
 
-	DSSDBGF("%d", mgr->id);
+	DSSDBG("writing mgr %d regs extra", mgr->id);
 
 	if (!mp->extra_info_dirty)
 		return;
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index e37e6d8..b0345f3 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1612,7 +1612,7 @@ int dsi_pll_set_clock_div(struct platform_device *dsidev,
 	u8 regn_start, regn_end, regm_start, regm_end;
 	u8 regm_dispc_start, regm_dispc_end, regm_dsi_start, regm_dsi_end;
 
-	DSSDBGF();
+	DSSDBG("DSI PLL clock config starts");
 
 	dsi->current_cinfo.clkin = cinfo->clkin;
 	dsi->current_cinfo.fint = cinfo->fint;
@@ -2431,7 +2431,7 @@ static int dsi_cio_init(struct platform_device *dsidev)
 	int r;
 	u32 l;
 
-	DSSDBGF();
+	DSSDBG("DSI CIO init starts");
 
 	r = dss_dsi_enable_pads(dsi->module_id, dsi_get_lane_mask(dsidev));
 	if (r)
@@ -2782,7 +2782,7 @@ static void dsi_vc_initial_config(struct platform_device *dsidev, int channel)
 {
 	u32 r;
 
-	DSSDBGF("%d", channel);
+	DSSDBG("Initial config of virtual channel %d", channel);
 
 	r = dsi_read_reg(dsidev, DSI_VC_CTRL(channel));
 
@@ -2814,7 +2814,7 @@ static int dsi_vc_config_source(struct platform_device *dsidev, int channel,
 	if (dsi->vc[channel].source == source)
 		return 0;
 
-	DSSDBGF("%d", channel);
+	DSSDBG("Source config of virtual channel %d", channel);
 
 	dsi_sync_vc(dsidev, channel);
 
@@ -3572,7 +3572,7 @@ static int dsi_enter_ulps(struct platform_device *dsidev)
 	int r, i;
 	unsigned mask;
 
-	DSSDBGF();
+	DSSDBG("Entering ULPS");
 
 	WARN_ON(!dsi_bus_is_locked(dsidev));
 
@@ -4276,7 +4276,7 @@ int omapdss_dsi_set_clocks(struct omap_dss_device *dssdev,
 	unsigned long pck;
 	int r;
 
-	DSSDBGF("ddr_clk %lu, lp_clk %lu", ddr_clk, lp_clk);
+	DSSDBG("Setting DSI clocks: ddr_clk %lu, lp_clk %lu", ddr_clk, lp_clk);
 
 	mutex_lock(&dsi->lock);
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index a8a1ab4..8bef7ee 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -25,38 +25,20 @@
 
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


From: Archit Taneja <archit@ti.com>
Subject: [RFC v3][PATCH 4/4] OMAP: DSS2: Add new Overlay Manager
Date: Tue,  5 Oct 2010 17:25:24 +0530
Message-ID: <1286279724-11692-5-git-send-email-archit@ti.com>
References: <1286279724-11692-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55409 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab0JELzO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 07:55:14 -0400
In-Reply-To: <1286279724-11692-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Sumit Semwal <sumit.semwal@ti.com>, Mukund Mittal <mmittal@ti.com>, Archit Taneja <archit@ti.com>, Samreen <samreen@ti.com>

From: Sumit Semwal <sumit.semwal@ti.com>

Add new Overlay Manager in manager.c, make changes needed
for secondary lcd channel

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Samreen <samreen@ti.com>
---
 drivers/video/omap2/dss/dispc.c   |   20 +++++-----
 drivers/video/omap2/dss/dss.h     |    2 +-
 drivers/video/omap2/dss/manager.c |   73 +++++++++++++++++++++++--------------
 drivers/video/omap2/dss/overlay.c |   14 ++++++-
 4 files changed, 69 insertions(+), 40 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 149ea5f..f70b2e2 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1593,7 +1593,7 @@ static int _dispc_setup_plane(enum omap_plane plane,
 		bool ilace,
 		enum omap_dss_rotation_type rotation_type,
 		u8 rotation, int mirror,
-		u8 global_alpha)
+		u8 global_alpha, enum omap_channel channel)
 {
 	const int maxdownscale = cpu_is_omap34xx() ? 4 : 2;
 	bool five_taps = 0;
@@ -1692,8 +1692,8 @@ static int _dispc_setup_plane(enum omap_plane plane,
 		five_taps = height > out_height * 2;
 
 		if (!five_taps) {
-			fclk = calc_fclk(OMAP_DSS_CHANNEL_LCD, width, height,
-					out_width, out_height);
+			fclk = calc_fclk(channel, width, height, out_width,
+					out_height);
 
 			/* Try 5-tap filter if 3-tap fclk is too high */
 			if (cpu_is_omap34xx() && height > out_height &&
@@ -1707,9 +1707,8 @@ static int _dispc_setup_plane(enum omap_plane plane,
 		}
 
 		if (five_taps)
-			fclk = calc_fclk_five_taps(OMAP_DSS_CHANNEL_LCD,
-					width, height, out_width, out_height,
-					color_mode);
+			fclk = calc_fclk_five_taps(channel, width, height,
+					out_width, out_height, color_mode);
 
 		DSSDBG("required fclk rate = %lu Hz\n", fclk);
 		DSSDBG("current fclk rate = %lu Hz\n", dispc_fclk_rate());
@@ -3338,17 +3337,18 @@ int dispc_setup_plane(enum omap_plane plane,
 		       enum omap_color_mode color_mode,
 		       bool ilace,
 		       enum omap_dss_rotation_type rotation_type,
-		       u8 rotation, bool mirror, u8 global_alpha)
+		       u8 rotation, bool mirror, u8 global_alpha,
+		       enum omap_channel channel)
 {
 	int r = 0;
 
 	DSSDBG("dispc_setup_plane %d, pa %x, sw %d, %d,%d, %dx%d -> "
-	       "%dx%d, ilace %d, cmode %x, rot %d, mir %d\n",
+	       "%dx%d, ilace %d, cmode %x, rot %d, mir %d, chan %d\n",
 	       plane, paddr, screen_width, pos_x, pos_y,
 	       width, height,
 	       out_width, out_height,
 	       ilace, color_mode,
-	       rotation, mirror);
+	       rotation, mirror, channel);
 
 	enable_clocks(1);
 
@@ -3360,7 +3360,7 @@ int dispc_setup_plane(enum omap_plane plane,
 			   color_mode, ilace,
 			   rotation_type,
 			   rotation, mirror,
-			   global_alpha);
+			   global_alpha, channel);
 
 	enable_clocks(0);
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 2efbb4f..a954a55 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -360,7 +360,7 @@ int dispc_setup_plane(enum omap_plane plane,
 		      bool ilace,
 		      enum omap_dss_rotation_type rotation_type,
 		      u8 rotation, bool mirror,
-		      u8 global_alpha);
+		      u8 global_alpha, enum omap_channel channel);
 
 bool dispc_go_busy(enum omap_channel channel);
 void dispc_go(enum omap_channel channel);
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 545e9b9..fe197a5 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -512,11 +512,14 @@ static int dss_mgr_wait_for_vsync(struct omap_overlay_manager *mgr)
 	unsigned long timeout = msecs_to_jiffies(500);
 	u32 irq;
 
-	if (mgr->device->type == OMAP_DISPLAY_TYPE_VENC)
+	if (mgr->device->type == OMAP_DISPLAY_TYPE_VENC) {
 		irq = DISPC_IRQ_EVSYNC_ODD;
-	else
-		irq = DISPC_IRQ_VSYNC;
-
+	} else {
+		if (mgr->device->channel == OMAP_DSS_CHANNEL_LCD)
+			irq = DISPC_IRQ_VSYNC;
+		else
+			irq = DISPC_IRQ_VSYNC2;
+	}
 	return omap_dispc_wait_for_irq_interruptible_timeout(irq, timeout);
 }
 
@@ -524,7 +527,6 @@ static int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 {
 	unsigned long timeout = msecs_to_jiffies(500);
 	struct manager_cache_data *mc;
-	enum omap_channel channel;
 	u32 irq;
 	int r;
 	int i;
@@ -535,7 +537,6 @@ static int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 
 	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC) {
 		irq = DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_EVSYNC_EVEN;
-		channel = OMAP_DSS_CHANNEL_DIGIT;
 	} else {
 		if (dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) {
 			enum omap_dss_update_mode mode;
@@ -543,11 +544,14 @@ static int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 			if (mode != OMAP_DSS_UPDATE_AUTO)
 				return 0;
 
-			irq = DISPC_IRQ_FRAMEDONE;
+			irq = (dssdev->channel == OMAP_DSS_CHANNEL_LCD) ?
+				DISPC_IRQ_FRAMEDONE
+				: DISPC_IRQ_FRAMEDONE2;
 		} else {
-			irq = DISPC_IRQ_VSYNC;
+			irq = (dssdev->channel == OMAP_DSS_CHANNEL_LCD) ?
+				DISPC_IRQ_VSYNC
+				: DISPC_IRQ_VSYNC2;
 		}
-		channel = OMAP_DSS_CHANNEL_LCD;
 	}
 
 	mc = &dss_cache.manager_cache[mgr->id];
@@ -594,7 +598,6 @@ static int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 {
 	unsigned long timeout = msecs_to_jiffies(500);
-	enum omap_channel channel;
 	struct overlay_cache_data *oc;
 	struct omap_dss_device *dssdev;
 	u32 irq;
@@ -611,7 +614,6 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 
 	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC) {
 		irq = DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_EVSYNC_EVEN;
-		channel = OMAP_DSS_CHANNEL_DIGIT;
 	} else {
 		if (dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) {
 			enum omap_dss_update_mode mode;
@@ -619,11 +621,14 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 			if (mode != OMAP_DSS_UPDATE_AUTO)
 				return 0;
 
-			irq = DISPC_IRQ_FRAMEDONE;
+			irq = (dssdev->channel == OMAP_DSS_CHANNEL_LCD) ?
+				DISPC_IRQ_FRAMEDONE
+				: DISPC_IRQ_FRAMEDONE2;
 		} else {
-			irq = DISPC_IRQ_VSYNC;
+			irq = (dssdev->channel == OMAP_DSS_CHANNEL_LCD) ?
+				DISPC_IRQ_VSYNC
+				: DISPC_IRQ_VSYNC2;
 		}
-		channel = OMAP_DSS_CHANNEL_LCD;
 	}
 
 	oc = &dss_cache.overlay_cache[ovl->id];
@@ -842,7 +847,8 @@ static int configure_overlay(enum omap_plane plane)
 			c->rotation_type,
 			c->rotation,
 			c->mirror,
-			c->global_alpha);
+			c->global_alpha,
+			c->channel);
 
 	if (r) {
 		/* this shouldn't happen */
@@ -894,10 +900,10 @@ static int configure_dispc(void)
 	r = 0;
 	busy = false;
 
-	mgr_busy[0] = dispc_go_busy(0);
-	mgr_busy[1] = dispc_go_busy(1);
-	mgr_go[0] = false;
-	mgr_go[1] = false;
+	for (i = 0; i < num_mgrs; i++) {
+		mgr_busy[i] = dispc_go_busy(i);
+		mgr_go[i] = false;
+	}
 
 	/* Commit overlay settings */
 	for (i = 0; i < num_ovls; ++i) {
@@ -1156,9 +1162,10 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 	const int num_mgrs = dss_feat_get_num_mgrs();
 	int i, r;
 	bool mgr_busy[MAX_DSS_MANAGERS];
+	u32 irq_mask;
 
-	mgr_busy[0] = dispc_go_busy(0);
-	mgr_busy[1] = dispc_go_busy(1);
+	for (i = 0; i < num_mgrs; i++)
+		mgr_busy[i] = dispc_go_busy(i);
 
 	spin_lock(&dss_cache.lock);
 
@@ -1189,9 +1196,12 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 			goto end;
 	}
 
-	omap_dispc_unregister_isr(dss_apply_irq_handler, NULL,
-			DISPC_IRQ_VSYNC	| DISPC_IRQ_EVSYNC_ODD |
-			DISPC_IRQ_EVSYNC_EVEN);
+	irq_mask = DISPC_IRQ_VSYNC | DISPC_IRQ_EVSYNC_ODD |
+			DISPC_IRQ_EVSYNC_EVEN;
+	if (dss_has_feature(FEAT_MGR_LCD2))
+		irq_mask |= DISPC_IRQ_VSYNC2;
+
+	omap_dispc_unregister_isr(dss_apply_irq_handler, NULL, irq_mask);
 	dss_cache.irq_enabled = false;
 
 end:
@@ -1383,9 +1393,14 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 	r = 0;
 	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
 	if (!dss_cache.irq_enabled) {
-		r = omap_dispc_register_isr(dss_apply_irq_handler, NULL,
-				DISPC_IRQ_VSYNC	| DISPC_IRQ_EVSYNC_ODD |
-				DISPC_IRQ_EVSYNC_EVEN);
+		u32 mask;
+
+		mask = DISPC_IRQ_VSYNC	| DISPC_IRQ_EVSYNC_ODD |
+			DISPC_IRQ_EVSYNC_EVEN;
+		if (dss_has_feature(FEAT_MGR_LCD2))
+			mask |= DISPC_IRQ_VSYNC2;
+
+		r = omap_dispc_register_isr(dss_apply_irq_handler, NULL, mask);
 		dss_cache.irq_enabled = true;
 	}
 	configure_dispc();
@@ -1477,6 +1492,10 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 			mgr->name = "tv";
 			mgr->id = OMAP_DSS_CHANNEL_DIGIT;
 			break;
+		case 2:
+			mgr->name = "lcd2";
+			mgr->id = OMAP_DSS_CHANNEL_LCD2;
+			break;
 		}
 
 		mgr->set_device = &omap_dss_set_device;
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 75642c2..40ef290 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -623,12 +623,22 @@ void dss_recheck_connections(struct omap_dss_device *dssdev, bool force)
 	int i;
 	struct omap_overlay_manager *lcd_mgr;
 	struct omap_overlay_manager *tv_mgr;
+	struct omap_overlay_manager *lcd2_mgr = NULL;
 	struct omap_overlay_manager *mgr = NULL;
 
 	lcd_mgr = omap_dss_get_overlay_manager(OMAP_DSS_OVL_MGR_LCD);
 	tv_mgr = omap_dss_get_overlay_manager(OMAP_DSS_OVL_MGR_TV);
-
-	if (dssdev->type != OMAP_DISPLAY_TYPE_VENC) {
+	if (cpu_is_omap44xx())
+		lcd2_mgr = omap_dss_get_overlay_manager(OMAP_DSS_OVL_MGR_LCD2);
+
+	if (dssdev->channel == OMAP_DSS_CHANNEL_LCD2) {
+		if (!lcd2_mgr->device || force) {
+			if (lcd2_mgr->device)
+				lcd2_mgr->unset_device(lcd2_mgr);
+			lcd2_mgr->set_device(lcd2_mgr, dssdev);
+			mgr = lcd2_mgr;
+		}
+	} else if (dssdev->type != OMAP_DISPLAY_TYPE_VENC) {
 		if (!lcd_mgr->device || force) {
 			if (lcd_mgr->device)
 				lcd_mgr->unset_device(lcd_mgr);
-- 
1.7.0.4


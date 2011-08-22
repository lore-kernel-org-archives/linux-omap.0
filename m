From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 02/10] OMAP: DSS2: DISPC: use lookup tables for bit shifts
Date: Mon, 22 Aug 2011 11:27:43 +0300
Message-ID: <1314001671-18123-3-git-send-email-tomi.valkeinen@ti.com>
References: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:58293 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756703Ab1HVI2H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 04:28:07 -0400
In-Reply-To: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use lookup tables instead of switch/if in some DISPC functions to make
the code cleaner.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Acked-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |  204 ++++++++++-----------------------------
 1 files changed, 50 insertions(+), 154 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 7c76370..f7451fe 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -737,6 +737,9 @@ static void _dispc_set_pre_mult_alpha(enum omap_plane plane, bool enable)
 
 static void _dispc_setup_global_alpha(enum omap_plane plane, u8 global_alpha)
 {
+	static const unsigned shifts[] = { 0, 8, 16, };
+	int shift;
+
 	if (!dss_has_feature(FEAT_GLOBAL_ALPHA))
 		return;
 
@@ -744,10 +747,8 @@ static void _dispc_setup_global_alpha(enum omap_plane plane, u8 global_alpha)
 		plane == OMAP_DSS_VIDEO1)
 		return;
 
-	if (plane == OMAP_DSS_GFX)
-		REG_FLD_MOD(DISPC_GLOBAL_ALPHA, global_alpha, 7, 0);
-	else if (plane == OMAP_DSS_VIDEO2)
-		REG_FLD_MOD(DISPC_GLOBAL_ALPHA, global_alpha, 23, 16);
+	shift = shifts[plane];
+	REG_FLD_MOD(DISPC_GLOBAL_ALPHA, global_alpha, shift + 7, shift);
 }
 
 static void _dispc_set_pix_inc(enum omap_plane plane, s32 inc)
@@ -891,21 +892,10 @@ void dispc_set_channel_out(enum omap_plane plane,
 static void dispc_set_burst_size(enum omap_plane plane,
 		enum omap_burst_size burst_size)
 {
+	static const unsigned shifts[] = { 6, 14, 14, };
 	int shift;
 
-	switch (plane) {
-	case OMAP_DSS_GFX:
-		shift = 6;
-		break;
-	case OMAP_DSS_VIDEO1:
-	case OMAP_DSS_VIDEO2:
-		shift = 14;
-		break;
-	default:
-		BUG();
-		return;
-	}
-
+	shift = shifts[plane];
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), burst_size, shift + 1, shift);
 }
 
@@ -987,14 +977,11 @@ static void _dispc_set_vid_color_conv(enum omap_plane plane, bool enable)
 
 void dispc_enable_replication(enum omap_plane plane, bool enable)
 {
-	int bit;
-
-	if (plane == OMAP_DSS_GFX)
-		bit = 5;
-	else
-		bit = 10;
+	static const unsigned shifts[] = { 5, 10, 10 };
+	int shift;
 
-	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), enable, bit, bit);
+	shift = shifts[plane];
+	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), enable, shift, shift);
 }
 
 void dispc_set_lcd_size(enum omap_channel channel, u16 width, u16 height)
@@ -3042,6 +3029,17 @@ static void dispc_error_worker(struct work_struct *work)
 	int i;
 	u32 errors;
 	unsigned long flags;
+	static const unsigned fifo_underflow_bits[] = {
+		DISPC_IRQ_GFX_FIFO_UNDERFLOW,
+		DISPC_IRQ_VID1_FIFO_UNDERFLOW,
+		DISPC_IRQ_VID2_FIFO_UNDERFLOW,
+	};
+
+	static const unsigned sync_lost_bits[] = {
+		DISPC_IRQ_SYNC_LOST,
+		DISPC_IRQ_SYNC_LOST_DIGIT,
+		DISPC_IRQ_SYNC_LOST2,
+	};
 
 	spin_lock_irqsave(&dispc.irq_lock, flags);
 	errors = dispc.error_irqs;
@@ -3050,154 +3048,52 @@ static void dispc_error_worker(struct work_struct *work)
 
 	dispc_runtime_get();
 
-	if (errors & DISPC_IRQ_GFX_FIFO_UNDERFLOW) {
-		DSSERR("GFX_FIFO_UNDERFLOW, disabling GFX\n");
-		for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
-			struct omap_overlay *ovl;
-			ovl = omap_dss_get_overlay(i);
-
-			if (ovl->id == 0) {
-				dispc_enable_plane(ovl->id, 0);
-				dispc_go(ovl->manager->id);
-				mdelay(50);
-				break;
-			}
-		}
-	}
-
-	if (errors & DISPC_IRQ_VID1_FIFO_UNDERFLOW) {
-		DSSERR("VID1_FIFO_UNDERFLOW, disabling VID1\n");
-		for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
-			struct omap_overlay *ovl;
-			ovl = omap_dss_get_overlay(i);
-
-			if (ovl->id == 1) {
-				dispc_enable_plane(ovl->id, 0);
-				dispc_go(ovl->manager->id);
-				mdelay(50);
-				break;
-			}
-		}
-	}
-
-	if (errors & DISPC_IRQ_VID2_FIFO_UNDERFLOW) {
-		DSSERR("VID2_FIFO_UNDERFLOW, disabling VID2\n");
-		for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
-			struct omap_overlay *ovl;
-			ovl = omap_dss_get_overlay(i);
-
-			if (ovl->id == 2) {
-				dispc_enable_plane(ovl->id, 0);
-				dispc_go(ovl->manager->id);
-				mdelay(50);
-				break;
-			}
-		}
-	}
-
-	if (errors & DISPC_IRQ_SYNC_LOST) {
-		struct omap_overlay_manager *manager = NULL;
-		bool enable = false;
-
-		DSSERR("SYNC_LOST, disabling LCD\n");
-
-		for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
-			struct omap_overlay_manager *mgr;
-			mgr = omap_dss_get_overlay_manager(i);
+	for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
+		struct omap_overlay *ovl;
+		unsigned bit;
 
-			if (mgr->id == OMAP_DSS_CHANNEL_LCD) {
-				manager = mgr;
-				enable = mgr->device->state ==
-						OMAP_DSS_DISPLAY_ACTIVE;
-				mgr->device->driver->disable(mgr->device);
-				break;
-			}
-		}
+		ovl = omap_dss_get_overlay(i);
+		bit = fifo_underflow_bits[i];
 
-		if (manager) {
-			struct omap_dss_device *dssdev = manager->device;
-			for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
-				struct omap_overlay *ovl;
-				ovl = omap_dss_get_overlay(i);
-
-				if (ovl->id != 0 && ovl->manager == manager)
-					dispc_enable_plane(ovl->id, 0);
-			}
-
-			dispc_go(manager->id);
+		if ((1 << bit) & errors) {
+			DSSERR("FIFO UNDERFLOW on %s, disabling the overlay\n",
+					ovl->name);
+			dispc_enable_plane(ovl->id, false);
+			dispc_go(ovl->manager->id);
 			mdelay(50);
-			if (enable)
-				dssdev->driver->enable(dssdev);
 		}
 	}
 
-	if (errors & DISPC_IRQ_SYNC_LOST_DIGIT) {
-		struct omap_overlay_manager *manager = NULL;
-		bool enable = false;
-
-		DSSERR("SYNC_LOST_DIGIT, disabling TV\n");
-
-		for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
-			struct omap_overlay_manager *mgr;
-			mgr = omap_dss_get_overlay_manager(i);
-
-			if (mgr->id == OMAP_DSS_CHANNEL_DIGIT) {
-				manager = mgr;
-				enable = mgr->device->state ==
-						OMAP_DSS_DISPLAY_ACTIVE;
-				mgr->device->driver->disable(mgr->device);
-				break;
-			}
-		}
-
-		if (manager) {
-			struct omap_dss_device *dssdev = manager->device;
-			for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
-				struct omap_overlay *ovl;
-				ovl = omap_dss_get_overlay(i);
+	for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
+		struct omap_overlay_manager *mgr;
+		unsigned bit;
 
-				if (ovl->id != 0 && ovl->manager == manager)
-					dispc_enable_plane(ovl->id, 0);
-			}
+		mgr = omap_dss_get_overlay_manager(i);
+		bit = sync_lost_bits[i];
 
-			dispc_go(manager->id);
-			mdelay(50);
-			if (enable)
-				dssdev->driver->enable(dssdev);
-		}
-	}
-
-	if (errors & DISPC_IRQ_SYNC_LOST2) {
-		struct omap_overlay_manager *manager = NULL;
-		bool enable = false;
-
-		DSSERR("SYNC_LOST for LCD2, disabling LCD2\n");
+		if ((1 << bit) & errors) {
+			struct omap_dss_device *dssdev = mgr->device;
+			bool enable;
 
-		for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
-			struct omap_overlay_manager *mgr;
-			mgr = omap_dss_get_overlay_manager(i);
+			DSSERR("SYNC_LOST on channel %s, restarting the output "
+					"with video overlays disabled\n",
+					mgr->name);
 
-			if (mgr->id == OMAP_DSS_CHANNEL_LCD2) {
-				manager = mgr;
-				enable = mgr->device->state ==
-						OMAP_DSS_DISPLAY_ACTIVE;
-				mgr->device->driver->disable(mgr->device);
-				break;
-			}
-		}
+			enable = dssdev->state == OMAP_DSS_DISPLAY_ACTIVE;
+			dssdev->driver->disable(dssdev);
 
-		if (manager) {
-			struct omap_dss_device *dssdev = manager->device;
 			for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
 				struct omap_overlay *ovl;
 				ovl = omap_dss_get_overlay(i);
 
-				if (ovl->id != 0 && ovl->manager == manager)
-					dispc_enable_plane(ovl->id, 0);
+				if (ovl->id != OMAP_DSS_GFX &&
+						ovl->manager == mgr)
+					dispc_enable_plane(ovl->id, false);
 			}
 
-			dispc_go(manager->id);
+			dispc_go(mgr->id);
 			mdelay(50);
+
 			if (enable)
 				dssdev->driver->enable(dssdev);
 		}
-- 
1.7.4.1


From: Archit Taneja <archit@ti.com>
Subject: [PATCH] [RFC][PATCH 6/8] OMAP: DSS2: Secondary LCD Channel DISPC IRQs
Date: Thu,  1 Jul 2010 16:01:23 +0530
Message-ID: <1277980285-20996-7-git-send-email-archit@ti.com>
References: <1277980285-20996-1-git-send-email-archit@ti.com>
 <1277980285-20996-2-git-send-email-archit@ti.com>
 <1277980285-20996-3-git-send-email-archit@ti.com>
 <1277980285-20996-4-git-send-email-archit@ti.com>
 <1277980285-20996-5-git-send-email-archit@ti.com>
 <1277980285-20996-6-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59980 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008Ab0GAKcC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 06:32:02 -0400
In-Reply-To: <1277980285-20996-6-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@nokia.com, Sumit Semwal <sumit.semwal@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Mukund Mittal <mmittal@ti.com>, Archit Taneja <archit@ti.com>, Samreen <samreen@ti.com>

From: Sumit Semwal <sumit.semwal@ti.com>

Introduce Secondary Channel IRQS for dumps and error handling

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Samreen <samreen@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    4 ++
 drivers/video/omap2/dss/dispc.c           |   62 +++++++++++++++++++++++++++--
 drivers/video/omap2/dss/manager.c         |   33 +++++++++++-----
 3 files changed, 85 insertions(+), 14 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index c3643f5..cfcde7d
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -42,6 +42,10 @@
 #define DISPC_IRQ_SYNC_LOST		(1 << 14)
 #define DISPC_IRQ_SYNC_LOST_DIGIT	(1 << 15)
 #define DISPC_IRQ_WAKEUP		(1 << 16)
+#define DISPC_IRQ_SYNC_LOST_2  (1 << 17)
+#define DISPC_IRQ_VSYNC2		(1 << 18)
+#define DISPC_IRQ_ACBIAS_COUNT_STAT2	(1 << 21)
+#define DISPC_IRQ_FRAMEDONE2		(1 << 22)
 
 struct omap_dss_device;
 struct omap_overlay_manager;
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 22fd2c2..785b8c1
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -134,7 +134,9 @@ struct dispc_reg { u16 idx; };
 					 DISPC_IRQ_VID1_FIFO_UNDERFLOW | \
 					 DISPC_IRQ_VID2_FIFO_UNDERFLOW | \
 					 DISPC_IRQ_SYNC_LOST | \
-					 DISPC_IRQ_SYNC_LOST_DIGIT)
+					DISPC_IRQ_SYNC_LOST_DIGIT | \
+					(cpu_is_omap44xx() ? \
+					DISPC_IRQ_SYNC_LOST_2 : 0))
 
 /* OMAP4 new global registers */
 #define DISPC_CONTROL2		DISPC_REG(0x0238)
@@ -1819,20 +1821,27 @@ static void dispc_enable_lcd_out(enum omap_channel channel, bool enable)
 	struct completion frame_done_completion;
 	bool is_on;
 	int r;
+	int irq;
 
 	enable_clocks(1);
 
 	/* When we disable LCD output, we need to wait until frame is done.
 	 * Otherwise the DSS is still working, and turning off the clocks
 	 * prevents DSS from going to OFF mode */
-	is_on = REG_GET(DISPC_CONTROL, 0, 0);
+	if (OMAP_DSS_CHANNEL_LCD2 == channel) {
+		is_on = REG_GET(DISPC_CONTROL2, 0, 0);
+		irq = DISPC_IRQ_FRAMEDONE2;
+	} else {
+		is_on = REG_GET(DISPC_CONTROL, 0, 0);
+		irq = DISPC_IRQ_FRAMEDONE;
+	}
 
 	if (!enable && is_on) {
 		init_completion(&frame_done_completion);
 
 		r = omap_dispc_register_isr(dispc_disable_isr,
 				&frame_done_completion,
-				DISPC_IRQ_FRAMEDONE);
+				irq);
 
 		if (r)
 			DSSERR("failed to register FRAMEDONE isr\n");
@@ -1847,7 +1856,7 @@ static void dispc_enable_lcd_out(enum omap_channel channel, bool enable)
 
 		r = omap_dispc_unregister_isr(dispc_disable_isr,
 				&frame_done_completion,
-				DISPC_IRQ_FRAMEDONE);
+				irq);
 
 		if (r)
 			DSSERR("failed to unregister FRAMEDONE isr\n");
@@ -2482,6 +2491,12 @@ void dispc_dump_irqs(struct seq_file *s)
 	PIS(SYNC_LOST);
 	PIS(SYNC_LOST_DIGIT);
 	PIS(WAKEUP);
+	if (cpu_is_omap44xx()) {
+		PIS(FRAMEDONE2);
+		PIS(VSYNC2);
+		PIS(ACBIAS_COUNT_STAT2);
+		PIS(SYNC_LOST_2);
+	}
 #undef PIS
 }
 #endif
@@ -3089,6 +3104,45 @@ static void dispc_error_worker(struct work_struct *work)
 		}
 	}
 
+	if (errors & DISPC_IRQ_SYNC_LOST_2) {
+		struct omap_overlay_manager *manager = NULL;
+		bool enable = false;
+
+		DSSERR("SYNC_LOST for LCD2, disabling LCD2\n");
+
+		for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
+			struct omap_overlay_manager *mgr;
+			mgr = omap_dss_get_overlay_manager(i);
+
+			if (mgr->id == OMAP_DSS_CHANNEL_LCD2) {
+				manager = mgr;
+				enable = mgr->device->state ==
+						OMAP_DSS_DISPLAY_ACTIVE;
+				mgr->device->driver->disable(mgr->device);
+				break;
+			}
+		}
+
+		if (manager) {
+			for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
+				struct omap_overlay *ovl;
+				ovl = omap_dss_get_overlay(i);
+
+				if (!(ovl->caps & OMAP_DSS_OVL_CAP_DISPC))
+					continue;
+
+				if (ovl->id != 0 && ovl->manager == manager)
+					dispc_enable_plane(ovl->id, 0);
+			}
+
+			dispc_go(manager->id);
+			mdelay(50);
+			if (enable)
+				manager->device->driver->enable(
+							manager->device);
+		}
+	}
+
 	if (errors & DISPC_IRQ_SYNC_LOST_DIGIT) {
 		struct omap_overlay_manager *manager = NULL;
 		bool enable = false;
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 2636b7f..0166b76
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -513,11 +513,14 @@ static int dss_mgr_wait_for_vsync(struct omap_overlay_manager *mgr)
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
 
@@ -543,9 +546,13 @@ static int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 			if (mode != OMAP_DSS_UPDATE_AUTO)
 				return 0;
 
-			irq = DISPC_IRQ_FRAMEDONE;
+			irq = (channel == OMAP_DSS_CHANNEL_LCD) ?
+				DISPC_IRQ_FRAMEDONE
+				: DISPC_IRQ_FRAMEDONE2;
 		} else {
-			irq = DISPC_IRQ_VSYNC;
+			irq = (channel == OMAP_DSS_CHANNEL_LCD) ?
+				DISPC_IRQ_VSYNC
+				: DISPC_IRQ_VSYNC2;
 		}
 	}
 
@@ -618,9 +625,13 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 			if (mode != OMAP_DSS_UPDATE_AUTO)
 				return 0;
 
-			irq = DISPC_IRQ_FRAMEDONE;
+			irq = (channel == OMAP_DSS_CHANNEL_LCD) ?
+				DISPC_IRQ_FRAMEDONE
+				: DISPC_IRQ_FRAMEDONE2;
 		} else {
-			irq = DISPC_IRQ_VSYNC;
+			irq = (channel == OMAP_DSS_CHANNEL_LCD) ?
+				DISPC_IRQ_VSYNC
+				: DISPC_IRQ_VSYNC2;
 		}
 	}
 
@@ -1190,7 +1201,8 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 
 	omap_dispc_unregister_isr(dss_apply_irq_handler, NULL,
 			DISPC_IRQ_VSYNC	| DISPC_IRQ_EVSYNC_ODD |
-			DISPC_IRQ_EVSYNC_EVEN);
+			DISPC_IRQ_EVSYNC_EVEN | (cpu_is_omap44xx()) ?
+			DISPC_IRQ_VSYNC2 : 0);
 	dss_cache.irq_enabled = false;
 
 end:
@@ -1384,7 +1396,8 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 	if (!dss_cache.irq_enabled) {
 		r = omap_dispc_register_isr(dss_apply_irq_handler, NULL,
 				DISPC_IRQ_VSYNC	| DISPC_IRQ_EVSYNC_ODD |
-				DISPC_IRQ_EVSYNC_EVEN);
+				DISPC_IRQ_EVSYNC_EVEN |
+				(cpu_is_omap44xx()) ? DISPC_IRQ_VSYNC2 : 0);
 		dss_cache.irq_enabled = true;
 	}
 	configure_dispc();
-- 
1.5.4.7


From: Archit Taneja <archit@ti.com>
Subject: [RFC v2][PATCH 5/7] OMAP: DSS2: Secondary LCD Channel DISPC IRQs
Date: Wed, 14 Jul 2010 12:02:45 +0530
Message-ID: <1279089167-14057-6-git-send-email-archit@ti.com>
References: <1279089167-14057-1-git-send-email-archit@ti.com>
 <1279089167-14057-2-git-send-email-archit@ti.com>
 <1279089167-14057-3-git-send-email-archit@ti.com>
 <1279089167-14057-4-git-send-email-archit@ti.com>
 <1279089167-14057-5-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40958 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738Ab0GNGdS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Jul 2010 02:33:18 -0400
In-Reply-To: <1279089167-14057-5-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Sumit Semwal <sumit.semwal@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Mukund Mittal <mmittal@ti.com>, Archit Taneja <archit@ti.com>, Samreen <samreen@ti.com>

From: Sumit Semwal <sumit.semwal@ti.com>

Introduce Secondary Channel IRQS for dumps and error handling

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Samreen <samreen@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    4 ++
 drivers/video/omap2/dss/dispc.c           |   59 +++++++++++++++++++++++++++-
 drivers/video/omap2/dss/manager.c         |   33 +++++++++++-----
 3 files changed, 83 insertions(+), 13 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index c3643f5..56e7045 
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -42,6 +42,10 @@
 #define DISPC_IRQ_SYNC_LOST		(1 << 14)
 #define DISPC_IRQ_SYNC_LOST_DIGIT	(1 << 15)
 #define DISPC_IRQ_WAKEUP		(1 << 16)
+#define DISPC_IRQ_SYNC_LOST_2  (1 << 17)
+#define DISPC_IRQ_VSYNC2               (1 << 18)
+#define DISPC_IRQ_ACBIAS_COUNT_STAT2   (1 << 21)
+#define DISPC_IRQ_FRAMEDONE2           (1 << 22)
 
 struct omap_dss_device;
 struct omap_overlay_manager;
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 060768a..c7811b4 
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -144,7 +144,9 @@ struct dispc_reg { u16 idx; };
 					 DISPC_IRQ_VID1_FIFO_UNDERFLOW | \
 					 DISPC_IRQ_VID2_FIFO_UNDERFLOW | \
 					 DISPC_IRQ_SYNC_LOST | \
-					 DISPC_IRQ_SYNC_LOST_DIGIT)
+					 DISPC_IRQ_SYNC_LOST_DIGIT | \
+					 (cpu_is_omap44xx() ? \
+					 DISPC_IRQ_SYNC_LOST_2 : 0))
 
 #define DISPC_MAX_NR_ISRS		8
 
@@ -1788,6 +1790,7 @@ static void dispc_enable_lcd_out(enum omap_channel channel, bool enable)
 	struct completion frame_done_completion;
 	bool is_on;
 	int r;
+	int irq;
 
 	enable_clocks(1);
 
@@ -1796,12 +1799,17 @@ static void dispc_enable_lcd_out(enum omap_channel channel, bool enable)
 	 * prevents DSS from going to OFF mode */
 	is_on = REG_GET(DISPC_CONTROL(channel), 0, 0);
 
+	if (OMAP_DSS_CHANNEL_LCD2 == channel)
+		irq = DISPC_IRQ_FRAMEDONE2;
+	else
+		irq = DISPC_IRQ_FRAMEDONE;
+
 	if (!enable && is_on) {
 		init_completion(&frame_done_completion);
 
 		r = omap_dispc_register_isr(dispc_disable_isr,
 				&frame_done_completion,
-				DISPC_IRQ_FRAMEDONE);
+				irq);
 
 		if (r)
 			DSSERR("failed to register FRAMEDONE isr\n");
@@ -1816,7 +1824,7 @@ static void dispc_enable_lcd_out(enum omap_channel channel, bool enable)
 
 		r = omap_dispc_unregister_isr(dispc_disable_isr,
 				&frame_done_completion,
-				DISPC_IRQ_FRAMEDONE);
+				irq);
 
 		if (r)
 			DSSERR("failed to unregister FRAMEDONE isr\n");
@@ -2412,6 +2420,12 @@ void dispc_dump_irqs(struct seq_file *s)
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
@@ -3013,6 +3027,45 @@ static void dispc_error_worker(struct work_struct *work)
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
index 8b6ff98..96073f5 
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
1.6.3.3


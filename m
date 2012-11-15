From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 31/32] OMAPDSS: export dispc functions
Date: Thu, 15 Nov 2012 17:58:39 +0200
Message-ID: <1352995120-3288-32-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50153 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768325Ab2KOQAD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 11:00:03 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Export DISPC functions.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   23 +++++++++++++++++++++++
 drivers/video/omap2/dss/dss.h   |   36 +-----------------------------------
 include/video/omapdss.h         |   39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 35 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 15ef1d1..1a29854 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -490,6 +490,7 @@ int dispc_runtime_get(void)
 	WARN_ON(r < 0);
 	return r < 0 ? r : 0;
 }
+EXPORT_SYMBOL(dispc_runtime_get);
 
 void dispc_runtime_put(void)
 {
@@ -500,11 +501,13 @@ void dispc_runtime_put(void)
 	r = pm_runtime_put_sync(&dispc.pdev->dev);
 	WARN_ON(r < 0 && r != -ENOSYS);
 }
+EXPORT_SYMBOL(dispc_runtime_put);
 
 u32 dispc_mgr_get_vsync_irq(enum omap_channel channel)
 {
 	return mgr_desc[channel].vsync_irq;
 }
+EXPORT_SYMBOL(dispc_mgr_get_vsync_irq);
 
 u32 dispc_mgr_get_framedone_irq(enum omap_channel channel)
 {
@@ -513,11 +516,13 @@ u32 dispc_mgr_get_framedone_irq(enum omap_channel channel)
 
 	return mgr_desc[channel].framedone_irq;
 }
+EXPORT_SYMBOL(dispc_mgr_get_framedone_irq);
 
 u32 dispc_mgr_get_sync_lost_irq(enum omap_channel channel)
 {
 	return mgr_desc[channel].sync_lost_irq;
 }
+EXPORT_SYMBOL(dispc_mgr_get_sync_lost_irq);
 
 u32 dispc_wb_get_framedone_irq(void)
 {
@@ -528,6 +533,7 @@ bool dispc_mgr_go_busy(enum omap_channel channel)
 {
 	return mgr_fld_read(channel, DISPC_MGR_FLD_GO) == 1;
 }
+EXPORT_SYMBOL(dispc_mgr_go_busy);
 
 void dispc_mgr_go(enum omap_channel channel)
 {
@@ -538,6 +544,7 @@ void dispc_mgr_go(enum omap_channel channel)
 
 	mgr_fld_write(channel, DISPC_MGR_FLD_GO, 1);
 }
+EXPORT_SYMBOL(dispc_mgr_go);
 
 bool dispc_wb_go_busy(void)
 {
@@ -941,6 +948,7 @@ void dispc_ovl_set_channel_out(enum omap_plane plane, enum omap_channel channel)
 	}
 	dispc_write_reg(DISPC_OVL_ATTRIBUTES(plane), val);
 }
+EXPORT_SYMBOL(dispc_ovl_set_channel_out);
 
 static enum omap_channel dispc_ovl_get_channel_out(enum omap_plane plane)
 {
@@ -2353,6 +2361,7 @@ int dispc_ovl_check(enum omap_plane plane, enum omap_channel channel,
 			&five_taps, x_predecim, y_predecim, pos_x,
 			oi->rotation_type, false);
 }
+EXPORT_SYMBOL(dispc_ovl_check);
 
 static int dispc_ovl_setup_common(enum omap_plane plane,
 		enum omap_overlay_caps caps, u32 paddr, u32 p_uv_addr,
@@ -2533,6 +2542,7 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 
 	return r;
 }
+EXPORT_SYMBOL(dispc_ovl_setup);
 
 int dispc_wb_setup(const struct omap_dss_writeback_info *wi,
 		bool mem_to_mem, const struct omap_video_timings *mgr_timings)
@@ -2593,11 +2603,13 @@ int dispc_ovl_enable(enum omap_plane plane, bool enable)
 
 	return 0;
 }
+EXPORT_SYMBOL(dispc_ovl_enable);
 
 bool dispc_ovl_enabled(enum omap_plane plane)
 {
 	return REG_GET(DISPC_OVL_ATTRIBUTES(plane), 0, 0);
 }
+EXPORT_SYMBOL(dispc_ovl_enabled);
 
 void dispc_mgr_enable(enum omap_channel channel, bool enable)
 {
@@ -2605,11 +2617,13 @@ void dispc_mgr_enable(enum omap_channel channel, bool enable)
 	/* flush posted write */
 	mgr_fld_read(channel, DISPC_MGR_FLD_ENABLE);
 }
+EXPORT_SYMBOL(dispc_mgr_enable);
 
 bool dispc_mgr_is_enabled(enum omap_channel channel)
 {
 	return !!mgr_fld_read(channel, DISPC_MGR_FLD_ENABLE);
 }
+EXPORT_SYMBOL(dispc_mgr_is_enabled);
 
 void dispc_wb_enable(bool enable)
 {
@@ -2706,6 +2720,7 @@ void dispc_mgr_setup(enum omap_channel channel,
 		dispc_mgr_set_cpr_coef(channel, &info->cpr_coefs);
 	}
 }
+EXPORT_SYMBOL(dispc_mgr_setup);
 
 static void dispc_mgr_set_tft_data_lines(enum omap_channel channel, u8 data_lines)
 {
@@ -2782,6 +2797,7 @@ void dispc_mgr_set_lcd_config(enum omap_channel channel,
 
 	dispc_mgr_set_lcd_type_tft(channel);
 }
+EXPORT_SYMBOL(dispc_mgr_set_lcd_config);
 
 static bool _dispc_mgr_size_ok(u16 width, u16 height)
 {
@@ -2920,6 +2936,7 @@ void dispc_mgr_set_timings(enum omap_channel channel,
 
 	dispc_mgr_set_size(channel, t.x_res, t.y_res);
 }
+EXPORT_SYMBOL(dispc_mgr_set_timings);
 
 static void dispc_mgr_set_lcd_divisor(enum omap_channel channel, u16 lck_div,
 		u16 pck_div)
@@ -3383,16 +3400,19 @@ u32 dispc_read_irqstatus(void)
 {
 	return dispc_read_reg(DISPC_IRQSTATUS);
 }
+EXPORT_SYMBOL(dispc_read_irqstatus);
 
 void dispc_clear_irqstatus(u32 mask)
 {
 	dispc_write_reg(DISPC_IRQSTATUS, mask);
 }
+EXPORT_SYMBOL(dispc_clear_irqstatus);
 
 u32 dispc_read_irqenable(void)
 {
 	return dispc_read_reg(DISPC_IRQENABLE);
 }
+EXPORT_SYMBOL(dispc_read_irqenable);
 
 void dispc_write_irqenable(u32 mask)
 {
@@ -3403,6 +3423,7 @@ void dispc_write_irqenable(u32 mask)
 
 	dispc_write_reg(DISPC_IRQENABLE, mask);
 }
+EXPORT_SYMBOL(dispc_write_irqenable);
 
 void dispc_enable_sidle(void)
 {
@@ -3545,11 +3566,13 @@ int dispc_request_irq(irq_handler_t handler, void *dev_id)
 	return devm_request_irq(&dispc.pdev->dev, dispc.irq, handler,
 			     IRQF_SHARED, "OMAP DISPC", dev_id);
 }
+EXPORT_SYMBOL(dispc_request_irq);
 
 void dispc_free_irq(void *dev_id)
 {
 	devm_free_irq(&dispc.pdev->dev, dispc.irq, dev_id);
 }
+EXPORT_SYMBOL(dispc_free_irq);
 
 /* DISPC HW IP initialisation */
 static int __init omap_dispchw_probe(struct platform_device *pdev)
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index aac53994..a7b0e92 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -370,16 +370,6 @@ void dpi_uninit_platform_driver(void) __exit;
 int dispc_init_platform_driver(void) __init;
 void dispc_uninit_platform_driver(void) __exit;
 void dispc_dump_clocks(struct seq_file *s);
-u32 dispc_read_irqstatus(void);
-void dispc_clear_irqstatus(u32 mask);
-u32 dispc_read_irqenable(void);
-void dispc_write_irqenable(u32 mask);
-
-int dispc_request_irq(irq_handler_t handler, void *dev_id);
-void dispc_free_irq(void *dev_id);
-
-int dispc_runtime_get(void);
-void dispc_runtime_put(void);
 
 void dispc_enable_sidle(void);
 void dispc_disable_sidle(void);
@@ -403,29 +393,7 @@ void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high);
 void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
 		u32 *fifo_low, u32 *fifo_high, bool use_fifomerge,
 		bool manual_update);
-int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
-		bool replication, const struct omap_video_timings *mgr_timings,
-		bool mem_to_mem);
-int dispc_ovl_enable(enum omap_plane plane, bool enable);
-bool dispc_ovl_enabled(enum omap_plane plane);
-void dispc_ovl_set_channel_out(enum omap_plane plane,
-		enum omap_channel channel);
-int dispc_ovl_check(enum omap_plane plane, enum omap_channel channel,
-		const struct omap_overlay_info *oi,
-		const struct omap_video_timings *timings,
-		int *x_predecim, int *y_predecim);
-
-u32 dispc_mgr_get_vsync_irq(enum omap_channel channel);
-u32 dispc_mgr_get_framedone_irq(enum omap_channel channel);
-u32 dispc_mgr_get_sync_lost_irq(enum omap_channel channel);
-bool dispc_mgr_go_busy(enum omap_channel channel);
-void dispc_mgr_go(enum omap_channel channel);
-void dispc_mgr_enable(enum omap_channel channel, bool enable);
-bool dispc_mgr_is_enabled(enum omap_channel channel);
-void dispc_mgr_set_lcd_config(enum omap_channel channel,
-		const struct dss_lcd_mgr_config *config);
-void dispc_mgr_set_timings(enum omap_channel channel,
-		const struct omap_video_timings *timings);
+
 unsigned long dispc_mgr_lclk_rate(enum omap_channel channel);
 unsigned long dispc_mgr_pclk_rate(enum omap_channel channel);
 unsigned long dispc_core_clk_rate(void);
@@ -433,8 +401,6 @@ void dispc_mgr_set_clock_div(enum omap_channel channel,
 		const struct dispc_clock_info *cinfo);
 int dispc_mgr_get_clock_div(enum omap_channel channel,
 		struct dispc_clock_info *cinfo);
-void dispc_mgr_setup(enum omap_channel channel,
-		const struct omap_overlay_manager_info *info);
 
 u32 dispc_wb_get_framedone_irq(void);
 bool dispc_wb_go_busy(void);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 60077f4..3c7fa6d 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -21,6 +21,7 @@
 #include <linux/list.h>
 #include <linux/kobject.h>
 #include <linux/device.h>
+#include <linux/interrupt.h>
 
 #define DISPC_IRQ_FRAMEDONE		(1 << 0)
 #define DISPC_IRQ_VSYNC			(1 << 1)
@@ -783,6 +784,44 @@ typedef void (*omap_dispc_isr_t) (void *arg, u32 mask);
 int omap_dispc_register_isr(omap_dispc_isr_t isr, void *arg, u32 mask);
 int omap_dispc_unregister_isr(omap_dispc_isr_t isr, void *arg, u32 mask);
 
+u32 dispc_read_irqstatus(void);
+void dispc_clear_irqstatus(u32 mask);
+u32 dispc_read_irqenable(void);
+void dispc_write_irqenable(u32 mask);
+
+int dispc_request_irq(irq_handler_t handler, void *dev_id);
+void dispc_free_irq(void *dev_id);
+
+int dispc_runtime_get(void);
+void dispc_runtime_put(void);
+
+void dispc_mgr_enable(enum omap_channel channel, bool enable);
+bool dispc_mgr_is_enabled(enum omap_channel channel);
+u32 dispc_mgr_get_vsync_irq(enum omap_channel channel);
+u32 dispc_mgr_get_framedone_irq(enum omap_channel channel);
+u32 dispc_mgr_get_sync_lost_irq(enum omap_channel channel);
+bool dispc_mgr_go_busy(enum omap_channel channel);
+void dispc_mgr_go(enum omap_channel channel);
+void dispc_mgr_set_lcd_config(enum omap_channel channel,
+		const struct dss_lcd_mgr_config *config);
+void dispc_mgr_set_timings(enum omap_channel channel,
+		const struct omap_video_timings *timings);
+void dispc_mgr_setup(enum omap_channel channel,
+		const struct omap_overlay_manager_info *info);
+
+int dispc_ovl_check(enum omap_plane plane, enum omap_channel channel,
+		const struct omap_overlay_info *oi,
+		const struct omap_video_timings *timings,
+		int *x_predecim, int *y_predecim);
+
+int dispc_ovl_enable(enum omap_plane plane, bool enable);
+bool dispc_ovl_enabled(enum omap_plane plane);
+void dispc_ovl_set_channel_out(enum omap_plane plane,
+		enum omap_channel channel);
+int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
+		bool replication, const struct omap_video_timings *mgr_timings,
+		bool mem_to_mem);
+
 #define to_dss_driver(x) container_of((x), struct omap_dss_driver, driver)
 #define to_dss_device(x) container_of((x), struct omap_dss_device, dev)
 
-- 
1.7.10.4


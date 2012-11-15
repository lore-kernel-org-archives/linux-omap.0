From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 29/32] OMAPDSS: export dss_mgr_ops functions
Date: Thu, 15 Nov 2012 17:58:37 +0200
Message-ID: <1352995120-3288-30-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59148 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768316Ab2KOP77 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 10:59:59 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Export dss_mgr_ops related functions.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.h    |   30 ------------------------------
 drivers/video/omap2/dss/output.c |    9 +++++++++
 include/video/omapdss.h          |   29 +++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 8004bdf..aac53994 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -180,19 +180,6 @@ void dss_put_device(struct omap_dss_device *dssdev);
 void dss_copy_device_pdata(struct omap_dss_device *dst,
 		const struct omap_dss_device *src);
 
-/* apply */
-void dss_mgr_start_update(struct omap_overlay_manager *mgr);
-int dss_mgr_enable(struct omap_overlay_manager *mgr);
-void dss_mgr_disable(struct omap_overlay_manager *mgr);
-void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
-		const struct omap_video_timings *timings);
-void dss_mgr_set_lcd_config(struct omap_overlay_manager *mgr,
-		const struct dss_lcd_mgr_config *config);
-int dss_mgr_register_framedone_handler(struct omap_overlay_manager *mgr,
-		void (*handler)(void *), void *data);
-void dss_mgr_unregister_framedone_handler(struct omap_overlay_manager *mgr,
-		void (*handler)(void *), void *data);
-
 /* output */
 void dss_register_output(struct omap_dss_output *out);
 void dss_unregister_output(struct omap_dss_output *out);
@@ -534,21 +521,4 @@ static inline void dss_collect_irq_stats(u32 irqstatus, unsigned *irq_arr)
 }
 #endif
 
-struct dss_mgr_ops {
-	void (*start_update)(struct omap_overlay_manager *mgr);
-	int (*enable)(struct omap_overlay_manager *mgr);
-	void (*disable)(struct omap_overlay_manager *mgr);
-	void (*set_timings)(struct omap_overlay_manager *mgr,
-			const struct omap_video_timings *timings);
-	void (*set_lcd_config)(struct omap_overlay_manager *mgr,
-			const struct dss_lcd_mgr_config *config);
-	int (*register_framedone_handler)(struct omap_overlay_manager *mgr,
-			void (*handler)(void *), void *data);
-	void (*unregister_framedone_handler)(struct omap_overlay_manager *mgr,
-			void (*handler)(void *), void *data);
-};
-
-int dss_install_mgr_ops(const struct dss_mgr_ops *mgr_ops);
-void dss_uninstall_mgr_ops(void);
-
 #endif
diff --git a/drivers/video/omap2/dss/output.c b/drivers/video/omap2/dss/output.c
index accb865..26d3f40 100644
--- a/drivers/video/omap2/dss/output.c
+++ b/drivers/video/omap2/dss/output.c
@@ -158,47 +158,56 @@ int dss_install_mgr_ops(const struct dss_mgr_ops *mgr_ops)
 
 	return 0;
 }
+EXPORT_SYMBOL(dss_install_mgr_ops);
 
 void dss_uninstall_mgr_ops(void)
 {
 	dss_mgr_ops = NULL;
 }
+EXPORT_SYMBOL(dss_uninstall_mgr_ops);
 
 void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
 		const struct omap_video_timings *timings)
 {
 	dss_mgr_ops->set_timings(mgr, timings);
 }
+EXPORT_SYMBOL(dss_mgr_set_timings);
 
 void dss_mgr_set_lcd_config(struct omap_overlay_manager *mgr,
 		const struct dss_lcd_mgr_config *config)
 {
 	dss_mgr_ops->set_lcd_config(mgr, config);
 }
+EXPORT_SYMBOL(dss_mgr_set_lcd_config);
 
 int dss_mgr_enable(struct omap_overlay_manager *mgr)
 {
 	return dss_mgr_ops->enable(mgr);
 }
+EXPORT_SYMBOL(dss_mgr_enable);
 
 void dss_mgr_disable(struct omap_overlay_manager *mgr)
 {
 	dss_mgr_ops->disable(mgr);
 }
+EXPORT_SYMBOL(dss_mgr_disable);
 
 void dss_mgr_start_update(struct omap_overlay_manager *mgr)
 {
 	dss_mgr_ops->start_update(mgr);
 }
+EXPORT_SYMBOL(dss_mgr_start_update);
 
 int dss_mgr_register_framedone_handler(struct omap_overlay_manager *mgr,
 		void (*handler)(void *), void *data)
 {
 	return dss_mgr_ops->register_framedone_handler(mgr, handler, data);
 }
+EXPORT_SYMBOL(dss_mgr_register_framedone_handler);
 
 void dss_mgr_unregister_framedone_handler(struct omap_overlay_manager *mgr,
 		void (*handler)(void *), void *data)
 {
 	dss_mgr_ops->unregister_framedone_handler(mgr, handler, data);
 }
+EXPORT_SYMBOL(dss_mgr_unregister_framedone_handler);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 823a07b..d1bf3bc 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -55,6 +55,7 @@
 
 struct omap_dss_device;
 struct omap_overlay_manager;
+struct dss_lcd_mgr_config;
 struct snd_aes_iec958;
 struct snd_cea_861_aud_if;
 
@@ -835,4 +836,32 @@ void omapdss_rfbi_set_interface_timings(struct omap_dss_device *dssdev,
 int omapdss_compat_init(void);
 void omapdss_compat_uninit(void);
 
+struct dss_mgr_ops {
+	void (*start_update)(struct omap_overlay_manager *mgr);
+	int (*enable)(struct omap_overlay_manager *mgr);
+	void (*disable)(struct omap_overlay_manager *mgr);
+	void (*set_timings)(struct omap_overlay_manager *mgr,
+			const struct omap_video_timings *timings);
+	void (*set_lcd_config)(struct omap_overlay_manager *mgr,
+			const struct dss_lcd_mgr_config *config);
+	int (*register_framedone_handler)(struct omap_overlay_manager *mgr,
+			void (*handler)(void *), void *data);
+	void (*unregister_framedone_handler)(struct omap_overlay_manager *mgr,
+			void (*handler)(void *), void *data);
+};
+
+int dss_install_mgr_ops(const struct dss_mgr_ops *mgr_ops);
+void dss_uninstall_mgr_ops(void);
+
+void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
+		const struct omap_video_timings *timings);
+void dss_mgr_set_lcd_config(struct omap_overlay_manager *mgr,
+		const struct dss_lcd_mgr_config *config);
+int dss_mgr_enable(struct omap_overlay_manager *mgr);
+void dss_mgr_disable(struct omap_overlay_manager *mgr);
+void dss_mgr_start_update(struct omap_overlay_manager *mgr);
+int dss_mgr_register_framedone_handler(struct omap_overlay_manager *mgr,
+		void (*handler)(void *), void *data);
+void dss_mgr_unregister_framedone_handler(struct omap_overlay_manager *mgr,
+		void (*handler)(void *), void *data);
 #endif
-- 
1.7.10.4


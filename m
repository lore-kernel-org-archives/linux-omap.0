From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 36/65] OMAPDSS: APPLY: rename dss_cache to dss_data
Date: Tue, 22 Nov 2011 11:21:35 +0200
Message-ID: <1321953724-6350-37-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:43947 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757932Ab1KVJXz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:23:55 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

dss_cache struct contains private data used to manage dispc. "cache" is
not a good word for it, so rename it to dss_data.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 17639c0..46d6a5c 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -38,7 +38,7 @@
  *        apply()
  *          v
  * +--------------------+
- * |     dss_cache      |
+ * |       info         |
  * +--------------------+
  *          v
  *      write_regs()
@@ -93,19 +93,19 @@ static struct {
 	struct mgr_priv_data mgr_priv_data_array[MAX_DSS_MANAGERS];
 
 	bool irq_enabled;
-} dss_cache;
+} dss_data;
 
-/* protects dss_cache */
+/* protects dss_data */
 static spinlock_t data_lock;
 
 static struct ovl_priv_data *get_ovl_priv(struct omap_overlay *ovl)
 {
-	return &dss_cache.ovl_priv_data_array[ovl->id];
+	return &dss_data.ovl_priv_data_array[ovl->id];
 }
 
 static struct mgr_priv_data *get_mgr_priv(struct omap_overlay_manager *mgr)
 {
-	return &dss_cache.mgr_priv_data_array[mgr->id];
+	return &dss_data.mgr_priv_data_array[mgr->id];
 }
 
 void dss_apply_init(void)
@@ -433,7 +433,7 @@ static void dss_register_vsync_isr(void)
 	r = omap_dispc_register_isr(dss_apply_irq_handler, NULL, mask);
 	WARN_ON(r);
 
-	dss_cache.irq_enabled = true;
+	dss_data.irq_enabled = true;
 }
 
 static void dss_unregister_vsync_isr(void)
@@ -449,7 +449,7 @@ static void dss_unregister_vsync_isr(void)
 	r = omap_dispc_unregister_isr(dss_apply_irq_handler, NULL, mask);
 	WARN_ON(r);
 
-	dss_cache.irq_enabled = false;
+	dss_data.irq_enabled = false;
 }
 
 static void dss_apply_irq_handler(void *data, u32 mask)
@@ -637,7 +637,7 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 
 	r = 0;
 	if (mgr->enabled && !mgr_manual_update(mgr)) {
-		if (!dss_cache.irq_enabled)
+		if (!dss_data.irq_enabled)
 			dss_register_vsync_isr();
 
 		dss_write_regs();
-- 
1.7.4.1


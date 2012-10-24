From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/20] OMAPDSS: DISPC: rename dispc_mgr_enable/disable to _sync
Date: Wed, 24 Oct 2012 12:28:58 +0300
Message-ID: <1351070951-18616-8-git-send-email-tomi.valkeinen@ti.com>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59706 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933474Ab2JXJ3g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Oct 2012 05:29:36 -0400
In-Reply-To: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The current dispc_mgr_enable/disable function are blocking, and do a bit
too much for omapdrm. We'll expose new enable & disable functions that
will just set the bits in the registers in the following patches.

This patch renames the current functions to *_sync, to make it clear
that they are blocking, and also to free up the dispc_mgr_enable/disable
names for these new functions.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |    6 +++---
 drivers/video/omap2/dss/dispc.c |    4 ++--
 drivers/video/omap2/dss/dss.h   |    4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 7a61a2f..6a21443 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -772,7 +772,7 @@ void dss_mgr_start_update(struct omap_overlay_manager *mgr)
 	if (!dss_data.irq_enabled && need_isr())
 		dss_register_vsync_isr();
 
-	dispc_mgr_enable(mgr->id);
+	dispc_mgr_enable_sync(mgr->id);
 
 	mgr_clear_shadow_dirty(mgr);
 
@@ -1027,7 +1027,7 @@ int dss_mgr_enable(struct omap_overlay_manager *mgr)
 	spin_unlock_irqrestore(&data_lock, flags);
 
 	if (!mgr_manual_update(mgr))
-		dispc_mgr_enable(mgr->id);
+		dispc_mgr_enable_sync(mgr->id);
 
 out:
 	mutex_unlock(&apply_lock);
@@ -1052,7 +1052,7 @@ void dss_mgr_disable(struct omap_overlay_manager *mgr)
 		goto out;
 
 	if (!mgr_manual_update(mgr))
-		dispc_mgr_disable(mgr->id);
+		dispc_mgr_disable_sync(mgr->id);
 
 	spin_lock_irqsave(&data_lock, flags);
 
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 392445a..600a412 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2755,7 +2755,7 @@ static void dispc_mgr_disable_digit_out(void)
 		DSSERR("failed to unregister %x isr\n", irq_mask);
 }
 
-void dispc_mgr_enable(enum omap_channel channel)
+void dispc_mgr_enable_sync(enum omap_channel channel)
 {
 	if (dss_mgr_is_lcd(channel))
 		dispc_mgr_enable_lcd_out(channel);
@@ -2765,7 +2765,7 @@ void dispc_mgr_enable(enum omap_channel channel)
 		WARN_ON(1);
 }
 
-void dispc_mgr_disable(enum omap_channel channel)
+void dispc_mgr_disable_sync(enum omap_channel channel)
 {
 	if (dss_mgr_is_lcd(channel))
 		dispc_mgr_disable_lcd_out(channel);
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 00e0a36..efe8984 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -437,8 +437,8 @@ u32 dispc_mgr_get_sync_lost_irq(enum omap_channel channel);
 bool dispc_mgr_go_busy(enum omap_channel channel);
 void dispc_mgr_go(enum omap_channel channel);
 bool dispc_mgr_is_enabled(enum omap_channel channel);
-void dispc_mgr_enable(enum omap_channel channel);
-void dispc_mgr_disable(enum omap_channel channel);
+void dispc_mgr_enable_sync(enum omap_channel channel);
+void dispc_mgr_disable_sync(enum omap_channel channel);
 bool dispc_mgr_is_channel_enabled(enum omap_channel channel);
 void dispc_mgr_set_lcd_config(enum omap_channel channel,
 		const struct dss_lcd_mgr_config *config);
-- 
1.7.9.5


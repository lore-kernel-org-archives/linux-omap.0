From: Archit Taneja <archit@ti.com>
Subject: [RFC v2][PATCH 2/7] OMAP: DSS2: Add new Overlay Manager
Date: Wed, 14 Jul 2010 12:02:42 +0530
Message-ID: <1279089167-14057-3-git-send-email-archit@ti.com>
References: <1279089167-14057-1-git-send-email-archit@ti.com>
 <1279089167-14057-2-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56860 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738Ab0GNGdE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Jul 2010 02:33:04 -0400
In-Reply-To: <1279089167-14057-2-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Sumit Semwal <sumit.semwal@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Mukund Mittal <mmittal@ti.com>, Archit Taneja <archit@ti.com>, Samreen <samreen@ti.com>

From: Sumit Semwal <sumit.semwal@ti.com>

Add new Overlay Manager in manager.c, make secondary channel changes
and update supported displays for the managers in OMAP4

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Samreen <samreen@ti.com>
---
 drivers/video/omap2/dss/manager.c |   56 ++++++++++++++++++++++--------------
 1 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 6a649ab..8b6ff98 
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -34,6 +34,8 @@
 
 #include "dss.h"
 
+#define MAX_DSS_MANAGERS (cpu_is_omap44xx() ? 3 : 2)
+
 static int num_managers;
 static struct list_head manager_list;
 
@@ -449,7 +451,7 @@ struct manager_cache_data {
 static struct {
 	spinlock_t lock;
 	struct overlay_cache_data overlay_cache[3];
-	struct manager_cache_data manager_cache[2];
+	struct manager_cache_data manager_cache[3];
 
 	bool irq_enabled;
 } dss_cache;
@@ -531,10 +533,9 @@ static int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 
 	if (!dssdev || dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
-
+	channel = mgr->device->channel;
 	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC) {
 		irq = DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_EVSYNC_EVEN;
-		channel = OMAP_DSS_CHANNEL_DIGIT;
 	} else {
 		if (dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) {
 			enum omap_dss_update_mode mode;
@@ -546,7 +547,6 @@ static int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 		} else {
 			irq = DISPC_IRQ_VSYNC;
 		}
-		channel = OMAP_DSS_CHANNEL_LCD;
 	}
 
 	mc = &dss_cache.manager_cache[mgr->id];
@@ -604,13 +604,13 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 		return 0;
 
 	dssdev = ovl->manager->device;
+	channel = dssdev->channel;
 
 	if (!dssdev || dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
 
 	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC) {
 		irq = DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_EVSYNC_EVEN;
-		channel = OMAP_DSS_CHANNEL_DIGIT;
 	} else {
 		if (dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) {
 			enum omap_dss_update_mode mode;
@@ -622,7 +622,6 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 		} else {
 			irq = DISPC_IRQ_VSYNC;
 		}
-		channel = OMAP_DSS_CHANNEL_LCD;
 	}
 
 	oc = &dss_cache.overlay_cache[ovl->id];
@@ -841,7 +840,8 @@ static int configure_overlay(enum omap_plane plane)
 			c->rotation_type,
 			c->rotation,
 			c->mirror,
-			c->global_alpha);
+			c->global_alpha,
+			c->channel);
 
 	if (r) {
 		/* this shouldn't happen */
@@ -883,20 +883,20 @@ static int configure_dispc(void)
 	struct overlay_cache_data *oc;
 	struct manager_cache_data *mc;
 	const int num_ovls = ARRAY_SIZE(dss_cache.overlay_cache);
-	const int num_mgrs = ARRAY_SIZE(dss_cache.manager_cache);
+	const int num_mgrs = MAX_DSS_MANAGERS;
 	int i;
 	int r;
-	bool mgr_busy[2];
-	bool mgr_go[2];
+	bool mgr_busy[MAX_DSS_MANAGERS];
+	bool mgr_go[MAX_DSS_MANAGERS];
 	bool busy;
 
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
@@ -1122,7 +1122,7 @@ void dss_start_update(struct omap_dss_device *dssdev)
 	struct manager_cache_data *mc;
 	struct overlay_cache_data *oc;
 	const int num_ovls = ARRAY_SIZE(dss_cache.overlay_cache);
-	const int num_mgrs = ARRAY_SIZE(dss_cache.manager_cache);
+	const int num_mgrs = MAX_DSS_MANAGERS;
 	struct omap_overlay_manager *mgr;
 	int i;
 
@@ -1154,10 +1154,10 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 	const int num_ovls = ARRAY_SIZE(dss_cache.overlay_cache);
 	const int num_mgrs = ARRAY_SIZE(dss_cache.manager_cache);
 	int i, r;
-	bool mgr_busy[2];
+	bool mgr_busy[MAX_DSS_MANAGERS];
 
-	mgr_busy[0] = dispc_go_busy(0);
-	mgr_busy[1] = dispc_go_busy(1);
+	for (i = 0; i < num_mgrs; i++)
+		mgr_busy[i] = dispc_go_busy(i);
 
 	spin_lock(&dss_cache.lock);
 
@@ -1461,7 +1461,7 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 
 	num_managers = 0;
 
-	for (i = 0; i < 2; ++i) {
+	for (i = 0; i < MAX_DSS_MANAGERS; ++i) {
 		struct omap_overlay_manager *mgr;
 		mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
 
@@ -1471,15 +1471,27 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 		case 0:
 			mgr->name = "lcd";
 			mgr->id = OMAP_DSS_CHANNEL_LCD;
-			mgr->supported_displays =
-				OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI |
-				OMAP_DISPLAY_TYPE_SDI | OMAP_DISPLAY_TYPE_DSI;
+			mgr->supported_displays = OMAP_DISPLAY_TYPE_DBI;
+			if (!cpu_is_omap24xx())
+				mgr->supported_displays |=
+					OMAP_DISPLAY_TYPE_DSI;
+			if (!cpu_is_omap44xx())
+				mgr->supported_displays |=
+					OMAP_DISPLAY_TYPE_DPI |
+					OMAP_DISPLAY_TYPE_SDI;
 			break;
 		case 1:
 			mgr->name = "tv";
 			mgr->id = OMAP_DSS_CHANNEL_DIGIT;
 			mgr->supported_displays = OMAP_DISPLAY_TYPE_VENC;
 			break;
+		case 2:
+			mgr->name = "lcd2";
+			mgr->id = OMAP_DSS_CHANNEL_LCD2;
+			mgr->supported_displays =
+				OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI |
+				OMAP_DISPLAY_TYPE_DSI;
+			break;
 		}
 
 		mgr->set_device = &omap_dss_set_device;
-- 
1.6.3.3


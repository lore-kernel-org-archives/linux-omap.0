From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 39/65] OMAPDSS: remove ovl/mgr check-code temporarily
Date: Tue, 22 Nov 2011 11:21:38 +0200
Message-ID: <1321953724-6350-40-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:35391 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757899Ab1KVJYB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:24:01 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

DSS currently tries to check that the given overlay and overlay manager
settings are acceptable, but the code does not work quite properly.
Things may change between the check and the actual use of the settings.

Furthermore, the following patches will rewrite how settings are
configured and managed, and trying to keep the (broken) settings
checking working during the rewrite would be very difficult.

This patch removes the checking code, and a working version of checking
will be added back after the settings rewrite has been done.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c   |   53 +--------------------
 drivers/video/omap2/dss/dss.h     |    2 -
 drivers/video/omap2/dss/manager.c |   17 -------
 drivers/video/omap2/dss/overlay.c |   90 -------------------------------------
 4 files changed, 3 insertions(+), 159 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 543a10b..b935264 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -503,10 +503,9 @@ end:
 	spin_unlock(&data_lock);
 }
 
-static int omap_dss_mgr_apply_ovl(struct omap_overlay *ovl)
+static void omap_dss_mgr_apply_ovl(struct omap_overlay *ovl)
 {
 	struct ovl_priv_data *op;
-	struct omap_dss_device *dssdev;
 
 	op = get_ovl_priv(ovl);
 
@@ -520,21 +519,11 @@ static int omap_dss_mgr_apply_ovl(struct omap_overlay *ovl)
 			op->enabled = false;
 			op->dirty = true;
 		}
-		return 0;
+		return;
 	}
 
 	if (!ovl->info_dirty)
-		return 0;
-
-	dssdev = ovl->manager->device;
-
-	if (dss_check_overlay(ovl, dssdev)) {
-		if (op->enabled) {
-			op->enabled = false;
-			op->dirty = true;
-		}
-		return -EINVAL;
-	}
+		return;
 
 	ovl->info_dirty = false;
 	op->dirty = true;
@@ -543,8 +532,6 @@ static int omap_dss_mgr_apply_ovl(struct omap_overlay *ovl)
 	op->channel = ovl->manager->id;
 
 	op->enabled = true;
-
-	return 0;
 }
 
 static void omap_dss_mgr_apply_mgr(struct omap_overlay_manager *mgr)
@@ -665,18 +652,7 @@ void dss_mgr_disable(struct omap_overlay_manager *mgr)
 int dss_mgr_set_info(struct omap_overlay_manager *mgr,
 		struct omap_overlay_manager_info *info)
 {
-	int r;
-	struct omap_overlay_manager_info old_info;
-
-	old_info = mgr->info;
 	mgr->info = *info;
-
-	r = dss_check_manager(mgr);
-	if (r) {
-		mgr->info = old_info;
-		return r;
-	}
-
 	mgr->info_dirty = true;
 
 	return 0;
@@ -692,7 +668,6 @@ int dss_mgr_set_device(struct omap_overlay_manager *mgr,
 		struct omap_dss_device *dssdev)
 {
 	int r;
-	struct omap_overlay *ovl;
 
 	if (dssdev->manager) {
 		DSSERR("display '%s' already has a manager '%s'\n",
@@ -706,15 +681,6 @@ int dss_mgr_set_device(struct omap_overlay_manager *mgr,
 		return -EINVAL;
 	}
 
-	list_for_each_entry(ovl, &mgr->overlays, list) {
-		if (!ovl->info.enabled)
-			continue;
-
-		r = dss_check_overlay(ovl, dssdev);
-		if (r)
-			return r;
-	}
-
 	dssdev->manager = mgr;
 	mgr->device = dssdev;
 	mgr->device_changed = true;
@@ -748,20 +714,7 @@ int dss_mgr_unset_device(struct omap_overlay_manager *mgr)
 int dss_ovl_set_info(struct omap_overlay *ovl,
 		struct omap_overlay_info *info)
 {
-	int r;
-	struct omap_overlay_info old_info;
-
-	old_info = ovl->info;
 	ovl->info = *info;
-
-	if (ovl->manager) {
-		r = dss_check_overlay(ovl, ovl->manager->device);
-		if (r) {
-			ovl->info = old_info;
-			return r;
-		}
-	}
-
 	ovl->info_dirty = true;
 
 	return 0;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index afe9713..0ef0e08 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -206,12 +206,10 @@ void default_get_overlay_fifo_thresholds(enum omap_plane plane,
 /* manager */
 int dss_init_overlay_managers(struct platform_device *pdev);
 void dss_uninit_overlay_managers(struct platform_device *pdev);
-int dss_check_manager(struct omap_overlay_manager *mgr);
 
 /* overlay */
 void dss_init_overlays(struct platform_device *pdev);
 void dss_uninit_overlays(struct platform_device *pdev);
-int dss_check_overlay(struct omap_overlay *ovl, struct omap_dss_device *dssdev);
 void dss_overlay_setup_dispc_manager(struct omap_overlay_manager *mgr);
 void dss_recheck_connections(struct omap_dss_device *dssdev, bool force);
 
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index ab0b61b..d7fd494 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -485,23 +485,6 @@ static int dss_mgr_wait_for_vsync(struct omap_overlay_manager *mgr)
 	return omap_dispc_wait_for_irq_interruptible_timeout(irq, timeout);
 }
 
-int dss_check_manager(struct omap_overlay_manager *mgr)
-{
-	if (dss_has_feature(FEAT_ALPHA_FIXED_ZORDER)) {
-		/*
-		 * OMAP3 supports only graphics source transparency color key
-		 * and alpha blending simultaneously. See TRM 15.4.2.4.2.2
-		 * Alpha Mode
-		 */
-		if (mgr->info.partial_alpha_enabled && mgr->info.trans_enabled
-			&& mgr->info.trans_key_type !=
-				OMAP_DSS_COLOR_KEY_GFX_DST)
-			return -EINVAL;
-	}
-
-	return 0;
-}
-
 int dss_init_overlay_managers(struct platform_device *pdev)
 {
 	int i, r;
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 00c01a3..4dc6b92 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -430,96 +430,6 @@ static struct kobj_type overlay_ktype = {
 	.default_attrs = overlay_sysfs_attrs,
 };
 
-/* Check if overlay parameters are compatible with display */
-int dss_check_overlay(struct omap_overlay *ovl, struct omap_dss_device *dssdev)
-{
-	struct omap_overlay_info *info;
-	u16 outw, outh;
-	u16 dw, dh;
-	int i;
-
-	if (!dssdev)
-		return 0;
-
-	if (!ovl->info.enabled)
-		return 0;
-
-	info = &ovl->info;
-
-	if (info->paddr == 0) {
-		DSSDBG("check_overlay failed: paddr 0\n");
-		return -EINVAL;
-	}
-
-	dssdev->driver->get_resolution(dssdev, &dw, &dh);
-
-	DSSDBG("check_overlay %d: (%d,%d %dx%d -> %dx%d) disp (%dx%d)\n",
-			ovl->id,
-			info->pos_x, info->pos_y,
-			info->width, info->height,
-			info->out_width, info->out_height,
-			dw, dh);
-
-	if ((ovl->caps & OMAP_DSS_OVL_CAP_SCALE) == 0) {
-		outw = info->width;
-		outh = info->height;
-	} else {
-		if (info->out_width == 0)
-			outw = info->width;
-		else
-			outw = info->out_width;
-
-		if (info->out_height == 0)
-			outh = info->height;
-		else
-			outh = info->out_height;
-	}
-
-	if (dw < info->pos_x + outw) {
-		DSSDBG("check_overlay failed 1: %d < %d + %d\n",
-				dw, info->pos_x, outw);
-		return -EINVAL;
-	}
-
-	if (dh < info->pos_y + outh) {
-		DSSDBG("check_overlay failed 2: %d < %d + %d\n",
-				dh, info->pos_y, outh);
-		return -EINVAL;
-	}
-
-	if ((ovl->supported_modes & info->color_mode) == 0) {
-		DSSERR("overlay doesn't support mode %d\n", info->color_mode);
-		return -EINVAL;
-	}
-
-	if (ovl->caps & OMAP_DSS_OVL_CAP_ZORDER) {
-		if (info->zorder < 0 || info->zorder > 3) {
-			DSSERR("zorder out of range: %d\n",
-				info->zorder);
-			return -EINVAL;
-		}
-		/*
-		 * Check that zorder doesn't match with zorder of any other
-		 * overlay which is enabled and is also connected to the same
-		 * manager
-		 */
-		for (i = 0; i < omap_dss_get_num_overlays(); i++) {
-			struct omap_overlay *tmp_ovl = omap_dss_get_overlay(i);
-
-			if (tmp_ovl->id != ovl->id &&
-					tmp_ovl->manager == ovl->manager &&
-					tmp_ovl->info.enabled == true &&
-					tmp_ovl->info.zorder == info->zorder) {
-				DSSERR("%s and %s have same zorder: %d\n",
-					ovl->name, tmp_ovl->name, info->zorder);
-				return -EINVAL;
-			}
-		}
-	}
-
-	return 0;
-}
-
 int omap_dss_get_num_overlays(void)
 {
 	return num_overlays;
-- 
1.7.4.1


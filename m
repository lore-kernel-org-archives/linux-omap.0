From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 51/65] OMAPDSS: APPLY: move ovl->info to apply.c
Date: Tue, 22 Nov 2011 11:21:50 +0200
Message-ID: <1321953724-6350-52-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:59201 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757321Ab1KVJY3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:24:29 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

struct omap_overlayr contains info and info_dirty fields, both of which
should be internal to apply.c.

This patch moves those fields into ovl_priv data, and names them
user_info and user_info_dirty.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c           |   51 ++++++++++++++++++++++++----
 drivers/video/omap2/dss/overlay.c         |   53 +++++++++++++++++++----------
 drivers/video/omap2/omapfb/omapfb-ioctl.c |   12 +++---
 drivers/video/omap2/omapfb/omapfb-main.c  |   12 ++++--
 include/video/omapdss.h                   |    3 --
 5 files changed, 93 insertions(+), 38 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index de1ac24..eac0041 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -55,6 +55,10 @@
  */
 
 struct ovl_priv_data {
+
+	bool user_info_dirty;
+	struct omap_overlay_info user_info;
+
 	/* If true, cache changed, but not written to shadow registers. Set
 	 * in apply(), cleared when registers written. */
 	bool dirty;
@@ -129,7 +133,38 @@ static struct mgr_priv_data *get_mgr_priv(struct omap_overlay_manager *mgr)
 
 void dss_apply_init(void)
 {
+	const int num_ovls = dss_feat_get_num_ovls();
+	int i;
+
 	spin_lock_init(&data_lock);
+
+	for (i = 0; i < num_ovls; ++i) {
+		struct ovl_priv_data *op;
+
+		op = &dss_data.ovl_priv_data_array[i];
+
+		op->info.global_alpha = 255;
+
+		switch (i) {
+		case 0:
+			op->info.zorder = 0;
+			break;
+		case 1:
+			op->info.zorder =
+				dss_has_feature(FEAT_ALPHA_FREE_ZORDER) ? 3 : 0;
+			break;
+		case 2:
+			op->info.zorder =
+				dss_has_feature(FEAT_ALPHA_FREE_ZORDER) ? 2 : 0;
+			break;
+		case 3:
+			op->info.zorder =
+				dss_has_feature(FEAT_ALPHA_FREE_ZORDER) ? 1 : 0;
+			break;
+		}
+
+		op->user_info = op->info;
+	}
 }
 
 static bool ovl_manual_update(struct omap_overlay *ovl)
@@ -575,15 +610,15 @@ static void omap_dss_mgr_apply_ovl(struct omap_overlay *ovl)
 
 	if (ovl->manager_changed) {
 		ovl->manager_changed = false;
-		ovl->info_dirty  = true;
+		op->user_info_dirty  = true;
 	}
 
-	if (!ovl->info_dirty)
+	if (!op->user_info_dirty)
 		return;
 
-	ovl->info_dirty = false;
+	op->user_info_dirty = false;
 	op->dirty = true;
-	op->info = ovl->info;
+	op->info = op->user_info;
 
 	op->channel = ovl->manager->id;
 }
@@ -821,12 +856,13 @@ err:
 int dss_ovl_set_info(struct omap_overlay *ovl,
 		struct omap_overlay_info *info)
 {
+	struct ovl_priv_data *op = get_ovl_priv(ovl);
 	unsigned long flags;
 
 	spin_lock_irqsave(&data_lock, flags);
 
-	ovl->info = *info;
-	ovl->info_dirty = true;
+	op->user_info = *info;
+	op->user_info_dirty = true;
 
 	spin_unlock_irqrestore(&data_lock, flags);
 
@@ -836,11 +872,12 @@ int dss_ovl_set_info(struct omap_overlay *ovl,
 void dss_ovl_get_info(struct omap_overlay *ovl,
 		struct omap_overlay_info *info)
 {
+	struct ovl_priv_data *op = get_ovl_priv(ovl);
 	unsigned long flags;
 
 	spin_lock_irqsave(&data_lock, flags);
 
-	*info = ovl->info;
+	*info = op->user_info;
 
 	spin_unlock_irqrestore(&data_lock, flags);
 }
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 7d7cdf6..8d036e6 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -124,19 +124,31 @@ err:
 
 static ssize_t overlay_input_size_show(struct omap_overlay *ovl, char *buf)
 {
+	struct omap_overlay_info info;
+
+	ovl->get_overlay_info(ovl, &info);
+
 	return snprintf(buf, PAGE_SIZE, "%d,%d\n",
-			ovl->info.width, ovl->info.height);
+			info.width, info.height);
 }
 
 static ssize_t overlay_screen_width_show(struct omap_overlay *ovl, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", ovl->info.screen_width);
+	struct omap_overlay_info info;
+
+	ovl->get_overlay_info(ovl, &info);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", info.screen_width);
 }
 
 static ssize_t overlay_position_show(struct omap_overlay *ovl, char *buf)
 {
+	struct omap_overlay_info info;
+
+	ovl->get_overlay_info(ovl, &info);
+
 	return snprintf(buf, PAGE_SIZE, "%d,%d\n",
-			ovl->info.pos_x, ovl->info.pos_y);
+			info.pos_x, info.pos_y);
 }
 
 static ssize_t overlay_position_store(struct omap_overlay *ovl,
@@ -170,8 +182,12 @@ static ssize_t overlay_position_store(struct omap_overlay *ovl,
 
 static ssize_t overlay_output_size_show(struct omap_overlay *ovl, char *buf)
 {
+	struct omap_overlay_info info;
+
+	ovl->get_overlay_info(ovl, &info);
+
 	return snprintf(buf, PAGE_SIZE, "%d,%d\n",
-			ovl->info.out_width, ovl->info.out_height);
+			info.out_width, info.out_height);
 }
 
 static ssize_t overlay_output_size_store(struct omap_overlay *ovl,
@@ -231,8 +247,12 @@ static ssize_t overlay_enabled_store(struct omap_overlay *ovl, const char *buf,
 
 static ssize_t overlay_global_alpha_show(struct omap_overlay *ovl, char *buf)
 {
+	struct omap_overlay_info info;
+
+	ovl->get_overlay_info(ovl, &info);
+
 	return snprintf(buf, PAGE_SIZE, "%d\n",
-			ovl->info.global_alpha);
+			info.global_alpha);
 }
 
 static ssize_t overlay_global_alpha_store(struct omap_overlay *ovl,
@@ -269,8 +289,12 @@ static ssize_t overlay_global_alpha_store(struct omap_overlay *ovl,
 static ssize_t overlay_pre_mult_alpha_show(struct omap_overlay *ovl,
 		char *buf)
 {
+	struct omap_overlay_info info;
+
+	ovl->get_overlay_info(ovl, &info);
+
 	return snprintf(buf, PAGE_SIZE, "%d\n",
-			ovl->info.pre_mult_alpha);
+			info.pre_mult_alpha);
 }
 
 static ssize_t overlay_pre_mult_alpha_store(struct omap_overlay *ovl,
@@ -306,7 +330,11 @@ static ssize_t overlay_pre_mult_alpha_store(struct omap_overlay *ovl,
 
 static ssize_t overlay_zorder_show(struct omap_overlay *ovl, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", ovl->info.zorder);
+	struct omap_overlay_info info;
+
+	ovl->get_overlay_info(ovl, &info);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", info.zorder);
 }
 
 static ssize_t overlay_zorder_store(struct omap_overlay *ovl,
@@ -456,29 +484,18 @@ void dss_init_overlays(struct platform_device *pdev)
 		case 0:
 			ovl->name = "gfx";
 			ovl->id = OMAP_DSS_GFX;
-			ovl->info.global_alpha = 255;
-			ovl->info.zorder = 0;
 			break;
 		case 1:
 			ovl->name = "vid1";
 			ovl->id = OMAP_DSS_VIDEO1;
-			ovl->info.global_alpha = 255;
-			ovl->info.zorder =
-				dss_has_feature(FEAT_ALPHA_FREE_ZORDER) ? 3 : 0;
 			break;
 		case 2:
 			ovl->name = "vid2";
 			ovl->id = OMAP_DSS_VIDEO2;
-			ovl->info.global_alpha = 255;
-			ovl->info.zorder =
-				dss_has_feature(FEAT_ALPHA_FREE_ZORDER) ? 2 : 0;
 			break;
 		case 3:
 			ovl->name = "vid3";
 			ovl->id = OMAP_DSS_VIDEO3;
-			ovl->info.global_alpha = 255;
-			ovl->info.zorder =
-				dss_has_feature(FEAT_ALPHA_FREE_ZORDER) ? 1 : 0;
 			break;
 		}
 
diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index 562b5cc..16ba619 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -189,19 +189,19 @@ static int omapfb_query_plane(struct fb_info *fbi, struct omapfb_plane_info *pi)
 		memset(pi, 0, sizeof(*pi));
 	} else {
 		struct omap_overlay *ovl;
-		struct omap_overlay_info *ovli;
+		struct omap_overlay_info ovli;
 
 		ovl = ofbi->overlays[0];
-		ovli = &ovl->info;
+		ovl->get_overlay_info(ovl, &ovli);
 
-		pi->pos_x = ovli->pos_x;
-		pi->pos_y = ovli->pos_y;
+		pi->pos_x = ovli.pos_x;
+		pi->pos_y = ovli.pos_y;
 		pi->enabled = ovl->is_enabled(ovl);
 		pi->channel_out = 0; /* xxx */
 		pi->mirror = 0;
 		pi->mem_idx = get_mem_idx(ofbi);
-		pi->out_width = ovli->out_width;
-		pi->out_height = ovli->out_height;
+		pi->out_width = ovli.out_width;
+		pi->out_height = ovli.out_height;
 	}
 
 	return 0;
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 91b49b5..46024ab 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -970,16 +970,20 @@ int omapfb_apply_changes(struct fb_info *fbi, int init)
 				outh = var->yres;
 			}
 		} else {
-			outw = ovl->info.out_width;
-			outh = ovl->info.out_height;
+			struct omap_overlay_info info;
+			ovl->get_overlay_info(ovl, &info);
+			outw = info.out_width;
+			outh = info.out_height;
 		}
 
 		if (init) {
 			posx = 0;
 			posy = 0;
 		} else {
-			posx = ovl->info.pos_x;
-			posy = ovl->info.pos_y;
+			struct omap_overlay_info info;
+			ovl->get_overlay_info(ovl, &info);
+			posx = info.pos_x;
+			posy = info.pos_y;
 		}
 
 		r = omapfb_setup_overlay(fbi, ovl, posx, posy, outw, outh);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 0d5333f..2e2c53f 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -383,11 +383,8 @@ struct omap_overlay {
 
 	/* dynamic fields */
 	struct omap_overlay_manager *manager;
-	struct omap_overlay_info info;
 
 	bool manager_changed;
-	/* if true, info has been changed, but not applied() yet */
-	bool info_dirty;
 
 	int (*enable)(struct omap_overlay *ovl);
 	int (*disable)(struct omap_overlay *ovl);
-- 
1.7.4.1


From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 05/10] OMAP4: DSS2: zorder support for DSS overlays
Date: Wed, 14 Sep 2011 17:55:09 +0530
Message-ID: <1316003114-24291-2-git-send-email-archit@ti.com>
References: <1316003114-24291-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38866 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932370Ab1INMYO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Sep 2011 08:24:14 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8ECOEx8024077
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:24:14 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8ECODng011307
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:24:13 -0500 (CDT)
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8ECODcW001077
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:24:13 -0500 (CDT)
In-Reply-To: <1316003114-24291-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Add zorder support on OMAP4, this feature allows deciding the visibility order
of the overlays based on the zorder value provided as an overlay info parameter
or a sysfs attribute of the overlay object.

Use the overlay cap OMAP_DSS_OVL_CAP_ZORDER to determine whether zorder is
supported for the overlay or not. Use dss feature FEAT_ALPHA_FREE_ZORDER
if the caps are not available.

Ensure that all overlays that are enabled and connected to the same manager
have different zorders. Swapping zorders of 2 enabled overlays currently
requires disabling one of the overlays.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c   |   24 ++++++++++++
 drivers/video/omap2/dss/overlay.c |   72 +++++++++++++++++++++++++++++++++++++
 include/video/omapdss.h           |    1 +
 3 files changed, 97 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index a3f6d17..6b9f1b6 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -726,6 +726,27 @@ static void dispc_ovl_set_vid_size(enum omap_plane plane, int width, int height)
 	dispc_write_reg(DISPC_OVL_SIZE(plane), val);
 }
 
+static void dispc_ovl_set_zorder(enum omap_plane plane, u8 zorder)
+{
+	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
+
+	if ((ovl->caps & OMAP_DSS_OVL_CAP_ZORDER) == 0)
+		return;
+
+	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), zorder, 27, 26);
+}
+
+static void dispc_ovl_enable_zorder_planes(void)
+{
+	int i;
+
+	if (!dss_has_feature(FEAT_ALPHA_FREE_ZORDER))
+		return;
+
+	for (i = 0; i < dss_feat_get_num_ovls(); i++)
+		REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(i), 1, 25, 25);
+}
+
 static void dispc_ovl_set_pre_mult_alpha(enum omap_plane plane, bool enable)
 {
 	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
@@ -1840,6 +1861,7 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	dispc_ovl_set_rotation_attrs(plane, oi->rotation, oi->mirror,
 			oi->color_mode);
 
+	dispc_ovl_set_zorder(plane, oi->zorder);
 	dispc_ovl_set_pre_mult_alpha(plane, oi->pre_mult_alpha);
 	dispc_ovl_setup_global_alpha(plane, oi->global_alpha);
 
@@ -3277,6 +3299,8 @@ static void _omap_dispc_initial_config(void)
 	dispc_read_plane_fifo_sizes();
 
 	dispc_configure_burst_sizes();
+
+	dispc_ovl_enable_zorder_planes();
 }
 
 /* DISPC HW IP initialisation */
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 11d21e3..ab8e40e 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -311,6 +311,42 @@ static ssize_t overlay_pre_mult_alpha_store(struct omap_overlay *ovl,
 	return size;
 }
 
+static ssize_t overlay_zorder_show(struct omap_overlay *ovl, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", ovl->info.zorder);
+}
+
+static ssize_t overlay_zorder_store(struct omap_overlay *ovl,
+		const char *buf, size_t size)
+{
+	int r;
+	u8 zorder;
+	struct omap_overlay_info info;
+
+	if ((ovl->caps & OMAP_DSS_OVL_CAP_ZORDER) == 0)
+		return -ENODEV;
+
+	r = kstrtou8(buf, 0, &zorder);
+	if (r)
+		return r;
+
+	ovl->get_overlay_info(ovl, &info);
+
+	info.zorder = zorder;
+
+	r = ovl->set_overlay_info(ovl, &info);
+	if (r)
+		return r;
+
+	if (ovl->manager) {
+		r = ovl->manager->apply(ovl->manager);
+		if (r)
+			return r;
+	}
+
+	return size;
+}
+
 struct overlay_attribute {
 	struct attribute attr;
 	ssize_t (*show)(struct omap_overlay *, char *);
@@ -337,6 +373,8 @@ static OVERLAY_ATTR(global_alpha, S_IRUGO|S_IWUSR,
 static OVERLAY_ATTR(pre_mult_alpha, S_IRUGO|S_IWUSR,
 		overlay_pre_mult_alpha_show,
 		overlay_pre_mult_alpha_store);
+static OVERLAY_ATTR(zorder, S_IRUGO|S_IWUSR,
+		overlay_zorder_show, overlay_zorder_store);
 
 static struct attribute *overlay_sysfs_attrs[] = {
 	&overlay_attr_name.attr,
@@ -348,6 +386,7 @@ static struct attribute *overlay_sysfs_attrs[] = {
 	&overlay_attr_enabled.attr,
 	&overlay_attr_global_alpha.attr,
 	&overlay_attr_pre_mult_alpha.attr,
+	&overlay_attr_zorder.attr,
 	NULL
 };
 
@@ -397,6 +436,7 @@ int dss_check_overlay(struct omap_overlay *ovl, struct omap_dss_device *dssdev)
 	struct omap_overlay_info *info;
 	u16 outw, outh;
 	u16 dw, dh;
+	int i;
 
 	if (!dssdev)
 		return 0;
@@ -452,6 +492,31 @@ int dss_check_overlay(struct omap_overlay *ovl, struct omap_dss_device *dssdev)
 		return -EINVAL;
 	}
 
+	if (ovl->caps & OMAP_DSS_OVL_CAP_ZORDER) {
+		if (info->zorder < 0 || info->zorder > 3) {
+			DSSERR("zorder out of range: %d\n",
+				info->zorder);
+			return -EINVAL;
+		}
+		/*
+		 * Check that zorder doesn't match with zorder of any other
+		 * overlay which is enabled and is also connected to the same
+		 * manager
+		 */
+		for (i = 0; i < omap_dss_get_num_overlays(); i++) {
+			struct omap_overlay *tmp_ovl = omap_dss_get_overlay(i);
+
+			if (tmp_ovl->id != ovl->id &&
+					tmp_ovl->manager == ovl->manager &&
+					tmp_ovl->info.enabled == true &&
+					tmp_ovl->info.zorder == info->zorder) {
+				DSSERR("%s and %s have same zorder: %d\n",
+					ovl->name, tmp_ovl->name, info->zorder);
+				return -EINVAL;
+			}
+		}
+	}
+
 	return 0;
 }
 
@@ -604,21 +669,28 @@ void dss_init_overlays(struct platform_device *pdev)
 			ovl->name = "gfx";
 			ovl->id = OMAP_DSS_GFX;
 			ovl->info.global_alpha = 255;
+			ovl->info.zorder = 0;
 			break;
 		case 1:
 			ovl->name = "vid1";
 			ovl->id = OMAP_DSS_VIDEO1;
 			ovl->info.global_alpha = 255;
+			ovl->info.zorder =
+				dss_has_feature(FEAT_ALPHA_FREE_ZORDER) ? 3 : 0;
 			break;
 		case 2:
 			ovl->name = "vid2";
 			ovl->id = OMAP_DSS_VIDEO2;
 			ovl->info.global_alpha = 255;
+			ovl->info.zorder =
+				dss_has_feature(FEAT_ALPHA_FREE_ZORDER) ? 2 : 0;
 			break;
 		case 3:
 			ovl->name = "vid3";
 			ovl->id = OMAP_DSS_VIDEO3;
 			ovl->info.global_alpha = 255;
+			ovl->info.zorder =
+				dss_has_feature(FEAT_ALPHA_FREE_ZORDER) ? 1 : 0;
 			break;
 		}
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 1f12559..9cd61e8 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -371,6 +371,7 @@ struct omap_overlay_info {
 	u16 out_height;	/* if 0, out_height == height */
 	u8 global_alpha;
 	u8 pre_mult_alpha;
+	u8 zorder;
 };
 
 struct omap_overlay {
-- 
1.7.1


From: Archit Taneja <archit@ti.com>
Subject: [PATCH 3/3] OMAP: DSS2: Zorder sysfs attributes, out of bound checks and initialization
Date: Mon, 19 Jul 2010 17:40:07 +0530
Message-ID: <1279541407-17711-4-git-send-email-archit@ti.com>
References: <1279541407-17711-1-git-send-email-archit@ti.com>
 <1279541407-17711-2-git-send-email-archit@ti.com>
 <1279541407-17711-3-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47263 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760638Ab0GSMKZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Jul 2010 08:10:25 -0400
In-Reply-To: <1279541407-17711-3-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, Sumit Semwal <sumit.semwal@ti.com>, Samreen <samreen@ti.com>

Add Zorder as a overlay sysfs attribute, check for out of bound entries
and initialize Zorder values for overlay objects.

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Samreen <samreen@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/overlay.c |   51 +++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 2f8f89c..eef474b
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -257,6 +257,38 @@ static ssize_t overlay_global_alpha_store(struct omap_overlay *ovl,
 	return size;
 }
 
+static ssize_t overlay_zorder_show(struct omap_overlay *ovl, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			ovl->info.zorder);
+}
+
+static ssize_t overlay_zorder_store(struct omap_overlay *ovl,
+		const char *buf, size_t size)
+{
+	int r;
+	struct omap_overlay_info info;
+
+	if (!cpu_is_omap44xx())
+		return size;
+
+	ovl->get_overlay_info(ovl, &info);
+
+	info.zorder = simple_strtoul(buf, NULL, 10);
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
@@ -280,6 +312,8 @@ static OVERLAY_ATTR(enabled, S_IRUGO|S_IWUSR,
 		overlay_enabled_show, overlay_enabled_store);
 static OVERLAY_ATTR(global_alpha, S_IRUGO|S_IWUSR,
 		overlay_global_alpha_show, overlay_global_alpha_store);
+static OVERLAY_ATTR(zorder, S_IRUGO|S_IWUSR,
+		overlay_zorder_show, overlay_zorder_store);
 
 static struct attribute *overlay_sysfs_attrs[] = {
 	&overlay_attr_name.attr,
@@ -290,6 +324,7 @@ static struct attribute *overlay_sysfs_attrs[] = {
 	&overlay_attr_output_size.attr,
 	&overlay_attr_enabled.attr,
 	&overlay_attr_global_alpha.attr,
+	&overlay_attr_zorder.attr,
 	NULL
 };
 
@@ -394,6 +429,12 @@ int dss_check_overlay(struct omap_overlay *ovl, struct omap_dss_device *dssdev)
 		return -EINVAL;
 	}
 
+	if ((info->zorder < OMAP_DSS_OVL_ZORDER_0) ||
+			(info->zorder > OMAP_DSS_OVL_ZORDER_3)) {
+		DSSERR("overlay doesn't support zorder %d\n", info->zorder);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -552,6 +593,7 @@ void dss_init_overlays(struct platform_device *pdev)
 				OMAP_DSS_COLOR_GFX_OMAP2;
 			ovl->caps = OMAP_DSS_OVL_CAP_DISPC;
 			ovl->info.global_alpha = 255;
+			ovl->info.zorder = OMAP_DSS_OVL_ZORDER_0;
 			break;
 		case 1:
 			ovl->name = "vid1";
@@ -562,6 +604,9 @@ void dss_init_overlays(struct platform_device *pdev)
 			ovl->caps = OMAP_DSS_OVL_CAP_SCALE |
 				OMAP_DSS_OVL_CAP_DISPC;
 			ovl->info.global_alpha = 255;
+			ovl->info.zorder = cpu_is_omap44xx() ?
+				OMAP_DSS_OVL_ZORDER_3 :
+				OMAP_DSS_OVL_ZORDER_0;
 			break;
 		case 2:
 			ovl->name = "vid2";
@@ -572,6 +617,9 @@ void dss_init_overlays(struct platform_device *pdev)
 			ovl->caps = OMAP_DSS_OVL_CAP_SCALE |
 				OMAP_DSS_OVL_CAP_DISPC;
 			ovl->info.global_alpha = 255;
+			ovl->info.zorder = cpu_is_omap44xx() ?
+				OMAP_DSS_OVL_ZORDER_2 :
+				OMAP_DSS_OVL_ZORDER_0;
 			break;
 		case 3:
 			ovl->name = "vid3";
@@ -580,6 +628,9 @@ void dss_init_overlays(struct platform_device *pdev)
 			ovl->caps = OMAP_DSS_OVL_CAP_SCALE |
 				OMAP_DSS_OVL_CAP_DISPC;
 			ovl->info.global_alpha = 255;
+			ovl->info.zorder = cpu_is_omap44xx() ?
+				OMAP_DSS_OVL_ZORDER_1 :
+				OMAP_DSS_OVL_ZORDER_0;
 			break;
 		}
 
-- 
1.5.4.7


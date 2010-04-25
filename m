From: "Y, Kishore" <kishore.y@ti.com>
Subject: [PATCH V2] OMAP3630:DSS2:Enable Pre-Multiplied Alpha Support
Date: Sun, 25 Apr 2010 16:09:21 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026F6E2B8D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51284 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751918Ab0DYKiG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Apr 2010 06:38:06 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Enables dss to process color formats with pre-mulitplied alpha.
With this we can have alpha values defined for each pixel
and hence can have different blending values for each pixel.
sysfs entry has been created for this and pre-multiplied alpha
support is turned of by default.

Signed-off-by: Sudeep Basavaraj <sudeep.basavaraj@ti.com>
Signed-off-by: Kishore Y <kishore.y@ti.com>
Signed-off-by: Sujeet Kumar Baranwal <s-baranwal@ti.com>
---
Changes from version 1:
Premultipiled alpha support is disabled by default for backward compatibility and sysfs entry created for configuring at runtime.

 arch/arm/plat-omap/include/plat/display.h |    1 +
 drivers/video/omap2/dss/dispc.c           |   17 +++++++++++--
 drivers/video/omap2/dss/dss.h             |    3 +-
 drivers/video/omap2/dss/manager.c         |    5 +++-
 drivers/video/omap2/dss/overlay.c         |   35 +++++++++++++++++++++++++++++
 5 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 1c529ce..545d793 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -299,6 +299,7 @@ struct omap_overlay_info {
 	u16 out_width;	/* if 0, out_width == width */
 	u16 out_height;	/* if 0, out_height == height */
 	u8 global_alpha;
+	u8 pre_alpha_mult;
 };
 
 struct omap_overlay {
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index e777e35..16770c5 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -788,6 +788,11 @@ static void _dispc_set_vid_size(enum omap_plane plane, int width, int height)
 	dispc_write_reg(vsi_reg[plane-1], val);
 }
 
+static void _dispc_set_alpha_blend_attrs(enum omap_plane plane, bool enable)
+{
+	REG_FLD_MOD(dispc_reg_att[plane], enable ? 1 : 0, 28, 28);
+}
+
 static void _dispc_setup_global_alpha(enum omap_plane plane, u8 global_alpha)
 {
 
@@ -1520,7 +1525,8 @@ static int _dispc_setup_plane(enum omap_plane plane,
 		bool ilace,
 		enum omap_dss_rotation_type rotation_type,
 		u8 rotation, int mirror,
-		u8 global_alpha)
+		u8 global_alpha,
+		u8 pre_alpha_mult)
 {
 	const int maxdownscale = cpu_is_omap34xx() ? 4 : 2;
 	bool five_taps = 0;
@@ -1703,6 +1709,9 @@ static int _dispc_setup_plane(enum omap_plane plane,
 
 	_dispc_set_rotation_attrs(plane, rotation, mirror, color_mode);
 
+	if (cpu_is_omap3630() && (plane != OMAP_DSS_VIDEO1))
+		_dispc_set_alpha_blend_attrs(plane, pre_alpha_mult);
+
 	if (plane != OMAP_DSS_VIDEO1)
 		_dispc_setup_global_alpha(plane, global_alpha);
 
@@ -3151,7 +3160,8 @@ int dispc_setup_plane(enum omap_plane plane,
 		       enum omap_color_mode color_mode,
 		       bool ilace,
 		       enum omap_dss_rotation_type rotation_type,
-		       u8 rotation, bool mirror, u8 global_alpha)
+		       u8 rotation, bool mirror, u8 global_alpha,
+		       u8 pre_alpha_mult)
 {
 	int r = 0;
 
@@ -3173,7 +3183,8 @@ int dispc_setup_plane(enum omap_plane plane,
 			   color_mode, ilace,
 			   rotation_type,
 			   rotation, mirror,
-			   global_alpha);
+			   global_alpha,
+			   pre_alpha_mult);
 
 	enable_clocks(0);
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index ad3d16e..3534577 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -293,7 +293,8 @@ int dispc_setup_plane(enum omap_plane plane,
 		      bool ilace,
 		      enum omap_dss_rotation_type rotation_type,
 		      u8 rotation, bool mirror,
-		      u8 global_alpha);
+		      u8 global_alpha,
+		      u8 pre_alpha_mult);
 
 bool dispc_go_busy(enum omap_channel channel);
 void dispc_go(enum omap_channel channel);
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 0820986..c12fa14 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -405,6 +405,7 @@ struct overlay_cache_data {
 	u16 out_width;	/* if 0, out_width == width */
 	u16 out_height;	/* if 0, out_height == height */
 	u8 global_alpha;
+	u8 pre_alpha_mult;
 
 	enum omap_channel channel;
 	bool replication;
@@ -816,7 +817,8 @@ static int configure_overlay(enum omap_plane plane)
 			c->rotation_type,
 			c->rotation,
 			c->mirror,
-			c->global_alpha);
+			c->global_alpha,
+			c->pre_alpha_mult);
 
 	if (r) {
 		/* this shouldn't happen */
@@ -1199,6 +1201,7 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 		oc->out_width = ovl->info.out_width;
 		oc->out_height = ovl->info.out_height;
 		oc->global_alpha = ovl->info.global_alpha;
+		oc->pre_alpha_mult = ovl->info.pre_alpha_mult;
 
 		oc->replication =
 			dss_use_replication(dssdev, ovl->info.color_mode);
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 8233658..cb630ba 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -255,6 +255,37 @@ static ssize_t overlay_global_alpha_store(struct omap_overlay *ovl,
 	return size;
 }
 
+static ssize_t overlay_pre_alpha_multiplication_show(struct omap_overlay *ovl,
+		char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			ovl->info.pre_alpha_mult);
+}
+
+static ssize_t overlay_pre_alpha_multiplication_store(struct omap_overlay *ovl,
+		const char *buf, size_t size)
+{
+	int r;
+	struct omap_overlay_info info;
+
+	ovl->get_overlay_info(ovl, &info);
+
+	/* only GFX and Video2 plane support pre alpha multiplication */
+	info.pre_alpha_mult = simple_strtoul(buf, NULL, 10);
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
@@ -278,6 +309,9 @@ static OVERLAY_ATTR(enabled, S_IRUGO|S_IWUSR,
 		overlay_enabled_show, overlay_enabled_store);
 static OVERLAY_ATTR(global_alpha, S_IRUGO|S_IWUSR,
 		overlay_global_alpha_show, overlay_global_alpha_store);
+static OVERLAY_ATTR(pre_alpha_multiplication, S_IRUGO|S_IWUSR,
+		overlay_pre_alpha_multiplication_show,
+		overlay_pre_alpha_multiplication_store);
 
 static struct attribute *overlay_sysfs_attrs[] = {
 	&overlay_attr_name.attr,
@@ -288,6 +322,7 @@ static struct attribute *overlay_sysfs_attrs[] = {
 	&overlay_attr_output_size.attr,
 	&overlay_attr_enabled.attr,
 	&overlay_attr_global_alpha.attr,
+	&overlay_attr_pre_alpha_multiplication.attr,
 	NULL
 };
 
-- 
1.5.6.3


Regards,
Kishore Y

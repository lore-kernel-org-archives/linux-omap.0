From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/5] OMAP: DSS2: Convert simple/strict_strto* to kstrto*
Date: Wed, 13 Apr 2011 09:50:13 +0300
Message-ID: <1302677417-4590-2-git-send-email-tomi.valkeinen@ti.com>
References: <1302677417-4590-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:44185 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754348Ab1DMGuf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Apr 2011 02:50:35 -0400
Received: by mail-ey0-f175.google.com with SMTP id 27so111460eye.34
        for <linux-omap@vger.kernel.org>; Tue, 12 Apr 2011 23:50:34 -0700 (PDT)
In-Reply-To: <1302677417-4590-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Convert simple/strict_strto* functions to kstrto* functions. Only simple
cases are converted.

simple_strto* uses are still left to places where it is used to parse
numbers from a list of numbers. These need some other solution than
kstrto*.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |    8 ++-
 drivers/video/omap2/dss/display.c                  |   44 +++++++++++++-------
 drivers/video/omap2/dss/overlay.c                  |   22 ++++++++--
 drivers/video/omap2/omapfb/omapfb-sysfs.c          |   21 ++++++---
 4 files changed, 66 insertions(+), 29 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
index dbe9d43..7081784 100644
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
@@ -144,13 +144,15 @@ static ssize_t tpo_td043_vmirror_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct tpo_td043_device *tpo_td043 = dev_get_drvdata(dev);
-	long val;
+	int val;
 	int ret;
 
-	ret = strict_strtol(buf, 0, &val);
+	ret = kstrtoint(buf, 0, &val);
 	if (ret < 0)
 		return ret;
 
+	val = !!val;
+
 	ret = tpo_td043_write_mirror(tpo_td043->spi, tpo_td043->hmirror, val);
 	if (ret < 0)
 		return ret;
@@ -175,7 +177,7 @@ static ssize_t tpo_td043_mode_store(struct device *dev,
 	long val;
 	int ret;
 
-	ret = strict_strtol(buf, 0, &val);
+	ret = kstrtol(buf, 0, &val);
 	if (ret != 0 || val & ~7)
 		return -EINVAL;
 
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index a85a6f3..4c9eeba 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -44,9 +44,13 @@ static ssize_t display_enabled_store(struct device *dev,
 		const char *buf, size_t size)
 {
 	struct omap_dss_device *dssdev = to_dss_device(dev);
-	bool enabled, r;
+	int r, enabled;
 
-	enabled = simple_strtoul(buf, NULL, 10);
+	r = kstrtoint(buf, 0, &enabled);
+	if (r)
+		return r;
+
+	enabled = !!enabled;
 
 	if (enabled != (dssdev->state != OMAP_DSS_DISPLAY_DISABLED)) {
 		if (enabled) {
@@ -82,7 +86,9 @@ static ssize_t display_upd_mode_store(struct device *dev,
 	if (!dssdev->driver->set_update_mode)
 		return -EINVAL;
 
-	val = simple_strtoul(buf, NULL, 10);
+	r = kstrtoint(buf, 0, &val);
+	if (r)
+		return r;
 
 	switch (val) {
 	case OMAP_DSS_UPDATE_DISABLED:
@@ -114,13 +120,16 @@ static ssize_t display_tear_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t size)
 {
 	struct omap_dss_device *dssdev = to_dss_device(dev);
-	unsigned long te;
-	int r;
+	int te, r;
 
 	if (!dssdev->driver->enable_te || !dssdev->driver->get_te)
 		return -ENOENT;
 
-	te = simple_strtoul(buf, NULL, 0);
+	r = kstrtoint(buf, 0, &te);
+	if (r)
+		return r;
+
+	te = !!te;
 
 	r = dssdev->driver->enable_te(dssdev, te);
 	if (r)
@@ -196,13 +205,14 @@ static ssize_t display_rotate_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t size)
 {
 	struct omap_dss_device *dssdev = to_dss_device(dev);
-	unsigned long rot;
-	int r;
+	int rot, r;
 
 	if (!dssdev->driver->set_rotate || !dssdev->driver->get_rotate)
 		return -ENOENT;
 
-	rot = simple_strtoul(buf, NULL, 0);
+	r = kstrtoint(buf, 0, &rot);
+	if (r)
+		return r;
 
 	r = dssdev->driver->set_rotate(dssdev, rot);
 	if (r)
@@ -226,13 +236,16 @@ static ssize_t display_mirror_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t size)
 {
 	struct omap_dss_device *dssdev = to_dss_device(dev);
-	unsigned long mirror;
-	int r;
+	int mirror, r;
 
 	if (!dssdev->driver->set_mirror || !dssdev->driver->get_mirror)
 		return -ENOENT;
 
-	mirror = simple_strtoul(buf, NULL, 0);
+	r = kstrtoint(buf, 0, &mirror);
+	if (r)
+		return r;
+
+	mirror = !!mirror;
 
 	r = dssdev->driver->set_mirror(dssdev, mirror);
 	if (r)
@@ -259,14 +272,15 @@ static ssize_t display_wss_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t size)
 {
 	struct omap_dss_device *dssdev = to_dss_device(dev);
-	unsigned long wss;
+	u32 wss;
 	int r;
 
 	if (!dssdev->driver->get_wss || !dssdev->driver->set_wss)
 		return -ENOENT;
 
-	if (strict_strtoul(buf, 0, &wss))
-		return -EINVAL;
+	r = kstrtou32(buf, 0, &wss);
+	if (r)
+		return r;
 
 	if (wss > 0xfffff)
 		return -EINVAL;
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 28469ab..46e17c3 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -201,12 +201,16 @@ static ssize_t overlay_enabled_show(struct omap_overlay *ovl, char *buf)
 static ssize_t overlay_enabled_store(struct omap_overlay *ovl, const char *buf,
 		size_t size)
 {
-	int r;
+	int r, enable;
 	struct omap_overlay_info info;
 
 	ovl->get_overlay_info(ovl, &info);
 
-	info.enabled = simple_strtoul(buf, NULL, 10);
+	r = kstrtoint(buf, 0, &enable);
+	if (r)
+		return r;
+
+	info.enabled = !!enable;
 
 	r = ovl->set_overlay_info(ovl, &info);
 	if (r)
@@ -231,8 +235,13 @@ static ssize_t overlay_global_alpha_store(struct omap_overlay *ovl,
 		const char *buf, size_t size)
 {
 	int r;
+	u8 alpha;
 	struct omap_overlay_info info;
 
+	r = kstrtou8(buf, 0, &alpha);
+	if (r)
+		return r;
+
 	ovl->get_overlay_info(ovl, &info);
 
 	/* Video1 plane does not support global alpha
@@ -242,7 +251,7 @@ static ssize_t overlay_global_alpha_store(struct omap_overlay *ovl,
 			ovl->id == OMAP_DSS_VIDEO1)
 		info.global_alpha = 255;
 	else
-		info.global_alpha = simple_strtoul(buf, NULL, 10);
+		info.global_alpha = alpha;
 
 	r = ovl->set_overlay_info(ovl, &info);
 	if (r)
@@ -268,8 +277,13 @@ static ssize_t overlay_pre_mult_alpha_store(struct omap_overlay *ovl,
 		const char *buf, size_t size)
 {
 	int r;
+	u8 alpha;
 	struct omap_overlay_info info;
 
+	r = kstrtou8(buf, 0, &alpha);
+	if (r)
+		return r;
+
 	ovl->get_overlay_info(ovl, &info);
 
 	/* only GFX and Video2 plane support pre alpha multiplied
@@ -279,7 +293,7 @@ static ssize_t overlay_pre_mult_alpha_store(struct omap_overlay *ovl,
 		ovl->id == OMAP_DSS_VIDEO1)
 		info.pre_mult_alpha = 0;
 	else
-		info.pre_mult_alpha = simple_strtoul(buf, NULL, 10);
+		info.pre_mult_alpha = alpha;
 
 	r = ovl->set_overlay_info(ovl, &info);
 	if (r)
diff --git a/drivers/video/omap2/omapfb/omapfb-sysfs.c b/drivers/video/omap2/omapfb/omapfb-sysfs.c
index 6f9c72c..672da54 100644
--- a/drivers/video/omap2/omapfb/omapfb-sysfs.c
+++ b/drivers/video/omap2/omapfb/omapfb-sysfs.c
@@ -50,10 +50,12 @@ static ssize_t store_rotate_type(struct device *dev,
 	struct fb_info *fbi = dev_get_drvdata(dev);
 	struct omapfb_info *ofbi = FB2OFB(fbi);
 	struct omapfb2_mem_region *rg;
-	enum omap_dss_rotation_type rot_type;
+	int rot_type;
 	int r;
 
-	rot_type = simple_strtoul(buf, NULL, 0);
+	r = kstrtoint(buf, 0, &rot_type);
+	if (r)
+		return r;
 
 	if (rot_type != OMAP_DSS_ROT_DMA && rot_type != OMAP_DSS_ROT_VRFB)
 		return -EINVAL;
@@ -102,14 +104,15 @@ static ssize_t store_mirror(struct device *dev,
 {
 	struct fb_info *fbi = dev_get_drvdata(dev);
 	struct omapfb_info *ofbi = FB2OFB(fbi);
-	unsigned long mirror;
+	int mirror;
 	int r;
 	struct fb_var_screeninfo new_var;
 
-	mirror = simple_strtoul(buf, NULL, 0);
+	r = kstrtoint(buf, 0, &mirror);
+	if (r)
+		return r;
 
-	if (mirror != 0 && mirror != 1)
-		return -EINVAL;
+	mirror = !!mirror;
 
 	if (!lock_fb_info(fbi))
 		return -ENODEV;
@@ -445,7 +448,11 @@ static ssize_t store_size(struct device *dev, struct device_attribute *attr,
 	int r;
 	int i;
 
-	size = PAGE_ALIGN(simple_strtoul(buf, NULL, 0));
+	r = kstrtoul(buf, 0, &size);
+	if (r)
+		return r;
+
+	size = PAGE_ALIGN(size);
 
 	if (!lock_fb_info(fbi))
 		return -ENODEV;
-- 
1.7.1


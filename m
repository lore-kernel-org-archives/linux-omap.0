From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 05/10] OMAP: DSS2: string parsing cleanups
Date: Mon, 22 Aug 2011 11:27:46 +0300
Message-ID: <1314001671-18123-6-git-send-email-tomi.valkeinen@ti.com>
References: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:52195 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755674Ab1HVI2O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 04:28:14 -0400
In-Reply-To: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use strtobool and kstrto* functions when parsing sysfs inputs.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/display.c |   21 +++++++++------------
 drivers/video/omap2/dss/manager.c |   37 +++++++++++++++++++------------------
 drivers/video/omap2/dss/overlay.c |    7 +++----
 3 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 94495e4..2c6e2bc 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -45,14 +45,13 @@ static ssize_t display_enabled_store(struct device *dev,
 		const char *buf, size_t size)
 {
 	struct omap_dss_device *dssdev = to_dss_device(dev);
-	int r, enabled;
+	int r;
+	bool enabled;
 
-	r = kstrtoint(buf, 0, &enabled);
+	r = strtobool(buf, &enabled);
 	if (r)
 		return r;
 
-	enabled = !!enabled;
-
 	if (enabled != (dssdev->state != OMAP_DSS_DISPLAY_DISABLED)) {
 		if (enabled) {
 			r = dssdev->driver->enable(dssdev);
@@ -79,17 +78,16 @@ static ssize_t display_tear_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t size)
 {
 	struct omap_dss_device *dssdev = to_dss_device(dev);
-	int te, r;
+	int r;
+	bool te;
 
 	if (!dssdev->driver->enable_te || !dssdev->driver->get_te)
 		return -ENOENT;
 
-	r = kstrtoint(buf, 0, &te);
+	r = strtobool(buf, &te);
 	if (r)
 		return r;
 
-	te = !!te;
-
 	r = dssdev->driver->enable_te(dssdev, te);
 	if (r)
 		return r;
@@ -195,17 +193,16 @@ static ssize_t display_mirror_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t size)
 {
 	struct omap_dss_device *dssdev = to_dss_device(dev);
-	int mirror, r;
+	int r;
+	bool mirror;
 
 	if (!dssdev->driver->set_mirror || !dssdev->driver->get_mirror)
 		return -ENOENT;
 
-	r = kstrtoint(buf, 0, &mirror);
+	r = strtobool(buf, &mirror);
 	if (r)
 		return r;
 
-	mirror = !!mirror;
-
 	r = dssdev->driver->set_mirror(dssdev, mirror);
 	if (r)
 		return r;
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index b9c4fb0..2e5d728 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -106,7 +106,7 @@ put_device:
 static ssize_t manager_default_color_show(struct omap_overlay_manager *mgr,
 					  char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", mgr->info.default_color);
+	return snprintf(buf, PAGE_SIZE, "%#x\n", mgr->info.default_color);
 }
 
 static ssize_t manager_default_color_store(struct omap_overlay_manager *mgr,
@@ -116,8 +116,9 @@ static ssize_t manager_default_color_store(struct omap_overlay_manager *mgr,
 	u32 color;
 	int r;
 
-	if (sscanf(buf, "%d", &color) != 1)
-		return -EINVAL;
+	r = kstrtouint(buf, 0, &color);
+	if (r)
+		return r;
 
 	mgr->get_manager_info(mgr, &info);
 
@@ -184,7 +185,7 @@ static ssize_t manager_trans_key_type_store(struct omap_overlay_manager *mgr,
 static ssize_t manager_trans_key_value_show(struct omap_overlay_manager *mgr,
 					    char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", mgr->info.trans_key);
+	return snprintf(buf, PAGE_SIZE, "%#x\n", mgr->info.trans_key);
 }
 
 static ssize_t manager_trans_key_value_store(struct omap_overlay_manager *mgr,
@@ -194,8 +195,9 @@ static ssize_t manager_trans_key_value_store(struct omap_overlay_manager *mgr,
 	u32 key_value;
 	int r;
 
-	if (sscanf(buf, "%d", &key_value) != 1)
-		return -EINVAL;
+	r = kstrtouint(buf, 0, &key_value);
+	if (r)
+		return r;
 
 	mgr->get_manager_info(mgr, &info);
 
@@ -222,15 +224,16 @@ static ssize_t manager_trans_key_enabled_store(struct omap_overlay_manager *mgr,
 					       const char *buf, size_t size)
 {
 	struct omap_overlay_manager_info info;
-	int enable;
+	bool enable;
 	int r;
 
-	if (sscanf(buf, "%d", &enable) != 1)
-		return -EINVAL;
+	r = strtobool(buf, &enable);
+	if (r)
+		return r;
 
 	mgr->get_manager_info(mgr, &info);
 
-	info.trans_enabled = enable ? true : false;
+	info.trans_enabled = enable;
 
 	r = mgr->set_manager_info(mgr, &info);
 	if (r)
@@ -254,15 +257,16 @@ static ssize_t manager_alpha_blending_enabled_store(
 		const char *buf, size_t size)
 {
 	struct omap_overlay_manager_info info;
-	int enable;
+	bool enable;
 	int r;
 
-	if (sscanf(buf, "%d", &enable) != 1)
-		return -EINVAL;
+	r = strtobool(buf, &enable);
+	if (r)
+		return r;
 
 	mgr->get_manager_info(mgr, &info);
 
-	info.alpha_enabled = enable ? true : false;
+	info.alpha_enabled = enable;
 
 	r = mgr->set_manager_info(mgr, &info);
 	if (r)
@@ -285,19 +289,16 @@ static ssize_t manager_cpr_enable_store(struct omap_overlay_manager *mgr,
 		const char *buf, size_t size)
 {
 	struct omap_overlay_manager_info info;
-	int v;
 	int r;
 	bool enable;
 
 	if (!dss_has_feature(FEAT_CPR))
 		return -ENODEV;
 
-	r = kstrtoint(buf, 0, &v);
+	r = strtobool(buf, &enable);
 	if (r)
 		return r;
 
-	enable = !!v;
-
 	mgr->get_manager_info(mgr, &info);
 
 	if (info.cpr_enable == enable)
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index a95f25e..b2a5685 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -211,17 +211,16 @@ static ssize_t overlay_enabled_show(struct omap_overlay *ovl, char *buf)
 static ssize_t overlay_enabled_store(struct omap_overlay *ovl, const char *buf,
 		size_t size)
 {
-	int r, enable;
+	int r;
+	bool enable;
 	struct omap_overlay_info info;
 
 	ovl->get_overlay_info(ovl, &info);
 
-	r = kstrtoint(buf, 0, &enable);
+	r = strtobool(buf, &enable);
 	if (r)
 		return r;
 
-	info.enabled = !!enable;
-
 	r = ovl->set_overlay_info(ovl, &info);
 	if (r)
 		return r;
-- 
1.7.4.1


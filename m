From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 07/23] OMAP: DSS2: check lock_fb_info() return value
Date: Tue, 18 May 2010 15:34:58 +0300
Message-ID: <1274186114-26951-8-git-send-email-tomi.valkeinen@nokia.com>
References: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:53432 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757523Ab0ERMgS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:36:18 -0400
In-Reply-To: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Cc: Jani Nikula <ext-jani.1.nikula@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Give up if lock_fb_info() fails, following the same convention as other
lock_fb_info() users.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/omapfb/omapfb-ioctl.c |    3 ++-
 drivers/video/omap2/omapfb/omapfb-sysfs.c |   21 ++++++++++++++-------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index 2c0f01c..9c73618 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -183,7 +183,8 @@ int omapfb_update_window(struct fb_info *fbi,
 	struct omapfb2_device *fbdev = ofbi->fbdev;
 	int r;
 
-	lock_fb_info(fbi);
+	if (!lock_fb_info(fbi))
+		return -ENODEV;
 	omapfb_lock(fbdev);
 
 	r = omapfb_update_window_nolock(fbi, x, y, w, h);
diff --git a/drivers/video/omap2/omapfb/omapfb-sysfs.c b/drivers/video/omap2/omapfb/omapfb-sysfs.c
index e104450..5179219 100644
--- a/drivers/video/omap2/omapfb/omapfb-sysfs.c
+++ b/drivers/video/omap2/omapfb/omapfb-sysfs.c
@@ -57,7 +57,8 @@ static ssize_t store_rotate_type(struct device *dev,
 	if (rot_type != OMAP_DSS_ROT_DMA && rot_type != OMAP_DSS_ROT_VRFB)
 		return -EINVAL;
 
-	lock_fb_info(fbi);
+	if (!lock_fb_info(fbi))
+		return -ENODEV;
 
 	r = 0;
 	if (rot_type == ofbi->rotation_type)
@@ -105,7 +106,8 @@ static ssize_t store_mirror(struct device *dev,
 	if (mirror != 0 && mirror != 1)
 		return -EINVAL;
 
-	lock_fb_info(fbi);
+	if (!lock_fb_info(fbi))
+		return -ENODEV;
 
 	ofbi->mirror = mirror;
 
@@ -137,7 +139,8 @@ static ssize_t show_overlays(struct device *dev,
 	ssize_t l = 0;
 	int t;
 
-	lock_fb_info(fbi);
+	if (!lock_fb_info(fbi))
+		return -ENODEV;
 	omapfb_lock(fbdev);
 
 	for (t = 0; t < ofbi->num_overlays; t++) {
@@ -195,7 +198,8 @@ static ssize_t store_overlays(struct device *dev, struct device_attribute *attr,
 	if (buf[len - 1] == '\n')
 		len = len - 1;
 
-	lock_fb_info(fbi);
+	if (!lock_fb_info(fbi))
+		return -ENODEV;
 	omapfb_lock(fbdev);
 
 	if (len > 0) {
@@ -317,7 +321,8 @@ static ssize_t show_overlays_rotate(struct device *dev,
 	ssize_t l = 0;
 	int t;
 
-	lock_fb_info(fbi);
+	if (!lock_fb_info(fbi))
+		return -ENODEV;
 
 	for (t = 0; t < ofbi->num_overlays; t++) {
 		l += snprintf(buf + l, PAGE_SIZE - l, "%s%d",
@@ -345,7 +350,8 @@ static ssize_t store_overlays_rotate(struct device *dev,
 	if (buf[len - 1] == '\n')
 		len = len - 1;
 
-	lock_fb_info(fbi);
+	if (!lock_fb_info(fbi))
+		return -ENODEV;
 
 	if (len > 0) {
 		char *p = (char *)buf;
@@ -416,7 +422,8 @@ static ssize_t store_size(struct device *dev, struct device_attribute *attr,
 
 	size = PAGE_ALIGN(simple_strtoul(buf, NULL, 0));
 
-	lock_fb_info(fbi);
+	if (!lock_fb_info(fbi))
+		return -ENODEV;
 
 	for (i = 0; i < ofbi->num_overlays; i++) {
 		if (ofbi->overlays[i]->info.enabled) {
-- 
1.7.0.4


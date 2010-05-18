From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 06/23] OMAP: DSS2: fix lock_fb_info() and omapfb_lock() locking order
Date: Tue, 18 May 2010 15:34:57 +0300
Message-ID: <1274186114-26951-7-git-send-email-tomi.valkeinen@nokia.com>
References: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:57895 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756206Ab0ERMgA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:36:00 -0400
In-Reply-To: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Cc: Jani Nikula <ext-jani.1.nikula@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Framebuffer ioctl processing forces lock_fb_info() -> omapfb_lock()
locking order. Follow that order to avoid possible circular locking
dependency, detected by lockdep.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/omapfb/omapfb-ioctl.c |    4 ++--
 drivers/video/omap2/omapfb/omapfb-sysfs.c |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index 1ffa760..2c0f01c 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -183,13 +183,13 @@ int omapfb_update_window(struct fb_info *fbi,
 	struct omapfb2_device *fbdev = ofbi->fbdev;
 	int r;
 
-	omapfb_lock(fbdev);
 	lock_fb_info(fbi);
+	omapfb_lock(fbdev);
 
 	r = omapfb_update_window_nolock(fbi, x, y, w, h);
 
-	unlock_fb_info(fbi);
 	omapfb_unlock(fbdev);
+	unlock_fb_info(fbi);
 
 	return r;
 }
diff --git a/drivers/video/omap2/omapfb/omapfb-sysfs.c b/drivers/video/omap2/omapfb/omapfb-sysfs.c
index 62bb88f..e104450 100644
--- a/drivers/video/omap2/omapfb/omapfb-sysfs.c
+++ b/drivers/video/omap2/omapfb/omapfb-sysfs.c
@@ -137,8 +137,8 @@ static ssize_t show_overlays(struct device *dev,
 	ssize_t l = 0;
 	int t;
 
-	omapfb_lock(fbdev);
 	lock_fb_info(fbi);
+	omapfb_lock(fbdev);
 
 	for (t = 0; t < ofbi->num_overlays; t++) {
 		struct omap_overlay *ovl = ofbi->overlays[t];
@@ -154,8 +154,8 @@ static ssize_t show_overlays(struct device *dev,
 
 	l += snprintf(buf + l, PAGE_SIZE - l, "\n");
 
-	unlock_fb_info(fbi);
 	omapfb_unlock(fbdev);
+	unlock_fb_info(fbi);
 
 	return l;
 }
@@ -195,8 +195,8 @@ static ssize_t store_overlays(struct device *dev, struct device_attribute *attr,
 	if (buf[len - 1] == '\n')
 		len = len - 1;
 
-	omapfb_lock(fbdev);
 	lock_fb_info(fbi);
+	omapfb_lock(fbdev);
 
 	if (len > 0) {
 		char *p = (char *)buf;
@@ -303,8 +303,8 @@ static ssize_t store_overlays(struct device *dev, struct device_attribute *attr,
 
 	r = count;
 out:
-	unlock_fb_info(fbi);
 	omapfb_unlock(fbdev);
+	unlock_fb_info(fbi);
 
 	return r;
 }
-- 
1.7.0.4


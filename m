From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] fbdev: omap2: Fix format string mismatch in display-sysfs.c
Date: Mon, 28 Apr 2014 19:54:15 +0900
Message-ID: <1398682455-21043-1-git-send-email-standby24x7@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:43687 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296AbaD1Kyg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2014 06:54:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Masanari Iida <standby24x7@gmail.com>

Fix two format string mismatch in display-sysfs.c

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/video/fbdev/omap2/dss/display-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/display-sysfs.c b/drivers/video/fbdev/omap2/dss/display-sysfs.c
index 5a2095a..5928bc9 100644
--- a/drivers/video/fbdev/omap2/dss/display-sysfs.c
+++ b/drivers/video/fbdev/omap2/dss/display-sysfs.c
@@ -184,7 +184,7 @@ static ssize_t display_rotate_show(struct device *dev,
 	if (!dssdev->driver->get_rotate)
 		return -ENOENT;
 	rotate = dssdev->driver->get_rotate(dssdev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", rotate);
+	return snprintf(buf, PAGE_SIZE, "%d\n", rotate);
 }
 
 static ssize_t display_rotate_store(struct device *dev,
@@ -215,7 +215,7 @@ static ssize_t display_mirror_show(struct device *dev,
 	if (!dssdev->driver->get_mirror)
 		return -ENOENT;
 	mirror = dssdev->driver->get_mirror(dssdev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", mirror);
+	return snprintf(buf, PAGE_SIZE, "%d\n", mirror);
 }
 
 static ssize_t display_mirror_store(struct device *dev,
-- 
2.0.0.rc1


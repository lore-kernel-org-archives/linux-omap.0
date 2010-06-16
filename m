From: "Nagarajan, Rajkumar" <x0133774@ti.com>
Subject: [PATCH] OMAP: DSS2: Switching GFX from LCD to TV
Date: Wed, 16 Jun 2010 19:45:42 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B6701706BD9A44BC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55388 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189Ab0FPOPp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 10:15:45 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o5GEFgNq014081
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Jun 2010 09:15:45 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o5GEFgnq012463
	for <linux-omap@vger.kernel.org>; Wed, 16 Jun 2010 19:45:42 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 53711271c3f22c8038f4961a9f9c2035b3e82d7f Mon Sep 17 00:00:00 2001
From: Sujeet Baranwal <s-baranwal@ti.com>
Date: Tue, 1 Jun 2010 19:29:24 +0530
Subject: [PATCH] OMAP: DSS2: Switching GFX from LCD to TV

1. Added a sysfs entry for setting overlay  input_size
in order to switch the GFX pipeline from LCD to TV.
2. the following sysfx entry has been added

echo "width,height" > /sys/devices/platform/omapdss/overlay0/input_size

Signed-off-by: Srinivas Pulukuru <srinivas.pulukuru@ti.com>
Signed-off-by: Sujeet Baranwal <s-baranwal@ti.com>
Acked-by: Axel Castaneda <x0055901@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Rajkumar N <rajkumar.nagarajan@ti.com>
---
 drivers/video/omap2/dss/overlay.c        |   33 +++++++++++++++++++++++++++++-
 drivers/video/omap2/omapfb/omapfb-main.c |    7 ++++++
 2 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 8233658..4e9966f 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -117,6 +117,36 @@ static ssize_t overlay_input_size_show(struct omap_overlay *ovl, char *buf)
 			ovl->info.width, ovl->info.height);
 }
 
+static ssize_t overlay_input_size_store(struct omap_overlay *ovl,
+		const char *buf, size_t size)
+{
+	int r;
+	char *last;
+	struct omap_overlay_info info;
+
+	ovl->get_overlay_info(ovl, &info);
+
+	info.width = simple_strtoul(buf, &last, 10);
+	++last;
+	if (last - buf >= size)
+		return -EINVAL;
+
+	info.height = simple_strtoul(last, &last, 10);
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
+
 static ssize_t overlay_screen_width_show(struct omap_overlay *ovl, char *buf)
 {
 	return snprintf(buf, PAGE_SIZE, "%d\n", ovl->info.screen_width);
@@ -268,7 +298,8 @@ struct overlay_attribute {
 static OVERLAY_ATTR(name, S_IRUGO, overlay_name_show, NULL);
 static OVERLAY_ATTR(manager, S_IRUGO|S_IWUSR,
 		overlay_manager_show, overlay_manager_store);
-static OVERLAY_ATTR(input_size, S_IRUGO, overlay_input_size_show, NULL);
+static OVERLAY_ATTR(input_size, S_IRUGO|S_IWUSR,
+		overlay_input_size_show, overlay_input_size_store);
 static OVERLAY_ATTR(screen_width, S_IRUGO, overlay_screen_width_show, NULL);
 static OVERLAY_ATTR(position, S_IRUGO|S_IWUSR,
 		overlay_position_show, overlay_position_store);
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 4b4506d..73ecc9f 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -46,6 +46,8 @@ static char *def_vram;
 static int def_vrfb;
 static int def_rotate;
 static int def_mirror;
+unsigned int omapfb_size;
+module_param_named(fb_size, omapfb_size, int, 0644);
 
 #ifdef DEBUG
 unsigned int omapfb_debug;
@@ -1444,6 +1446,11 @@ static int omapfb_alloc_fbmem_display(struct fb_info *fbi, unsigned long size,
 		}
 	}
 
+	if (omapfb_size)	{
+		if (omapfb_size > size)
+			size = omapfb_size;
+	}
+
 	if (!size)
 		return 0;
 
-- 
1.5.4.3

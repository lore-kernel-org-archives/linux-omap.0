From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/16] OMAPFB: remove mem info from platform_data
Date: Tue, 24 Jan 2012 12:00:24 +0200
Message-ID: <1327399231-20826-10-git-send-email-tomi.valkeinen@ti.com>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:46922 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755921Ab2AXKBB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 05:01:01 -0500
In-Reply-To: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, tony@atomide.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

omapfb driver used platform_data to get fb memory areas and formats
defined by the board file.

This patch removes omapfb's (both old and new omapfb) use of the
memory data in platform_data, because:

- No board uses them currently
- It's not board file's job to define things like amount of default
  framebuffer memory. These should come from the bootloader via command
  line parameters.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap/omapfb_main.c         |    5 ---
 drivers/video/omap2/omapfb/omapfb-main.c |   43 ------------------------------
 include/linux/omapfb.h                   |    1 -
 3 files changed, 0 insertions(+), 49 deletions(-)

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index aaf0990..3d2e147 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -157,11 +157,6 @@ static int ctrl_init(struct omapfb_device *fbdev)
 			fbdev->mem_desc.region[i].size =
 				PAGE_ALIGN(def_vram[i]);
 		fbdev->mem_desc.region_cnt = i;
-	} else {
-		struct omapfb_platform_data *conf;
-
-		conf = fbdev->dev->platform_data;
-		fbdev->mem_desc = conf->mem_desc;
 	}
 
 	if (!fbdev->mem_desc.region_cnt) {
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 17e7320b..4c28d57 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1614,23 +1614,6 @@ static int omapfb_allocate_all_fbs(struct omapfb2_device *fbdev)
 		memset(&vram_paddrs, 0, sizeof(vram_paddrs));
 	}
 
-	if (fbdev->dev->platform_data) {
-		struct omapfb_platform_data *opd;
-		opd = fbdev->dev->platform_data;
-		for (i = 0; i < opd->mem_desc.region_cnt; ++i) {
-			if (!vram_sizes[i]) {
-				unsigned long size;
-				unsigned long paddr;
-
-				size = opd->mem_desc.region[i].size;
-				paddr = opd->mem_desc.region[i].paddr;
-
-				vram_sizes[i] = size;
-				vram_paddrs[i] = paddr;
-			}
-		}
-	}
-
 	for (i = 0; i < fbdev->num_fbs; i++) {
 		/* allocate memory automatically only for fb0, or if
 		 * excplicitly defined with vram or plat data option */
@@ -1828,32 +1811,6 @@ static int omapfb_fb_init(struct omapfb2_device *fbdev, struct fb_info *fbi)
 
 	var->rotate = def_rotate;
 
-	/*
-	 * Check if there is a default color format set in the board file,
-	 * and use this format instead the default deducted from the
-	 * display bpp.
-	 */
-	if (fbdev->dev->platform_data) {
-		struct omapfb_platform_data *opd;
-		int id = ofbi->id;
-
-		opd = fbdev->dev->platform_data;
-		if (opd->mem_desc.region[id].format_used) {
-			enum omap_color_mode mode;
-			enum omapfb_color_format format;
-
-			format = opd->mem_desc.region[id].format;
-			mode = fb_format_to_dss_mode(format);
-			if (mode < 0) {
-				r = mode;
-				goto err;
-			}
-			r = dss_mode_to_fb_mode(mode, var);
-			if (r < 0)
-				goto err;
-		}
-	}
-
 	if (display) {
 		u16 w, h;
 		int rotation = (var->rotate + ofbi->rotation[0]) % 4;
diff --git a/include/linux/omapfb.h b/include/linux/omapfb.h
index 7ab9ceb..03f5255 100644
--- a/include/linux/omapfb.h
+++ b/include/linux/omapfb.h
@@ -249,7 +249,6 @@ struct omapfb_mem_desc {
 
 struct omapfb_platform_data {
 	struct omap_lcd_config		lcd;
-	struct omapfb_mem_desc		mem_desc;
 };
 
 /* in arch/arm/plat-omap/fb.c */
-- 
1.7.4.1


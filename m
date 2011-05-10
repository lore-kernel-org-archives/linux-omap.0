From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 8/8] OMAP: DSS2: OMAPFB: Reduce stack usage
Date: Tue, 10 May 2011 19:24:16 +0300
Message-ID: <1305044656-31512-9-git-send-email-tomi.valkeinen@ti.com>
References: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:49329 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932986Ab1EJQYo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 May 2011 12:24:44 -0400
In-Reply-To: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

omapfb_mode_to_timings() had struct fb_info, struct fb_var and struct
fb_ops allocated from stack. This caused the stack usage grow quite
high.

Use kzalloc to allocate the structs instead.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |   49 +++++++++++++++++-------------
 1 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 30c958b..ae3e2be 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1996,9 +1996,9 @@ static int omapfb_create_framebuffers(struct omapfb2_device *fbdev)
 static int omapfb_mode_to_timings(const char *mode_str,
 		struct omap_video_timings *timings, u8 *bpp)
 {
-	struct fb_info fbi;
-	struct fb_var_screeninfo var;
-	struct fb_ops fbops;
+	struct fb_info *fbi;
+	struct fb_var_screeninfo *var;
+	struct fb_ops *fbops;
 	int r;
 
 #ifdef CONFIG_OMAP2_DSS_VENC
@@ -2016,25 +2016,25 @@ static int omapfb_mode_to_timings(const char *mode_str,
 	/* this is quite a hack, but I wanted to use the modedb and for
 	 * that we need fb_info and var, so we create dummy ones */
 
-	memset(&fbi, 0, sizeof(fbi));
-	memset(&var, 0, sizeof(var));
-	memset(&fbops, 0, sizeof(fbops));
-	fbi.fbops = &fbops;
+	fbi = kzalloc(sizeof(*fbi), GFP_KERNEL);
+	var = kzalloc(sizeof(*var), GFP_KERNEL);
+	fbops = kzalloc(sizeof(*fbops), GFP_KERNEL);
+	fbi->fbops = fbops;
 
-	r = fb_find_mode(&var, &fbi, mode_str, NULL, 0, NULL, 24);
+	r = fb_find_mode(var, fbi, mode_str, NULL, 0, NULL, 24);
 
 	if (r != 0) {
-		timings->pixel_clock = PICOS2KHZ(var.pixclock);
-		timings->hbp = var.left_margin;
-		timings->hfp = var.right_margin;
-		timings->vbp = var.upper_margin;
-		timings->vfp = var.lower_margin;
-		timings->hsw = var.hsync_len;
-		timings->vsw = var.vsync_len;
-		timings->x_res = var.xres;
-		timings->y_res = var.yres;
-
-		switch (var.bits_per_pixel) {
+		timings->pixel_clock = PICOS2KHZ(var->pixclock);
+		timings->hbp = var->left_margin;
+		timings->hfp = var->right_margin;
+		timings->vbp = var->upper_margin;
+		timings->vfp = var->lower_margin;
+		timings->hsw = var->hsync_len;
+		timings->vsw = var->vsync_len;
+		timings->x_res = var->xres;
+		timings->y_res = var->yres;
+
+		switch (var->bits_per_pixel) {
 		case 16:
 			*bpp = 16;
 			break;
@@ -2045,10 +2045,17 @@ static int omapfb_mode_to_timings(const char *mode_str,
 			break;
 		}
 
-		return 0;
+		r = 0;
 	} else {
-		return -EINVAL;
+		*bpp = 0;
+		r = -EINVAL;
 	}
+
+	kfree(fbi);
+	kfree(var);
+	kfree(fbops);
+
+	return r;
 }
 
 static int omapfb_set_def_mode(struct omapfb2_device *fbdev,
-- 
1.7.4.1


From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH 12/20] omapfb: Add support for rotation on the Blizzard LCD ctrl
Date: Thu,  4 Jun 2009 20:52:37 +0300
Message-ID: <5dfa68a13340c793f25f12815e5055f9c2eda1a5.1244131952.git.imre.deak@nokia.com>
References: <1244137965-8937-1-git-send-email-imre.deak@nokia.com>
 <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
 <e7f92ea9f0a823f7be401e34243754141b7f72c1.1244131952.git.imre.deak@nokia.com>
 <e9040774f324311979aebd3fa5fa71d20890d433.1244131952.git.imre.deak@nokia.com>
 <833ed44e61e3d4093eb27b55b97252967e042d41.1244131952.git.imre.deak@nokia.com>
 <5ba715a9dbc88b8c3a8225bc1cfdabd3faffe00f.1244131952.git.imre.deak@nokia.com>
 <646692ce09a12e1a8a2d4072097b4d440b7de5d5.1244131952.git.imre.deak@nokia.com>
 <b0e578438bb53d9fbf333e5bd10d4d33f869b373.1244131952.git.imre.deak@nokia.com>
 <9139035cc12b22600135677cd5d3096c1dcd286d.1244131952.git.imre.deak@nokia.com>
 <08ba068bda363adf4cb8a1f5afe11245c828d017.1244131952.git.imre.deak@nokia.com>
 <057471246e776de4c452b4ba2ebf2a4579f3171c.1244131952.git.imre.deak@nokia.com>
 <310d4aa52bfd6dd15664286643ca8a9703787dce.1244131952.git.imre.deak@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:42190 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbZFDRzv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 13:55:51 -0400
In-Reply-To: <310d4aa52bfd6dd15664286643ca8a9703787dce.1244131952.git.imre.deak@nokia.com>
In-Reply-To: <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
References: <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <Tomi.Valkeinen@nokia.com>, Rodrigo Vivi <rodrigo.vivi@openbossa.org>, Imre Deak <imre.deak@nokia.com>

From: Rodrigo Vivi <rodrigo.vivi@openbossa.org>

The LCD controller (EPSON S1D13744) supports rotation (0, 90, 180
and 270 degrees) on hardware just setting the bits 0 and 1 of 0x28
register (LCD Panel Configuration Register). Now it is possible to
use this caps only setting the angle degree on var rotate of
fb_var_screeninfo using the FBIOPUT_VSCREENINFO ioctl.

Signed-off-by: Rodrigo Vivi <rodrigo.vivi@openbossa.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Fixed-by: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Signed-off-by: Imre Deak <imre.deak@nokia.com>
---
 drivers/video/omap/blizzard.c    |   91 +++++++++++++++++++++++++++++++++++--
 drivers/video/omap/omapfb_main.c |   52 ++++++++++++++++------
 2 files changed, 124 insertions(+), 19 deletions(-)

diff --git a/drivers/video/omap/blizzard.c b/drivers/video/omap/blizzard.c
index 9dfcf39..d5e5955 100644
--- a/drivers/video/omap/blizzard.c
+++ b/drivers/video/omap/blizzard.c
@@ -44,6 +44,7 @@
 #define BLIZZARD_CLK_SRC			0x0e
 #define BLIZZARD_MEM_BANK0_ACTIVATE		0x10
 #define BLIZZARD_MEM_BANK0_STATUS		0x14
+#define BLIZZARD_PANEL_CONFIGURATION		0x28
 #define BLIZZARD_HDISP				0x2a
 #define BLIZZARD_HNDP				0x2c
 #define BLIZZARD_VDISP0				0x2e
@@ -162,6 +163,10 @@ struct blizzard_struct {
 	int			vid_scaled;
 	int			last_color_mode;
 	int			zoom_on;
+	int			zoom_area_gx1;
+	int			zoom_area_gx2;
+	int			zoom_area_gy1;
+	int			zoom_area_gy2;
 	int			screen_width;
 	int			screen_height;
 	unsigned		te_connected:1;
@@ -513,6 +518,13 @@ static int do_full_screen_update(struct blizzard_request *req)
 	return REQ_PENDING;
 }
 
+static int check_1d_intersect(int a1, int a2, int b1, int b2)
+{
+	if (a2 <= b1 || b2 <= a1)
+		return 0;
+	return 1;
+}
+
 /* Setup all planes with an overlapping area with the update window. */
 static int do_partial_update(struct blizzard_request *req, int plane,
 			     int x, int y, int w, int h,
@@ -525,6 +537,7 @@ static int do_partial_update(struct blizzard_request *req, int plane,
 	int color_mode;
 	int flags;
 	int zoom_off;
+	int have_zoom_for_this_update = 0;
 
 	/* Global coordinates, relative to pixel 0,0 of the LCD */
 	gx1 = x + blizzard.plane[plane].pos_x;
@@ -544,10 +557,6 @@ static int do_partial_update(struct blizzard_request *req, int plane,
 		gx2_out = gx1_out + w_out;
 		gy2_out = gy1_out + h_out;
 	}
-	zoom_off = blizzard.zoom_on && gx1 == 0 && gy1 == 0 &&
-		w == blizzard.screen_width && h == blizzard.screen_height;
-	blizzard.zoom_on = (!zoom_off && blizzard.zoom_on) ||
-			   (w < w_out || h < h_out);
 
 	for (i = 0; i < OMAPFB_PLANE_NUM; i++) {
 		struct plane_info *p = &blizzard.plane[i];
@@ -653,8 +662,49 @@ static int do_partial_update(struct blizzard_request *req, int plane,
 	else
 		disable_tearsync();
 
+	if ((gx2_out - gx1_out) != (gx2 - gx1) ||
+	    (gy2_out - gy1_out) != (gy2 - gy1))
+		have_zoom_for_this_update = 1;
+
+	/* 'background' type of screen update (as opposed to 'destructive')
+	   can be used to disable scaling if scaling is active */
+	zoom_off = blizzard.zoom_on && !have_zoom_for_this_update &&
+	    (gx1_out == 0) && (gx2_out == blizzard.screen_width) &&
+	    (gy1_out == 0) && (gy2_out == blizzard.screen_height) &&
+	    (gx1 == 0) && (gy1 == 0);
+
+	if (blizzard.zoom_on && !have_zoom_for_this_update && !zoom_off &&
+	    check_1d_intersect(blizzard.zoom_area_gx1, blizzard.zoom_area_gx2,
+			       gx1_out, gx2_out) &&
+	    check_1d_intersect(blizzard.zoom_area_gy1, blizzard.zoom_area_gy2,
+			       gy1_out, gy2_out)) {
+		/* Previous screen update was using scaling, current update
+		 * is not using it. Additionally, current screen update is
+		 * going to overlap with the scaled area. Scaling needs to be
+		 * disabled in order to avoid 'magnifying glass' effect.
+		 * Dummy setup of background window can be used for this.
+		 */
+		set_window_regs(0, 0, blizzard.screen_width,
+				blizzard.screen_height,
+				0, 0, blizzard.screen_width,
+				blizzard.screen_height,
+				BLIZZARD_COLOR_RGB565, 1, flags);
+		blizzard.zoom_on = 0;
+	}
+
+	/* remember scaling settings if we have scaled update */
+	if (have_zoom_for_this_update) {
+		blizzard.zoom_on = 1;
+		blizzard.zoom_area_gx1 = gx1_out;
+		blizzard.zoom_area_gx2 = gx2_out;
+		blizzard.zoom_area_gy1 = gy1_out;
+		blizzard.zoom_area_gy2 = gy2_out;
+	}
+
 	set_window_regs(gx1, gy1, gx2, gy2, gx1_out, gy1_out, gx2_out, gy2_out,
 			color_mode, zoom_off, flags);
+	if (zoom_off)
+		blizzard.zoom_on = 0;
 
 	blizzard.extif->set_bits_per_cycle(16);
 	/* set_window_regs has left the register index at the right
@@ -908,6 +958,35 @@ static int blizzard_set_scale(int plane, int orig_w, int orig_h,
 	return 0;
 }
 
+static int blizzard_set_rotate(int angle)
+{
+	u32 l;
+
+	l = blizzard_read_reg(BLIZZARD_PANEL_CONFIGURATION);
+	l &= ~0x03;
+
+	switch (angle) {
+	case 0:
+		l = l | 0x00;
+		break;
+	case 90:
+		l = l | 0x03;
+		break;
+	case 180:
+		l = l | 0x02;
+		break;
+	case 270:
+		l = l | 0x01;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	blizzard_write_reg(BLIZZARD_PANEL_CONFIGURATION, l);
+
+	return 0;
+}
+
 static int blizzard_enable_plane(int plane, int enable)
 {
 	if (enable)
@@ -1285,7 +1364,8 @@ static void blizzard_get_caps(int plane, struct omapfb_caps *caps)
 	caps->ctrl |= OMAPFB_CAPS_MANUAL_UPDATE |
 		OMAPFB_CAPS_WINDOW_PIXEL_DOUBLE |
 		OMAPFB_CAPS_WINDOW_SCALE |
-		OMAPFB_CAPS_WINDOW_OVERLAY;
+		OMAPFB_CAPS_WINDOW_OVERLAY |
+		OMAPFB_CAPS_WINDOW_ROTATE;
 	if (blizzard.te_connected)
 		caps->ctrl |= OMAPFB_CAPS_TEARSYNC;
 	caps->wnd_color |= (1 << OMAPFB_COLOR_RGB565) |
@@ -1560,6 +1640,7 @@ struct lcd_ctrl blizzard_ctrl = {
 	.setup_plane		= blizzard_setup_plane,
 	.set_scale		= blizzard_set_scale,
 	.enable_plane		= blizzard_enable_plane,
+	.set_rotate		= blizzard_set_rotate,
 	.update_window		= blizzard_update_window_async,
 	.sync			= blizzard_sync,
 	.suspend		= blizzard_suspend,
diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index 060d72f..5b04b9c 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -67,6 +67,7 @@ static struct caps_table_struct ctrl_caps[] = {
 	{ OMAPFB_CAPS_WINDOW_PIXEL_DOUBLE, "pixel double window" },
 	{ OMAPFB_CAPS_WINDOW_SCALE,   "scale window" },
 	{ OMAPFB_CAPS_WINDOW_OVERLAY, "overlay window" },
+	{ OMAPFB_CAPS_WINDOW_ROTATE,  "rotate window" },
 	{ OMAPFB_CAPS_SET_BACKLIGHT,  "backlight setting" },
 };
 
@@ -215,6 +216,15 @@ static int ctrl_change_mode(struct fb_info *fbi)
 				 offset, var->xres_virtual,
 				 plane->info.pos_x, plane->info.pos_y,
 				 var->xres, var->yres, plane->color_mode);
+	if (r < 0)
+		return r;
+
+	if (fbdev->ctrl->set_rotate != NULL) {
+		r = fbdev->ctrl->set_rotate(var->rotate);
+		if (r < 0)
+			return r;
+	}
+
 	if (fbdev->ctrl->set_scale != NULL)
 		r = fbdev->ctrl->set_scale(plane->idx,
 				   var->xres, var->yres,
@@ -598,7 +608,7 @@ static void omapfb_rotate(struct fb_info *fbi, int rotate)
 	struct omapfb_device *fbdev = plane->fbdev;
 
 	omapfb_rqueue_lock(fbdev);
-	if (cpu_is_omap15xx() && rotate != fbi->var.rotate) {
+	if (rotate != fbi->var.rotate) {
 		struct fb_var_screeninfo *new_var = &fbdev->new_var;
 
 		memcpy(new_var, &fbi->var, sizeof(*new_var));
@@ -705,28 +715,42 @@ int omapfb_update_window_async(struct fb_info *fbi,
 				void (*callback)(void *),
 				void *callback_data)
 {
+	int xres, yres;
 	struct omapfb_plane_struct *plane = fbi->par;
 	struct omapfb_device *fbdev = plane->fbdev;
-	struct fb_var_screeninfo *var;
+	struct fb_var_screeninfo *var = &fbi->var;
+
+	switch (var->rotate) {
+	case 0:
+	case 180:
+		xres = fbdev->panel->x_res;
+		yres = fbdev->panel->y_res;
+		break;
+	case 90:
+	case 270:
+		xres = fbdev->panel->y_res;
+		yres = fbdev->panel->x_res;
+		break;
+	default:
+		return -EINVAL;
+	}
 
-	var = &fbi->var;
-	if (win->x >= var->xres || win->y >= var->yres ||
-	    win->out_x > var->xres || win->out_y >= var->yres)
+	if (win->x >= xres || win->y >= yres ||
+	    win->out_x > xres || win->out_y > yres)
 		return -EINVAL;
 
 	if (!fbdev->ctrl->update_window ||
 	    fbdev->ctrl->get_update_mode() != OMAPFB_MANUAL_UPDATE)
 		return -ENODEV;
 
-	if (win->x + win->width >= var->xres)
-		win->width = var->xres - win->x;
-	if (win->y + win->height >= var->yres)
-		win->height = var->yres - win->y;
-	/* The out sizes should be cropped to the LCD size */
-	if (win->out_x + win->out_width > fbdev->panel->x_res)
-		win->out_width = fbdev->panel->x_res - win->out_x;
-	if (win->out_y + win->out_height > fbdev->panel->y_res)
-		win->out_height = fbdev->panel->y_res - win->out_y;
+	if (win->x + win->width > xres)
+		win->width = xres - win->x;
+	if (win->y + win->height > yres)
+		win->height = yres - win->y;
+	if (win->out_x + win->out_width > xres)
+		win->out_width = xres - win->out_x;
+	if (win->out_y + win->out_height > yres)
+		win->out_height = yres - win->out_y;
 	if (!win->width || !win->height || !win->out_width || !win->out_height)
 		return 0;
 
-- 
1.6.3.1


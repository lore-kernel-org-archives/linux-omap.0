From: Jonathan McDowell <noodles@earth.li>
Subject: [PATCH 3/3] Add RGB444 support to OMAP FB driver.
Date: Sun, 2 Apr 2006 17:41:14 +0100
Message-ID: <20060402164114.GF26949@earth.li>
References: <20060402163614.GC26949@earth.li> <20060402163832.GD26949@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060402163832.GD26949@earth.li>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: e3-hacking@earth.li
List-Id: linux-omap@vger.kernel.org

This patch adds support for an RGB444 mode to the OMAP FB driver; it's
used by the Amstrad Delta which has a 12 bit DSTN screen setup in 444
mode.

Mark Underwood did the original work for this patch:

http://www.earth.li/pipermail/e3-hacking/2006-March/000376.html

I have simply updated to the latest git tree.

Signed-Off-By: Jonathan McDowell <noodles@earth.li>

diff -rupN -X linux-omap/Documentation/dontdiff linux-omap-lcd/drivers/video/omap/lcd_ams_delta.c linux-omap-lcd-444/drivers/video/omap/lcd_ams_delta.c
--- linux-omap-lcd/drivers/video/omap/lcd_ams_delta.c	2006-04-02 16:53:09.881449750 +0100
+++ linux-omap-lcd-444/drivers/video/omap/lcd_ams_delta.c	2006-04-02 17:21:04.654931750 +0100
@@ -77,7 +77,7 @@ struct lcd_panel ams_delta_panel = {
 	.name		= "ams-delta",
 	.config		= 0,
 
-	.bpp		= 16,
+	.bpp		= 12,
 	.data_lines	= 16,
 	.x_res		= 480,
 	.y_res		= 320,
diff -rupN -X linux-omap/Documentation/dontdiff linux-omap-lcd/drivers/video/omap/lcdc.c linux-omap-lcd-444/drivers/video/omap/lcdc.c
--- linux-omap-lcd/drivers/video/omap/lcdc.c	2006-04-02 16:56:46.278973750 +0100
+++ linux-omap-lcd-444/drivers/video/omap/lcdc.c	2006-04-02 17:21:47.105584750 +0100
@@ -353,6 +353,7 @@ static int omap_lcdc_setup_plane(int pla
 		omap_lcdc.palette_size = 512;
 		break;
 	case OMAPFB_COLOR_RGB565:
+	case OMAPFB_COLOR_RGB444:
 		omap_lcdc.bpp = 16;
 		omap_lcdc.palette_code = 0x4000;
 		omap_lcdc.palette_size = 32;
@@ -720,7 +721,11 @@ static int alloc_fbmem(int req_size)
 	int frame_size;
 	struct lcd_panel *panel = omap_lcdc.fbdev->panel;
 
-	frame_size = PAGE_ALIGN(panel->x_res * panel->bpp / 8 * panel->y_res);
+	if (panel->bpp == 12)
+		frame_size = PAGE_ALIGN(panel->x_res * 16 / 8 * panel->y_res);
+	else
+		frame_size = PAGE_ALIGN(panel->x_res * panel->bpp / 8 *
+				panel->y_res);
 	if (req_size > frame_size)
 		frame_size = req_size;
 	omap_lcdc.vram_size = frame_size;
diff -rupN -X linux-omap/Documentation/dontdiff linux-omap-lcd/drivers/video/omap/omapfb_main.c linux-omap-lcd-444/drivers/video/omap/omapfb_main.c
--- linux-omap-lcd/drivers/video/omap/omapfb_main.c	2006-04-02 15:52:24.524659500 +0100
+++ linux-omap-lcd-444/drivers/video/omap/omapfb_main.c	2006-04-02 17:25:23.947136500 +0100
@@ -239,6 +239,7 @@ static int _setcolreg(struct fb_info *in
 							transp, update_hw_pal);
 		/* Fallthrough */
 	case OMAPFB_COLOR_RGB565:
+	case OMAPFB_COLOR_RGB444:
 		if (r != 0)
 			break;
 
@@ -249,8 +250,14 @@ static int _setcolreg(struct fb_info *in
 
 		if (regno < 16) {
 			u16 pal;
-			pal = ((red >> 11) << 11) | ((green >> 10) << 5) |
-				(blue >> 11);
+			if (fbdev->color_mode == OMAPFB_COLOR_RGB444)
+				pal = ((red >> 12) << 8) |
+					((green >> 12) << 4) |
+					(blue >> 12);
+			else
+				pal = ((red >> 11) << 11) |
+					((green >> 10) << 5) |
+					(blue >> 11);
 			((u32 *)(info->pseudo_palette))[regno] = pal;
 		}
 		break;
@@ -402,12 +409,19 @@ static int set_fb_var(struct omapfb_devi
 	unsigned long	line_size;
 	struct lcd_panel *panel = fbdev->panel;
 
-	bpp = var->bits_per_pixel = panel->bpp;
+	if (panel->bpp == 12)
+		/* 12-bpp mode stores colours in 16 bits and ignores top 4 */
+		bpp = var->bits_per_pixel = 16;
+	else
+		bpp = var->bits_per_pixel = panel->bpp;
 
-	switch (bpp) {
+	switch (panel->bpp) {
 	case 16:
 		fbdev->color_mode = OMAPFB_COLOR_RGB565;
 		break;
+	case 12:
+		fbdev->color_mode = OMAPFB_COLOR_RGB444;
+		break;
 	case 8:
 		fbdev->color_mode = OMAPFB_COLOR_CLUT_8BPP;
 		break;
@@ -453,9 +467,21 @@ static int set_fb_var(struct omapfb_devi
 		var->yoffset = var->yres_virtual - var->yres;
 	line_size = var->xres * bpp / 8;
 
-	var->red.offset	 = 11; var->red.length	 = 5; var->red.msb_right   = 0;
-	var->green.offset= 5;  var->green.length = 6; var->green.msb_right = 0;
-	var->blue.offset = 0;  var->blue.length  = 5; var->blue.msb_right  = 0;
+	if (fbdev->color_mode == OMAPFB_COLOR_RGB444) {
+		var->red.offset	 = 8; var->red.length	= 4;
+		var->red.msb_right   = 0;
+		var->green.offset= 4; var->green.length = 4;
+		var->green.msb_right = 0;
+		var->blue.offset = 0; var->blue.length  = 4;
+		var->blue.msb_right  = 0;
+	} else {
+		var->red.offset	 = 11; var->red.length	 = 5;
+		var->red.msb_right   = 0;
+		var->green.offset= 5;  var->green.length = 6;
+		var->green.msb_right = 0;
+		var->blue.offset = 0;  var->blue.length  = 5;
+		var->blue.msb_right  = 0;
+	}
 
 	var->height		= -1;
 	var->width		= -1;
diff -rupN -X linux-omap/Documentation/dontdiff linux-omap-lcd/include/asm-arm/arch/omapfb.h linux-omap-lcd-444/include/asm-arm/arch/omapfb.h
--- linux-omap-lcd/include/asm-arm/arch/omapfb.h	2006-04-02 15:51:02.303521000 +0100
+++ linux-omap-lcd-444/include/asm-arm/arch/omapfb.h	2006-04-02 17:20:38.957325750 +0100
@@ -64,6 +64,7 @@ enum omapfb_color_format {
 	OMAPFB_COLOR_CLUT_4BPP,
 	OMAPFB_COLOR_CLUT_2BPP,
 	OMAPFB_COLOR_CLUT_1BPP,
+	OMAPFB_COLOR_RGB444,
 };
 
 struct omapfb_update_window {
diff -rupN -X linux-omap/Documentation/dontdiff linux-omap-lcd/include/asm-arm/arch-omap/omapfb.h linux-omap-lcd-444/include/asm-arm/arch-omap/omapfb.h
--- linux-omap-lcd/include/asm-arm/arch-omap/omapfb.h	2006-04-02 15:51:02.303521000 +0100
+++ linux-omap-lcd-444/include/asm-arm/arch-omap/omapfb.h	2006-04-02 17:20:38.957325750 +0100
@@ -64,6 +64,7 @@ enum omapfb_color_format {
 	OMAPFB_COLOR_CLUT_4BPP,
 	OMAPFB_COLOR_CLUT_2BPP,
 	OMAPFB_COLOR_CLUT_1BPP,
+	OMAPFB_COLOR_RGB444,
 };
 
 struct omapfb_update_window {

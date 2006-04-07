From: Mark Underwood <basicmark@yahoo.com>
Subject: [PATCH] add-RGB444-support-to-omapfb.patch
Date: Fri, 7 Apr 2006 20:39:41 +0100 (BST)
Message-ID: <20060407193941.35989.qmail@web36915.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-465950276-1144438781=:33431"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

--0-465950276-1144438781=:33431
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

This is an updated version of my patch that adds support for RGB444 mode for the internal LCD
controller which now applies against linux-2.6.16 with the patch-2.6.16-omap2 applied. 
 
Jonathan McDowell posted a slightly modified version of my original patch to this list previously:

http://Linux.omap.com/pipermail/linux-omap-open-source/2006-April/006839.html 
 
This patch is used by the Amstrad Delta (E3). 
 
Signed-Off-By: Mark Underwood <basicmark@yahoo.com>


		
___________________________________________________________ 
Win a BlackBerry device from O2 with Yahoo!. Enter now. http://www.yahoo.co.uk/blackberry
--0-465950276-1144438781=:33431
Content-Type: text/x-diff; name="add-RGB444-support-to-omapfb.patch"
Content-Description: 3268946195-add-RGB444-support-to-omapfb.patch
Content-Disposition: inline; filename="add-RGB444-support-to-omapfb.patch"

diff -uprN linux-2.6.16-orig/drivers/video/omap/lcdc.c linux-2.6.16/drivers/video/omap/lcdc.c
--- linux-2.6.16-orig/drivers/video/omap/lcdc.c	2006-04-06 20:45:53.000000000 +0000
+++ linux-2.6.16/drivers/video/omap/lcdc.c	2006-04-06 21:12:24.000000000 +0000
@@ -357,6 +357,11 @@ static int omap_lcdc_setup_plane(int pla
 		omap_lcdc.palette_code = 0x4000;
 		omap_lcdc.palette_size = 32;
 		break;
+	case OMAPFB_COLOR_RGB444:
+		omap_lcdc.bpp = 16;
+		omap_lcdc.palette_code = 0x4000;
+		omap_lcdc.palette_size = 32;
+		break;
 	case OMAPFB_COLOR_YUV420:
 		if (omap_lcdc.ext_mode) {
 			omap_lcdc.bpp = 12;
@@ -764,7 +769,10 @@ static int setup_fbmem(int req_size)
 		return 0;
 	}
 
-	frame_size = PAGE_ALIGN(panel->x_res * panel->bpp / 8 * panel->y_res);
+	if (panel->bpp == 12)
+		frame_size = PAGE_ALIGN(panel->x_res * 16 / 8 * panel->y_res);
+	else
+		frame_size = PAGE_ALIGN(panel->x_res * panel->bpp / 8 * panel->y_res);
 
 	if (conf->fbmem.fb_sdram_size < frame_size) {
 		pr_err("invalid FB memory configuration\n");
diff -uprN linux-2.6.16-orig/drivers/video/omap/omapfb_main.c linux-2.6.16/drivers/video/omap/omapfb_main.c
--- linux-2.6.16-orig/drivers/video/omap/omapfb_main.c	2006-04-06 20:45:53.000000000 +0000
+++ linux-2.6.16/drivers/video/omap/omapfb_main.c	2006-04-06 21:45:11.000000000 +0000
@@ -223,6 +223,7 @@ static int _setcolreg(struct fb_info *in
 			u_int blue, u_int transp, int update_hw_pal)
 {
 	struct omapfb_device *fbdev = (struct omapfb_device *)info->par;
+	struct fb_var_screeninfo *var = &info->var;
 	int r = 0;
 
 	switch (fbdev->color_mode) {
@@ -239,6 +240,7 @@ static int _setcolreg(struct fb_info *in
 							transp, update_hw_pal);
 		/* Fallthrough */
 	case OMAPFB_COLOR_RGB565:
+	case OMAPFB_COLOR_RGB444:
 		if (r != 0)
 			break;
 
@@ -249,8 +251,9 @@ static int _setcolreg(struct fb_info *in
 
 		if (regno < 16) {
 			u16 pal;
-			pal = ((red >> 11) << 11) | ((green >> 10) << 5) |
-				(blue >> 11);
+			pal = ((red >> (16 - var->red.length)) << var->red.offset) |
+				((green >> (16 - var->green.length)) << var->green.offset) |
+				(blue >> (16 - var->blue.length));
 			((u32 *)(info->pseudo_palette))[regno] = pal;
 		}
 		break;
@@ -402,12 +405,18 @@ static int set_fb_var(struct omapfb_devi
 	unsigned long	line_size;
 	struct lcd_panel *panel = fbdev->panel;
 
-	bpp = var->bits_per_pixel = panel->bpp;
+	if (panel->bpp == 12)
+		bpp = var->bits_per_pixel = 16;	/* 12-bit bpp mode stores colours in 16-bits */
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
@@ -453,9 +462,18 @@ static int set_fb_var(struct omapfb_devi
 		var->yoffset = var->yres_virtual - var->yres;
 	line_size = var->xres * bpp / 8;
 
-	var->red.offset	 = 11; var->red.length	 = 5; var->red.msb_right   = 0;
-	var->green.offset= 5;  var->green.length = 6; var->green.msb_right = 0;
-	var->blue.offset = 0;  var->blue.length  = 5; var->blue.msb_right  = 0;
+	if (fbdev->color_mode == OMAPFB_COLOR_RGB444)
+	{
+		var->red.offset	 = 8; var->red.length	 = 4; var->red.msb_right   = 0;
+		var->green.offset= 4;  var->green.length = 4; var->green.msb_right = 0;
+		var->blue.offset = 0;  var->blue.length  = 4; var->blue.msb_right  = 0;
+	}
+	else
+	{
+		var->red.offset	 = 11; var->red.length	 = 5; var->red.msb_right   = 0;
+		var->green.offset= 5;  var->green.length = 6; var->green.msb_right = 0;
+		var->blue.offset = 0;  var->blue.length  = 5; var->blue.msb_right  = 0;
+	}
 
 	var->height		= -1;
 	var->width		= -1;
diff -uprN linux-2.6.16-orig/include/asm-arm/arch-omap/omapfb.h linux-2.6.16/include/asm-arm/arch-omap/omapfb.h
--- linux-2.6.16-orig/include/asm-arm/arch-omap/omapfb.h	2006-04-06 20:46:45.000000000 +0000
+++ linux-2.6.16/include/asm-arm/arch-omap/omapfb.h	2006-04-06 20:59:56.000000000 +0000
@@ -64,6 +64,7 @@ enum omapfb_color_format {
 	OMAPFB_COLOR_CLUT_4BPP,
 	OMAPFB_COLOR_CLUT_2BPP,
 	OMAPFB_COLOR_CLUT_1BPP,
+	OMAPFB_COLOR_RGB444,
 };
 
 struct omapfb_update_window {

--0-465950276-1144438781=:33431
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-465950276-1144438781=:33431--

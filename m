From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] fbdev: kill fb_rotate
Date: Tue,  9 Feb 2016 19:56:11 +0100
Message-ID: <1455044172-17488-1-git-send-email-linux@rasmusvillemoes.dk>
References: <87d1swdk90.fsf@rasmusvillemoes.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87d1swdk90.fsf@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The fb_rotate method in struct fb_ops is never actually invoked, and
it's been that way in the entire history of git (in fact, the last
occurrence of the string '->fb_rotate' vanished over 10 years ago,
with b4d8aea6d6, and that merely tested whether the callback
existed). So remove some dead code and make struct fb_obs a little
smaller.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/video/fbdev/atafb.c            |  3 ---
 drivers/video/fbdev/au1100fb.c         | 22 ----------------------
 drivers/video/fbdev/bf537-lq035.c      | 23 -----------------------
 drivers/video/fbdev/omap/omapfb_main.c | 22 ----------------------
 drivers/video/fbdev/skeletonfb.c       | 17 -----------------
 include/linux/fb.h                     |  3 ---
 6 files changed, 90 deletions(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index d6ce613e12ad..fcd2dd670a65 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -313,9 +313,6 @@ extern unsigned char fontdata_8x16[];
  *	* Draws cursor *
  *	int (*fb_cursor) (struct fb_info *info, struct fb_cursor *cursor);
  *
- *	* Rotates the display *
- *	void (*fb_rotate)(struct fb_info *info, int angle);
- *
  *	* wait for blit idle, optional *
  *	int (*fb_sync)(struct fb_info *info);
  *
diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 59560189b24a..35df2c1a8a63 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -334,27 +334,6 @@ int au1100fb_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *fbi)
 	return 0;
 }
 
-/* fb_rotate
- * Rotate the display of this angle. This doesn't seems to be used by the core,
- * but as our hardware supports it, so why not implementing it...
- */
-void au1100fb_fb_rotate(struct fb_info *fbi, int angle)
-{
-	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
-
-	print_dbg("fb_rotate %p %d", fbi, angle);
-
-	if (fbdev && (angle > 0) && !(angle % 90)) {
-
-		fbdev->regs->lcd_control &= ~LCD_CONTROL_GO;
-
-		fbdev->regs->lcd_control &= ~(LCD_CONTROL_SM_MASK);
-		fbdev->regs->lcd_control |= ((angle/90) << LCD_CONTROL_SM_BIT);
-
-		fbdev->regs->lcd_control |= LCD_CONTROL_GO;
-	}
-}
-
 /* fb_mmap
  * Map video memory in user space. We don't use the generic fb_mmap method mainly
  * to allow the use of the TLB streaming flag (CCA=6)
@@ -380,7 +359,6 @@ static struct fb_ops au1100fb_ops =
 	.fb_fillrect		= cfb_fillrect,
 	.fb_copyarea		= cfb_copyarea,
 	.fb_imageblit		= cfb_imageblit,
-	.fb_rotate		= au1100fb_fb_rotate,
 	.fb_mmap		= au1100fb_fb_mmap,
 };
 
diff --git a/drivers/video/fbdev/bf537-lq035.c b/drivers/video/fbdev/bf537-lq035.c
index 7db3052b471d..ef29fb425122 100644
--- a/drivers/video/fbdev/bf537-lq035.c
+++ b/drivers/video/fbdev/bf537-lq035.c
@@ -554,28 +554,6 @@ static int bfin_lq035_fb_check_var(struct fb_var_screeninfo *var,
 	return 0;
 }
 
-/* fb_rotate
- * Rotate the display of this angle. This doesn't seems to be used by the core,
- * but as our hardware supports it, so why not implementing it...
- */
-static void bfin_lq035_fb_rotate(struct fb_info *fbi, int angle)
-{
-	pr_debug("%s: %p %d", __func__, fbi, angle);
-#if (defined(UD) && defined(LBR))
-	switch (angle) {
-
-	case 180:
-		gpio_set_value(LBR, 0);
-		gpio_set_value(UD, 1);
-		break;
-	default:
-		gpio_set_value(LBR, 1);
-		gpio_set_value(UD, 0);
-		break;
-	}
-#endif
-}
-
 static int bfin_lq035_fb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	if (nocursor)
@@ -623,7 +601,6 @@ static struct fb_ops bfin_lq035_fb_ops = {
 	.fb_open		= bfin_lq035_fb_open,
 	.fb_release		= bfin_lq035_fb_release,
 	.fb_check_var		= bfin_lq035_fb_check_var,
-	.fb_rotate		= bfin_lq035_fb_rotate,
 	.fb_fillrect		= cfb_fillrect,
 	.fb_copyarea		= cfb_copyarea,
 	.fb_imageblit		= cfb_imageblit,
diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index 393ae1bc07e8..6429f33167f5 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -594,27 +594,6 @@ static int set_fb_var(struct fb_info *fbi,
 }
 
 
-/* Set rotation (0, 90, 180, 270 degree), and switch to the new mode. */
-static void omapfb_rotate(struct fb_info *fbi, int rotate)
-{
-	struct omapfb_plane_struct *plane = fbi->par;
-	struct omapfb_device *fbdev = plane->fbdev;
-
-	omapfb_rqueue_lock(fbdev);
-	if (rotate != fbi->var.rotate) {
-		struct fb_var_screeninfo *new_var = &fbdev->new_var;
-
-		memcpy(new_var, &fbi->var, sizeof(*new_var));
-		new_var->rotate = rotate;
-		if (set_fb_var(fbi, new_var) == 0 &&
-		    memcmp(new_var, &fbi->var, sizeof(*new_var))) {
-			memcpy(&fbi->var, new_var, sizeof(*new_var));
-			ctrl_change_mode(fbi);
-		}
-	}
-	omapfb_rqueue_unlock(fbdev);
-}
-
 /*
  * Set new x,y offsets in the virtual display for the visible area and switch
  * to the new mode.
@@ -1256,7 +1235,6 @@ static struct fb_ops omapfb_ops = {
 	.fb_ioctl	= omapfb_ioctl,
 	.fb_check_var	= omapfb_check_var,
 	.fb_set_par	= omapfb_set_par,
-	.fb_rotate	= omapfb_rotate,
 	.fb_pan_display = omapfb_pan_display,
 };
 
diff --git a/drivers/video/fbdev/skeletonfb.c b/drivers/video/fbdev/skeletonfb.c
index fefde7c6add7..f948baa16d82 100644
--- a/drivers/video/fbdev/skeletonfb.c
+++ b/drivers/video/fbdev/skeletonfb.c
@@ -614,22 +614,6 @@ int xxxfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 }
 
 /**
- *	xxxfb_rotate -  NOT a required function. If your hardware
- *			supports rotation the whole screen then 
- *			you would provide a hook for this. 
- *
- *      @info: frame buffer structure that represents a single frame buffer
- *	@angle: The angle we rotate the screen.   
- *
- *      This operation is used to set or alter the properities of the
- *	cursor.
- */
-void xxxfb_rotate(struct fb_info *info, int angle)
-{
-/* Will be deprecated */
-}
-
-/**
  *	xxxfb_sync - NOT a required function. Normally the accel engine 
  *		     for a graphics card take a specific amount of time.
  *		     Often we have to wait for the accelerator to finish
@@ -665,7 +649,6 @@ static struct fb_ops xxxfb_ops = {
 	.fb_copyarea	= xxxfb_copyarea,	/* Needed !!! */
 	.fb_imageblit	= xxxfb_imageblit,	/* Needed !!! */
 	.fb_cursor	= xxxfb_cursor,		/* Optional !!! */
-	.fb_rotate	= xxxfb_rotate,
 	.fb_sync	= xxxfb_sync,
 	.fb_ioctl	= xxxfb_ioctl,
 	.fb_mmap	= xxxfb_mmap,
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 55433f86f0a3..dfe88351341f 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -296,9 +296,6 @@ struct fb_ops {
 	/* Draws cursor */
 	int (*fb_cursor) (struct fb_info *info, struct fb_cursor *cursor);
 
-	/* Rotates the display */
-	void (*fb_rotate)(struct fb_info *info, int angle);
-
 	/* wait for blit idle, optional */
 	int (*fb_sync)(struct fb_info *info);
 
-- 
2.1.4

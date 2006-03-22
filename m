From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] omap24xx camera cleanup
Date: Wed, 22 Mar 2006 08:55:57 -0800 (PST)
Message-ID: <20060322165557.7683.qmail@web32912.mail.mud.yahoo.com>
References: <20060322132144.30079.qmail@web32909.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1609740917-1143046557=:7665"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060322132144.30079.qmail@web32909.mail.mud.yahoo.com>
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
List-Id: linux-omap@vger.kernel.org

--0-1609740917-1143046557=:7665
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

--- Komal Shah <komal_shah802003@yahoo.com> wrote:

> Patch should be applied on top of previous patches on 24xx camera
> driver.
> Tested on H4 and it is working.
> 
> ---
> Move common vout functions to omap24xxlib.c (Taken from TI 2.6.10)
> Convert sem to mutex apis.
> 
> Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>
> 

Please ignore the last patch.

Attached new patch is a further cleanup to 24xx camera driver which
populates the _remove function, uses schedule_timeout_interruptible
api, adds proper check on error return path in _probe function and few
cosmetic changes. Tested on H4 and it works.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1609740917-1143046557=:7665
Content-Type: text/x-patch; name="24xxcamcleanup02.patch"
Content-Description: 2790603595-24xxcamcleanup02.patch
Content-Disposition: inline; filename="24xxcamcleanup02.patch"

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index def9e53..0ce0705 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -28,6 +28,40 @@
 extern void omap_nop_release(struct device *dev);
 
 /*-------------------------------------------------------------------------*/
+#if defined(CONFIG_VIDEO_OMAP_CAMERA) || defined(CONFIG_VIDEO_OMAP_CAMERA_MODULE)
+
+#define OMAP2_CAM_BASE		0x48052000
+#define OMAP2_CAM_MPU_IRQ	24
+
+static struct resource cam_resources[] = {
+	{
+		.start		= OMAP2_CAM_BASE,
+		.end		= OMAP2_CAM_BASE + 0xfff,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP2_CAM_MPU_IRQ,
+		.flags		= IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device omap_cam_device = {
+	.name		= "cam_omap",
+	.id		= -1,
+	.dev = {
+		.release	= omap_nop_release,
+	},
+	.num_resources	= ARRAY_SIZE(cam_resources),
+	.resource	= cam_resources,
+};
+
+static inline void omap_init_camera(void)
+{
+	platform_device_register(&omap_cam_device);
+}
+#else
+static inline void omap_init_camera(void) {}
+#endif
 
 #if 	defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
 
@@ -122,6 +156,7 @@ static int __init omap2_init_devices(voi
 	/* please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
+	omap_init_camera();
 	omap_init_i2c();
 	omap_init_sti();
 
diff --git a/drivers/media/video/omap/Makefile b/drivers/media/video/omap/Makefile
index 164700e..454b056 100644
--- a/drivers/media/video/omap/Makefile
+++ b/drivers/media/video/omap/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_VIDEO_OMAP_CAMERA) += omapc
 obj-$(CONFIG_VIDEO_CAMERA_SENSOR_OV9640) += sensor_ov9640.o
 
 objs-y$(CONFIG_ARCH_OMAP16XX) += camera_core.o omap16xxcam.o
-objs-y$(CONFIG_ARCH_OMAP24XX) += omap24xxcam.o
+objs-y$(CONFIG_ARCH_OMAP24XX) += omap24xxcam.o omap24xxlib.o
 objs-y$(CONFIG_MACH_OMAP_H3) += h3_sensor_power.o
 objs-y$(CONFIG_MACH_OMAP_H4) += h4_sensor_power.o
 
diff --git a/drivers/media/video/omap/omap24xxcam.c b/drivers/media/video/omap/omap24xxcam.c
index e46ce15..bfc8cf2 100644
--- a/drivers/media/video/omap/omap24xxcam.c
+++ b/drivers/media/video/omap/omap24xxcam.c
@@ -56,14 +56,12 @@
 #include <asm/arch/clock.h>
 
 #include "omap24xxcam.h"
+#include "omap24xxlib.h"
 #include "sensor_if.h"
 
 /* configuration macros */
 #define CAM_NAME 	"omap24xxcam"
 
-/* Should be moved from here */
-#define INT_CAM_MPU_IRQ 24
-
 //#define DEBUG_CAM
 
 #ifdef DEBUG_CAM
@@ -98,9 +96,6 @@ static int overlay_mem = 640 * 480 * 2;
 */
 static int video2_mem = 320 * 240 * 2;
 
-static struct clk *cam_fck;
-static struct clk *cam_ick;
-
 /* -------------------------------------------------------------------------- */
 
 /* Set the value of the CC_CTRL register in cam->cc_ctrl that is required to 
@@ -304,16 +299,14 @@ cam_reset(const struct omap24xxcam_devic
 	timeout = jiffies + timeout_ticks;
 	while (!(cam_reg_in(cam, CAM_SYSSTATUS) & CAM_SYSSTATUS_RESETDONE)
 	       && time_before(jiffies, timeout)) {
-		if (!in_atomic()) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(1);
-		} else
+		if (!in_atomic()) 
+			schedule_timeout_interruptible(1);
+		else
 			udelay(10);
 	}
-	if (!(cam_reg_in(cam, CAM_SYSSTATUS) & CAM_SYSSTATUS_RESETDONE)) {
+	if (!(cam_reg_in(cam, CAM_SYSSTATUS) & CAM_SYSSTATUS_RESETDONE)) 
 		printk(KERN_WARNING CAM_NAME
 		       ": timeout waiting for camera subsystem reset\n");
-	}
 
 	return;
 }
@@ -415,15 +408,14 @@ omap24xxcam_flip_overlay(struct omap24xx
 	vid_attributes = dispc_reg_merge(cam, DISPC_VID_ATTRIBUTES(v),
 					 DISPC_VID_ATTRIBUTES_ENABLE,
 					 DISPC_VID_ATTRIBUTES_ENABLE);
-	if (vid_attributes & DISPC_VID_ATTRIBUTES_VIDCHANNELOUT) {
+	if (vid_attributes & DISPC_VID_ATTRIBUTES_VIDCHANNELOUT)
 		/* digital output */
 		dispc_reg_merge(cam, DISPC_CONTROL, DISPC_CONTROL_GODIGITAL,
 				DISPC_CONTROL_GODIGITAL);
-	} else {
+	else
 		/* LCD */
 		dispc_reg_merge(cam, DISPC_CONTROL, DISPC_CONTROL_GOLCD,
 				DISPC_CONTROL_GOLCD);
-	}
 }
 
 /* Get the framebuffer parameters by reading the display controller registers 
@@ -459,256 +451,6 @@ static void omap24xxcam_g_fbuf(struct om
 	cam->gfx_attributes = dispc_reg_in(cam, DISPC_GFX_ATTRIBUTES);
 }
 
-/* Return the default overlay cropping rectangle in crop given the image capture
- * size in cam->pix and the video display size in cam->fbuf.  The default 
- * cropping rectangle is the largest rectangle no larger than the capture size 
- * that will fit on the display.  The default cropping rectangle is centered in 
- * the captured image.  All dimensions and offsets are rounded down to even 
- * numbers.
- */
-static void
-omap24xxcam_default_crop_rect(struct omap24xxcam_device *cam,
-			      struct v4l2_rect *crop)
-{
-	struct v4l2_pix_format *pix = &cam->pix;
-	struct v4l2_framebuffer *fbuf = &cam->fbuf;
-
-	DBG;
-
-	crop->width = (pix->width < fbuf->fmt.width) ?
-	    pix->width : fbuf->fmt.width;
-	crop->height = (pix->height < fbuf->fmt.height) ?
-	    pix->height : fbuf->fmt.height;
-	crop->width &= ~1;
-	crop->height &= ~1;
-	crop->left = ((pix->width - crop->width) >> 1) & ~1;
-	crop->top = ((pix->height - crop->height) >> 1) & ~1;
-}
-
-/* Given a new cropping rectangle in new_crop, adjust the cropping rectangle to 
- * the nearest supported configuration.  The image preview window cam->win will 
- * also be adjusted if necessary.  The preview window is adjusted such that the 
- * horizontal and vertical rescaling ratios stay constant.  If the preview 
- * window would fall outside the display boundaries, the cropping rectangle will 
- * also be adjusted to maintain the rescaling ratios.  If successful, cam->crop 
- * and cam->win are updated.
- * Returns zero if succesful, or -EINVAL if the requested cropping rectangle is 
- * impossible and cannot reasonably be adjusted.
- */
-static int
-omap24xxcam_new_crop_rect(struct omap24xxcam_device *cam,
-			  const struct v4l2_rect *new_crop)
-{
-	struct v4l2_pix_format *pix = &cam->pix;
-	struct v4l2_window *win = &cam->win;
-	struct v4l2_framebuffer *fbuf = &cam->fbuf;
-	struct v4l2_rect *crop = &cam->crop;
-	struct v4l2_rect try_crop;
-	unsigned long vresize, hresize;
-
-	DBG;
-
-	/* make a working copy of the new_crop rectangle */
-	try_crop = *new_crop;
-
-	/* adjust the cropping rectangle so it fits in the image */
-	if (try_crop.left < 0) {
-		try_crop.width += try_crop.left;
-		try_crop.left = 0;
-	}
-	if (try_crop.top < 0) {
-		try_crop.height += try_crop.top;
-		try_crop.top = 0;
-	}
-	try_crop.width = (try_crop.width < pix->width) ?
-	    try_crop.width : pix->width;
-	try_crop.height = (try_crop.height < pix->height) ?
-	    try_crop.height : pix->height;
-	if (try_crop.left + try_crop.width > pix->width)
-		try_crop.width = pix->width - try_crop.left;
-	if (try_crop.top + try_crop.height > pix->height)
-		try_crop.height = pix->height - try_crop.top;
-	try_crop.width &= ~1;
-	try_crop.height &= ~1;
-	if (try_crop.width <= 0 || try_crop.height <= 0)
-		return -EINVAL;
-
-	if (crop->height != win->w.height) {
-		/* If we're resizing vertically, we can't support a crop width 
-		 * wider than 768 pixels.
-		 */
-		if (try_crop.width > 768)
-			try_crop.width = 768;
-	}
-	/* vertical resizing */
-	vresize = (1024 * crop->height) / win->w.height;
-	if (vresize > 2048)
-		vresize = 2048;
-	else if (vresize == 0)
-		vresize = 1;
-	win->w.height = ((1024 * try_crop.height) / vresize) & ~1;
-	if (win->w.height == 0)
-		win->w.height = 2;
-	if (win->w.height + win->w.top > fbuf->fmt.height) {
-		/* We made the preview window extend below the bottom of the 
-		 * display, so clip it to the display boundary and resize the 
-		 * cropping height to maintain the vertical resizing ratio.
-		 */
-		win->w.height = (fbuf->fmt.height - win->w.top) & ~1;
-		try_crop.height = ((vresize * win->w.height) / 1024) & ~1;
-		if (try_crop.height == 0)
-			try_crop.height = 2;
-	}
-	/* horizontal resizing */
-	hresize = (1024 * crop->width) / win->w.width;
-	if (hresize > 2048)
-		hresize = 2048;
-	else if (hresize == 0)
-		hresize = 1;
-	win->w.width = ((1024 * try_crop.width) / hresize) & ~1;
-	if (win->w.width == 0)
-		win->w.width = 2;
-	if (win->w.width + win->w.left > fbuf->fmt.width) {
-		/* We made the preview window extend past the right side of the  
-		 * display, so clip it to the display boundary and resize the 
-		 * cropping width to maintain the horizontal resizing ratio.
-		 */
-		win->w.width = (fbuf->fmt.width - win->w.left) & ~1;
-		try_crop.width = ((hresize * win->w.width) / 1024) & ~1;
-		if (try_crop.width == 0)
-			try_crop.width = 2;
-	}
-	/* update our cropping rectangle and we're done */
-	*crop = try_crop;
-	return 0;
-}
-
-/* Given a new preview window in new_win, adjust the preview window to the 
- * nearest supported configuration.  The adjusted preview window parameters are 
- * returned in new_win.
- * Returns zero if succesful, or -EINVAL if the requested preview window is 
- * impossible and cannot reasonably be adjusted.
- */
-static int
-omap24xxcam_try_preview_window(struct omap24xxcam_device *cam,
-			       struct v4l2_window *new_win)
-{
-	struct v4l2_framebuffer *fbuf = &cam->fbuf;
-	struct v4l2_rect try_win;
-
-	DBG;
-
-	/* make a working copy of the new_win rectangle */
-	try_win = new_win->w;
-
-	/* adjust the preview window so it fits on the display by clipping any 
-	 * offscreen areas
-	 */
-	if (try_win.left < 0) {
-		try_win.width += try_win.left;
-		try_win.left = 0;
-	}
-	if (try_win.top < 0) {
-		try_win.height += try_win.top;
-		try_win.top = 0;
-	}
-	try_win.width = (try_win.width < fbuf->fmt.width) ?
-	    try_win.width : fbuf->fmt.width;
-	try_win.height = (try_win.height < fbuf->fmt.height) ?
-	    try_win.height : fbuf->fmt.height;
-	if (try_win.left + try_win.width > fbuf->fmt.width)
-		try_win.width = fbuf->fmt.width - try_win.left;
-	if (try_win.top + try_win.height > fbuf->fmt.height)
-		try_win.height = fbuf->fmt.height - try_win.top;
-	try_win.width &= ~1;
-	try_win.height &= ~1;
-	if (try_win.width <= 0 || try_win.height <= 0)
-		return -EINVAL;
-
-	/* We now have a valid preview window, so go with it */
-	new_win->w = try_win;
-	new_win->field = V4L2_FIELD_NONE;
-	return 0;
-}
-
-/* Given a new preview window in new_win, adjust the preview window to the 
- * nearest supported configuration.  The image cropping window cam->crop 
- * will also be adjusted if necessary.  Preference is given to keeping the 
- * preview window as close to the requested configuration as possible.  If 
- * successful, new_win, cam->win, and cam->crop are updated.
- * Returns zero if succesful, or -EINVAL if the requested preview window is 
- * impossible and cannot reasonably be adjusted.
- */
-static int
-omap24xxcam_new_preview_window(struct omap24xxcam_device *cam,
-			       struct v4l2_window *new_win)
-{
-	struct v4l2_window *win = &cam->win;
-	struct v4l2_rect *crop = &cam->crop;
-	int err;
-
-	DBG;
-
-	err = omap24xxcam_try_preview_window(cam, new_win);
-	if (err)
-		return err;
-
-	/* update our preview window */
-	win->w = new_win->w;
-	win->field = new_win->field;
-	win->chromakey = new_win->chromakey;
-
-	/* adjust the cropping window to allow for resizing limitations */
-	if (crop->height / win->w.height >= 2) {
-		/* The maximum vertical downsizing ratio is 2:1 */
-		crop->height = win->w.height * 2;
-	}
-	if (crop->width / win->w.width >= 2) {
-		/* The maximum horizontal downsizing ratio is 2:1 */
-		crop->width = win->w.width * 2;
-	}
-	if (crop->width > 768) {
-		/* The OMAP2420 vertical resizing line buffer is 768 pixels 
-		 * wide.  If the cropped image is wider than 768 pixels then it 
-		 * cannot be vertically resized.
-		 */
-		if (crop->height != win->w.height)
-			crop->width = 768;
-	}
-	return 0;
-}
-
-/* Given a capture format in cam->pix, the cam->crop, cam->win, and cam->fbuf 
- * structures are initialized to default values.  cam->fbuf is initialized by 
- * reading the display controller registers for the graphics window.  cam->crop 
- * is initialized to the largest window size that will fit on the display.  The 
- * crop window is centered in the captured image.  cam->win is initialized to 
- * the same size as cam->crop and is centered on the display.
- * All sizes and offsets are constrained to be even numbers.  
- */
-static void omap24xxcam_new_capture_format(struct omap24xxcam_device *cam)
-{
-	struct v4l2_rect *crop = &cam->crop;
-	struct v4l2_window *win = &cam->win;
-	struct v4l2_framebuffer *fbuf = &cam->fbuf;
-
-	DBG;
-
-	/* get the framebuffer parameters */
-	omap24xxcam_g_fbuf(cam);
-
-	/* crop defines the preview source window in the image capture 
-	 * buffer
-	 */
-	omap24xxcam_default_crop_rect(cam, crop);
-
-	/* win defines the preview target window on the display */
-	win->w.width = crop->width;
-	win->w.height = crop->height;
-	win->w.left = ((fbuf->fmt.width - win->w.width) >> 1) & ~1;
-	win->w.top = ((fbuf->fmt.height - win->w.height) >> 1) & ~1;
-}
-
 /* Program the camera interface xclk for the frequency cam->xclk based on 
  * the functional clock frequency cam->mclk.  If the specifed cam->xclk 
  * frequency is not possible based on the value of cam->mclk, then the 
@@ -999,22 +741,19 @@ omap24xxcam_configure_overlay(struct oma
 		int row_inc;
 		/* in video2 layer we won't be down or up scaling */
 		dispc_reg_out(cam, DISPC_VID_FIR(v), 0x400 | (0x400 << 16));
-		if (pix->width + vid2_format->left > fbuf->fmt.width) {
+		if (pix->width + vid2_format->left > fbuf->fmt.width) 
 			vid_position_x = fbuf->fmt.width < pix->width ? 0 :
 			    cam->gfx_position_x + fbuf->fmt.width - pix->width;
-		} else {
+		else 
 			vid_position_x = cam->gfx_position_x +
 			    vid2_format->left;
 
-		}
-
-		if (pix->height + vid2_format->top > fbuf->fmt.height) {
+		if (pix->height + vid2_format->top > fbuf->fmt.height)
 			vid_position_y = fbuf->fmt.height < pix->height ? 0 :
 			    cam->gfx_position_y +
 			    fbuf->fmt.height - pix->height;
-		} else {
+		else 
 			vid_position_y = cam->gfx_position_y + vid2_format->top;
-		}
 
 		vid_size = ((((pix->width > fbuf->fmt.width ? fbuf->fmt.width
 			       : pix->width) - 1)
@@ -1051,16 +790,15 @@ omap24xxcam_configure_overlay(struct oma
 		vid_attributes = dispc_reg_merge(cam, DISPC_VID_ATTRIBUTES(v),
 						 DISPC_VID_ATTRIBUTES_ENABLE,
 						 DISPC_VID_ATTRIBUTES_ENABLE);
-		if (vid_attributes & DISPC_VID_ATTRIBUTES_VIDCHANNELOUT) {
+		if (vid_attributes & DISPC_VID_ATTRIBUTES_VIDCHANNELOUT) 
 			/* digital output */
 			dispc_reg_merge(cam, DISPC_CONTROL,
 					DISPC_CONTROL_GODIGITAL,
 					DISPC_CONTROL_GODIGITAL);
-		} else {
+		else 
 			/* LCD */
 			dispc_reg_merge(cam, DISPC_CONTROL, DISPC_CONTROL_GOLCD,
 					DISPC_CONTROL_GOLCD);
-		}
 	}
 }
 
@@ -1785,13 +1523,12 @@ static void omap24xxcam_error_handler(st
 	camdma_reg_out(cam, CAMDMA_IRQENABLE_L3, 0);
 #endif
 
-	if (cam->previewing || cam->streaming) {
+	if (cam->previewing || cam->streaming) 
 		/* Preview or capture is in progress, so we need to register 
 		 * our routine to restart the camera interface the next time a 
 		 * DMA transfer is queued.
 		 */
 		omap24xxcam_dma_notify(cam, omap24xxcam_cc_enable);
-	}
 
 	/* Restart overlay DMA if preview is enabled. */
 	omap24xxcam_start_overlay_dma(cam);
@@ -1970,10 +1707,9 @@ omap24xxcam_vbq_prepare(struct videobuf_
 				spin_lock(&cam->img_lock);
 				vb->size = size;
 			}
-		} else {
+		} else 
 			/* We need to allocate a new kernel bounce buffer. */
 			vb->size = size;
-		}
 	}
 	if (cam->still_capture && cam->cam_sensor->try_format_still_capture) {
 		vb->width = cam->pix2.width;
@@ -2162,8 +1898,8 @@ omap24xxcam_do_ioctl(struct inode *inode
 
 					spin_lock(&cam->img_lock);
 					err =
-					    omap24xxcam_try_preview_window(cam,
-									   win);
+					    omap24xxvout_try_window(&cam->fbuf,
+									win);
 					spin_unlock(&cam->img_lock);
 					return err;
 				}
@@ -2199,8 +1935,11 @@ omap24xxcam_do_ioctl(struct inode *inode
 						return -EBUSY;
 					}
 					err =
-					    omap24xxcam_new_preview_window(cam,
-									   win);
+					    omap24xxvout_new_window(&cam->crop,
+								    &cam->win,
+								    &cam->fbuf,
+								    win);
+						    					    					    
 					spin_unlock(&cam->img_lock);
 					return err;
 				}
@@ -2256,7 +1995,10 @@ omap24xxcam_do_ioctl(struct inode *inode
 					cam->cparm.timeperframe =
 					    cam->nominal_timeperframe;
 					/* intialize the preview parameters */
-					omap24xxcam_new_capture_format(cam);
+					omap24xxvout_new_format(&cam->pix,
+								&cam->fbuf,
+								&cam->crop,
+								&cam->win);
 					spin_unlock(&cam->img_lock);
 					/* program xclk */
 					omap24xxcam_set_xclk(cam);
@@ -2331,9 +2073,10 @@ omap24xxcam_do_ioctl(struct inode *inode
 					cropcap->bounds.width = pix->width & ~1;
 					cropcap->bounds.height =
 					    pix->height & ~1;
-					omap24xxcam_default_crop_rect(cam,
-								      &cropcap->
-								      defrect);
+					omap24xxvout_default_crop(&cam->pix,
+								  &cam->fbuf,
+								  &cropcap->
+								  defrect);
 					spin_unlock(&cam->img_lock);
 					cropcap->pixelaspect.numerator = 1;
 					cropcap->pixelaspect.denominator = 1;
@@ -2409,9 +2152,11 @@ omap24xxcam_do_ioctl(struct inode *inode
 						spin_unlock(&cam->img_lock);
 						return -EBUSY;
 					}
-					err = omap24xxcam_new_crop_rect(cam,
-									&crop->
-									c);
+					err = omap24xxvout_new_crop(&cam->pix,
+								    &cam->crop,
+								    &cam->win,
+								    &cam->fbuf,
+								    &crop->c);
 					spin_unlock(&cam->img_lock);
 					return err;
 				}
@@ -2483,9 +2228,8 @@ omap24xxcam_do_ioctl(struct inode *inode
 							       &cam->cparm.
 							       timeperframe,
 							       cam->sensor);
-			} else {
+			} else 
 				spin_unlock(&cam->img_lock);
-			}
 			return 0;
 		}
 
@@ -2705,26 +2449,26 @@ int omap24xxcam_poll(struct file *file, 
 	} else {
 		/* read() capture */
 		spin_unlock(&cam->img_lock);
-		down(&fh->vbq.lock);
+		mutex_lock(&fh->vbq.lock);
 		if (fh->vbq.read_buf == NULL) {
 			/* need to capture a new image */
 			fh->vbq.read_buf = videobuf_alloc(fh->vbq.msize);
 			if (fh->vbq.read_buf == NULL) {
-				up(&fh->vbq.lock);
+				mutex_unlock(&fh->vbq.lock);
 				return POLLERR;
 			}
 			fh->vbq.read_buf->memory = V4L2_MEMORY_USERPTR;
 			field = videobuf_next_field(&fh->vbq);
 			if (fh->vbq.ops->buf_prepare(&fh->vbq, fh->vbq.read_buf,
 						     field) != 0) {
-				up(&fh->vbq.lock);
+				mutex_unlock(&fh->vbq.lock);
 				return POLLERR;
 			}
 			omap24xxcam_dma_notify(cam, omap24xxcam_cc_enable);
 			fh->vbq.ops->buf_queue(&fh->vbq, fh->vbq.read_buf);
 			fh->vbq.read_off = 0;
 		}
-		up(&fh->vbq.lock);
+		mutex_unlock(&fh->vbq.lock);
 		vb = (struct videobuf_buffer *)fh->vbq.read_buf;
 	}
 
@@ -2799,9 +2543,9 @@ omap24xxcam_write(struct file *file, con
 		dispc_reg_merge(cam, DISPC_CONTROL, DISPC_CONTROL_GOLCD,
 				DISPC_CONTROL_GOLCD);
 	}
-	if (copy_from_user((void *)cam->video2_base, data, count)) {
-		printk("error in copying data");
-	}
+	if (copy_from_user((void *)cam->video2_base, data, count)) 
+		printk(KERN_INFO "error in copying data");
+
 	return count;
 }
 
@@ -2823,16 +2567,15 @@ omap24xxcam_ioctl(struct inode *inode, s
  * Do some sanity check, set clock rate, starts it and
  *  turn codec audio on 
  */
-int omap24xxcam_clock_on(void)
+int omap24xxcam_clock_on(struct omap24xxcam_device *cam)
 {
-
-	clk_enable(cam_fck);
-	clk_enable(cam_ick);
+	clk_enable(cam->cam_fck);
+	clk_enable(cam->cam_ick);
 
 	printk(KERN_DEBUG
 	       "FCLK = %d [%d], usecount = %d\n",
-	       (uint) clk_get_rate(cam_fck), CAM_CLOCK,
-	       clk_get_usecount(cam_fck));
+	       (uint) clk_get_rate(cam->cam_fck), CAM_CLOCK,
+	       clk_get_usecount(cam->cam_fck));
 
 	return 0;
 }
@@ -2841,17 +2584,17 @@ int omap24xxcam_clock_on(void)
  * Do some sanity check, turn clock off and then turn
  *  codec audio off
  */
-int omap24xxcam_clock_off(void)
+int omap24xxcam_clock_off(struct omap24xxcam_device *cam)
 {
-	if (clk_get_usecount(cam_fck) > 0) {
-		if (clk_get_rate(cam_fck) != CAM_CLOCK) {
+	if (clk_get_usecount(cam->cam_fck) > 0) {
+		if (clk_get_rate(cam->cam_fck) != CAM_CLOCK) {
 			printk(KERN_WARNING
 			       "FCLK for camera should be %d Hz. But is %d Hz\n",
-			       (uint) clk_get_rate(cam_fck), CAM_CLOCK);
+			       (uint) clk_get_rate(cam->cam_fck), CAM_CLOCK);
 		}
 
-		clk_disable(cam_fck);
-		clk_disable(cam_ick);
+		clk_disable(cam->cam_fck);
+		clk_disable(cam->cam_ick);
 	}
 
 	return 0;
@@ -2933,6 +2676,7 @@ static struct file_operations omap24xxca
 };
 
 /* -------------------------------------------------------------------------- */
+#ifdef CONFIG_PM
 static int omap24xxcam_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct omap24xxcam_device *cam = platform_get_drvdata(pdev);
@@ -2995,27 +2739,51 @@ static int omap24xxcam_resume(struct pla
 
 	return 0;
 }
+#endif
 
 static int omap24xxcam_probe(struct platform_device *pdev)
 {
 	struct omap24xxcam_device *cam;
 	struct video_device *vfd;
+	struct resource *mem;
+	int irq = NO_IRQ;
 
 	DBG;
 
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		printk(KERN_WARNING "no mem resource?\n");
+		return -ENODEV;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0) {
+		printk(KERN_WARNING "no irq for camera?\n");
+		return -ENOENT;
+	}
+
+	/* request the mem region for the camera registers */
+	if (!request_mem_region(mem->start, (mem->end - mem->start) + 1,
+			       	pdev->name)) {
+		printk(KERN_ERR CAM_NAME
+		       ": cannot reserve camera register I/O region\n");
+		return -EBUSY;	
+	}
+
 	cam = kzalloc(sizeof(struct omap24xxcam_device), GFP_KERNEL);
 	if (!cam) {
 		printk(KERN_ERR CAM_NAME ": could not allocate memory\n");
-		goto init_error;
+		goto err0;
 	}
 	saved_cam = cam;
+	cam->irq  = irq;
 
 	/* initialize the video_device struct */
 	vfd = cam->vfd = video_device_alloc();
 	if (!vfd) {
 		printk(KERN_ERR CAM_NAME
 		       ": could not allocate video device struct\n");
-		goto init_error;
+		goto err1;
 	}
 	vfd->release = video_device_release;
 #ifdef FIXME_FIXME
@@ -3047,22 +2815,14 @@ static int omap24xxcam_probe(struct plat
 	if (capture_mem < 320 * 240 * 2 * 2)
 		capture_mem = 320 * 240 * 2 * 2;
 
-	/* request the mem region for the camera registers */
-	if (!request_mem_region(CAM_REG_BASE, CAM_REG_SIZE, vfd->name)) {
-		printk(KERN_ERR CAM_NAME
-		       ": cannot reserve camera register I/O region\n");
-		goto init_error;
-	}
-	cam->cam_mmio_base_phys = CAM_REG_BASE;
-	cam->cam_mmio_size = CAM_REG_SIZE;
 
 	/* map the region */
 	cam->cam_mmio_base = (unsigned long)
-	    ioremap(cam->cam_mmio_base_phys, cam->cam_mmio_size);
+		ioremap(mem->start, (mem->end - mem->start) + 1);
 	if (!cam->cam_mmio_base) {
 		printk(KERN_ERR CAM_NAME
 		       ": cannot map camera register I/O region\n");
-		goto init_error;
+		goto err2;
 	}
 
 	/* Map the display controller registers.
@@ -3077,7 +2837,7 @@ static int omap24xxcam_probe(struct plat
 	if (!cam->dispc_mmio_base) {
 		printk(KERN_ERR CAM_NAME
 		       ": cannot map display controller register I/O region\n");
-		goto init_error;
+		goto err3;
 	}
 
 	/* allocate coherent memory for the overlay framebuffer */
@@ -3096,7 +2856,7 @@ static int omap24xxcam_probe(struct plat
 		if (!cam->overlay_base) {
 			printk(KERN_ERR CAM_NAME
 			       ": cannot allocate overlay framebuffer\n");
-			goto init_error;
+			goto err4;
 		}
 	}
 	memset((void *)cam->overlay_base, 0, cam->overlay_size);
@@ -3114,7 +2874,7 @@ static int omap24xxcam_probe(struct plat
 		if (!cam->video2_base) {
 			printk(KERN_ERR CAM_NAME
 			       ": cannot allocate video2 layer memory\n");
-			goto init_error;
+			goto err5;
 
 		}
 	}
@@ -3134,9 +2894,9 @@ static int omap24xxcam_probe(struct plat
 
 	/* initialize the camera interface functional clock frequency */
 	cam->mclk = 96000000;	/* 96MHz */
-	cam_fck = clk_get(0, "cam_fck");
-	cam_ick = clk_get(0, "cam_ick");
-	omap24xxcam_clock_on();
+	cam->cam_fck = clk_get(0, "cam_fck");
+	cam->cam_ick = clk_get(0, "cam_ick");
+	omap24xxcam_clock_on(cam);
 
 	/* initialize the streaming capture parameters */
 	cam->cparm.readbuffers = 1;
@@ -3162,7 +2922,7 @@ static int omap24xxcam_probe(struct plat
 	cam->sensor = cam->cam_sensor->init(&cam->pix, &cam->pix2);
 	if (!cam->sensor) {
 		printk(KERN_ERR CAM_NAME ": cannot initialize sensor\n");
-		goto init_error;
+		goto err6;
 	}
 	printk(KERN_INFO "Sensor is %s\n", cam->cam_sensor->name);
 
@@ -3181,7 +2941,7 @@ static int omap24xxcam_probe(struct plat
 	/* initialize the image preview parameters based on the default capture 
 	 * format
 	 */
-	omap24xxcam_new_capture_format(cam);
+	omap24xxvout_new_format(&cam->pix, &cam->fbuf, &cam->crop, &cam->win);
 
 	/* program the sensor for the default capture format and rate */
 	cam->cam_sensor->configure(&cam->pix, cam->xclk,
@@ -3198,80 +2958,130 @@ static int omap24xxcam_probe(struct plat
 	omap24xxcam_dma_init(cam);
 
 	/* install the interrupt service routine */
-	if (request_irq(INT_CAM_MPU_IRQ, omap24xxcam_isr, 0, CAM_NAME, cam)) {
+	if (request_irq(cam->irq, omap24xxcam_isr, 0, CAM_NAME, cam)) {
 		printk(KERN_ERR CAM_NAME
 		       ": could not install interrupt service routine\n");
-		goto init_error;
+		goto err7;
 	}
-	cam->irq = INT_CAM_MPU_IRQ;
 
 	if (video_register_device(vfd, VFL_TYPE_GRABBER, video_nr) < 0) {
 		printk(KERN_ERR CAM_NAME
 		       ": could not register Video for Linux device\n");
 		vfd->minor = -1;
-		goto init_error;
+		goto err8;
 	}
+
 	/* set driver specific data to use in power management functions */
 	platform_set_drvdata(pdev, cam);
 
 	printk(KERN_INFO CAM_NAME
 	       ": registered device video%d [v4l2]\n", vfd->minor);
 
-#undef CAMERA_TEST
-//#define CAMERA_TEST
-#ifdef CAMERA_TEST
-	if (cam->pix.sizeimage <= cam->overlay_size) {
-		printk(KERN_INFO CAM_NAME ": Camera test--enabling overlay\n");
-		/* turn on the video overlay */
-		omap24xxcam_configure_overlay(cam, NULL);
-		omap24xxcam_flip_overlay(cam, cam->overlay_base_phys);
-		cam->previewing = (struct omap24xxcam_fh *)1;
-		/* start the camera interface */
-		omap24xxcam_dma_notify(cam, omap24xxcam_cc_enable);
-		omap24xxcam_start_overlay_dma(cam);
-	} else {
-		printk(KERN_INFO CAM_NAME
-		       ": Can't start camera test--overlay buffer too"
-		       " small\n");
-	}
-#endif
-
 	return 0;
+	
+err8:
+	free_irq(cam->irq, cam);
+err7:
+	omap24xxcam_dma_exit(cam);
+	cam->cam_sensor->cleanup(cam->sensor);
+	cam->sensor = NULL;
+err6:
+	omap24xxcam_clock_off(cam);
+	dma_free_coherent(NULL, cam->video2_size,
+			  (void *)cam->video2_base,
+			  cam->video2_base_phys);
+	cam->video2_base = 0;
+err5:
+	dma_free_coherent(NULL, cam->overlay_size,
+			  (void *)cam->overlay_base,
+			  cam->overlay_base_phys);
+	cam->overlay_base = 0;
+err4:
+	iounmap((void *)cam->dispc_mmio_base);
+	cam->dispc_mmio_base = 0;
+err3:
+	iounmap((void *)cam->cam_mmio_base);
+	cam->cam_mmio_base = 0;
+err2:
+	video_device_release(vfd);
+err1:
+	kfree(cam);
+	saved_cam = NULL;
+err0:
+	release_mem_region(mem->start, (mem->end - mem->start) + 1);
 
-      init_error:
-	omap24xxcam_cleanup();
 	return -ENODEV;
 }
 
 static int omap24xxcam_remove(struct platform_device *pdev)
 {
+	struct omap24xxcam_device *cam = platform_get_drvdata(pdev);
+	struct resource	*mem;
+	struct video_device *vfd;
+
+	vfd = cam->vfd;
+	
+	if (vfd) {
+		if (vfd->minor == -1) 
+			/* The device was never registered, so release the 
+			 * video_device struct directly.
+			 */
+			video_device_release(vfd);
+		else 
+			/* The unregister function will release the video_device
+			 * struct as well as unregistering it.
+			 */
+			video_unregister_device(vfd);
+		
+		cam->vfd = NULL;
+	}
+	
+	free_irq(cam->irq, cam);
+	
+	omap24xxcam_dma_exit(cam);
+	cam->cam_sensor->cleanup(cam->sensor);
+
+	dma_free_coherent(NULL, cam->video2_size,
+				(void *)cam->video2_base,
+				cam->video2_base_phys);
+	cam->video2_base = 0;
+	
+	dma_free_coherent(NULL, cam->overlay_size,
+			  (void *)cam->overlay_base,
+			  cam->overlay_base_phys);
+	cam->overlay_base = 0;
+
+	iounmap((void *)cam->dispc_mmio_base);
+	cam->dispc_mmio_base = 0;
+
+	iounmap((void *)cam->cam_mmio_base);
+	cam->cam_mmio_base = 0;
+
+	omap24xxcam_clock_off(cam);
+
+	kfree(cam);
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(mem->start, (mem->end - mem->start) + 1);
+	
 	return 0;
 }
 
 static struct platform_driver omap24xxcam_driver = {
-	.probe = omap24xxcam_probe,
-	.remove = omap24xxcam_remove,
+	.probe		= omap24xxcam_probe,
+	.remove		= omap24xxcam_remove,
 #ifdef CONFIG_PM
-	.suspend = omap24xxcam_suspend,
-	.resume = omap24xxcam_resume,
+	.suspend	= omap24xxcam_suspend,
+	.resume		= omap24xxcam_resume,
 #else
-	.suspend = NULL,
-	.resume = NULL,
+	.suspend	= NULL,
+	.resume		= NULL,
 #endif
-	.shutdown = NULL,
-	.driver {
-		.name = CAM_NAME,
+	.shutdown	= NULL,
+	.driver		= {
+		.name = "cam_omap",
 	},
 };
 
-static struct platform_device omap24xxcam_dev = {
-	.name = CAM_NAME,
-	.dev = {
-		.release = NULL,
-		},
-	.id = 0,
-};
-
 int __init omap24xxcam_init(void)
 {
 	int ret;
@@ -3281,87 +3091,13 @@ int __init omap24xxcam_init(void)
 	ret = platform_driver_register(&omap24xxcam_driver);
 	if (ret != 0)
 		return ret;
-	ret = platform_device_register(&omap24xxcam_dev);
-	if (ret != 0) {
-		platform_driver_unregister(&omap24xxcam_driver);
-		return ret;
-	}
 
 	return 0;
 }
 
-void omap24xxcam_cleanup(void)
+static void __exit omap24xxcam_exit(void)
 {
-	struct omap24xxcam_device *cam = saved_cam;
-	struct video_device *vfd;
-
-	DBG;
-
-	if (!cam)
-		return;
-	vfd = cam->vfd;
-
-	if (vfd) {
-		if (vfd->minor == -1) {
-			/* The device was never registered, so release the 
-			 * video_device struct directly.
-			 */
-			video_device_release(vfd);
-		} else {
-			/* The unregister function will release the video_device
-			 * struct as well as unregistering it.
-			 */
-			video_unregister_device(vfd);
-		}
-		cam->vfd = NULL;
-	}
-
-	if (cam->irq) {
-		free_irq(cam->irq, cam);
-		cam->irq = 0;
-	}
-
-	omap24xxcam_dma_exit(cam);
-	cam->cam_sensor->cleanup(cam->sensor);
-	/* sensor allocated private data is gone */
-	cam->sensor = NULL;
-
-	if (cam->video2_base) {
-		dma_free_coherent(NULL, cam->video2_size,
-				  (void *)cam->video2_base,
-				  cam->video2_base_phys);
-		cam->video2_base = 0;
-	}
-	cam->video2_base_phys = 0;
-
-	if (cam->overlay_base) {
-		dma_free_coherent(NULL, cam->overlay_size,
-				  (void *)cam->overlay_base,
-				  cam->overlay_base_phys);
-		cam->overlay_base = 0;
-	}
-	cam->overlay_base_phys = 0;
-
-	if (cam->dispc_mmio_base) {
-		iounmap((void *)cam->dispc_mmio_base);
-		cam->dispc_mmio_base = 0;
-	}
-	cam->dispc_mmio_base_phys = 0;
-
-	if (cam->cam_mmio_base) {
-		iounmap((void *)cam->cam_mmio_base);
-		cam->cam_mmio_base = 0;
-	}
-	if (cam->cam_mmio_base_phys) {
-		release_mem_region(cam->cam_mmio_base_phys, cam->cam_mmio_size);
-		cam->cam_mmio_base_phys = 0;
-	}
-
-	platform_device_unregister(&omap24xxcam_dev);
 	platform_driver_unregister(&omap24xxcam_driver);
-
-	kfree(cam);
-	saved_cam = NULL;
 }
 
 MODULE_AUTHOR("MontaVista Software, Inc.");
@@ -3378,4 +3114,4 @@ MODULE_PARM_DESC(overlay_mem,
 		 "Preview overlay framebuffer size (default 600KB)");
 
 module_init(omap24xxcam_init);
-module_exit(omap24xxcam_cleanup);
+module_exit(omap24xxcam_exit);
diff --git a/drivers/media/video/omap/omap24xxcam.h b/drivers/media/video/omap/omap24xxcam.h
index 85c10e6..2e4bb9b 100644
--- a/drivers/media/video/omap/omap24xxcam.h
+++ b/drivers/media/video/omap/omap24xxcam.h
@@ -423,8 +423,6 @@ struct omap24xxcam_device {
 	unsigned int irq;
 
 	unsigned long cam_mmio_base;
-	unsigned long cam_mmio_base_phys;
-	unsigned long cam_mmio_size;
 
 	unsigned long dispc_mmio_base;
 	unsigned long dispc_mmio_base_phys;
@@ -547,6 +545,9 @@ struct omap24xxcam_device {
 	/* value of GFX_ATTRIBUTES register from display controller */
 	unsigned long gfx_attributes;
 
+	struct clk *cam_fck;
+	struct clk *cam_ick;
+
 	/* video 2 layer of the display controller is also configured through
 	 ** it */
 	int vid2;
diff --git a/drivers/media/video/omap/omap24xxlib.c b/drivers/media/video/omap/omap24xxlib.c
new file mode 100644
index 0000000..63c0d4f
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxlib.c
@@ -0,0 +1,264 @@
+/*
+ * drivers/media/video/omap/omap24xxlib.c
+ *
+ * Copyright (C) 2005-2006 Texas Instruments.
+ *
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ *
+ * Based on the OMAP2 camera driver
+ * Video-for-Linux (Version 2) camera capture driver for 
+ * the OMAP24xx camera controller.
+ *
+ * Author: Andy Lowe (source@mvista.com)
+ *
+ * Copyright (C) 2004 MontaVista Software, Inc.
+ * Copyright (C) 2004 Texas Instruments.
+ *
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/videodev.h>
+
+/* Return the default overlay cropping rectangle in crop given the image
+ * size in pix and the video display size in fbuf.  The default 
+ * cropping rectangle is the largest rectangle no larger than the capture size 
+ * that will fit on the display.  The default cropping rectangle is centered in 
+ * the image.  All dimensions and offsets are rounded down to even numbers.
+ */
+void
+omap24xxvout_default_crop(struct v4l2_pix_format *pix,
+			  struct v4l2_framebuffer *fbuf, struct v4l2_rect *crop)
+{
+	crop->width = (pix->width < fbuf->fmt.width) ?
+	    pix->width : fbuf->fmt.width;
+	crop->height = (pix->height < fbuf->fmt.height) ?
+	    pix->height : fbuf->fmt.height;
+	crop->width &= ~1;
+	crop->height &= ~1;
+	crop->left = ((pix->width - crop->width) >> 1) & ~1;
+	crop->top = ((pix->height - crop->height) >> 1) & ~1;
+}
+
+/* Given a new render window in new_win, adjust the window to the 
+ * nearest supported configuration.  The adjusted window parameters are 
+ * returned in new_win.
+ * Returns zero if succesful, or -EINVAL if the requested window is 
+ * impossible and cannot reasonably be adjusted.
+ */
+int
+omap24xxvout_try_window(struct v4l2_framebuffer *fbuf,
+			struct v4l2_window *new_win)
+{
+	struct v4l2_rect try_win;
+
+	/* make a working copy of the new_win rectangle */
+	try_win = new_win->w;
+
+	/* adjust the preview window so it fits on the display by clipping any 
+	 * offscreen areas
+	 */
+	if (try_win.left < 0) {
+		try_win.width += try_win.left;
+		try_win.left = 0;
+	}
+	if (try_win.top < 0) {
+		try_win.height += try_win.top;
+		try_win.top = 0;
+	}
+	try_win.width = (try_win.width < fbuf->fmt.width) ?
+	    try_win.width : fbuf->fmt.width;
+	try_win.height = (try_win.height < fbuf->fmt.height) ?
+	    try_win.height : fbuf->fmt.height;
+	if (try_win.left + try_win.width > fbuf->fmt.width)
+		try_win.width = fbuf->fmt.width - try_win.left;
+	if (try_win.top + try_win.height > fbuf->fmt.height)
+		try_win.height = fbuf->fmt.height - try_win.top;
+	try_win.width &= ~1;
+	try_win.height &= ~1;
+
+	if (try_win.width <= 0 || try_win.height <= 0)
+		return -EINVAL;
+
+	/* We now have a valid preview window, so go with it */
+	new_win->w = try_win;
+	new_win->field = V4L2_FIELD_NONE;
+	return 0;
+}
+
+/* Given a new render window in new_win, adjust the window to the 
+ * nearest supported configuration.  The image cropping window in crop 
+ * will also be adjusted if necessary.  Preference is given to keeping the 
+ * the window as close to the requested configuration as possible.  If 
+ * successful, new_win, vout->win, and crop are updated.
+ * Returns zero if succesful, or -EINVAL if the requested preview window is 
+ * impossible and cannot reasonably be adjusted.
+ */
+int
+omap24xxvout_new_window(struct v4l2_rect *crop,
+			struct v4l2_window *win,
+			struct v4l2_framebuffer *fbuf,
+			struct v4l2_window *new_win)
+{
+	int err;
+
+	err = omap24xxvout_try_window(fbuf, new_win);
+	if (err)
+		return err;
+
+	/* update our preview window */
+	win->w = new_win->w;
+	win->field = new_win->field;
+	win->chromakey = new_win->chromakey;
+
+	/* adjust the cropping window to allow for resizing limitations */
+	if (crop->height / win->w.height >= 2) 
+		/* The maximum vertical downsizing ratio is 2:1 */
+		crop->height = win->w.height * 2;
+	
+	if (crop->width / win->w.width >= 2)
+		/* The maximum horizontal downsizing ratio is 2:1 */
+		crop->width = win->w.width * 2;
+	
+	if (crop->width > 768) {
+		/* The OMAP2420 vertical resizing line buffer is 768 pixels 
+		 * wide.  If the cropped image is wider than 768 pixels then it 
+		 * cannot be vertically resized.
+		 */
+		if (crop->height != win->w.height)
+			crop->width = 768;
+	}
+	return 0;
+}
+
+/* Given a new cropping rectangle in new_crop, adjust the cropping rectangle to 
+ * the nearest supported configuration.  The image render window in win will 
+ * also be adjusted if necessary.  The preview window is adjusted such that the 
+ * horizontal and vertical rescaling ratios stay constant.  If the render 
+ * window would fall outside the display boundaries, the cropping rectangle will 
+ * also be adjusted to maintain the rescaling ratios.  If successful, crop 
+ * and win are updated.
+ * Returns zero if succesful, or -EINVAL if the requested cropping rectangle is 
+ * impossible and cannot reasonably be adjusted.
+ */
+int
+omap24xxvout_new_crop(struct v4l2_pix_format *pix,
+		      struct v4l2_rect *crop,
+		      struct v4l2_window *win,
+		      struct v4l2_framebuffer *fbuf,
+		      const struct v4l2_rect *new_crop)
+{
+	struct v4l2_rect try_crop;
+	unsigned long vresize, hresize;
+
+	/* make a working copy of the new_crop rectangle */
+	try_crop = *new_crop;
+
+	/* adjust the cropping rectangle so it fits in the image */
+	if (try_crop.left < 0) {
+		try_crop.width += try_crop.left;
+		try_crop.left = 0;
+	}
+	if (try_crop.top < 0) {
+		try_crop.height += try_crop.top;
+		try_crop.top = 0;
+	}
+	try_crop.width = (try_crop.width < pix->width) ?
+	    try_crop.width : pix->width;
+	try_crop.height = (try_crop.height < pix->height) ?
+	    try_crop.height : pix->height;
+	if (try_crop.left + try_crop.width > pix->width)
+		try_crop.width = pix->width - try_crop.left;
+	if (try_crop.top + try_crop.height > pix->height)
+		try_crop.height = pix->height - try_crop.top;
+	try_crop.width &= ~1;
+	try_crop.height &= ~1;
+	if (try_crop.width <= 0 || try_crop.height <= 0)
+		return -EINVAL;
+
+	if (crop->height != win->w.height) {
+		/* If we're resizing vertically, we can't support a crop width 
+		 * wider than 768 pixels.
+		 */
+		if (try_crop.width > 768)
+			try_crop.width = 768;
+	}
+	/* vertical resizing */
+	vresize = (1024 * crop->height) / win->w.height;
+	if (vresize > 2048)
+		vresize = 2048;
+	else if (vresize == 0)
+		vresize = 1;
+	win->w.height = ((1024 * try_crop.height) / vresize) & ~1;
+	if (win->w.height == 0)
+		win->w.height = 2;
+	if (win->w.height + win->w.top > fbuf->fmt.height) {
+		/* We made the preview window extend below the bottom of the 
+		 * display, so clip it to the display boundary and resize the 
+		 * cropping height to maintain the vertical resizing ratio.
+		 */
+		win->w.height = (fbuf->fmt.height - win->w.top) & ~1;
+		try_crop.height = ((vresize * win->w.height) / 1024) & ~1;
+		if (try_crop.height == 0)
+			try_crop.height = 2;
+	}
+	/* horizontal resizing */
+	hresize = (1024 * crop->width) / win->w.width;
+	if (hresize > 2048)
+		hresize = 2048;
+	else if (hresize == 0)
+		hresize = 1;
+	win->w.width = ((1024 * try_crop.width) / hresize) & ~1;
+	if (win->w.width == 0)
+		win->w.width = 2;
+	if (win->w.width + win->w.left > fbuf->fmt.width) {
+		/* We made the preview window extend past the right side of the  
+		 * display, so clip it to the display boundary and resize the 
+		 * cropping width to maintain the horizontal resizing ratio.
+		 */
+		win->w.width = (fbuf->fmt.width - win->w.left) & ~1;
+		try_crop.width = ((hresize * win->w.width) / 1024) & ~1;
+		if (try_crop.width == 0)
+			try_crop.width = 2;
+	}
+	/* update our cropping rectangle and we're done */
+	*crop = try_crop;
+	return 0;
+}
+
+/* Given a new format in pix and fbuf,  crop and win 
+ * structures are initialized to default values. crop 
+ * is initialized to the largest window size that will fit on the display.  The 
+ * crop window is centered in the image. win is initialized to 
+ * the same size as crop and is centered on the display.
+ * All sizes and offsets are constrained to be even numbers.  
+ */
+void
+omap24xxvout_new_format(struct v4l2_pix_format *pix,
+			struct v4l2_framebuffer *fbuf,
+			struct v4l2_rect *crop, struct v4l2_window *win)
+{
+	/* crop defines the preview source window in the image capture 
+	 * buffer
+	 */
+	omap24xxvout_default_crop(pix, fbuf, crop);
+
+	/* win defines the preview target window on the display */
+	win->w.width = crop->width;
+	win->w.height = crop->height;
+	win->w.left = ((fbuf->fmt.width - win->w.width) >> 1) & ~1;
+	win->w.top = ((fbuf->fmt.height - win->w.height) >> 1) & ~1;
+}
+
+EXPORT_SYMBOL_GPL(omap24xxvout_default_crop);
+EXPORT_SYMBOL_GPL(omap24xxvout_try_window);
+EXPORT_SYMBOL_GPL(omap24xxvout_new_window);
+EXPORT_SYMBOL_GPL(omap24xxvout_new_crop);
+EXPORT_SYMBOL_GPL(omap24xxvout_new_format);
+
+MODULE_AUTHOR("Texas Instruments.");
+MODULE_DESCRIPTION("OMAP24xx Video library");
+MODULE_LICENSE ("GPL");
diff --git a/drivers/media/video/omap/omap24xxlib.h b/drivers/media/video/omap/omap24xxlib.h
new file mode 100644
index 0000000..f778291
--- /dev/null
+++ b/drivers/media/video/omap/omap24xxlib.h
@@ -0,0 +1,39 @@
+/*
+ * drivers/media/video/omap/omap24xxlib.h
+ *
+ * Copyright (C) 2005-2006 Texas Instruments.
+ *
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ *
+ */
+
+#ifndef OMAP24XXLIB_VIDEO_H
+#define OMAP24XXLIB_VIDEO_H
+
+extern void
+ omap24xxvout_default_crop(struct v4l2_pix_format *pix,
+				struct v4l2_framebuffer *fbuf,
+				struct v4l2_rect *crop);
+
+extern int
+ omap24xxvout_new_crop(struct v4l2_pix_format *pix, struct v4l2_rect *crop,
+			struct v4l2_window *win, struct v4l2_framebuffer *fbuf,
+			const struct v4l2_rect *new_crop);
+
+extern int
+ omap24xxvout_try_window(struct v4l2_framebuffer *fbuf,
+				 struct v4l2_window *new_win);
+
+extern int
+ omap24xxvout_new_window(struct v4l2_rect *crop,struct v4l2_window *win,
+				struct v4l2_framebuffer *fbuf,
+				struct v4l2_window *new_win);
+
+extern void
+ omap24xxvout_new_format(struct v4l2_pix_format *pix,
+			 	struct v4l2_framebuffer *fbuf,
+				struct v4l2_rect *crop,
+				struct v4l2_window *win);
+#endif

--0-1609740917-1143046557=:7665
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-1609740917-1143046557=:7665--

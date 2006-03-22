From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] omap24xx camera cleanup
Date: Wed, 22 Mar 2006 05:21:44 -0800 (PST)
Message-ID: <20060322132144.30079.qmail@web32909.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1459620839-1143033704=:5903"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--0-1459620839-1143033704=:5903
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Patch should be applied on top of previous patches on 24xx camera
driver.
Tested on H4 and it is working.

---
Move common vout functions to omap24xxlib.c (Taken from TI 2.6.10)
Convert sem to mutex apis.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1459620839-1143033704=:5903
Content-Type: text/x-patch; name="24xxcamcleanup.patch"
Content-Description: 601869014-24xxcamcleanup.patch
Content-Disposition: inline; filename="24xxcamcleanup.patch"

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
index e46ce15..a4e4226 100644
--- a/drivers/media/video/omap/omap24xxcam.c
+++ b/drivers/media/video/omap/omap24xxcam.c
@@ -56,6 +56,7 @@
 #include <asm/arch/clock.h>
 
 #include "omap24xxcam.h"
+#include "omap24xxlib.h"
 #include "sensor_if.h"
 
 /* configuration macros */
@@ -459,256 +460,6 @@ static void omap24xxcam_g_fbuf(struct om
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
@@ -2162,8 +1913,8 @@ omap24xxcam_do_ioctl(struct inode *inode
 
 					spin_lock(&cam->img_lock);
 					err =
-					    omap24xxcam_try_preview_window(cam,
-									   win);
+					    omap24xxvout_try_window(&cam->fbuf,
+									win);
 					spin_unlock(&cam->img_lock);
 					return err;
 				}
@@ -2199,8 +1950,11 @@ omap24xxcam_do_ioctl(struct inode *inode
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
@@ -2256,7 +2010,10 @@ omap24xxcam_do_ioctl(struct inode *inode
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
@@ -2331,9 +2088,10 @@ omap24xxcam_do_ioctl(struct inode *inode
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
@@ -2409,9 +2167,11 @@ omap24xxcam_do_ioctl(struct inode *inode
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
@@ -2705,26 +2465,26 @@ int omap24xxcam_poll(struct file *file, 
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
 
@@ -2933,6 +2693,7 @@ static struct file_operations omap24xxca
 };
 
 /* -------------------------------------------------------------------------- */
+#ifdef CONFIG_PM
 static int omap24xxcam_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct omap24xxcam_device *cam = platform_get_drvdata(pdev);
@@ -2995,6 +2756,7 @@ static int omap24xxcam_resume(struct pla
 
 	return 0;
 }
+#endif
 
 static int omap24xxcam_probe(struct platform_device *pdev)
 {
@@ -3181,7 +2943,7 @@ static int omap24xxcam_probe(struct plat
 	/* initialize the image preview parameters based on the default capture 
 	 * format
 	 */
-	omap24xxcam_new_capture_format(cam);
+	omap24xxvout_new_format(&cam->pix, &cam->fbuf, &cam->crop, &cam->win);
 
 	/* program the sensor for the default capture format and rate */
 	cam->cam_sensor->configure(&cam->pix, cam->xclk,
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

--0-1459620839-1143033704=:5903
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-1459620839-1143033704=:5903--

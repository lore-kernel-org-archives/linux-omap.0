From: "Ogeid Alavaz" <omzatru@gmail.com>
Subject: [PATCH] [OMAPZOOM] OMAP: DISPLAY: Code Clean up Trailing Whitespace
Date: Mon, 24 Nov 2008 12:19:43 -0600
Message-ID: <b293b9830811241019m5817d1f3jc99cd09c99ea964a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.189]:42452 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbYKXSTq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2008 13:19:46 -0500
Received: by gv-out-0910.google.com with SMTP id e6so381238gvc.37
        for <linux-omap@vger.kernel.org>; Mon, 24 Nov 2008 10:19:44 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vikram.pandita@ti.com
Cc: linux-omap@vger.kernel.org

>From 59dd3abeec8498c59ec27408467b7ebaf82d74cf Mon Sep 17 00:00:00 2001
From: Diego Zavala Trujillo <diegozt@ti.com>
Date: Mon, 24 Nov 2008 12:16:01 -0600
Subject: [PATCH] OMAP: DISPLAY: Code Clean up Trailing Whitespace

Clean Whitespaces from drivers/media/video/omap/files
---
 drivers/media/video/omap/Makefile          |    2 +-
 drivers/media/video/omap/omap24xxlib.c     |   64 +++---
 drivers/media/video/omap/omap24xxlib.h     |    4 +-
 drivers/media/video/omap/omap24xxvout.c    |  294 ++++++++++++++--------------
 drivers/media/video/omap/omap24xxvout.h    |    6 +-
 drivers/media/video/omap/omap24xxvoutdef.h |   32 ++--
 6 files changed, 201 insertions(+), 201 deletions(-)

diff --git a/drivers/media/video/omap/Makefile
b/drivers/media/video/omap/Makefile
index d4b0149..cc1c51a 100644
--- a/drivers/media/video/omap/Makefile
+++ b/drivers/media/video/omap/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_VIDEO_OMAP_CAMERA) += omapcamera.o

 objs-y$(CONFIG_ARCH_OMAP16XX) += omap16xxcam.o camera_core.o

-obj-$(CONFIG_VIDEO_OMAP24XX_VIDEOLIB) += omap24xxlib.o
+obj-$(CONFIG_VIDEO_OMAP24XX_VIDEOLIB) += omap24xxlib.o
 obj-$(CONFIG_VIDEO_OMAP24XX_VIDEOOUT) += omap24xxvout.o
 omapcamera-objs := $(objs-yy)

diff --git a/drivers/media/video/omap/omap24xxlib.c
b/drivers/media/video/omap/omap24xxlib.c
index 337123e..0d48584 100644
--- a/drivers/media/video/omap/omap24xxlib.c
+++ b/drivers/media/video/omap/omap24xxlib.c
@@ -3,12 +3,12 @@
  *
  * Copyright (C) 2005 Texas Instruments.
  *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
  * kind, whether express or implied.
  *
  * Based on the OMAP2 camera driver
- * Video-for-Linux (Version 2) camera capture driver for
+ * Video-for-Linux (Version 2) camera capture driver for
  * the OMAP24xx camera controller.
  *
  * Author: Andy Lowe (source@mvista.com)
@@ -38,9 +38,9 @@
 #include <linux/semaphore.h>

 /* Return the default overlay cropping rectangle in crop given the image
- * size in pix and the video display size in fbuf.  The default
- * cropping rectangle is the largest rectangle no larger than the capture size
- * that will fit on the display.  The default cropping rectangle is
centered in
+ * size in pix and the video display size in fbuf.  The default
+ * cropping rectangle is the largest rectangle no larger than the capture size
+ * that will fit on the display.  The default cropping rectangle is centered in
  * the image.  All dimensions and offsets are rounded down to even numbers.
  */
 void
@@ -57,10 +57,10 @@ omap24xxvout_default_crop(struct v4l2_pix_format *pix,
 	crop->top = ((pix->height - crop->height) >> 1) & ~1;
 }

-/* Given a new render window in new_win, adjust the window to the
- * nearest supported configuration.  The adjusted window parameters are
+/* Given a new render window in new_win, adjust the window to the
+ * nearest supported configuration.  The adjusted window parameters are
  * returned in new_win.
- * Returns zero if succesful, or -EINVAL if the requested window is
+ * Returns zero if succesful, or -EINVAL if the requested window is
  * impossible and cannot reasonably be adjusted.
  */
 int
@@ -72,7 +72,7 @@ omap24xxvout_try_window(struct v4l2_framebuffer *fbuf,
 	/* make a working copy of the new_win rectangle */
 	try_win = new_win->w;

-	/* adjust the preview window so it fits on the display by clipping any
+	/* adjust the preview window so it fits on the display by clipping any
 	 * offscreen areas
 	 */
 	if (try_win.left < 0) {
@@ -103,12 +103,12 @@ omap24xxvout_try_window(struct v4l2_framebuffer *fbuf,
 	return 0;
 }

-/* Given a new render window in new_win, adjust the window to the
- * nearest supported configuration.  The image cropping window in crop
- * will also be adjusted if necessary.  Preference is given to keeping the
- * the window as close to the requested configuration as possible.  If
+/* Given a new render window in new_win, adjust the window to the
+ * nearest supported configuration.  The image cropping window in crop
+ * will also be adjusted if necessary.  Preference is given to keeping the
+ * the window as close to the requested configuration as possible.  If
  * successful, new_win, vout->win, and crop are updated.
- * Returns zero if succesful, or -EINVAL if the requested preview window is
+ * Returns zero if succesful, or -EINVAL if the requested preview window is
  * impossible and cannot reasonably be adjusted.
  */
 int
@@ -141,14 +141,14 @@ omap24xxvout_new_window(struct v4l2_rect *crop,
 	return 0;
 }

-/* Given a new cropping rectangle in new_crop, adjust the cropping
rectangle to
- * the nearest supported configuration.  The image render window in win will
- * also be adjusted if necessary.  The preview window is adjusted
such that the
- * horizontal and vertical rescaling ratios stay constant.  If the render
- * window would fall outside the display boundaries, the cropping
rectangle will
- * also be adjusted to maintain the rescaling ratios.  If successful, crop
+/* Given a new cropping rectangle in new_crop, adjust the cropping rectangle to
+ * the nearest supported configuration.  The image render window in win will
+ * also be adjusted if necessary.  The preview window is adjusted such that the
+ * horizontal and vertical rescaling ratios stay constant.  If the render
+ * window would fall outside the display boundaries, the cropping
rectangle will
+ * also be adjusted to maintain the rescaling ratios.  If successful, crop
  * and win are updated.
- * Returns zero if succesful, or -EINVAL if the requested cropping
rectangle is
+ * Returns zero if succesful, or -EINVAL if the requested cropping rectangle is
  * impossible and cannot reasonably be adjusted.
  */
 int
@@ -196,8 +196,8 @@ omap24xxvout_new_crop(struct v4l2_pix_format *pix,
 	if (win->w.height == 0)
 		win->w.height = 2;
 	if (win->w.height + win->w.top > fbuf->fmt.height) {
-		/* We made the preview window extend below the bottom of the
-		 * display, so clip it to the display boundary and resize the
+		/* We made the preview window extend below the bottom of the
+		 * display, so clip it to the display boundary and resize the
 		 * cropping height to maintain the vertical resizing ratio.
 		 */
 		win->w.height = (fbuf->fmt.height - win->w.top) & ~1;
@@ -214,8 +214,8 @@ omap24xxvout_new_crop(struct v4l2_pix_format *pix,
 	if (win->w.width == 0)
 		win->w.width = 2;
 	if (win->w.width + win->w.left > fbuf->fmt.width) {
-		/* We made the preview window extend past the right side of the
-		 * display, so clip it to the display boundary and resize the
+		/* We made the preview window extend past the right side of the
+		 * display, so clip it to the display boundary and resize the
 		 * cropping width to maintain the horizontal resizing ratio.
 		 */
 		win->w.width = (fbuf->fmt.width - win->w.left) & ~1;
@@ -238,19 +238,19 @@ omap24xxvout_new_crop(struct v4l2_pix_format *pix,
 	return 0;
 }

-/* Given a new format in pix and fbuf,  crop and win
- * structures are initialized to default values. crop
- * is initialized to the largest window size that will fit on the
display.  The
- * crop window is centered in the image. win is initialized to
+/* Given a new format in pix and fbuf,  crop and win
+ * structures are initialized to default values. crop
+ * is initialized to the largest window size that will fit on the display.  The
+ * crop window is centered in the image. win is initialized to
  * the same size as crop and is centered on the display.
- * All sizes and offsets are constrained to be even numbers.
+ * All sizes and offsets are constrained to be even numbers.
  */
 void
 omap24xxvout_new_format(struct v4l2_pix_format *pix,
 			struct v4l2_framebuffer *fbuf,
 			struct v4l2_rect *crop, struct v4l2_window *win)
 {
-	/* crop defines the preview source window in the image capture
+	/* crop defines the preview source window in the image capture
 	 * buffer
 	 */
 	omap24xxvout_default_crop(pix, fbuf, crop);
diff --git a/drivers/media/video/omap/omap24xxlib.h
b/drivers/media/video/omap/omap24xxlib.h
index 81b9e03..3b25a8f 100644
--- a/drivers/media/video/omap/omap24xxlib.h
+++ b/drivers/media/video/omap/omap24xxlib.h
@@ -3,8 +3,8 @@
  *
  * Copyright (C) 2005 Texas Instruments.
  *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
  * kind, whether express or implied.
  *
  */
diff --git a/drivers/media/video/omap/omap24xxvout.c
b/drivers/media/video/omap/omap24xxvout.c
index 25ac131..9faa468 100644
--- a/drivers/media/video/omap/omap24xxvout.c
+++ b/drivers/media/video/omap/omap24xxvout.c
@@ -3,12 +3,12 @@
  *
  * Copyright (C) 2005-2006 Texas Instruments.
  *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
  * kind, whether express or implied.
  *
  * Leveraged code from the OMAP2 camera driver
- * Video-for-Linux (Version 2) camera capture driver for
+ * Video-for-Linux (Version 2) camera capture driver for
  * the OMAP24xx camera controller.
  *
  * Author: Andy Lowe (source@mvista.com)
@@ -20,7 +20,7 @@
  * 20-APR-2006	Khasim		Modified VRFB based Rotation,
  *				The image data is always read from 0 degree view and written
  *				to the virtual space of desired rotation angle
- * 4-DEC-2006 Jian		Changed to support better memory management
+ * 4-DEC-2006 Jian		Changed to support better memory management
  *
  */

@@ -78,7 +78,7 @@ extern const char *global_mode_option;
 #endif
 unsigned long timeout;

-/*
+/*
  * Uncomment this if debugging support needs to be enabled
  */

@@ -91,9 +91,9 @@ unsigned long timeout;
 #define DPRINTK( x... )
 #endif

-/*
+/*
  * -1 means rotation support is disabled
- * 0/90/180/270 are initial rotation angles
+ * 0/90/180/270 are initial rotation angles
  */

 static int rotation_support = -1;
@@ -151,7 +151,7 @@ static struct omap24xxvout_device *saved_v1out,
*saved_v2out;
 #define STREAMING_IS_ON()	((saved_v1out && saved_v1out->streaming) || \
 				(saved_v2out && saved_v2out->streaming))

-/*
+/*
  * this is the layer being linked to (slave layer). possible values are:
  * OMAP2_VIDEO1:  V1 is linked to V2. V1 uses V2's pix and crop.
  * OMAP2_VIDEO2:  V2 is linked to V1. V2 uses V1's pix and crop.
@@ -166,9 +166,9 @@ static struct videobuf_queue_ops dummy_vbq_ops;

 /* module parameters */

-/*
+/*
  * Maximum amount of memory to use for rendering buffers.
- * Default is enough to four (RGB24) VGA buffers.
+ * Default is enough to four (RGB24) VGA buffers.
  */
 #define MAX_ALLOWED_VIDBUFFERS            4
 static int render_mem = VID_MAX_WIDTH * VID_MAX_HEIGHT * 4 *
MAX_ALLOWED_VIDBUFFERS;
@@ -206,7 +206,7 @@ const static struct v4l2_fmtdesc omap2_formats[] = {
 	.pixelformat = V4L2_PIX_FMT_RGB565X,
 },
 {
-	/* Note:  V4L2 defines RGB32 as: RGB-8-8-8-8  we use
+	/* Note:  V4L2 defines RGB32 as: RGB-8-8-8-8  we use
 	 *        this for RGB24 unpack mode, the last 8 bits are ignored
 	 *
 	 */
@@ -214,7 +214,7 @@ const static struct v4l2_fmtdesc omap2_formats[] = {
 	.pixelformat = V4L2_PIX_FMT_RGB32,
 },
 {
-	/* Note:  V4L2 defines RGB24 as: RGB-8-8-8  we use
+	/* Note:  V4L2 defines RGB24 as: RGB-8-8-8  we use
 	 *        this for RGB24 packed mode
 	 *
 	 */
@@ -307,8 +307,8 @@ static void
 omap24xxvout_sync (struct omap24xxvout_device *dest,
 		   struct omap24xxvout_device *src)
 {
-	/*
-	 * once linked, dest shares src's framebuffer, pix and crop
+	/*
+	 * once linked, dest shares src's framebuffer, pix and crop
 	 */

 	dest->pix = src->pix;
@@ -488,7 +488,7 @@ omap24xxvout_do_ioctl (struct inode *inode, struct
file *file,

 		switch (fmt->type){
 			case V4L2_BUF_TYPE_VIDEO_OUTPUT:
-	  		case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+			case V4L2_BUF_TYPE_VIDEO_OVERLAY:
 			if (index >= NUM_OUTPUT_FORMATS)
 				return -EINVAL;
 			break;
@@ -521,13 +521,13 @@ omap24xxvout_do_ioctl (struct inode *inode,
struct file *file,
 			struct v4l2_window *win = &f->fmt.win;
 			memset (win, 0, sizeof (*win));

-			/*
-			 * The API has a bit of a problem here.
-			 * We're returning a v4l2_window
-			 * structure, but that structure
-			 * contains pointers to variable-sized
-			 * objects for clipping rectangles and
-			 * clipping bitmaps.  We will just
+			/*
+			 * The API has a bit of a problem here.
+			 * We're returning a v4l2_window
+			 * structure, but that structure
+			 * contains pointers to variable-sized
+			 * objects for clipping rectangles and
+			 * clipping bitmaps.  We will just
 			 * return NULLs for those pointers.
 			 */

@@ -546,11 +546,11 @@ omap24xxvout_do_ioctl (struct inode *inode,
struct file *file,

 		if (vout->streaming)
 			return -EBUSY;
-			
+
 		/* We dont support RGB24-packed mode if vrfb rotation is enabled*/
 		if(vout->rotation != -1 && f->fmt.pix.pixelformat == V4L2_PIX_FMT_RGB24)
 			return -EINVAL;
-			
+
 		switch (f->type){

 		case V4L2_BUF_TYPE_VIDEO_OVERLAY:
@@ -575,10 +575,10 @@ omap24xxvout_do_ioctl (struct inode *inode,
struct file *file,
 	case VIDIOC_S_FMT:
 	{
 		struct v4l2_format *f = (struct v4l2_format *) arg;
-		
+
 		if (vout->streaming)
 			return -EBUSY;
-		
+
 		/* We dont support RGB24-packed mode if vrfb rotation is enabled*/
 		if(vout->rotation != -1 && f->fmt.pix.pixelformat == V4L2_PIX_FMT_RGB24 )
 			return -EINVAL;
@@ -593,7 +593,7 @@ omap24xxvout_do_ioctl (struct inode *inode, struct
file *file,
 		else{
 			omap2_disp_get_panel_size (omap2_disp_get_output_dev (vout->vid),
 				&(vout->fbuf.fmt.width), &(vout->fbuf.fmt.height));
-			
+
 		}

 		omap2_disp_put_dss();
@@ -604,22 +604,22 @@ omap24xxvout_do_ioctl (struct inode *inode,
struct file *file,
 			struct v4l2_window *win = &f->fmt.win;


-			err = omap24xxvout_new_window (&vout->crop, &vout->win,
+			err = omap24xxvout_new_window (&vout->crop, &vout->win,
 				&vout->fbuf, win);
 			return err;
 		}
 		case V4L2_BUF_TYPE_VIDEO_OUTPUT:
 		{
 			int bpp;
-			/*
-			 * don't allow to change img for the linked layer
+			/*
+			 * don't allow to change img for the linked layer
 			 */
 			if (vout->vid == vout_linked)
 				return -EINVAL;

 			/* change to samller size is OK */
 			bpp = try_format (&f->fmt.pix);
-			f->fmt.pix.sizeimage = f->fmt.pix.width * f->fmt.pix.height *bpp;
+			f->fmt.pix.sizeimage = f->fmt.pix.width * f->fmt.pix.height *bpp;

 			/* try & set the new output format */
 			vout->bpp = bpp;
@@ -683,7 +683,7 @@ omap24xxvout_do_ioctl (struct inode *inode, struct
file *file,
 		struct v4l2_crop *crop = (struct v4l2_crop *) arg;
 		if (vout->streaming)
 			return -EBUSY;
-		
+
 		omap2_disp_get_dss();

 		/* get the framebuffer parameters */
@@ -694,7 +694,7 @@ omap24xxvout_do_ioctl (struct inode *inode, struct
file *file,
 		else{
 			omap2_disp_get_panel_size (omap2_disp_get_output_dev (vout->vid),
 				&(vout->fbuf.fmt.width), &(vout->fbuf.fmt.height));
-			
+
 		}
 		omap2_disp_put_dss();

@@ -742,7 +742,7 @@ omap24xxvout_do_ioctl (struct inode *inode, struct
file *file,
 			}
 		}

-		/*
+		/*
 		 * We allow re-request as long as old buffers are not mmaped.
 		 * We will need to free old buffers first.
 		 */
@@ -762,8 +762,8 @@ omap24xxvout_do_ioctl (struct inode *inode, struct
file *file,
 				dma_free_coherent(NULL, vout->buffer_size,
 					(void *) ((struct videobuf_dmabuf*)(q->bufs[i]->priv))->vmalloc,
 					((struct videobuf_dmabuf *)(q->bufs[i]->priv))->bus_addr);
-	
-#endif	
+
+#endif
 				q->bufs[i] = NULL;
 			}
 			vout->buffer_allocated = 0;
@@ -780,9 +780,9 @@ omap24xxvout_do_ioctl (struct inode *inode, struct
file *file,
 		while (PAGE_ALIGN(vout->pix.sizeimage) * count > render_mem)
 			count--;

-		// vout->buffer_size = PAGE_ALIGN(vout->pix.sizeimage);
+		// vout->buffer_size = PAGE_ALIGN(vout->pix.sizeimage);
 		/* Allocate for maximum size */
-		vout->buffer_size = PAGE_ALIGN(VID_MAX_WIDTH * VID_MAX_HEIGHT * 2);
+		vout->buffer_size = PAGE_ALIGN(VID_MAX_WIDTH * VID_MAX_HEIGHT * 2);
 		for (i = 0; i < count; i++) {
 			virt_addr =
 			(unsigned int)dma_alloc_coherent(NULL,
@@ -797,7 +797,7 @@ omap24xxvout_do_ioctl (struct inode *inode, struct
file *file,
 			DPRINTK("REQBUFS: buffer %d: virt=0x%x, phy=0x%x, size=0x%x\n",
 				i, virt_addr, phy_addr, vout->buffer_size);

-#if 0	
+#if 0
 			q->bufs[i] = videobuf_alloc (q->msize);
 #else
 			q->bufs[i] = videobuf_alloc (q);
@@ -813,8 +813,8 @@ omap24xxvout_do_ioctl (struct inode *inode, struct
file *file,
 			q->bufs[i]->memory = req->memory;
 			q->bufs[i]->bsize = vout->buffer_size;
 			q->bufs[i]->boff = vout->buffer_size * i;
-			
-#if 0	
+
+#if 0
 			q->bufs[i]->dma.vmalloc = (void *) (virt_addr);
 			q->bufs[i]->dma.bus_addr = phy_addr;
 #else
@@ -859,18 +859,18 @@ omap24xxvout_do_ioctl (struct inode *inode,
struct file *file,
 		int dest_frame_index = 0, src_element_index = 0;
 		int dest_element_index = 0, src_frame_index = 0;
 		int elem_count = 0, frame_count = 0, pixsize = 2,mir_rot_deg = 0;
-		int output_dev = omap2_disp_get_output_dev(vout->vid);	
-		int streaming_on = STREAMING_IS_ON(); 	
+		int output_dev = omap2_disp_get_output_dev(vout->vid);
+		int streaming_on = STREAMING_IS_ON();

 		timeout = HZ / 5;
-		timeout += jiffies;
-	
+		timeout += jiffies;
+
 		omap2_disp_get_tvlcd(&tvlcd_status);
-		
-		if (!streaming_on)	
+
+		if (!streaming_on)
 		omap2_disp_get_dss();
 		if (tvlcd_status.status == TVLCD_STOP){
-			
+
 			if (tvlcd_status.ltype == vout->vid){
 				omap2_disp_disable_layer (vout->vid);
 				vout->streaming = NULL;
@@ -885,7 +885,7 @@ omap24xxvout_do_ioctl (struct inode *inode, struct
file *file,
 					set_current_state(TASK_INTERRUPTIBLE);
 					schedule_timeout(1);
 				} else
-					udelay(10);	
+					udelay(10);
 			}

 				if(vout->rotation == 90 || vout->rotation == 270){
@@ -905,13 +905,13 @@ omap24xxvout_do_ioctl (struct inode *inode,
struct file *file,
 			if (!streaming_on)
 			omap2_disp_put_dss();

-#if 0	
+#if 0
 			return 0;
 #else
 		omap2_disp_get_tvlcd(&tvlcd_status);
-#endif	
+#endif
 		}
-		
+
 		if (tvlcd_status.status == TVLCD_CONTINUE){

 			if (tvlcd_status.ltype == vout->vid){
@@ -926,8 +926,8 @@ omap24xxvout_do_ioctl (struct inode *inode, struct
file *file,

 			omap2_disp_set_tvlcd(0);
 		}
-		
-		
+
+
 		/* don't allow to queue buffer for the linked layer */
 		if (vout->vid == vout_linked) {
 			if (!streaming_on)
@@ -955,19 +955,19 @@ omap24xxvout_do_ioctl (struct inode *inode,
struct file *file,
 			omap2_disp_put_dss();
 			return -EINVAL;
 		}
-			
+
 		mutex_lock(&q->vb_lock);

-		/*
-		 * If rotation is enabled then copy the image data from the
-		 * MMAPPED area to SMS area
+		/*
+		 * If rotation is enabled then copy the image data from the
+		 * MMAPPED area to SMS area
 		 */

 		if (vout->rotation >= 0){
-		
-		
+
+
 			/*
-			 * WAIT FOR GO bit to be cleared or in other terms wait till current
+			 * WAIT FOR GO bit to be cleared or in other terms wait till current
 			 * frame is renderned
 			 */

@@ -977,16 +977,16 @@ omap24xxvout_do_ioctl (struct inode *inode,
struct file *file,
 					set_current_state(TASK_INTERRUPTIBLE);
 					schedule_timeout(1);
 				} else
-					udelay(10);	
+					udelay(10);
 			}

-			
-			
+
+
 			pixsize = vout->bpp * vout->vrfb_bpp;
 			/*
 			 * DMA transfer in double index mode
 			 */
-	
+
 			/* Frame index */
 			dest_frame_index =
 				((MAX_PIXELS_PER_LINE * pixsize) - (vout->pix.width * vout->bpp)) + 1;
@@ -1002,7 +1002,7 @@ omap24xxvout_do_ioctl (struct inode *inode,
struct file *file,
 			vout->vrfb_dma_tx.tx_status = 0;
 			omap_set_dma_transfer_params (vout->vrfb_dma_tx.dma_ch,
 				OMAP_DMA_DATA_TYPE_S32,(elem_count / 4), frame_count,
-				OMAP_DMA_SYNC_ELEMENT,vout->vrfb_dma_tx.dev_id, 0x0);
+				OMAP_DMA_SYNC_ELEMENT,vout->vrfb_dma_tx.dev_id, 0x0);

 #if 0
 			omap_set_dma_src_params (vout->vrfb_dma_tx.dma_ch,
@@ -1014,7 +1014,7 @@ omap24xxvout_do_ioctl (struct inode *inode,
struct file *file,
 				0,	// src_port required only for OMAP1
 				OMAP_DMA_AMODE_POST_INC,((struct videobuf_dmabuf
*)(q->bufs[buffer->index]->priv))->bus_addr,
 				src_element_index, src_frame_index);
-#endif			
+#endif
 			/*set dma source burst mode for VRFB*/
 			omap_set_dma_src_burst_mode(vout->vrfb_dma_tx.dma_ch,
OMAP_DMA_DATA_BURST_16);

@@ -1022,7 +1022,7 @@ omap24xxvout_do_ioctl (struct inode *inode,
struct file *file,
 				mir_rot_deg = (vout->rotation == 90)?(270/90):
 						(vout->rotation == 270)?(90/90):
 							(vout->rotation == 180)?(0/90):(180/90);
-				
+
 				omap_set_dma_dest_params (vout->vrfb_dma_tx.dma_ch,
 						0,	// dest_port required only for OMAP1
 						OMAP_DMA_AMODE_DOUBLE_IDX,
@@ -1042,7 +1042,7 @@ omap24xxvout_do_ioctl (struct inode *inode,
struct file *file,
 			omap_start_dma (vout->vrfb_dma_tx.dma_ch);
 			interruptible_sleep_on_timeout (&vout->vrfb_dma_tx.wait,
 					    VRFB_TX_TIMEOUT);
-					
+
 			if (vout->vrfb_dma_tx.tx_status == 0){
 				omap_stop_dma (vout->vrfb_dma_tx.dma_ch);
 				mutex_unlock(&q->vb_lock);
@@ -1069,7 +1069,7 @@ omap24xxvout_do_ioctl (struct inode *inode,
struct file *file,
 #else
 				omap2_disp_start_vlayer (vout->vid, &vout->pix, &vout->crop, &vout->win,
 				((struct videobuf_dmabuf*)(q->bufs[buffer->index]->priv))->bus_addr,vout->rotation,
vout->mirror);
-#endif	
+#endif
 		}

 		/* start slave layer if V1 and V2 are linked */
@@ -1082,20 +1082,20 @@ omap24xxvout_do_ioctl (struct inode *inode,
struct file *file,
 						mir_rot_deg = (dest->rotation == 90)? 270:
 							(dest->rotation == 270)? 90:
 								(dest->rotation == 180)? 0:180;
-						
-						omap2_disp_start_vlayer(dest->vid,&dest->pix,
+
+						omap2_disp_start_vlayer(dest->vid,&dest->pix,
 						&dest->crop, &vout->win, vout->sms_rot_phy[vout->pos][0], mir_rot_deg,
 						dest->mirror);
 					}
 					/* if no mirroring but rotation */
 					else{
 						omap2_disp_start_vlayer(dest->vid,&dest->pix,
-						&dest->crop, &vout->win, vout->sms_rot_phy[vout->pos][0],
+						&dest->crop, &vout->win, vout->sms_rot_phy[vout->pos][0],
 						dest->rotation,dest->mirror);
 					}
 				}
 				else {
-#if 0	
+#if 0
 					omap2_disp_start_vlayer (dest-> vid, &dest->pix, &dest-> crop, &vout->win,
 					q->bufs[buffer->index]->dma.bus_addr, dest->rotation,
 					dest->mirror);
@@ -1103,12 +1103,12 @@ omap24xxvout_do_ioctl (struct inode *inode,
struct file *file,
 					omap2_disp_start_vlayer (dest-> vid, &dest->pix, &dest-> crop, &vout->win,
 					((struct videobuf_dmabuf
*)(q->bufs[buffer->index]->priv))->bus_addr, dest->rotation,
 					dest->mirror);
-#endif	
+#endif
 				}		/* if no rotation and mirroring */
 			}
 		}

-		vout->pos = (vout->pos == 0)? 1 : 0;		
+		vout->pos = (vout->pos == 0)? 1 : 0;
 		mutex_unlock(&q->vb_lock);
 		if (!streaming_on)
 		omap2_disp_put_dss();
@@ -1148,82 +1148,82 @@ omap24xxvout_do_ioctl (struct inode *inode,
struct file *file,

 		if (vout->vid != vout_linked){
 			if (vout->rotation >= 0){
-				
+
 				/* Align the image size with respect to tile size */
 				u32 image_width = 0, image_height = 0;
-				
-		    image_width = VGA_WIDTH / TILE_SIZE;
-		    						if(VGA_WIDTH % TILE_SIZE)						
+
+		    image_width = VGA_WIDTH / TILE_SIZE;
+								if(VGA_WIDTH % TILE_SIZE)
 		                        image_width++;
 		                image_width = image_width * TILE_SIZE;
-				
-				image_height = VGA_HEIGHT / TILE_SIZE;
-		    						if (VGA_HEIGHT % TILE_SIZE)
+
+				image_height = VGA_HEIGHT / TILE_SIZE;
+								if (VGA_HEIGHT % TILE_SIZE)
 		                        image_height++;
 		                image_height = image_height * TILE_SIZE;
-				
+
 				/* Required to free */
 				vout->tile_aligned_psize = image_width * image_height * vout->bpp
* vout->vrfb_bpp;
-				
+
 				/* have to free and re-allocate */
-				if (vout->smsshado_size && vout->smsshado_size <
vout->tile_aligned_psize) {
-				
+				if (vout->smsshado_size && vout->smsshado_size <
vout->tile_aligned_psize) {
+
 					/* First context per video pipeline */
 						dma_free_coherent(NULL, vout->smsshado_size,
 						(void *)vout->smsshado_virt_addr[0],
 						(dma_addr_t)vout->smsshado_phy_addr[0]);
-					
-				
+
+
 						dma_free_coherent(NULL, vout->smsshado_size,
 						(void *)vout->smsshado_virt_addr[1],
 						(dma_addr_t)vout->smsshado_phy_addr[1]);
-					
+
 					vout->smsshado_size = 0;
 					vout->smsshado_virt_addr[0] = 0;
 					vout->smsshado_virt_addr[1] = 0;
 				}

 				/* Allocate the actual physical space for VRFB */
-				/*
-				 * The allocation is rounded to tile size as we are
-				 * taking care of the offset while reading the data
-				 * and also we will always fill the 0 degree space with
+				/*
+				 * The allocation is rounded to tile size as we are
+				 * taking care of the offset while reading the data
+				 * and also we will always fill the 0 degree space with
 				 * the image data and read the data requested space (rotation degree)
 				 */
-				
+
 				for(k = 0; k < 2; k++){
 						if (!vout->smsshado_virt_addr[k]) {
 								/* allocate for worst case size */
-								image_width = VID_MAX_WIDTH / TILE_SIZE;
+								image_width = VID_MAX_WIDTH / TILE_SIZE;
 								if (VID_MAX_WIDTH % TILE_SIZE)
 										image_width++;
-								
+
 								image_width = image_width * TILE_SIZE;
 								image_height = VID_MAX_HEIGHT / TILE_SIZE;
-								
+
 								if (VID_MAX_HEIGHT % TILE_SIZE)
 										image_height++;
-								
+
 								image_height = image_height * TILE_SIZE;
 								vrfb_buf_size = image_width * image_height * 2 * 2; //
allocate for YUV format (worst case)
 								vout->smsshado_virt_addr[k] = (unsigned int)
 										dma_alloc_coherent(NULL, PAGE_ALIGN(vrfb_buf_size),
 														(dma_addr_t *) &vout->smsshado_phy_addr[k], GFP_KERNEL
| GFP_DMA);
-								vout->smsshado_size = PAGE_ALIGN(vrfb_buf_size);				 		
+								vout->smsshado_size = PAGE_ALIGN(vrfb_buf_size);

 						}
-						
+
 						if (!vout->smsshado_virt_addr[k])
 							return -ENOMEM;
-					
+
 						memset((void *) vout->smsshado_virt_addr[k], 0, vout->smsshado_size);
-	
+
 						if(vout->rotation == 90 || vout->rotation == 270){
-							omap2_disp_set_vrfb (vout->vrfb_context[k], vout->smsshado_phy_addr[k],
+							omap2_disp_set_vrfb (vout->vrfb_context[k], vout->smsshado_phy_addr[k],
 							vout->pix.height, vout->pix.width, vout->bpp * vout->vrfb_bpp);
 						}
 						else{
-							omap2_disp_set_vrfb (vout->vrfb_context[k], vout->smsshado_phy_addr[k],
+							omap2_disp_set_vrfb (vout->vrfb_context[k], vout->smsshado_phy_addr[k],
 							vout->pix.width, vout->pix.height, vout->bpp * vout->vrfb_bpp);
 						}
 					}
@@ -1242,7 +1242,7 @@ omap24xxvout_do_ioctl (struct inode *inode,
struct file *file,

 	case VIDIOC_STREAMOFF:
 	{
-		/*
+		/*
 		 * only allow the file handler that started streaming to
 		 * stop streaming
 		 */
@@ -1343,7 +1343,7 @@ omap24xxvout_do_ioctl (struct inode *inode,
struct file *file,
 		else
 			return -EINVAL;
 	}
-	
+
 	case VIDIOC_G_OMAP2_ROTATION:
 	{
 		int *rotation = arg;
@@ -1404,7 +1404,7 @@ omap24xxvout_do_ioctl (struct inode *inode,
struct file *file,
 		omap2_disp_set_bg_color (bgcolor->output_dev, bgcolor->color);

 		omap2_disp_put_dss();
-		
+
 		return 0;
 	}
 	case VIDIOC_G_OMAP2_BGCOLOR:
@@ -1455,10 +1455,10 @@ omap24xxvout_do_ioctl (struct inode *inode,
struct file *file,

 		return 0;
 	}
-	
+
 	case VIDIOC_S_OMAP2_COLORCONV:
 	{
-		int v;
+		int v;
 		struct omap24xxvout_colconv *ccmtx =
                         (struct omap24xxvout_colconv *) arg;

@@ -1475,14 +1475,14 @@ omap24xxvout_do_ioctl (struct inode *inode,
struct file *file,
 		current_colorconv_values[v][2][1]=ccmtx->BCr;
 		current_colorconv_values[v][2][2]=ccmtx->BCb;
 		omap2_disp_get_dss();
-		omap2_disp_set_colorconv(vout->vid, &vout->pix);	
+		omap2_disp_set_colorconv(vout->vid, &vout->pix);
 		omap2_disp_put_dss();
 		return 0;
 	}

 	case VIDIOC_G_OMAP2_COLORCONV:
 	{
-		int v;
+		int v;
 		struct omap24xxvout_colconv *ccmtx =
                         (struct omap24xxvout_colconv *) arg;

@@ -1506,7 +1506,7 @@ omap24xxvout_do_ioctl (struct inode *inode,
struct file *file,
 	{
 		omap2_disp_get_dss();

-		omap2_disp_set_default_colorconv(vout->vid, &vout->pix);	
+		omap2_disp_set_default_colorconv(vout->vid, &vout->pix);

 		omap2_disp_put_dss();

@@ -1593,9 +1593,9 @@ omap24xxvout_mmap (struct file *file, struct
vm_area_struct *vma)
 	struct videobuf_queue *q = &fh->vbq;
 	unsigned long size = (vma->vm_end - vma->vm_start), start = vma->vm_start;
 	int i;
-	void *pos;
+	void *pos;

-	DPRINTK ("pgoff=0x%x, start=0x%x, end=0x%x\n", vma->vm_pgoff,
+	DPRINTK ("pgoff=0x%x, start=0x%x, end=0x%x\n", vma->vm_pgoff,
 		vma->vm_start,  vma->vm_end);


@@ -1636,9 +1636,9 @@ omap24xxvout_mmap (struct file *file, struct
vm_area_struct *vma)
 	size -= PAGE_SIZE;
 	}
 	vma->vm_flags &= ~VM_IO; /* using shared anonymous pages */
-	/* under investigation.
+	/* under investigation.
 	clearing this bit allows video-buf to accept buffers alloacted here
but has troube when unmap */
-	//vma->vm_flags &= ~VM_PFNMAP;
+	//vma->vm_flags &= ~VM_PFNMAP;

 	mutex_unlock(&q->vb_lock);
 	vout->mmap_count++;
@@ -1674,22 +1674,22 @@ omap24xxvout_release (struct inode *inode,
struct file *file)
 	omap2_disp_get_dss();
 	omap24xxvout_suspend_lockout (vout, file);

-	/*
+	/*
 	 * Check if the hidden buffer transfer is happening with DMA
 	 * if yes then stop it
 	 */
-	
+
 	if (vout->rotation != -1){
 		if (vout->vrfb_dma_tx.tx_status == 0){

-			/*
-			 * DMA will be stopped once here and again after wakeup to
-			 * avoid race conditions due to time taken to wakeup the
+			/*
+			 * DMA will be stopped once here and again after wakeup to
+			 * avoid race conditions due to time taken to wakeup the
 			 * sleeping process
 			 */
-			
+
 			omap_stop_dma (vout->vrfb_dma_tx.dma_ch);
-			wake_up_interruptible(&vout->vrfb_dma_tx.wait);	
+			wake_up_interruptible(&vout->vrfb_dma_tx.wait);
 		}
 	}

@@ -1826,7 +1826,7 @@ omap24xxvout_open (struct inode *inode, struct file *file)
 	dummy_vbq_ops.buf_prepare = dummy_vbq_prepare;
 	dummy_vbq_ops.buf_release = dummy_vbq_release;
 	dummy_vbq_ops.buf_queue = dummy_vbq_queue;
-#if 0	
+#if 0
 	videobuf_queue_init (q, &dummy_vbq_ops, NULL, &vout->vbq_lock,
 		fh->type, V4L2_FIELD_NONE, sizeof (struct videobuf_buffer), fh);
 #else
@@ -1853,14 +1853,14 @@ omap24xxvout_open (struct inode *inode, struct
file *file)
 		q->bufs[i]->memory = vout->buf_memory_type;
 		q->bufs[i]->bsize = vout->buffer_size;
 		q->bufs[i]->boff = vout->buffer_size * i;
-#if 0	
+#if 0
 		q->bufs[i]->dma.vmalloc = (void *) vout->buf_virt_addr[i];
 		q->bufs[i]->dma.bus_addr = vout->buf_phy_addr[i];
 #else
 		q->bufs[i]->priv = kmalloc(sizeof(struct videobuf_dmabuf),GFP_KERNEL);
 		((struct videobuf_dmabuf*)(q->bufs[i]->priv))->vmalloc = (void *)
vout->buf_virt_addr[i];
 		((struct videobuf_dmabuf*)(q->bufs[i]->priv))->bus_addr =
vout->buf_phy_addr[i];
-#endif	
+#endif
 		q->bufs[i]->state = VIDEOBUF_PREPARED;
 	}

@@ -1887,7 +1887,7 @@ static int
 omap24xxvout_suspend (struct platform_device *dev, pm_message_t state)
 {
 	struct omap24xxvout_device *vout = platform_get_drvdata (dev);
-	
+
 	/* lock-out applications during suspend */
 	if(vout->suspended == 1) return 0;
 	if (vout->opened){
@@ -1898,14 +1898,14 @@ omap24xxvout_suspend (struct platform_device
*dev, pm_message_t state)
 			 * Check if the hidden buffer transfer is happening with DMA
 			 * if yes then stop it
 			 */
-			
+
 			if (vout->rotation != -1){
 				if (vout->vrfb_dma_tx.tx_status == 0){
 					/*
 					 * DMA will be stopped once here and again after wakeup to
 					 * avoid race conditions due to time taken to wakeup the
-				 	 * sleeping process
-				 	 */
+					 * sleeping process
+					 */
 					omap_stop_dma (vout->vrfb_dma_tx.dma_ch);
 					wake_up_interruptible (&vout->vrfb_dma_tx.wait);
 				}
@@ -1914,8 +1914,8 @@ omap24xxvout_suspend (struct platform_device
*dev, pm_message_t state)
 		vout->suspended = 1;
 		omap2_disp_put_dss ();
 	}
-	
-	
+
+
 	return 0;
 }

@@ -1927,11 +1927,11 @@ omap24xxvout_resume (struct platform_device *dev)
 	if (vout->opened)
 	{
 		omap2_disp_get_dss ();
-		
+
 		/* resume vid DMA */
 		if (vout->streaming)
 			omap2_disp_enable_layer (vout->vid);
-			
+
 		/* wake up applications waiting on suspend queue */
 		vout->suspended = 0;
 		wake_up (&vout->suspend_wq);
@@ -2144,16 +2144,16 @@ cleanup_vout_device (int vid)

 	if (vfd){
 		if (vfd->minor == -1){
-			/*
-			 * The device was never registered, so release the
-			 * video_device struct directly.
+			/*
+			 * The device was never registered, so release the
+			 * video_device struct directly.
 			 */
 			video_device_release (vfd);
 		}
 		else{
-			/*
+			/*
 			 * The unregister function will release the video_device
-			 * struct as well as unregistering it.
+			 * struct as well as unregistering it.
 			 */
 			video_unregister_device (vfd);
 		}
@@ -2238,7 +2238,7 @@ init_vout_device (int vid)

 	vout->bpp = RGB565_BPP;
 	vout->vrfb_bpp = 1;
-	
+
 	/* get the screen parameters */
 	omap2_disp_get_panel_size (omap2_disp_get_output_dev (vout->vid),
 		&(vout->fbuf.fmt.width),&(vout->fbuf.fmt.height));
@@ -2258,13 +2258,13 @@ init_vout_device (int vid)
 	strncpy (vfd->name, VOUT_NAME, sizeof (vfd->name));
 	vfd->vfl_type = VID_TYPE_OVERLAY | VID_TYPE_CHROMAKEY;
 	/* need to register for a VID_HARDWARE_* ID in videodev.h */
-#if 0	
+#if 0
 	vfd->hardware = 0;
-#endif	
+#endif
 	vfd->fops = &omap24xxvout_fops;
 	video_set_drvdata (vfd, vout);
 	vfd->minor = -1;
-	
+
 	/* SMS memory starts from 0x70000000 - 256 MB region */
 	vout->sms_rot_phy[0][0] = (vid == OMAP2_VIDEO1) ? 0x74000000 : 0x7C000000;
 	vout->sms_rot_phy[0][1] = (vid == OMAP2_VIDEO1) ? 0x75000000 : 0x7D000000;
@@ -2292,12 +2292,12 @@ init_vout_device (int vid)
 	}
 		if (!request_mem_region (vout->sms_rot_phy[k][3], VRF_SIZE, vfd->name)){
 		printk (KERN_ERR VOUT_NAME ": cannot reserve sms I/O region - 3\n");
-		goto rotation_sms_free_180;	
+		goto rotation_sms_free_180;
 		/* free them in reverse order - otherewise you will free
 		   extra stuff and get caught */
 	}
 	}
-	
+
 	vout->suspended = 0;
 	init_waitqueue_head (&vout->suspend_wq);

@@ -2359,7 +2359,7 @@ init_vout_device (int vid)
 	if (r)
 		vout->vrfb_dma_tx.req_status = DMA_CHAN_NOT_ALLOTED;
 	init_waitqueue_head (&vout->vrfb_dma_tx.wait);
-	
+
 	/*if rotation support */
 	printk (KERN_INFO VOUT_NAME ": registered device video%d [v4l2]\n",
 		vfd->minor);
diff --git a/drivers/media/video/omap/omap24xxvout.h
b/drivers/media/video/omap/omap24xxvout.h
index e086940..92a2a2b 100644
--- a/drivers/media/video/omap/omap24xxvout.h
+++ b/drivers/media/video/omap/omap24xxvout.h
@@ -3,8 +3,8 @@
  *
  * Copyright (C) 2005 Texas Instruments.
  *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
  * kind, whether express or implied.
  */

@@ -31,7 +31,7 @@ struct omap24xxvout_bgcolor {
 struct omap24xxvout_colconv{
 	short int RY,RCr,RCb;
 	short int GY,GCr,GCb;
-	short int BY,BCr,BCb;
+	short int BY,BCr,BCb;
 };


diff --git a/drivers/media/video/omap/omap24xxvoutdef.h
b/drivers/media/video/omap/omap24xxvoutdef.h
index 395e414..22bc981 100644
--- a/drivers/media/video/omap/omap24xxvoutdef.h
+++ b/drivers/media/video/omap/omap24xxvoutdef.h
@@ -3,8 +3,8 @@
  *
  * Copyright (C) 2005 Texas Instruments.
  *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
  * kind, whether express or implied.
  */

@@ -21,8 +21,8 @@
 #define YUYV_VRFB_BPP   2
 #define RGB_VRFB_BPP    1

-/*
- * This structure is used to store the DMA transfer parameters
+/*
+ * This structure is used to store the DMA transfer parameters
  * for VRFB hidden buffer
  */
 struct vid_vrfb_dma
@@ -59,15 +59,15 @@ struct omap24xxvout_device {
 	int buffer_size;
 	/* keep buffer info accross opens */
 	unsigned long buf_virt_addr[VIDEO_MAX_FRAME], buf_phy_addr[VIDEO_MAX_FRAME];
-	unsigned int buf_memory_type;
+	unsigned int buf_memory_type;

 	/* we don't allow to request new buffer when old buffers are still mmaped */
 	int mmap_count;

 	spinlock_t vbq_lock;		/* spinlock for videobuf queues */
 	unsigned long field_count;	/* field counter for videobuf_buffer */
- 	
- 	/* non-NULL means streaming is in progress. */
+
+	/* non-NULL means streaming is in progress. */
 	struct omap24xxvout_fh *streaming;

 	struct v4l2_pix_format pix;
@@ -81,18 +81,18 @@ struct omap24xxvout_device {

 	int mirror;
 	int rotation;
-	
+
 	int bpp; /* bytes per pixel */
 	int vrfb_bpp; /* bytes per pixel with respect to VRFB */
 	unsigned int tile_aligned_psize;
-				
+
 	struct vid_vrfb_dma vrfb_dma_tx;
 	unsigned int smsshado_phy_addr[2];
 	unsigned int smsshado_virt_addr[2];
 	unsigned int vrfb_context[2];
 	unsigned int smsshado_size;
 	unsigned char pos;
-	
+
 };

 /* per-filehandle data structure */
@@ -114,9 +114,9 @@ struct aux_disp_buf {
 };

 struct aux_disp_queue_hdr {
-	int 					queue_depth;
+	int					queue_depth;
 	int						queued;
-	int 					dequeued;
+	int					dequeued;
 	int						processed;
 	struct aux_disp_buf		*aux_disp_queue;
 };
@@ -144,15 +144,15 @@ struct omap3_aux_disp_device {
 	int buffer_size;
 	/* keep buffer info accross opens */
 	unsigned long buf_virt_addr[VIDEO_MAX_FRAME], buf_phy_addr[VIDEO_MAX_FRAME];
-	unsigned int buf_memory_type;
+	unsigned int buf_memory_type;

 	/* we don't allow to request new buffer when old buffers are still mmaped */
 	int mmap_count;

 	spinlock_t vbq_lock;		/* spinlock for videobuf queues */
 	unsigned long field_count;	/* field counter for videobuf_buffer */
- 	
- 	/* non-NULL means streaming is in progress. */
+
+	/* non-NULL means streaming is in progress. */
 	struct omap24xxvout_fh *streaming;

 	struct v4l2_pix_format pix;
@@ -162,7 +162,7 @@ struct omap3_aux_disp_device {

 	int mirror;
 	int rotation;
-	
+
 	int bpp; /* bytes per pixel */
 	struct aux_disp_queue_hdr	aux_queue_hdr;
 };
-- 
1.5.5.1

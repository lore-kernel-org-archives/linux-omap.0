From: Trilok Soni <trilok_soni@yahoo.co.in>
Subject: [PATCH] OMAP: Update OMAP1 camera core with video_ioctl2 interface.
Date: Thu, 23 Aug 2007 04:52:56 -0700 (PDT)
Message-ID: <689645.52282.qm@web8514.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1786622073-1187869976=:52282"
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
List-Id: linux-omap@vger.kernel.org

--0-1786622073-1187869976=:52282
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

Attached patch uses video_ioctl2 interface. It is
compile tested only. Please test it if one has OMAP1
based board.

---Trilok Soni


      ____________________________________________________________________________________
Shape Yahoo! in your own image.  Join our Network Research Panel today!   http://surveylink.yahoo.com/gmrs/yahoo_panel_invite.asp?a=7 


--0-1786622073-1187869976=:52282
Content-Type: text/x-patch;
	name="0001-OMAP-Update-OMAP1-camera-core-with-video_ioctl2-interface.patch"
Content-Description: 2904221201-0001-OMAP-Update-OMAP1-camera-core-with-video_ioctl2-interface.patch
Content-Disposition: inline;
	filename="0001-OMAP-Update-OMAP1-camera-core-with-video_ioctl2-interface.patch"

>From 564392b1ddab13202e6824c9818b2389cd74baa6 Mon Sep 17 00:00:00 2001
From: Trilok Soni <soni.trilok@gmail.com>
Date: Thu, 23 Aug 2007 22:15:48 +0530
Subject: [PATCH] OMAP: Update OMAP1 camera core with video_ioctl2 interface.

- Update omap1 camera interface to use video_ioctl2 interface.
- coding style related updates.

Signed-off-by: Trilok Soni <soni.trilok@gmail.com>
---
 drivers/media/video/omap/camera_core.c |  525 +++++++++++++++-----------------
 1 files changed, 251 insertions(+), 274 deletions(-)

diff --git a/drivers/media/video/omap/camera_core.c b/drivers/media/video/omap/camera_core.c
index dcf3f6d..bbd51d1 100644
--- a/drivers/media/video/omap/camera_core.c
+++ b/drivers/media/video/omap/camera_core.c
@@ -21,7 +21,6 @@
  *   27/03/05   Vladimir Barinov - Added support for power management
  */
 #include <linux/module.h>
-#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/version.h>
@@ -36,6 +35,7 @@
 #include "camera_hw_if.h"
 #include "camera_core.h"
 
+#define OMAP1CAM_VERSION KERNEL_VERSION(0, 0, 0)
 
 static struct camera_device *camera_dev;
 static void camera_core_sgdma_process(struct camera_device *cam);
@@ -66,8 +66,7 @@ camera_core_callback_sgdma(void *arg1, void *arg2)
 
 	spin_lock(&cam->sg_lock);
 	sgdma = cam->sgdma + sgslot;
-	if (!sgdma->queued_sglist)
-	{
+	if (!sgdma->queued_sglist) {
 		spin_unlock(&cam->sg_lock);
 		dev_err(&cam->dev, "SGDMA completed when none queued\n");
 		return;
@@ -146,8 +145,7 @@ camera_core_sgdma_process(struct camera_device *cam)
 					/* dma start failed */
 					cam->in_use = 0;
 					return;
-			}
-			else {
+			} else {
 				/* dma start successful */
 				sgdma->next_sglist ++;
 				sgdma->queued_sglist ++;
@@ -280,7 +278,7 @@ camera_core_start_overlay(struct camera_device *cam)
 	spin_unlock_irqrestore(&cam->overlay_lock, irqflags);
 }
 
-/* ------------------ videobuf_queue_ops ---------------------------------------- */
+/* ------------------ videobuf_queue_ops --------------------------------*/
 
 /* This routine is called from interrupt context when a scatter-gather DMA
  * transfer of a videobuf_buffer completes.
@@ -389,289 +387,263 @@ camera_core_vbq_queue(struct videobuf_queue *q, struct videobuf_buffer *vb)
 	}
 }
 
-/* ------------------ videobuf_queue_ops ---------------------------------------- */
 
-static int
-camera_core_do_ioctl(struct inode *inode, struct file *file, unsigned int cmd, 
-		     void *arg)
+/*
+ *
+ * IOCTL interface.
+ *
+ */
+static int vidioc_querycap(struct file *file, void *fh,
+			   struct v4l2_capability *cap)
 {
-	struct camera_fh *fh  = file->private_data;
-	struct camera_device *cam = fh->cam;
-	int err;
+	struct camera_fh *ofh = fh;
+	struct camera_device *cam = ofh->cam;
+
+	strlcpy(cap->driver, CAM_NAME, sizeof(cap->driver));
+	strlcpy(cap->card, cam->vfd->name, sizeof(cap->card));
+	cap->version = OMAP1CAM_VERSION;
+	cap->capabilities =
+		V4L2_CAP_VIDEO_CAPTURE |
+		V4L2_CAP_VIDEO_OVERLAY |
+		V4L2_CAP_READWRITE |
+		V4L2_CAP_STREAMING;
 
-	switch (cmd) {
-		case VIDIOC_ENUMINPUT:
-		{
-			/* default handler assumes 1 video input (the camera) */
-			struct v4l2_input *input = (struct v4l2_input *)arg;
-			int index = input->index;
+	return 0;
+}
 
-			memset(input, 0, sizeof(*input));
-			input->index = index;
+static int vidioc_enum_fmt_cap(struct file *file, void *fh,
+			       struct v4l2_fmtdesc *f)
+{
+	struct camera_fh *ofh  = fh;
+	struct camera_device *cam = ofh->cam;
 
-			if (index > 0)
-				return -EINVAL;
+	return cam->cam_sensor->enum_pixformat(f, cam->sensor_data);
+}
 
-			strlcpy(input->name, "camera", sizeof(input->name));
-			input->type = V4L2_INPUT_TYPE_CAMERA;
+static int vidioc_g_fmt_cap(struct file *file, void *fh,
+			    struct v4l2_format *f)
+{
+	struct camera_fh *ofh  = fh;
+	struct camera_device *cam = ofh->cam;
 
-			return 0;
-		}
+	/* get the current format */
+	memset(&f->fmt.pix, 0, sizeof(f->fmt.pix));
+	f->fmt.pix = cam->pix;
 
-		case VIDIOC_G_INPUT:
-		{
-			unsigned int *input = arg;
-			*input = 0;
+	return 0;
+}
 
-			return 0;
-		}
+static int vidioc_s_fmt_cap(struct file *file, void *fh,
+			    struct v4l2_format *f)
+{
+	struct camera_fh *ofh = fh;
+	struct camera_device *cam = ofh->cam;
+	unsigned int temp_sizeimage = 0;
 
-		case VIDIOC_S_INPUT:
-		{
-			unsigned int *input = arg;
+	temp_sizeimage = cam->pix.sizeimage;
+	cam->cam_sensor->try_format(&f->fmt.pix, cam->sensor_data);
+	cam->pix = f->fmt.pix;
 
-			if (*input > 0)
-				return -EINVAL;
+	cam->xclk = cam->cam_sensor->calc_xclk(&cam->pix,
+			       &cam->nominal_timeperframe, cam->sensor_data);
+	cam->cparm.timeperframe = cam->nominal_timeperframe;
+	cam->xclk = cam->cam_hardware->set_xclk(cam->xclk, cam->hardware_data);
+	return cam->cam_sensor->configure(&cam->pix, cam->xclk,
+				  &cam->cparm.timeperframe, cam->sensor_data);
+}
 
-			return 0;
-		}
+static int vidioc_try_fmt_cap(struct file *file, void *fh,
+			      struct v4l2_format *f)
+{
+	struct camera_fh *ofh = fh;
+	struct camera_device *cam = ofh->cam;
 
-		case VIDIOC_ENUM_FMT:
-		{
-			struct v4l2_fmtdesc *fmt = arg;
-			return cam->cam_sensor->enum_pixformat(fmt, cam->sensor_data);
-		}
+	return cam->cam_sensor->try_format(&f->fmt.pix, cam->sensor_data);
+}
 
-		case VIDIOC_TRY_FMT:
-		{
-			struct v4l2_format *fmt = arg;
-			return cam->cam_sensor->try_format(&fmt->fmt.pix, cam->sensor_data);
+static int vidioc_reqbufs(struct file *file, void *fh,
+			  struct v4l2_requestbuffers *b)
+{
+	struct camera_fh *ofh = fh;
 
-		}
+	return videobuf_reqbufs(&ofh->vbq, b);
+}
 
-		case VIDIOC_G_FMT:
-		{
-			struct v4l2_format *fmt = arg;
+static int vidioc_querybuf(struct file *file, void *fh,
+			   struct v4l2_buffer *b)
+{
+	struct camera_fh *ofh = fh;
 
-			/* get the current format */
-			memset(&fmt->fmt.pix, 0, sizeof (fmt->fmt.pix));
-			fmt->fmt.pix = cam->pix;
+	return videobuf_querybuf(&ofh->vbq, b);
+}
 
-			return 0;
-		}
+static int vidioc_qbuf(struct file *file, void *fh, struct v4l2_buffer *b)
+{
+	struct camera_fh *ofh = fh;
 
-		case VIDIOC_S_FMT:
-		{
-			struct v4l2_format *fmt = arg;
-			unsigned int temp_sizeimage = 0;
-
-			temp_sizeimage = cam->pix.sizeimage;
-			cam->cam_sensor->try_format(&fmt->fmt.pix, cam->sensor_data);
-			cam->pix = fmt->fmt.pix;
-
-			cam->xclk = cam->cam_sensor->calc_xclk(&cam->pix,
-				&cam->nominal_timeperframe, cam->sensor_data);
-			cam->cparm.timeperframe = cam->nominal_timeperframe;
-			cam->xclk = cam->cam_hardware->set_xclk(cam->xclk, cam->hardware_data);
-			return cam->cam_sensor->configure(&cam->pix, cam->xclk,
-						&cam->cparm.timeperframe, cam->sensor_data);
-		}
+	return videobuf_qbuf(&ofh->vbq, b);
+}
 
-		case VIDIOC_QUERYCTRL:
-		{
-			struct v4l2_queryctrl *qc = arg;
-			return cam->cam_sensor->query_control(qc, cam->sensor_data);
-		}
+static int vidioc_dqbuf(struct file *file, void *fh, struct v4l2_buffer *b)
+{
+	struct camera_fh *ofh = fh;
 
-		case VIDIOC_G_CTRL:
-		{
-			struct v4l2_control *vc = arg;
-			return cam->cam_sensor->get_control(vc, cam->sensor_data);
-		}
+	return videobuf_dqbuf(&ofh->vbq, b, file->f_flags & O_NONBLOCK);
+}
 
-		case VIDIOC_S_CTRL:
-		{
-			struct v4l2_control *vc = arg;
-			return cam->cam_sensor->set_control(vc, cam->sensor_data);
-		}
+static int vidioc_streamon(struct file *file, void *fh, enum v4l2_buf_type i)
+{
+	struct camera_fh *ofh = fh;
+	struct camera_device *cam = ofh->cam;
 
-		case VIDIOC_QUERYCAP:
-		{
-			struct v4l2_capability *cap =
-				(struct v4l2_capability *) arg;
-
-			memset(cap, 0, sizeof(*cap));
-			strlcpy(cap->driver, CAM_NAME, sizeof(cap->driver));
-			strlcpy(cap->card, cam->vfd->name, sizeof(cap->card));
-			cap->bus_info[0] = '\0';
-			cap->version = KERNEL_VERSION(0, 0, 0);
-			cap->capabilities =
-				V4L2_CAP_VIDEO_CAPTURE |
-				V4L2_CAP_VIDEO_OVERLAY |
-				V4L2_CAP_READWRITE |
-				V4L2_CAP_STREAMING;
-			return 0;
-		}
+	spin_lock(&cam->img_lock);
 
-		case VIDIOC_G_FBUF: /* Get the frame buffer parameters */
-		{
-			struct v4l2_framebuffer *fbuf =
-				(struct v4l2_framebuffer *) arg;
+	if (cam->streaming || cam->reading) {
+		spin_unlock(&cam->img_lock);
+		return -EBUSY;
+	} else
+		cam->streaming = ofh;
+		/* FIXME: start camera interface */
 
-			spin_lock(&cam->img_lock);
-			*fbuf = cam->fbuf;
-			spin_unlock(&cam->img_lock);
-			return 0;
-		}
 
-		case VIDIOC_S_FBUF: /* set the frame buffer parameters */
-		{
-			struct v4l2_framebuffer *fbuf =
-				(struct v4l2_framebuffer *) arg;
+	spin_unlock(&cam->img_lock);
 
-			spin_lock(&cam->img_lock);
-			if (cam->previewing) {
-				spin_unlock(&cam->img_lock);
-				return -EBUSY;
-			}
-			cam->fbuf.base = fbuf->base;
-			cam->fbuf.fmt = fbuf->fmt;
+	return videobuf_streamon(&ofh->vbq);
+}
 
-			spin_unlock(&cam->img_lock);
-			return 0;
-		}
+static int vidioc_streamoff(struct file *file, void *fh, enum v4l2_buf_type i)
+{
+	struct camera_fh *ofh = fh;
+	struct camera_device *cam = ofh->cam;
+	int err;
 
-		case VIDIOC_OVERLAY:
-		{
-			int enable = *((int *) arg);
-
-			/*
-			 * check whether the capture format and
-			 ** the display format matches
-			 * return failure if they are different
-			 */
-			if (cam->pix.pixelformat != cam->fbuf.fmt.pixelformat)
-			{
-				return -EINVAL;
-			}
+	err = videobuf_streamoff(&ofh->vbq);
+	if (err < 0)
+		return err;
 
-			/* If the camera image size is greater
-			** than LCD size return failure */
-			if ((cam->pix.width > cam->fbuf.fmt.height) ||
-				(cam->pix.height > cam->fbuf.fmt.width))
-			{
-				return -EINVAL;
-			}
+	spin_lock(&cam->img_lock);
+	if (cam->streaming == ofh)
+		cam->streaming = NULL;
+		/* FIXME: stop camera interface */
 
-			if (!cam->previewing && enable)
-			{
-				cam->previewing = fh;
-				cam->overlay_cnt = 0;
-				camera_core_start_overlay(cam);
-			}
-			else if (!enable)
-			{
-				cam->previewing = NULL;
-			}
+	spin_unlock(&cam->img_lock);
+	return 0;
+}
 
-			return 0;
-		}
+static int vidioc_enum_input(struct file *file, void *fh,
+			     struct v4l2_input *inp)
+{
+	if (inp->index > 0)
+		return -EINVAL;
+
+	strlcpy(inp->name, "camera", sizeof(inp->name));
+	inp->type = V4L2_INPUT_TYPE_CAMERA;
+
+	return 0;
+}
 
-		case VIDIOC_REQBUFS:
-			return videobuf_reqbufs(&fh->vbq, arg);
+static int vidioc_g_input(struct file *file, void *fh, unsigned int *i)
+{
+	*i = 0;
 
-		case VIDIOC_QUERYBUF:
-			return videobuf_querybuf(&fh->vbq, arg);
+	return 0;
+}
 
-		case VIDIOC_QBUF:
-			return videobuf_qbuf(&fh->vbq, arg);
+static int vidioc_s_input(struct file *file, void *fh, unsigned int i)
+{
+	if (i > 0)
+		return -EINVAL;
 
-		case VIDIOC_DQBUF:
-			return videobuf_dqbuf(&fh->vbq, arg,
-	   file->f_flags & O_NONBLOCK);
+	return 0;
+}
 
-		case VIDIOC_STREAMON:
-		{
-			spin_lock(&cam->img_lock);
+static int vidioc_queryctrl(struct file *file, void *fh,
+			    struct v4l2_queryctrl *a)
+{
+	struct camera_fh *ofh = fh;
+	struct camera_device *cam = ofh->cam;
 
-			if (cam->streaming || cam->reading) {
-				spin_unlock(&cam->img_lock);
-				return -EBUSY;
-			}
-			else {
-				cam->streaming = fh;
-				/* FIXME: start camera interface */
-			}
+	return cam->cam_sensor->query_control(a, cam->sensor_data);
+}
 
-			spin_unlock(&cam->img_lock);
+static int vidioc_g_ctrl(struct file *file, void *fh,
+			 struct v4l2_control *a)
+{
+	struct camera_fh *ofh = fh;
+	struct camera_device *cam = ofh->cam;
 
-			return videobuf_streamon(&fh->vbq);
-		}
-		case VIDIOC_STREAMOFF:
-		{
-			err = videobuf_streamoff(&fh->vbq);
-			if (err < 0)
-				return err;
-
-			spin_lock(&cam->img_lock);
-			if (cam->streaming == fh) {
-				cam->streaming = NULL;
-				/* FIXME: stop camera interface */
-			}
-			spin_unlock(&cam->img_lock);
-			return 0;
-		}
-		case VIDIOC_ENUMSTD:
-		case VIDIOC_G_STD:
-		case VIDIOC_S_STD:
-		case VIDIOC_QUERYSTD:
-		{
-			/* Digital cameras don't have an analog video standard,
-			 * so we don't need to implement these ioctls.
-			 */
-			 return -EINVAL;
-		}
-		case VIDIOC_G_AUDIO:
-		case VIDIOC_S_AUDIO:
-		case VIDIOC_G_AUDOUT:
-		case VIDIOC_S_AUDOUT:
-		{
-			/* we don't have any audio inputs or outputs */
-			return -EINVAL;
-		}
+	return cam->cam_sensor->get_control(a, cam->sensor_data);
+}
 
-		case VIDIOC_G_JPEGCOMP:
-		case VIDIOC_S_JPEGCOMP:
-		{
-			/* JPEG compression is not supported */
-			return -EINVAL;
-		}
+static int vidioc_s_ctrl(struct file *file, void *fh,
+			 struct v4l2_control *a)
+{
+	struct camera_fh *ofh = fh;
+	struct camera_device *cam = ofh->cam;
 
-		case VIDIOC_G_TUNER:
-		case VIDIOC_S_TUNER:
-		case VIDIOC_G_MODULATOR:
-		case VIDIOC_S_MODULATOR:
-		case VIDIOC_G_FREQUENCY:
-		case VIDIOC_S_FREQUENCY:
-		{
-			/* we don't have a tuner or modulator */
-			return -EINVAL;
-		}
+	return cam->cam_sensor->set_control(a, cam->sensor_data);
+}
 
-		case VIDIOC_ENUMOUTPUT:
-		case VIDIOC_G_OUTPUT:
-		case VIDIOC_S_OUTPUT:
-		{
-			/* we don't have any video outputs */
-			return -EINVAL;
-		}
+static int vidioc_g_fbuf(struct file *file, void *fh,
+			 struct v4l2_framebuffer *a)
+{
+	struct camera_fh *ofh = fh;
+	struct camera_device *cam = ofh->cam;
 
-		default:
-		{
-			/* unrecognized ioctl */
-			return -ENOIOCTLCMD;
-		}
+	spin_lock(&cam->img_lock);
+	*a = cam->fbuf;
+	spin_unlock(&cam->img_lock);
+
+	return 0;
+}
+
+static int vidioc_s_fbuf(struct file *file, void *fh,
+			 struct v4l2_framebuffer *a)
+{
+	struct camera_fh *ofh = fh;
+	struct camera_device *cam = ofh->cam;
+
+	spin_lock(&cam->img_lock);
+	if (cam->previewing) {
+		spin_unlock(&cam->img_lock);
+		return -EBUSY;
 	}
+	cam->fbuf.base = a->base;
+	cam->fbuf.fmt = a->fmt;
+
+	spin_unlock(&cam->img_lock);
+	return 0;
+}
+
+static int vidioc_overlay(struct file *file, void *fh,
+			 unsigned int i)
+{
+	struct camera_fh *ofh = fh;
+	struct camera_device *cam = ofh->cam;
+	int enable = i;
+
+	/*
+	 * check whether the capture format and
+	 * the display format matches
+	 * return failure if they are different
+	 */
+	if (cam->pix.pixelformat != cam->fbuf.fmt.pixelformat)
+		return -EINVAL;
+
+	/* If the camera image size is greater
+	 * than LCD size return failure
+	 */
+	if ((cam->pix.width > cam->fbuf.fmt.height) ||
+	    (cam->pix.height > cam->fbuf.fmt.width))
+		return -EINVAL;
+
+	if (!cam->previewing && enable)	{
+		cam->previewing = fh;
+		cam->overlay_cnt = 0;
+		camera_core_start_overlay(cam);
+	} else if (!enable)
+		cam->previewing = NULL;
+
 	return 0;
 }
 
@@ -698,8 +670,7 @@ camera_core_capture_callback(void *arg1, void *arg)
 	static int done = 0;
 
 	spin_lock_irqsave(&cam->capture_lock, irqflags);
-	if (!cam->reading)
-	{
+	if (!cam->reading) {
 		done = 0;
 		cam->capture_started = 0;
 		spin_unlock_irqrestore(&cam->capture_lock, irqflags);
@@ -714,8 +685,7 @@ camera_core_capture_callback(void *arg1, void *arg)
 			camera_core_capture_callback, NULL);
 	} else {
 		cam->capture_completed = 1;
-		if (cam->reading)
-		{
+		if (cam->reading) {
 			/* Wake up any process which are waiting for the
 			** DMA to complete */
 			wake_up_interruptible(&camera_dev->new_video_frame);
@@ -793,14 +763,6 @@ camera_core_mmap(struct file *file, struct vm_area_struct *vma)
 }
 
 static int
-camera_core_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-		  unsigned long arg)
-{
-
-	return video_usercopy(inode, file, cmd, arg, camera_core_do_ioctl);
-}
-
-static int
 camera_core_release(struct inode *inode, struct file *file)
 {
 	struct camera_fh *fh = file->private_data;
@@ -810,15 +772,14 @@ camera_core_release(struct inode *inode, struct file *file)
 	kfree(fh);
 
 	spin_lock(&cam->img_lock);
-	if (cam->previewing == fh) {
+
+	if (cam->previewing == fh)
 		cam->previewing = NULL;
-	}
-	if (cam->streaming == fh) {
+	if (cam->streaming == fh)
 		cam->streaming = NULL;
-	}
-	if (cam->reading == fh) {
+	if (cam->reading == fh)
 		cam->reading = NULL;
-	}
+
 	spin_unlock(&cam->img_lock);
 
 	camera_dev->cam_hardware->finish_dma(cam->hardware_data);
@@ -873,8 +834,7 @@ camera_core_open(struct inode *inode, struct file *file)
 	cam->capture_completed = 0;
 	cam->capture_started = 0;
 
-	if (cam->cam_hardware->open(cam->hardware_data))
-	{
+	if (cam->cam_hardware->open(cam->hardware_data)) {
 		dev_err(&cam->dev, "Camera IF configuration failed\n");
 		cam->active = 0;
 		return -ENODEV;
@@ -883,8 +843,7 @@ camera_core_open(struct inode *inode, struct file *file)
 	cam->xclk = cam->cam_hardware->set_xclk(cam->xclk, cam->hardware_data);
 	/* program the sensor for the capture format and rate */
 	if (cam->cam_sensor->configure(&cam->pix, cam->xclk,
-				&cam->cparm.timeperframe, cam->sensor_data))
-	{
+				&cam->cparm.timeperframe, cam->sensor_data)) {
 		dev_err(&cam->dev, "Camera sensor configuration failed\n");
 		cam->cam_hardware->close(cam->hardware_data);
 		cam->active = 0;
@@ -901,9 +860,9 @@ static int camera_core_suspend(struct platform_device *pdev, pm_message_t state)
 	int ret = 0;
 
 	spin_lock(&cam->img_lock);
-	if (cam->active) {
+	if (cam->active)
 		cam->cam_hardware->close(cam->hardware_data);
-	}
+
 	cam->cam_sensor->power_off(cam->sensor_data);
 	spin_unlock(&cam->img_lock);
 
@@ -933,13 +892,12 @@ static int camera_core_resume(struct platform_device *pdev)
 }
 #endif	/* CONFIG_PM */
 
-static struct file_operations camera_core_fops =
-{
+static struct file_operations camera_core_fops = {
 	.owner			= THIS_MODULE,
 	.llseek			= no_llseek,
 	.read			= camera_core_read,
 	.poll			= camera_core_poll,
-	.ioctl			= camera_core_ioctl,
+	.ioctl			= video_ioctl2,
 	.mmap			= camera_core_mmap,
 	.open			= camera_core_open,
 	.release		= camera_core_release,
@@ -980,6 +938,27 @@ static int __init camera_core_probe(struct platform_device *pdev)
 	video_set_drvdata(vfd, cam);
 	vfd->minor = -1;
 
+	vfd->vidioc_querycap = vidioc_querycap;
+	vfd->vidioc_enum_fmt_cap = vidioc_enum_fmt_cap;
+	vfd->vidioc_g_fmt_cap = vidioc_g_fmt_cap;
+	vfd->vidioc_s_fmt_cap = vidioc_s_fmt_cap;
+	vfd->vidioc_try_fmt_cap = vidioc_try_fmt_cap;
+	vfd->vidioc_reqbufs = vidioc_reqbufs;
+	vfd->vidioc_querybuf = vidioc_querybuf;
+	vfd->vidioc_qbuf = vidioc_qbuf;
+	vfd->vidioc_dqbuf = vidioc_dqbuf;
+	vfd->vidioc_streamon = vidioc_streamon;
+	vfd->vidioc_streamoff = vidioc_streamoff;
+	vfd->vidioc_enum_input = vidioc_enum_input;
+	vfd->vidioc_g_input = vidioc_g_input;
+	vfd->vidioc_s_input = vidioc_s_input;
+	vfd->vidioc_queryctrl = vidioc_queryctrl;
+	vfd->vidioc_g_ctrl = vidioc_g_ctrl;
+	vfd->vidioc_s_ctrl = vidioc_s_ctrl;
+	vfd->vidioc_g_fbuf = vidioc_g_fbuf;
+	vfd->vidioc_s_fbuf = vidioc_s_fbuf;
+	vfd->vidioc_overlay = vidioc_overlay;
+
 	/* initialize the videobuf queue ops */
 	cam->vbq_ops.buf_setup = camera_core_vbq_setup;
 	cam->vbq_ops.buf_prepare = camera_core_vbq_prepare;
@@ -988,8 +967,7 @@ static int __init camera_core_probe(struct platform_device *pdev)
 
 	/* initilize the overlay interface */
 	cam->overlay_size = overlay_mem;
-	if (cam->overlay_size > 0)
-	{
+	if (cam->overlay_size > 0) {
 		cam->overlay_base = (unsigned long) dma_alloc_coherent(NULL,
 					cam->overlay_size,
 					(dma_addr_t *) &cam->overlay_base_phys,
@@ -1184,4 +1162,3 @@ MODULE_PARM_DESC(capture_mem,
 
 module_init(camera_core_init);
 module_exit(camera_core_cleanup);
-
-- 
1.5.0


--0-1786622073-1187869976=:52282
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-1786622073-1187869976=:52282--

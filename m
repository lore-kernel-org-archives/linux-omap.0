From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [PATCH] VIDEO OMAP: camera_core whitespace cleanup
Date: Tue, 24 Jul 2007 14:28:07 -0400
Message-ID: <11853016883587-git-send-email-felipe.lima@indt.org.br>
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

Whitespace removal from camera_core.[ch]

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---
 drivers/media/video/omap/camera_core.c |  160 ++++++++++++++++----------------
 drivers/media/video/omap/camera_core.h |   76 ++++++++--------
 2 files changed, 118 insertions(+), 118 deletions(-)

diff --git a/drivers/media/video/omap/camera_core.c b/drivers/media/video/omap/camera_core.c
index 9440718..669c472 100644
--- a/drivers/media/video/omap/camera_core.c
+++ b/drivers/media/video/omap/camera_core.c
@@ -1,21 +1,21 @@
 /*
  * drivers/media/video/omap/camera_core.c
  *
- * Copyright (C) 2004 Texas Instruments, Inc. 
+ * Copyright (C) 2004 Texas Instruments, Inc.
  *
  * Video-for-Linux (Version 2) camera capture driver for
  * the OMAP H2 and H3 camera controller.
  *
  * Adapted from omap24xx driver written by Andy Lowe (source@mvista.com)
  * Copyright (C) 2003-2004 MontaVista Software, Inc.
- * 
- * This package is free software; you can redistribute it and/or modify 
+ *
+ * This package is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation. 
- * 
- * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR 
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED 
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE. 
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  *
  * History:
  *   27/03/05   Vladimir Barinov - Added support for power management
@@ -53,7 +53,7 @@ static int capture_mem = 1280*960*2*2;
  */
 static int overlay_mem = 640*480*2;
 
- 
+
 /* DMA completion routine for the scatter-gather DMA fragments. */
 /* This function is called when a scatter DMA fragment is completed */
 static void
@@ -102,7 +102,7 @@ camera_core_sgdma_init(struct camera_device *cam)
 	/* Initialize the underlying camera DMA */
 	cam->cam_hardware->init_dma(cam->hardware_data);
 	spin_lock_init(&cam->sg_lock);
-	
+
 	cam->free_sgdma = NUM_SG_DMA;
 	cam->next_sgdma = 0;
 	for (sg = 0; sg < NUM_SG_DMA; sg++) {
@@ -126,7 +126,7 @@ camera_core_sgdma_process(struct camera_device *cam)
 	int queued_sgdma, sgslot;
 	struct sgdma_state *sgdma;
 	const struct scatterlist *sglist;
-	
+
 	spin_lock_irqsave(&cam->sg_lock, irqflags);
 	if (1 == cam->in_use) {
 		spin_unlock_irqrestore(&cam->sg_lock, irqflags);
@@ -155,7 +155,7 @@ camera_core_sgdma_process(struct camera_device *cam)
 		}
 		queued_sgdma-- ;
 		sgslot = (sgslot + 1) % (NUM_SG_DMA);
- 	}
+	}
 
 	cam->in_use = 0;
 }
@@ -192,7 +192,7 @@ camera_core_sgdma_queue(struct camera_device *cam,
 	sgdma->callback = callback;
 	sgdma->arg = arg;
 
-	cam->next_sgdma = (cam->next_sgdma + 1) % (NUM_SG_DMA); 
+	cam->next_sgdma = (cam->next_sgdma + 1) % (NUM_SG_DMA);
 	cam->free_sgdma--;
 
 	spin_unlock_irqrestore(&cam->sg_lock, irqflags);
@@ -255,14 +255,14 @@ camera_core_overlay_callback(void *arg1, void *arg)
 
 }
 
- 
+
 static void
 camera_core_start_overlay(struct camera_device *cam)
 {
 	int err;
 	unsigned long irqflags;
 
-	if (!cam->previewing) 
+	if (!cam->previewing)
 		return;
 
 	spin_lock_irqsave(&cam->overlay_lock, irqflags);
@@ -299,7 +299,7 @@ camera_core_vbq_complete(void *arg1, void *arg)
 	vb->state = STATE_DONE;
 
 	wake_up(&vb->done);
-	
+
 	spin_unlock(&cam->vbq_lock);
 }
 
@@ -350,7 +350,7 @@ camera_core_vbq_prepare(struct videobuf_queue *q, struct videobuf_buffer *vb,
 		spin_unlock(&cam->img_lock);
 		return -EINVAL;
 	}
-	vb->size = cam->pix.sizeimage; 
+	vb->size = cam->pix.sizeimage;
 	vb->width = cam->pix.width;
 	vb->height = cam->pix.height;
 	vb->field = field;
@@ -441,7 +441,7 @@ camera_core_do_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 		{
 			struct v4l2_fmtdesc *fmt = arg;
 			return cam->cam_sensor->enum_pixformat(fmt, cam->sensor_data);
-		}	
+		}
 
 		case VIDIOC_TRY_FMT:
 		{
@@ -457,7 +457,7 @@ camera_core_do_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 			/* get the current format */
 			memset(&fmt->fmt.pix, 0, sizeof (fmt->fmt.pix));
 			fmt->fmt.pix = cam->pix;
-			
+
 			return 0;
 		}
 
@@ -470,11 +470,11 @@ camera_core_do_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 			cam->cam_sensor->try_format(&fmt->fmt.pix, cam->sensor_data);
 			cam->pix = fmt->fmt.pix;
 
- 			cam->xclk = cam->cam_sensor->calc_xclk(&cam->pix,
- 				&cam->nominal_timeperframe, cam->sensor_data);
- 			cam->cparm.timeperframe = cam->nominal_timeperframe;
+			cam->xclk = cam->cam_sensor->calc_xclk(&cam->pix,
+				&cam->nominal_timeperframe, cam->sensor_data);
+			cam->cparm.timeperframe = cam->nominal_timeperframe;
 			cam->xclk = cam->cam_hardware->set_xclk(cam->xclk, cam->hardware_data);
-			return cam->cam_sensor->configure(&cam->pix, cam->xclk, 
+			return cam->cam_sensor->configure(&cam->pix, cam->xclk,
 						&cam->cparm.timeperframe, cam->sensor_data);
 		}
 
@@ -495,10 +495,10 @@ camera_core_do_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 			struct v4l2_control *vc = arg;
 			return cam->cam_sensor->set_control(vc, cam->sensor_data);
 		}
-		
+
 		case VIDIOC_QUERYCAP:
 		{
-			struct v4l2_capability *cap = 
+			struct v4l2_capability *cap =
 				(struct v4l2_capability *) arg;
 
 			memset(cap, 0, sizeof(*cap));
@@ -509,7 +509,7 @@ camera_core_do_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 			cap->capabilities =
 				V4L2_CAP_VIDEO_CAPTURE |
 				V4L2_CAP_VIDEO_OVERLAY |
-				V4L2_CAP_READWRITE | 
+				V4L2_CAP_READWRITE |
 				V4L2_CAP_STREAMING;
 			return 0;
 		}
@@ -536,8 +536,8 @@ camera_core_do_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 				return -EBUSY;
 			}
 			cam->fbuf.base = fbuf->base;
-			cam->fbuf.fmt = fbuf->fmt;	
-			
+			cam->fbuf.fmt = fbuf->fmt;
+
 			spin_unlock(&cam->img_lock);
 			return 0;
 		}
@@ -546,9 +546,9 @@ camera_core_do_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 		{
 			int enable = *((int *) arg);
 
-			/* 
-			 * check whether the capture format and 
-			 ** the display format matches 
+			/*
+			 * check whether the capture format and
+			 ** the display format matches
 			 * return failure if they are different
 			 */
 			if (cam->pix.pixelformat != cam->fbuf.fmt.pixelformat)
@@ -556,14 +556,14 @@ camera_core_do_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 				return -EINVAL;
 			}
 
-			/* If the camera image size is greater 
+			/* If the camera image size is greater
 			** than LCD size return failure */
-			if ((cam->pix.width > cam->fbuf.fmt.height) || 
+			if ((cam->pix.width > cam->fbuf.fmt.height) ||
 				(cam->pix.height > cam->fbuf.fmt.width))
 			{
 				return -EINVAL;
 			}
-			
+
 			if (!cam->previewing && enable)
 			{
 				cam->previewing = fh;
@@ -574,7 +574,7 @@ camera_core_do_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 			{
 				cam->previewing = NULL;
 			}
-	
+
 			return 0;
 		}
 
@@ -627,7 +627,7 @@ camera_core_do_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 		case VIDIOC_S_STD:
 		case VIDIOC_QUERYSTD:
 		{
-			/* Digital cameras don't have an analog video standard, 
+			/* Digital cameras don't have an analog video standard,
 			 * so we don't need to implement these ioctls.
 			 */
 			 return -EINVAL;
@@ -712,12 +712,12 @@ camera_core_capture_callback(void *arg1, void *arg)
 		sg_dma_address(&cam->capture_sglist) = cam->capture_base_phys;
 		sg_dma_len(&cam->capture_sglist) = cam->pix.sizeimage;
 		err = camera_core_sgdma_queue(cam, &cam->capture_sglist, 1,
-			camera_core_capture_callback, NULL);		
+			camera_core_capture_callback, NULL);
 	} else {
 		cam->capture_completed = 1;
 		if (cam->reading)
 		{
-			/* Wake up any process which are waiting for the 
+			/* Wake up any process which are waiting for the
 			** DMA to complete */
 			wake_up_interruptible(&camera_dev->new_video_frame);
 			sg_dma_address(&cam->capture_sglist) = cam->capture_base_phys;
@@ -730,7 +730,7 @@ camera_core_capture_callback(void *arg1, void *arg)
 	spin_unlock_irqrestore(&cam->capture_lock, irqflags);
 }
 
- 
+
 static ssize_t
 camera_core_read(struct file *file, char *data, size_t count, loff_t *ppos)
 {
@@ -746,7 +746,7 @@ camera_core_read(struct file *file, char *data, size_t count, loff_t *ppos)
 	i = videobuf_read_one(file, &fh->vbq, data, count, ppos);
 	return i;
 #endif
-	
+
 	if (!cam->capture_base) {
 		cam->capture_base = (unsigned long)dma_alloc_coherent(NULL,
 				cam->pix.sizeimage,
@@ -773,17 +773,17 @@ camera_core_read(struct file *file, char *data, size_t count, loff_t *ppos)
 	timeout = HZ * 10;
 	cam->capture_completed = 0;
 	while (cam->capture_completed == 0) {
-		timeout = interruptible_sleep_on_timeout 
+		timeout = interruptible_sleep_on_timeout
 				(&cam->new_video_frame, timeout);
 		if (timeout == 0) {
-			printk(KERN_ERR CAM_NAME ": timeout waiting video frame\n");	
+			printk(KERN_ERR CAM_NAME ": timeout waiting video frame\n");
 			return -EIO; /* time out */
 		}
 	}
 	/* copy the data to the user buffer */
 	err = copy_to_user(data, (void *)cam->capture_base, cam->pix.sizeimage);
 	return (cam->pix.sizeimage - err);
-	
+
 }
 
 static int
@@ -795,7 +795,7 @@ camera_core_mmap(struct file *file, struct vm_area_struct *vma)
 }
 
 static int
-camera_core_ioctl(struct inode *inode, struct file *file, unsigned int cmd, 
+camera_core_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 		  unsigned long arg)
 {
 
@@ -807,7 +807,7 @@ camera_core_release(struct inode *inode, struct file *file)
 {
 	struct camera_fh *fh = file->private_data;
 	struct camera_device *cam = fh->cam;
-	
+
 	file->private_data = NULL;
 	kfree(fh);
 
@@ -826,8 +826,8 @@ camera_core_release(struct inode *inode, struct file *file)
 	camera_dev->cam_hardware->finish_dma(cam->hardware_data);
 
 	if (cam->capture_base) {
-		dma_free_coherent(NULL, cam->pix.sizeimage, 
-					(void *)cam->capture_base, 
+		dma_free_coherent(NULL, cam->pix.sizeimage,
+					(void *)cam->capture_base,
 					cam->capture_base_phys);
 		cam->capture_base = 0;
 		cam->capture_base_phys = 0;
@@ -881,7 +881,7 @@ camera_core_open(struct inode *inode, struct file *file)
 		cam->active = 0;
 		return -ENODEV;
 	}
-	
+
 	cam->xclk = cam->cam_hardware->set_xclk(cam->xclk, cam->hardware_data);
 	/* program the sensor for the capture format and rate */
 	if (cam->cam_sensor->configure(&cam->pix, cam->xclk, 
@@ -930,12 +930,12 @@ static int camera_core_resume(struct platform_device *pdev)
 		camera_core_sgdma_process(cam);
 	}
 	spin_unlock(&cam->img_lock);
-	
+
 	return ret;
 }
 #endif	/* CONFIG_PM */
 
-static struct file_operations camera_core_fops = 
+static struct file_operations camera_core_fops =
 {
 	.owner			= THIS_MODULE,
 	.llseek			= no_llseek,
@@ -962,7 +962,7 @@ static int __init camera_core_probe(struct platform_device *pdev)
 
 	/* Save the pointer to camera device in a global variable */
 	camera_dev = cam;
-	
+
 	/* initialize the video_device struct */
 	vfd = cam->vfd = video_device_alloc();
 	if (!vfd) {
@@ -971,17 +971,17 @@ static int __init camera_core_probe(struct platform_device *pdev)
 		status = -ENOMEM;
 		goto err1;
 	}
-	
- 	vfd->release = video_device_release;
-
- 	strlcpy(vfd->name, CAM_NAME, sizeof(vfd->name));
- 	vfd->type = VID_TYPE_CAPTURE | VID_TYPE_OVERLAY | VID_TYPE_CHROMAKEY;
- 	
- 	/* need to register for a VID_HARDWARE_* ID in videodev.h */
- 	vfd->hardware = 0;
- 	vfd->fops = &camera_core_fops;
- 	video_set_drvdata(vfd, cam);
- 	vfd->minor = -1;
+
+	vfd->release = video_device_release;
+
+	strlcpy(vfd->name, CAM_NAME, sizeof(vfd->name));
+	vfd->type = VID_TYPE_CAPTURE | VID_TYPE_OVERLAY | VID_TYPE_CHROMAKEY;
+
+	/* need to register for a VID_HARDWARE_* ID in videodev.h */
+	vfd->hardware = 0;
+	vfd->fops = &camera_core_fops;
+	video_set_drvdata(vfd, cam);
+	vfd->minor = -1;
 
 	/* initialize the videobuf queue ops */
 	cam->vbq_ops.buf_setup = camera_core_vbq_setup;
@@ -1008,9 +1008,9 @@ static int __init camera_core_probe(struct platform_device *pdev)
 	spin_lock_init(&cam->overlay_lock);
 	spin_lock_init(&cam->capture_lock);
 
- 	/*Initialise the pointer to the sensor interface and camera interface */
- 	cam->cam_sensor = &camera_sensor_if;
- 	cam->cam_hardware = &camera_hardware_if;
+	/*Initialise the pointer to the sensor interface and camera interface */
+	cam->cam_sensor = &camera_sensor_if;
+	cam->cam_hardware = &camera_hardware_if;
 
 	/* initialize the camera interface */
 	cam->hardware_data = cam->cam_hardware->init();
@@ -1019,8 +1019,8 @@ static int __init camera_core_probe(struct platform_device *pdev)
 		status = -ENODEV;
 		goto err3;
 	}
- 	 
-	/* initialize the spinlock used to serialize access to the image 
+
+	/* initialize the spinlock used to serialize access to the image
 	 * parameters
 	 */
 	spin_lock_init(&cam->img_lock);
@@ -1029,8 +1029,8 @@ static int __init camera_core_probe(struct platform_device *pdev)
 	cam->cparm.capability = V4L2_CAP_TIMEPERFRAME;
 	cam->cparm.readbuffers = 1;
 
-	/* Enable the xclk output.  The sensor may (and does, in the case of 
-	 * the OV9640) require an xclk input in order for its initialization 
+	/* Enable the xclk output.  The sensor may (and does, in the case of
+	 * the OV9640) require an xclk input in order for its initialization
 	 * routine to work.
 	 */
 	cam->xclk = 21000000;	/* choose an arbitrary xclk frequency */
@@ -1052,12 +1052,12 @@ static int __init camera_core_probe(struct platform_device *pdev)
 	cam->nominal_timeperframe.numerator = 1;
 	cam->nominal_timeperframe.denominator = 15;
 
-	/* calculate xclk based on the default capture format and default 
+	/* calculate xclk based on the default capture format and default
 	 * frame rate
 	 */
 	cam->xclk = cam->cam_sensor->calc_xclk(&cam->pix,
 		&cam->nominal_timeperframe, cam->sensor_data);
- 	cam->cparm.timeperframe = cam->nominal_timeperframe;
+	cam->cparm.timeperframe = cam->nominal_timeperframe;
 
 	/* initialise the wait queue */
 	init_waitqueue_head(&cam->new_video_frame);
@@ -1067,17 +1067,17 @@ static int __init camera_core_probe(struct platform_device *pdev)
 
 	/* Disable the Camera after detection */
 	cam->cam_hardware->disable(cam->hardware_data);
-	
+
 	platform_set_drvdata(pdev, cam);
-	
+
 	if (video_register_device(vfd, VFL_TYPE_GRABBER, video_nr) < 0) {
-		printk(KERN_ERR CAM_NAME 
+		printk(KERN_ERR CAM_NAME
 			": could not register Video for Linux device\n");
 		status = -ENODEV;
 		goto err5;
 	}
 
-	printk(KERN_INFO CAM_NAME 
+	printk(KERN_INFO CAM_NAME
 	       ": registered device video%d [v4l2]\n", vfd->minor);
 
 	return 0;
@@ -1088,7 +1088,7 @@ static int __init camera_core_probe(struct platform_device *pdev)
 	cam->cam_hardware->cleanup(cam->hardware_data);
  err3:
 	dma_free_coherent(NULL, cam->overlay_size,
-				(void *)cam->overlay_base, 
+				(void *)cam->overlay_base,
 				cam->overlay_base_phys);
 	cam->overlay_base = 0;
  err2:
@@ -1108,7 +1108,7 @@ static int camera_core_remove(struct platform_device *pdev)
 	vfd = cam->vfd;
 	if (vfd) {
 		if (vfd->minor == -1) {
-			/* The device never got registered, so release the 
+			/* The device never got registered, so release the
 			** video_device struct directly
 			*/
 			video_device_release(vfd);
@@ -1122,10 +1122,10 @@ static int camera_core_remove(struct platform_device *pdev)
 	}
 	if (cam->overlay_base) {
 		dma_free_coherent(NULL, cam->overlay_size,
-					(void *)cam->overlay_base, 
+					(void *)cam->overlay_base,
 					cam->overlay_base_phys);
 		cam->overlay_base = 0;
-	}	
+	}
 	cam->overlay_base_phys = 0;
 
 	cam->cam_sensor->cleanup(cam->sensor_data);
@@ -1182,7 +1182,7 @@ MODULE_DESCRIPTION("OMAP Video for Linux camera driver");
 MODULE_LICENSE("GPL");
 
 module_param(video_nr, int, 0);
-MODULE_PARM_DESC(video_nr, 
+MODULE_PARM_DESC(video_nr,
 		"Minor number for video device (-1 ==> auto assign)");
 module_param(capture_mem, int, 0);
 MODULE_PARM_DESC(capture_mem,
diff --git a/drivers/media/video/omap/camera_core.h b/drivers/media/video/omap/camera_core.h
index 0f94446..a300d67 100644
--- a/drivers/media/video/omap/camera_core.h
+++ b/drivers/media/video/omap/camera_core.h
@@ -1,15 +1,15 @@
 /*
  *  drivers/media/video/omap/camera_core.h
  *
- * Copyright (C) 2004 Texas Instruments, Inc. 
- * 
- * This package is free software; you can redistribute it and/or modify 
+ * Copyright (C) 2004 Texas Instruments, Inc.
+ *
+ * This package is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation. 
- * 
- * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR 
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED 
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE. 
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */
 
 #ifndef CAMERA_CORE__H
@@ -36,12 +36,12 @@ struct sgdma_state {
 /* NUM_SG_DMA is the number of scatter-gather DMA transfers that can be queued.
  */
 #define NUM_SG_DMA VIDEO_MAX_FRAME+2
- 
+
 /* per-device data structure */
 struct camera_device {
 	struct device dev;
 	struct video_device *vfd;
-	
+
 	spinlock_t overlay_lock;        /* spinlock for overlay DMA counter */
 	int overlay_cnt;                /* count of queued overlay DMA xfers */
 	struct scatterlist overlay_sglist;
@@ -60,22 +60,22 @@ struct camera_device {
 	struct sgdma_state sgdma[NUM_SG_DMA];
 	char in_use;
 
-	/* The img_lock is used to serialize access to the image parameters for 
-	 * overlay and capture.  Need to use spin_lock_irq when writing to the 
-	 * reading, streaming, and previewing parameters.  A regular spin_lock 
+	/* The img_lock is used to serialize access to the image parameters for
+	 * overlay and capture.  Need to use spin_lock_irq when writing to the
+	 * reading, streaming, and previewing parameters.  A regular spin_lock
 	 * will suffice for all other cases.
 	 */
 	spinlock_t img_lock;
- 
- 	/* We allow reading from at most one filehandle at a time.
- 	 * non-NULL means reading is in progress.
- 	 */
- 	struct camera_fh *reading;
- 	/* We allow streaming from at most one filehandle at a time.  
- 	 * non-NULL means streaming is in progress.
- 	 */
+
+	/* We allow reading from at most one filehandle at a time.
+	 * non-NULL means reading is in progress.
+	 */
+	struct camera_fh *reading;
+	/* We allow streaming from at most one filehandle at a time.
+	 * non-NULL means streaming is in progress.
+	 */
 	struct camera_fh *streaming;
-	/* We allow previewing from at most one filehandle at a time.  
+	/* We allow previewing from at most one filehandle at a time.
 	 * non-NULL means previewing is in progress.
 	 */
 	struct camera_fh *previewing;
@@ -85,44 +85,44 @@ struct camera_device {
 
 	/* This is the frame period actually requested by the user. */
 	struct v4l2_fract nominal_timeperframe;
-	
+
 	/* frequency (in Hz) of camera interface xclk output */
 	unsigned long xclk;
 
 	/* Pointer to the sensor interface ops */
 	struct omap_camera_sensor *cam_sensor;
 	void *sensor_data;
-	
+
 	/* Pointer to the camera interface hardware ops */
 	struct camera_hardware *cam_hardware;
 	void *hardware_data;
 
-	/* pix defines the size and pixel format of the image captured by the 
-	 * sensor.  This also defines the size of the framebuffers.  The 
-	 * same pool of framebuffers is used for video capture and video 
-	 * overlay.  These parameters are set/queried by the 
+	/* pix defines the size and pixel format of the image captured by the
+	 * sensor.  This also defines the size of the framebuffers.  The
+	 * same pool of framebuffers is used for video capture and video
+	 * overlay.  These parameters are set/queried by the
 	 * VIDIOC_S_FMT/VIDIOC_G_FMT ioctls with a CAPTURE buffer type.
 	 */
 	struct v4l2_pix_format pix;
 	struct v4l2_pix_format pix2;
 
-	/* crop defines the size and offset of the video overlay source window 
-	 * within the framebuffer.  These parameters are set/queried by the 
-	 * VIDIOC_S_CROP/VIDIOC_G_CROP ioctls with an OVERLAY buffer type.  
-	 * The cropping rectangle allows a subset of the captured image to be 
-	 * previewed.  It only affects the portion of the image previewed, not 
+	/* crop defines the size and offset of the video overlay source window
+	 * within the framebuffer.  These parameters are set/queried by the
+	 * VIDIOC_S_CROP/VIDIOC_G_CROP ioctls with an OVERLAY buffer type.
+	 * The cropping rectangle allows a subset of the captured image to be
+	 * previewed.  It only affects the portion of the image previewed, not
 	 * captured; the entire camera image is always captured.
 	 */
 	struct v4l2_rect crop;
 
-	/* win defines the size and offset of the video overlay target window 
-	 * within the video display.  These parameters are set/queried by the 
+	/* win defines the size and offset of the video overlay target window
+	 * within the video display.  These parameters are set/queried by the
 	 * VIDIOC_S_FMT/VIDIOC_G_FMT ioctls with an OVERLAY buffer type.
 	 */
 	struct v4l2_window win;
 
-	/* fbuf reflects the size of the video display.  It is queried with the 
-	 * VIDIOC_G_FBUF ioctl.  The size of the video display cannot be 
+	/* fbuf reflects the size of the video display.  It is queried with the
+	 * VIDIOC_G_FBUF ioctl.  The size of the video display cannot be
 	 * changed with the VIDIOC_S_FBUF ioctl.
 	 */
 	struct v4l2_framebuffer fbuf;
@@ -136,7 +136,7 @@ struct camera_device {
 	wait_queue_head_t new_video_frame;
 	char capture_completed;
 	char capture_started;
- 	spinlock_t capture_lock;
+	spinlock_t capture_lock;
 	struct scatterlist capture_sglist;
 	unsigned long capture_base;
 	unsigned long capture_base_phys;
-- 
1.5.3.rc2.29.gc4640f

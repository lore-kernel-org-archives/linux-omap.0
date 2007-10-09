From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 5/6] OMAP1: CAMERA: Changed camera_core.c to the coding
	style standard
Date: Tue,  9 Oct 2007 08:52:32 -0400
Message-ID: <1191934353-24072-6-git-send-email-edubezval@gmail.com>
References: <1191934353-24072-1-git-send-email-edubezval@gmail.com>
	<1191934353-24072-2-git-send-email-edubezval@gmail.com>
	<1191934353-24072-3-git-send-email-edubezval@gmail.com>
	<1191934353-24072-4-git-send-email-edubezval@gmail.com>
	<1191934353-24072-5-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1191934353-24072-5-git-send-email-edubezval@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-mailing-list <linux-omap-open-source@linux.omap.com>
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>
List-Id: linux-omap@vger.kernel.org

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

- Executed Lindent on camera_core.c
- Removed extra blank spaces
- Lines with more than 80 columns were broken

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 drivers/media/video/omap/camera_core.c |  403 +++++++++++++++-----------------
 1 files changed, 191 insertions(+), 212 deletions(-)

diff --git a/drivers/media/video/omap/camera_core.c b/drivers/media/video/omap/camera_core.c
index 217a79f..1d47212 100644
--- a/drivers/media/video/omap/camera_core.c
+++ b/drivers/media/video/omap/camera_core.c
@@ -40,24 +40,22 @@
 static struct camera_device *camera_dev;
 static void camera_core_sgdma_process(struct camera_device *cam);
 
-/* module parameters */
-static int video_nr = -1;	/* video device minor (-1 ==> auto assign) */
+/* Module parameters */
+static int video_nr = -1;	/* Video device minor (-1 ==> auto assign) */
 
 /* Maximum amount of memory to use for capture buffers.
  * Default is 4800KB, enough to double-buffer SXGA.
  */
-static int capture_mem = 1280*960*2*2;
+static int capture_mem = 1280 * 960 * 2 * 2;
 
-/*Size of video overlay framebuffer. This determines the maximum image size
- *that can be previewed. Default is 600KB, enough for sxga.
+/* Size of video overlay framebuffer. This determines the maximum image size
+ * that can be previewed. Default is 600KB, enough for sxga.
  */
-static int overlay_mem = 640*480*2;
+static int overlay_mem = 640 * 480 * 2;
 
-
-/*
- * Enable the external sensor interface. Try to negotiate interface
+/* Enable the external sensor interface. Try to negotiate interface
  * parameters with the sensor and start using the new ones. The calls
- * to sensor_if_enable and sensor_if_disable need not to be balanced.
+ * to sensor_if_enable and sensor_if_disable do not need to be balanced.
  */
 static int camera_sensor_if_enable(struct camera_device *cam)
 {
@@ -75,8 +73,8 @@ static int camera_sensor_if_enable(struct camera_device *cam)
 	switch (p.if_type) {
 	case V4L2_IF_TYPE_BT656:
 		cam->if_u.bt656.xclk =
-			cam->cam_hardware->set_xclk(cam->if_u.bt656.xclk,
-						    cam->hardware_data);
+		    cam->cam_hardware->set_xclk(cam->if_u.bt656.xclk,
+						cam->hardware_data);
 		break;
 	default:
 		/* FIXME: how about other interfaces? */
@@ -96,9 +94,7 @@ static void camera_sensor_if_disable(const struct camera_device *cam)
 	}
 }
 
-/*
- * Initialise the sensor hardware.
- */
+/* Initialize the sensor hardware. */
 static int camera_sensor_init(struct camera_device *cam)
 {
 	int err = 0;
@@ -109,7 +105,8 @@ static int camera_sensor_init(struct camera_device *cam)
 	 * routine to work.
 	 */
 
-	cam->if_u.bt656.xclk = 21000000;/* choose an arbitrary xclk frequency */
+	/* Choose an arbitrary xclk frequency */
+	cam->if_u.bt656.xclk = 21000000;
 
 	cam->if_u.bt656.xclk = cam->cam_hardware->set_xclk(cam->if_u.bt656.xclk,
 							   cam->hardware_data);
@@ -117,18 +114,18 @@ static int camera_sensor_init(struct camera_device *cam)
 	err = camera_sensor_if_enable(cam);
 	if (err) {
 		dev_err(cam->dev, "sensor interface could not be enabled at "
-			"initialisation, %d\n", err);
+			"initialization, %d\n", err);
 		cam->sdev = NULL;
 		goto out;
 	}
 
-	/* power up sensor during sensor initialization */
+	/* Power up sensor during sensor initialization */
 	vidioc_int_s_power(sdev, 1);
 
 	err = vidioc_int_dev_init(sdev);
 	if (err) {
 		dev_err(cam->dev, "cannot initialize sensor, error %d\n", err);
-		/* Sensor init failed --- it's nonexistent to us! */
+		/* Sensor initialization failed --- it's nonexistent to us! */
 		cam->sdev = NULL;
 		goto out;
 	}
@@ -149,10 +146,10 @@ static void camera_sensor_exit(struct camera_device *cam)
 		vidioc_int_dev_exit(cam->sdev);
 }
 
-/* DMA completion routine for the scatter-gather DMA fragments. */
-/* This function is called when a scatter DMA fragment is completed */
-static void
-camera_core_callback_sgdma(void *arg1, void *arg2)
+/* DMA completion routine for the scatter-gather DMA fragments.
+ * This function is called when a scatter DMA fragment is completed
+ */
+static void camera_core_callback_sgdma(void *arg1, void *arg2)
 {
 	struct camera_device *cam = (struct camera_device *)arg1;
 	int sgslot = (int)arg2;
@@ -167,16 +164,17 @@ camera_core_callback_sgdma(void *arg1, void *arg2)
 		return;
 	}
 	if (!--sgdma->queued_sglist) {
-		/* queue for this sglist is empty so check whether transfer
-		** of the frame has been completed */
+		/* Queue for this sglist is empty so check whether transfer
+		 * of the frame has been completed
+		 */
 		if (sgdma->next_sglist == sgdma->sglen) {
 			dma_callback_t callback = sgdma->callback;
 			void *arg = sgdma->arg;
-			/* all done with this sglist */
+			/* All done with this sglist */
 			cam->free_sgdma++;
 			if (callback) {
 				spin_unlock(&cam->sg_lock);
-				(*callback)(cam, arg);
+				(*callback) (cam, arg);
 				camera_core_sgdma_process(cam);
 				return;
 			}
@@ -188,8 +186,7 @@ camera_core_callback_sgdma(void *arg1, void *arg2)
 	return;
 }
 
-static void
-camera_core_sgdma_init(struct camera_device *cam)
+static void camera_core_sgdma_init(struct camera_device *cam)
 {
 	int sg;
 
@@ -209,12 +206,10 @@ camera_core_sgdma_init(struct camera_device *cam)
 	}
 }
 
-/*
- * Process the scatter-gather DMA queue by starting queued transfers
- * This function is called to program the dma to start the transfer of an image.
+/* Process the scatter-gather DMA queue by starting queued transfers
+ * This function is called to program the DMA to start the transfer of an image.
  */
-static void
-camera_core_sgdma_process(struct camera_device *cam)
+static void camera_core_sgdma_process(struct camera_device *cam)
 {
 	unsigned long irqflags;
 	int queued_sgdma, sgslot;
@@ -235,18 +230,20 @@ camera_core_sgdma_process(struct camera_device *cam)
 		sgdma = cam->sgdma + sgslot;
 		while (sgdma->next_sglist < sgdma->sglen) {
 			sglist = sgdma->sglist + sgdma->next_sglist;
-			if (cam->cam_hardware->start_dma(sgdma, camera_core_callback_sgdma,
-				(void *)cam, (void *)sgslot, cam->hardware_data)) {
-					/* dma start failed */
-					cam->in_use = 0;
-					return;
+			if (cam->cam_hardware->
+			    start_dma(sgdma, camera_core_callback_sgdma,
+				      (void *)cam, (void *)sgslot,
+				      cam->hardware_data)) {
+				/* DMA start failed */
+				cam->in_use = 0;
+				return;
 			} else {
-				/* dma start successful */
-				sgdma->next_sglist ++;
-				sgdma->queued_sglist ++;
+				/* DMA start successful */
+				sgdma->next_sglist++;
+				sgdma->queued_sglist++;
 			}
 		}
-		queued_sgdma-- ;
+		queued_sgdma--;
 		sgslot = (sgslot + 1) % (NUM_SG_DMA);
 	}
 
@@ -257,10 +254,10 @@ camera_core_sgdma_process(struct camera_device *cam)
  * Returns zero if the transfer was successfully queued, or
  * non-zero if all of the scatter-gather slots are already in use.
  */
-static int
-camera_core_sgdma_queue(struct camera_device *cam,
-        const struct scatterlist *sglist, int sglen, dma_callback_t callback,
-        void *arg)
+static int camera_core_sgdma_queue(struct camera_device *cam,
+				   const struct scatterlist *sglist,
+				   int sglen, dma_callback_t callback,
+				   void *arg)
 {
 	unsigned long irqflags;
 	struct sgdma_state *sgdma;
@@ -295,21 +292,19 @@ camera_core_sgdma_queue(struct camera_device *cam,
 	return 0;
 }
 
-
-/* -------------------overlay routines ------------------------------*/
-/* callback routine for overlay DMA completion. We just start another DMA
+/* -------------------overlay routines ------------------------------
+ * Callback routine for overlay DMA completion. We just start another DMA
  * transfer unless overlay has been turned off
  */
-
-static void
-camera_core_overlay_callback(void *arg1, void *arg)
+static void camera_core_overlay_callback(void *arg1, void *arg)
 {
 	struct camera_device *cam = (struct camera_device *)arg1;
 	int err;
 	unsigned long irqflags;
 	int i, j;
 	int count, index;
-	unsigned char *fb_buf = phys_to_virt((unsigned long)camera_dev->fbuf.base);
+	unsigned char *fb_buf =
+	    phys_to_virt((unsigned long)camera_dev->fbuf.base);
 
 	spin_lock_irqsave(&cam->overlay_lock, irqflags);
 
@@ -324,12 +319,13 @@ camera_core_overlay_callback(void *arg1, void *arg)
 
 	count = 0;
 	j = ((cam->pix.width - 1) * cam->fbuf.fmt.bytesperline);
-	for (i = 0 ; i < cam->pix.sizeimage; i += cam->pix.bytesperline) {
+	for (i = 0; i < cam->pix.sizeimage; i += cam->pix.bytesperline) {
 		for (index = 0; index < cam->pix.bytesperline; index++) {
-			fb_buf[j] = *(((unsigned char *) cam->overlay_base) +
-								 i + index);
+			fb_buf[j] = *(((unsigned char *)cam->overlay_base) +
+				      i + index);
 			index++;
-			fb_buf[j + 1] = *(((unsigned char *) cam->overlay_base) + i + index);
+			fb_buf[j + 1] =
+			    *(((unsigned char *)cam->overlay_base) + i + index);
 			j = j - cam->fbuf.fmt.bytesperline;
 		}
 		count += 2;
@@ -338,7 +334,8 @@ camera_core_overlay_callback(void *arg1, void *arg)
 
 	while (cam->overlay_cnt < 2) {
 		err = camera_core_sgdma_queue(cam, &cam->overlay_sglist, 1,
-			camera_core_overlay_callback, NULL);
+					      camera_core_overlay_callback,
+					      NULL);
 		if (err)
 			break;
 		++cam->overlay_cnt;
@@ -348,9 +345,7 @@ camera_core_overlay_callback(void *arg1, void *arg)
 
 }
 
-
-static void
-camera_core_start_overlay(struct camera_device *cam)
+static void camera_core_start_overlay(struct camera_device *cam)
 {
 	int err;
 	unsigned long irqflags;
@@ -361,10 +356,11 @@ camera_core_start_overlay(struct camera_device *cam)
 	spin_lock_irqsave(&cam->overlay_lock, irqflags);
 
 	sg_dma_address(&cam->overlay_sglist) = cam->overlay_base_phys;
-	sg_dma_len(&cam->overlay_sglist)= cam->pix.sizeimage;
+	sg_dma_len(&cam->overlay_sglist) = cam->pix.sizeimage;
 	while (cam->overlay_cnt < 2) {
 		err = camera_core_sgdma_queue(cam, &cam->overlay_sglist, 1,
-				camera_core_overlay_callback, NULL);
+					      camera_core_overlay_callback,
+					      NULL);
 		if (err)
 			break;
 		++cam->overlay_cnt;
@@ -373,13 +369,11 @@ camera_core_start_overlay(struct camera_device *cam)
 	spin_unlock_irqrestore(&cam->overlay_lock, irqflags);
 }
 
-/* ------------------ videobuf_queue_ops --------------------------------*/
-
-/* This routine is called from interrupt context when a scatter-gather DMA
+/* ------------------ videobuf_queue_ops --------------------------------
+ * This routine is called from interrupt context when a scatter-gather DMA
  * transfer of a videobuf_buffer completes.
  */
-static void
-camera_core_vbq_complete(void *arg1, void *arg)
+static void camera_core_vbq_complete(void *arg1, void *arg)
 {
 	struct camera_device *cam = (struct camera_device *)arg1;
 	struct videobuf_buffer *vb = (struct videobuf_buffer *)arg;
@@ -396,8 +390,8 @@ camera_core_vbq_complete(void *arg1, void *arg)
 	spin_unlock(&cam->vbq_lock);
 }
 
-static void
-camera_core_vbq_release(struct videobuf_queue *q, struct videobuf_buffer *vb)
+static void camera_core_vbq_release(struct videobuf_queue *q,
+				    struct videobuf_buffer *vb)
 {
 	videobuf_waiton(vb, 0, 0);
 	videobuf_dma_unmap(q, &vb->dma);
@@ -410,14 +404,14 @@ camera_core_vbq_release(struct videobuf_queue *q, struct videobuf_buffer *vb)
  * number requested, the currently selected image size, and the maximum
  * amount of memory permitted for kernel capture buffers.
  */
-static int
-camera_core_vbq_setup(struct videobuf_queue *q, unsigned int *cnt, unsigned int *size)
+static int camera_core_vbq_setup(struct videobuf_queue *q, unsigned int *cnt,
+				 unsigned int *size)
 {
 	struct camera_fh *fh = q->priv_data;
 	struct camera_device *cam = fh->cam;
 
 	if (*cnt <= 0)
-		*cnt = VIDEO_MAX_FRAME; /* supply a default number of buffers */
+		*cnt = VIDEO_MAX_FRAME;	/* Supply a default number of buffers */
 
 	if (*cnt > VIDEO_MAX_FRAME)
 		*cnt = VIDEO_MAX_FRAME;
@@ -432,9 +426,9 @@ camera_core_vbq_setup(struct videobuf_queue *q, unsigned int *cnt, unsigned int
 	return 0;
 }
 
-static int
-camera_core_vbq_prepare(struct videobuf_queue *q, struct videobuf_buffer *vb,
-        enum v4l2_field field)
+static int camera_core_vbq_prepare(struct videobuf_queue *q,
+				   struct videobuf_buffer *vb,
+				   enum v4l2_field field)
 {
 	struct camera_fh *fh = q->priv_data;
 	struct camera_device *cam = fh->cam;
@@ -457,13 +451,13 @@ camera_core_vbq_prepare(struct videobuf_queue *q, struct videobuf_buffer *vb,
 	if (!err)
 		vb->state = STATE_PREPARED;
 	else
-		camera_core_vbq_release (q, vb);
+		camera_core_vbq_release(q, vb);
 
 	return err;
 }
 
-static void
-camera_core_vbq_queue(struct videobuf_queue *q, struct videobuf_buffer *vb)
+static void camera_core_vbq_queue(struct videobuf_queue *q,
+				  struct videobuf_buffer *vb)
 {
 	struct camera_fh *fh = q->priv_data;
 	struct camera_device *cam = fh->cam;
@@ -472,25 +466,20 @@ camera_core_vbq_queue(struct videobuf_queue *q, struct videobuf_buffer *vb)
 
 	vb->state = STATE_QUEUED;
 	err = camera_core_sgdma_queue(cam, vb->dma.sglist, vb->dma.sglen,
-                camera_core_vbq_complete, vb);
+				      camera_core_vbq_complete, vb);
 	if (err) {
 		/* Oops.  We're not supposed to get any errors here.  The only
-		* way we could get an error is if we ran out of scatter-gather
-		* DMA slots, but we are supposed to have at least as many
-		* scatter-gather DMA slots as video buffers so that can't
-		* happen.
-		*/
+		 * way we could get an error is if we ran out of scatter-gather
+		 * DMA slots, but we are supposed to have at least as many
+		 * scatter-gather DMA slots as video buffers so that can't
+		 * happen.
+		 */
 		dev_dbg(cam->dev, "Failed to queue a video buffer for SGDMA\n");
 		vb->state = state;
 	}
 }
 
-
-/*
- *
- * IOCTL interface.
- *
- */
+/* IOCTL interface. */
 static int vidioc_querycap(struct file *file, void *fh,
 			   struct v4l2_capability *cap)
 {
@@ -501,10 +490,8 @@ static int vidioc_querycap(struct file *file, void *fh,
 	strlcpy(cap->card, cam->vfd->name, sizeof(cap->card));
 	cap->version = OMAP1CAM_VERSION;
 	cap->capabilities =
-		V4L2_CAP_VIDEO_CAPTURE |
-		V4L2_CAP_VIDEO_OVERLAY |
-		V4L2_CAP_READWRITE |
-		V4L2_CAP_STREAMING;
+	    V4L2_CAP_VIDEO_CAPTURE |
+	    V4L2_CAP_VIDEO_OVERLAY | V4L2_CAP_READWRITE | V4L2_CAP_STREAMING;
 
 	return 0;
 }
@@ -512,27 +499,25 @@ static int vidioc_querycap(struct file *file, void *fh,
 static int vidioc_enum_fmt_cap(struct file *file, void *fh,
 			       struct v4l2_fmtdesc *f)
 {
-	struct camera_fh *ofh  = fh;
+	struct camera_fh *ofh = fh;
 	struct camera_device *cam = ofh->cam;
 
 	return vidioc_int_enum_fmt_cap(cam->sdev, f);
 }
 
-static int vidioc_g_fmt_cap(struct file *file, void *fh,
-			    struct v4l2_format *f)
+static int vidioc_g_fmt_cap(struct file *file, void *fh, struct v4l2_format *f)
 {
-	struct camera_fh *ofh  = fh;
+	struct camera_fh *ofh = fh;
 	struct camera_device *cam = ofh->cam;
 
-	/* get the current format */
+	/* Get the current format */
 	memset(&f->fmt.pix, 0, sizeof(f->fmt.pix));
 	f->fmt.pix = cam->pix;
 
 	return 0;
 }
 
-static int vidioc_s_fmt_cap(struct file *file, void *fh,
-			    struct v4l2_format *f)
+static int vidioc_s_fmt_cap(struct file *file, void *fh, struct v4l2_format *f)
 {
 	struct camera_fh *ofh = fh;
 	struct camera_device *cam = ofh->cam;
@@ -565,8 +550,7 @@ static int vidioc_reqbufs(struct file *file, void *fh,
 	return videobuf_reqbufs(&ofh->vbq, b);
 }
 
-static int vidioc_querybuf(struct file *file, void *fh,
-			   struct v4l2_buffer *b)
+static int vidioc_querybuf(struct file *file, void *fh, struct v4l2_buffer *b)
 {
 	struct camera_fh *ofh = fh;
 
@@ -599,8 +583,7 @@ static int vidioc_streamon(struct file *file, void *fh, enum v4l2_buf_type i)
 		return -EBUSY;
 	} else
 		cam->streaming = ofh;
-		/* FIXME: start camera interface */
-
+	/* FIXME: start camera interface */
 
 	spin_unlock(&cam->img_lock);
 
@@ -620,7 +603,7 @@ static int vidioc_streamoff(struct file *file, void *fh, enum v4l2_buf_type i)
 	spin_lock(&cam->img_lock);
 	if (cam->streaming == ofh)
 		cam->streaming = NULL;
-		/* FIXME: stop camera interface */
+	/* FIXME: stop camera interface */
 
 	spin_unlock(&cam->img_lock);
 	return 0;
@@ -662,8 +645,7 @@ static int vidioc_queryctrl(struct file *file, void *fh,
 	return vidioc_int_queryctrl(cam->sdev, a);
 }
 
-static int vidioc_g_ctrl(struct file *file, void *fh,
-			 struct v4l2_control *a)
+static int vidioc_g_ctrl(struct file *file, void *fh, struct v4l2_control *a)
 {
 	struct camera_fh *ofh = fh;
 	struct camera_device *cam = ofh->cam;
@@ -671,8 +653,7 @@ static int vidioc_g_ctrl(struct file *file, void *fh,
 	return vidioc_int_g_ctrl(cam->sdev, a);
 }
 
-static int vidioc_s_ctrl(struct file *file, void *fh,
-			 struct v4l2_control *a)
+static int vidioc_s_ctrl(struct file *file, void *fh, struct v4l2_control *a)
 {
 	struct camera_fh *ofh = fh;
 	struct camera_device *cam = ofh->cam;
@@ -711,15 +692,13 @@ static int vidioc_s_fbuf(struct file *file, void *fh,
 	return 0;
 }
 
-static int vidioc_overlay(struct file *file, void *fh,
-			 unsigned int i)
+static int vidioc_overlay(struct file *file, void *fh, unsigned int i)
 {
 	struct camera_fh *ofh = fh;
 	struct camera_device *cam = ofh->cam;
 	int enable = i;
 
-	/*
-	 * check whether the capture format and
+	/* Check whether the capture format and
 	 * the display format matches
 	 * return failure if they are different
 	 */
@@ -733,7 +712,7 @@ static int vidioc_overlay(struct file *file, void *fh,
 	    (cam->pix.height > cam->fbuf.fmt.width))
 		return -EINVAL;
 
-	if (!cam->previewing && enable)	{
+	if (!cam->previewing && enable) {
 		cam->previewing = fh;
 		cam->overlay_cnt = 0;
 		camera_core_start_overlay(cam);
@@ -743,22 +722,17 @@ static int vidioc_overlay(struct file *file, void *fh,
 	return 0;
 }
 
-/*
- *  file operations
- */
-
-static unsigned
-int camera_core_poll(struct file *file, struct poll_table_struct *wait)
+/* File operations */
+static unsigned int camera_core_poll(struct file *file,
+				     struct poll_table_struct *wait)
 {
 	return -EINVAL;
 }
 
-/* ------------------------------------------------------------ */
-/* callback routine for read DMA completion. We just start another DMA
+/* Callback routine for read DMA completion. We just start another DMA
  * transfer unless overlay has been turned off
  */
-static void
-camera_core_capture_callback(void *arg1, void *arg)
+static void camera_core_capture_callback(void *arg1, void *arg)
 {
 	struct camera_device *cam = (struct camera_device *)arg1;
 	int err;
@@ -778,33 +752,38 @@ camera_core_capture_callback(void *arg1, void *arg)
 		sg_dma_address(&cam->capture_sglist) = cam->capture_base_phys;
 		sg_dma_len(&cam->capture_sglist) = cam->pix.sizeimage;
 		err = camera_core_sgdma_queue(cam, &cam->capture_sglist, 1,
-			camera_core_capture_callback, NULL);
+					      camera_core_capture_callback,
+					      NULL);
 	} else {
 		cam->capture_completed = 1;
 		if (cam->reading) {
 			/* Wake up any process which are waiting for the
-			** DMA to complete */
+			 * DMA to complete
+			 */
 			wake_up_interruptible(&camera_dev->new_video_frame);
-			sg_dma_address(&cam->capture_sglist) = cam->capture_base_phys;
+			sg_dma_address(&cam->capture_sglist) =
+			    cam->capture_base_phys;
 			sg_dma_len(&cam->capture_sglist) = cam->pix.sizeimage;
-			err = camera_core_sgdma_queue(cam, &cam->capture_sglist, 1,
-				camera_core_capture_callback, NULL);
+			err =
+			   camera_core_sgdma_queue(cam, &cam->capture_sglist,
+						   1,
+						   camera_core_capture_callback,
+						   NULL);
 		}
 	}
 
 	spin_unlock_irqrestore(&cam->capture_lock, irqflags);
 }
 
-
-static ssize_t
-camera_core_read(struct file *file, char *data, size_t count, loff_t *ppos)
+static ssize_t camera_core_read(struct file *file, char *data, size_t count,
+				loff_t *ppos)
 {
 	struct camera_fh *fh = file->private_data;
 	struct camera_device *cam = fh->cam;
 	int err;
 	unsigned long irqflags;
 	long timeout;
-#if 0	/* use video_buf to do capture */
+#if 0				/* Use video_buf to do capture */
 	int i;
 	for (i = 0; i < 14; i++)
 		videobuf_read_one(file, &fh->vbq, data, count, ppos);
@@ -813,10 +792,12 @@ camera_core_read(struct file *file, char *data, size_t count, loff_t *ppos)
 #endif
 
 	if (!cam->capture_base) {
-		cam->capture_base = (unsigned long)dma_alloc_coherent(NULL,
-				cam->pix.sizeimage,
-				(dma_addr_t *) &cam->capture_base_phys,
-				GFP_KERNEL | GFP_DMA);
+		cam->capture_base = (unsigned long)
+		    dma_alloc_coherent(NULL,
+				       cam->pix.sizeimage,
+				       (dma_addr_t *) &
+				       cam->capture_base_phys,
+				       GFP_KERNEL | GFP_DMA);
 	}
 	if (!cam->capture_base) {
 		dev_err(cam->dev, "cannot allocate capture buffer\n");
@@ -827,39 +808,37 @@ camera_core_read(struct file *file, char *data, size_t count, loff_t *ppos)
 	cam->reading = fh;
 	cam->capture_started = 1;
 	sg_dma_address(&cam->capture_sglist) = cam->capture_base_phys;
-	sg_dma_len(&cam->capture_sglist)= cam->pix.sizeimage;
+	sg_dma_len(&cam->capture_sglist) = cam->pix.sizeimage;
 	spin_unlock_irqrestore(&cam->capture_lock, irqflags);
 
 	err = camera_core_sgdma_queue(cam, &cam->capture_sglist, 1,
-			camera_core_capture_callback, NULL);
+				      camera_core_capture_callback, NULL);
 
 	/* Wait till DMA is completed */
 	timeout = HZ * 10;
 	cam->capture_completed = 0;
 	while (cam->capture_completed == 0) {
 		timeout = interruptible_sleep_on_timeout
-				(&cam->new_video_frame, timeout);
+		    (&cam->new_video_frame, timeout);
 		if (timeout == 0) {
 			dev_err(cam->dev, "timeout waiting video frame\n");
-			return -EIO; /* time out */
+			return -EIO;	/* Time out */
 		}
 	}
-	/* copy the data to the user buffer */
+	/* Copy the data to the user buffer */
 	err = copy_to_user(data, (void *)cam->capture_base, cam->pix.sizeimage);
 	return (cam->pix.sizeimage - err);
 
 }
 
-static int
-camera_core_mmap(struct file *file, struct vm_area_struct *vma)
+static int camera_core_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct camera_fh *fh = file->private_data;
 
 	return videobuf_mmap_mapper(&fh->vbq, vma);
 }
 
-static int
-camera_core_release(struct inode *inode, struct file *file)
+static int camera_core_release(struct inode *inode, struct file *file)
 {
 	struct camera_fh *fh = file->private_data;
 	struct camera_device *cam = fh->cam;
@@ -882,8 +861,8 @@ camera_core_release(struct inode *inode, struct file *file)
 
 	if (cam->capture_base) {
 		dma_free_coherent(NULL, cam->pix.sizeimage,
-					(void *)cam->capture_base,
-					cam->capture_base_phys);
+				  (void *)cam->capture_base,
+				  cam->capture_base_phys);
 		cam->capture_base = 0;
 		cam->capture_base_phys = 0;
 	}
@@ -899,8 +878,7 @@ camera_core_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int
-camera_core_open(struct inode *inode, struct file *file)
+static int camera_core_open(struct inode *inode, struct file *file)
 {
 	int minor = iminor(inode);
 	struct camera_device *cam = camera_dev;
@@ -911,7 +889,7 @@ camera_core_open(struct inode *inode, struct file *file)
 	if (!cam || !cam->vfd || (cam->vfd->minor != minor))
 		return -ENODEV;
 
-	/* allocate per-filehandle data */
+	/* Allocate per-filehandle data */
 	fh = kmalloc(sizeof(*fh), GFP_KERNEL);
 	if (NULL == fh)
 		return -ENOMEM;
@@ -938,7 +916,8 @@ camera_core_open(struct inode *inode, struct file *file)
 	spin_unlock(&cam->img_lock);
 
 	videobuf_queue_init(&fh->vbq, &cam->vbq_ops, NULL, &cam->vbq_lock,
-		fh->type, V4L2_FIELD_NONE, sizeof(struct videobuf_buffer), fh);
+			    fh->type, V4L2_FIELD_NONE,
+			    sizeof(struct videobuf_buffer), fh);
 
 	cam->capture_completed = 0;
 	cam->capture_started = 0;
@@ -951,7 +930,8 @@ camera_core_open(struct inode *inode, struct file *file)
 	}
 	rval = vidioc_s_fmt_cap(file, fh, &format);
 	if (rval) {
-		dev_err(cam->dev, "Camera sensor configuration failed (%d)\n", rval);
+		dev_err(cam->dev, "Camera sensor configuration failed (%d)\n",
+			rval);
 		cam->cam_hardware->close(cam->hardware_data);
 		cam->active = 0;
 		rval = -ENODEV;
@@ -1003,25 +983,24 @@ static int camera_core_resume(struct platform_device *pdev)
 
 	return 0;
 }
-#endif	/* CONFIG_PM */
+#endif /* CONFIG_PM */
 
 static struct file_operations camera_core_fops = {
-	.owner			= THIS_MODULE,
-	.llseek			= no_llseek,
-	.read			= camera_core_read,
-	.poll			= camera_core_poll,
-	.ioctl			= video_ioctl2,
-	.mmap			= camera_core_mmap,
-	.open			= camera_core_open,
-	.release		= camera_core_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= camera_core_read,
+	.poll		= camera_core_poll,
+	.ioctl		= video_ioctl2,
+	.mmap		= camera_core_mmap,
+	.open		= camera_core_open,
+	.release	= camera_core_release,
 };
-static ssize_t
-camera_streaming_show(struct device *dev, struct device_attribute *attr,
-		char *buf)
+static ssize_t camera_streaming_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
 {
 	struct camera_device *cam = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%s\n", cam->streaming ?  "active" : "inactive");
+	return sprintf(buf, "%s\n", cam->streaming ? "active" : "inactive");
 }
 
 static DEVICE_ATTR(streaming, S_IRUGO, camera_streaming_show, NULL);
@@ -1034,12 +1013,11 @@ static void camera_device_unregister(struct v4l2_int_device *ctl)
 }
 
 static int camera_device_register(struct v4l2_int_device *ctl,
-				       struct v4l2_int_device *s)
+				  struct v4l2_int_device *s)
 {
 	struct camera_device *cam = ctl->priv;
 	struct video_device *vfd;
 	int rval;
-	/*Initialise the pointer to the sensor interface and camera interface */
 
 	/* We already have a slave. */
 	if (cam->sdev)
@@ -1053,7 +1031,7 @@ static int camera_device_register(struct v4l2_int_device *ctl,
 		goto err;
 	}
 
-	/* initialize the video_device struct */
+	/* Initialize the video_device struct */
 	vfd = cam->vfd = video_device_alloc();
 	if (!vfd) {
 		dev_err(cam->dev, " could not allocate video device struct\n");
@@ -1066,7 +1044,7 @@ static int camera_device_register(struct v4l2_int_device *ctl,
 	strlcpy(vfd->name, CAM_NAME, sizeof(vfd->name));
 	vfd->type = VID_TYPE_CAPTURE | VID_TYPE_OVERLAY | VID_TYPE_CHROMAKEY;
 
-	/* need to register for a VID_HARDWARE_* ID in videodev.h */
+	/* Need to register for a VID_HARDWARE_* ID in videodev.h */
 	vfd->hardware = 0;
 	vfd->fops = &camera_core_fops;
 	video_set_drvdata(vfd, cam);
@@ -1093,17 +1071,16 @@ static int camera_device_register(struct v4l2_int_device *ctl,
 	vfd->vidioc_s_fbuf = vidioc_s_fbuf;
 	vfd->vidioc_overlay = vidioc_overlay;
 
-
 	dev_info(cam->dev, "%s interface with %s sensor\n",
-		cam->cam_hardware->name, cam->sdev->name);
+		 cam->cam_hardware->name, cam->sdev->name);
 
 	if (video_register_device(vfd, VFL_TYPE_GRABBER, video_nr) < 0) {
-		dev_err(cam->dev, "could not register Video for Linux device\n");
+		dev_err(cam->dev,
+			"could not register Video for Linux device\n");
 		rval = -ENODEV;
 		goto err;
 	}
 
-
 	rval = camera_sensor_init(cam);
 	if (rval)
 		goto err;
@@ -1136,7 +1113,7 @@ static struct v4l2_int_device camera = {
 static int __init camera_core_probe(struct platform_device *pdev)
 {
 	struct camera_device *cam;
-	int	status = 0;
+	int status = 0;
 
 	cam = kzalloc(sizeof(struct camera_device), GFP_KERNEL);
 	if (!cam) {
@@ -1149,7 +1126,7 @@ static int __init camera_core_probe(struct platform_device *pdev)
 
 	cam->dev = &pdev->dev;
 
-	/* initialize the camera interface */
+	/* Initialize the camera interface */
 	cam->cam_hardware = &camera_hardware_if;
 	cam->hardware_data = cam->cam_hardware->init();
 	if (!cam->hardware_data) {
@@ -1161,38 +1138,41 @@ static int __init camera_core_probe(struct platform_device *pdev)
 	/* Save the pointer to camera device in a global variable */
 	camera_dev = cam;
 
-	/* initialize the videobuf queue ops */
+	/* Initialize the videobuf queue ops */
 	cam->vbq_ops.buf_setup = camera_core_vbq_setup;
 	cam->vbq_ops.buf_prepare = camera_core_vbq_prepare;
 	cam->vbq_ops.buf_queue = camera_core_vbq_queue;
 	cam->vbq_ops.buf_release = camera_core_vbq_release;
 
-	/* initilize the overlay interface */
+	/* Initialize the overlay interface */
 	cam->overlay_size = overlay_mem;
 	if (cam->overlay_size > 0) {
-		cam->overlay_base = (unsigned long) dma_alloc_coherent(NULL,
-					cam->overlay_size,
-					(dma_addr_t *) &cam->overlay_base_phys,
-					GFP_KERNEL | GFP_DMA);
+		cam->overlay_base = (unsigned long)
+		    dma_alloc_coherent(NULL,
+				       cam->overlay_size,
+				       (dma_addr_t *) &
+				       cam->overlay_base_phys,
+				       GFP_KERNEL | GFP_DMA);
 		if (!cam->overlay_base) {
-			dev_err(cam->dev, "cannot allocate overlay framebuffer\n");
+			dev_err(cam->dev,
+				"cannot allocate overlay framebuffer\n");
 			status = -ENOMEM;
 			goto err;
 		}
 	}
-	memset((void*)cam->overlay_base, 0, cam->overlay_size);
+	memset((void *)cam->overlay_base, 0, cam->overlay_size);
 	spin_lock_init(&cam->overlay_lock);
 	spin_lock_init(&cam->capture_lock);
 
-	/* initialize the spinlock used to serialize access to the image
+	/* Initialize the spinlock used to serialize access to the image
 	 * parameters
 	 */
 	spin_lock_init(&cam->img_lock);
 
-	/* initialise the wait queue */
+	/* Initialize the wait queue */
 	init_waitqueue_head(&cam->new_video_frame);
 
-	/* Initialise the DMA structures */
+	/* Initialize the DMA structures */
 	camera_core_sgdma_init(cam);
 
 	platform_set_drvdata(pdev, cam);
@@ -1204,7 +1184,7 @@ static int __init camera_core_probe(struct platform_device *pdev)
 
 	return 0;
 
- err:
+err:
 	vidioc_int_dev_exit(cam->sdev);
 	cam->overlay_base = 0;
 	return status;
@@ -1219,21 +1199,21 @@ static int camera_core_remove(struct platform_device *pdev)
 	if (vfd) {
 		if (vfd->minor == -1) {
 			/* The device never got registered, so release the
-			** video_device struct directly
-			*/
+			 * video_device struct directly
+			 */
 			video_device_release(vfd);
 		} else {
-			/* The unregister function will release the video_device
-			** struct as well as unregistering it.
-			*/
+			/* The unregister function will release the
+			 * video_device struct as well as unregistering it.
+			 */
 			video_unregister_device(vfd);
 		}
 		cam->vfd = NULL;
 	}
 	if (cam->overlay_base) {
 		dma_free_coherent(NULL, cam->overlay_size,
-					(void *)cam->overlay_base,
-					cam->overlay_base_phys);
+				  (void *)cam->overlay_base,
+				  cam->overlay_base_phys);
 		cam->overlay_base = 0;
 	}
 	cam->overlay_base_phys = 0;
@@ -1247,27 +1227,26 @@ static int camera_core_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver camera_core_driver = {
-	.driver = {
-		.name		= CAM_NAME,
-		.owner		= THIS_MODULE,
+	.driver	= {
+		.name	= CAM_NAME,
+		.owner	= THIS_MODULE,
 	},
-	.probe			= camera_core_probe,
-	.remove			= camera_core_remove,
+	.probe		= camera_core_probe,
+	.remove		= camera_core_remove,
 #ifdef CONFIG_PM
-	.suspend		= camera_core_suspend,
-	.resume			= camera_core_resume,
+	.suspend	= camera_core_suspend,
+	.resume		= camera_core_resume,
 #endif
 };
 
 /* FIXME register omap16xx or omap24xx camera device in arch/arm/...
- * system init code, with its resources and mux setup, NOT here.
+ * system initialization code, with its resources and mux setup, NOT here.
  * Then MODULE_ALIAS(CAM_NAME) so it hotplugs and coldplugs; this
  * "legacy" driver style is trouble.
  */
 static struct platform_device *cam;
 
-static void __exit
-camera_core_cleanup(void)
+static void __exit camera_core_cleanup(void)
 {
 	platform_driver_unregister(&camera_core_driver);
 	platform_device_unregister(cam);
@@ -1275,8 +1254,7 @@ camera_core_cleanup(void)
 
 static char banner[] __initdata = KERN_INFO "OMAP Camera driver initializing\n";
 
-static int __init
-camera_core_init(void)
+static int __init camera_core_init(void)
 {
 
 	printk(banner);
@@ -1293,10 +1271,11 @@ MODULE_LICENSE("GPL");
 
 module_param(video_nr, int, 0);
 MODULE_PARM_DESC(video_nr,
-		"Minor number for video device (-1 ==> auto assign)");
+		 "Minor number for video device (-1 ==> auto assign)");
 module_param(capture_mem, int, 0);
 MODULE_PARM_DESC(capture_mem,
-        "Maximum amount of memory for capture buffers (default 4800KB)");
+		 "Maximum amount of memory for capture buffers "
+		 "(default 4800KB)");
 
 module_init(camera_core_init);
 module_exit(camera_core_cleanup);
-- 
1.5.3.4.206.g58ba4

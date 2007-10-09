From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 4/6] OMAP1: CAMERA: Convert camera_core.c to use
	v4l2-int-device API
Date: Tue,  9 Oct 2007 08:52:31 -0400
Message-ID: <1191934353-24072-5-git-send-email-edubezval@gmail.com>
References: <1191934353-24072-1-git-send-email-edubezval@gmail.com>
	<1191934353-24072-2-git-send-email-edubezval@gmail.com>
	<1191934353-24072-3-git-send-email-edubezval@gmail.com>
	<1191934353-24072-4-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1191934353-24072-4-git-send-email-edubezval@gmail.com>
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

This patch converts camera_core.c to use v4l2-int-device API.
Only read method was tested with success. MMAP method still needs
re-work and tests.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 drivers/media/video/omap/camera_core.c |  394 +++++++++++++++++++++-----------
 drivers/media/video/omap/camera_core.h |   26 +-
 2 files changed, 279 insertions(+), 141 deletions(-)

diff --git a/drivers/media/video/omap/camera_core.c b/drivers/media/video/omap/camera_core.c
index bbd51d1..217a79f 100644
--- a/drivers/media/video/omap/camera_core.c
+++ b/drivers/media/video/omap/camera_core.c
@@ -54,6 +54,101 @@ static int capture_mem = 1280*960*2*2;
 static int overlay_mem = 640*480*2;
 
 
+/*
+ * Enable the external sensor interface. Try to negotiate interface
+ * parameters with the sensor and start using the new ones. The calls
+ * to sensor_if_enable and sensor_if_disable need not to be balanced.
+ */
+static int camera_sensor_if_enable(struct camera_device *cam)
+{
+	int rval;
+	struct v4l2_ifparm p;
+
+	rval = vidioc_int_g_ifparm(cam->sdev, &p);
+	if (rval) {
+		dev_err(cam->dev, "vidioc_int_g_ifparm failed with %d\n", rval);
+		return rval;
+	}
+
+	cam->if_type = p.if_type;
+
+	switch (p.if_type) {
+	case V4L2_IF_TYPE_BT656:
+		cam->if_u.bt656.xclk =
+			cam->cam_hardware->set_xclk(cam->if_u.bt656.xclk,
+						    cam->hardware_data);
+		break;
+	default:
+		/* FIXME: how about other interfaces? */
+		dev_err(cam->dev, "interface type %d not supported\n",
+			p.if_type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void camera_sensor_if_disable(const struct camera_device *cam)
+{
+	switch (cam->if_type) {
+	case V4L2_IF_TYPE_BT656:
+		break;
+	}
+}
+
+/*
+ * Initialise the sensor hardware.
+ */
+static int camera_sensor_init(struct camera_device *cam)
+{
+	int err = 0;
+	struct v4l2_int_device *sdev = cam->sdev;
+
+	/* Enable the xclk output.  The sensor may (and does, in the case of
+	 * the OV9640) require an xclk input in order for its initialization
+	 * routine to work.
+	 */
+
+	cam->if_u.bt656.xclk = 21000000;/* choose an arbitrary xclk frequency */
+
+	cam->if_u.bt656.xclk = cam->cam_hardware->set_xclk(cam->if_u.bt656.xclk,
+							   cam->hardware_data);
+
+	err = camera_sensor_if_enable(cam);
+	if (err) {
+		dev_err(cam->dev, "sensor interface could not be enabled at "
+			"initialisation, %d\n", err);
+		cam->sdev = NULL;
+		goto out;
+	}
+
+	/* power up sensor during sensor initialization */
+	vidioc_int_s_power(sdev, 1);
+
+	err = vidioc_int_dev_init(sdev);
+	if (err) {
+		dev_err(cam->dev, "cannot initialize sensor, error %d\n", err);
+		/* Sensor init failed --- it's nonexistent to us! */
+		cam->sdev = NULL;
+		goto out;
+	}
+
+	dev_info(cam->dev, "sensor is %s\n", sdev->name);
+
+out:
+	camera_sensor_if_disable(cam);
+
+	vidioc_int_s_power(sdev, 0);
+
+	return err;
+}
+
+static void camera_sensor_exit(struct camera_device *cam)
+{
+	if (cam->sdev)
+		vidioc_int_dev_exit(cam->sdev);
+}
+
 /* DMA completion routine for the scatter-gather DMA fragments. */
 /* This function is called when a scatter DMA fragment is completed */
 static void
@@ -68,7 +163,7 @@ camera_core_callback_sgdma(void *arg1, void *arg2)
 	sgdma = cam->sgdma + sgslot;
 	if (!sgdma->queued_sglist) {
 		spin_unlock(&cam->sg_lock);
-		dev_err(&cam->dev, "SGDMA completed when none queued\n");
+		dev_err(cam->dev, "SGDMA completed when none queued\n");
 		return;
 	}
 	if (!--sgdma->queued_sglist) {
@@ -318,7 +413,8 @@ camera_core_vbq_release(struct videobuf_queue *q, struct videobuf_buffer *vb)
 static int
 camera_core_vbq_setup(struct videobuf_queue *q, unsigned int *cnt, unsigned int *size)
 {
-	struct camera_device *cam = q->priv_data;
+	struct camera_fh *fh = q->priv_data;
+	struct camera_device *cam = fh->cam;
 
 	if (*cnt <= 0)
 		*cnt = VIDEO_MAX_FRAME; /* supply a default number of buffers */
@@ -340,7 +436,8 @@ static int
 camera_core_vbq_prepare(struct videobuf_queue *q, struct videobuf_buffer *vb,
         enum v4l2_field field)
 {
-	struct camera_device *cam = q->priv_data;
+	struct camera_fh *fh = q->priv_data;
+	struct camera_device *cam = fh->cam;
 	int err = 0;
 
 	spin_lock(&cam->img_lock);
@@ -368,7 +465,8 @@ camera_core_vbq_prepare(struct videobuf_queue *q, struct videobuf_buffer *vb,
 static void
 camera_core_vbq_queue(struct videobuf_queue *q, struct videobuf_buffer *vb)
 {
-	struct camera_device *cam = q->priv_data;
+	struct camera_fh *fh = q->priv_data;
+	struct camera_device *cam = fh->cam;
 	enum videobuf_state state = vb->state;
 	int err;
 
@@ -382,7 +480,7 @@ camera_core_vbq_queue(struct videobuf_queue *q, struct videobuf_buffer *vb)
 		* scatter-gather DMA slots as video buffers so that can't
 		* happen.
 		*/
-		dev_dbg(&cam->dev, "Failed to queue a video buffer for SGDMA\n");
+		dev_dbg(cam->dev, "Failed to queue a video buffer for SGDMA\n");
 		vb->state = state;
 	}
 }
@@ -417,7 +515,7 @@ static int vidioc_enum_fmt_cap(struct file *file, void *fh,
 	struct camera_fh *ofh  = fh;
 	struct camera_device *cam = ofh->cam;
 
-	return cam->cam_sensor->enum_pixformat(f, cam->sensor_data);
+	return vidioc_int_enum_fmt_cap(cam->sdev, f);
 }
 
 static int vidioc_g_fmt_cap(struct file *file, void *fh,
@@ -438,18 +536,16 @@ static int vidioc_s_fmt_cap(struct file *file, void *fh,
 {
 	struct camera_fh *ofh = fh;
 	struct camera_device *cam = ofh->cam;
-	unsigned int temp_sizeimage = 0;
+	int rval = 0;
+
+	vidioc_int_try_fmt_cap(cam->sdev, f);
 
-	temp_sizeimage = cam->pix.sizeimage;
-	cam->cam_sensor->try_format(&f->fmt.pix, cam->sensor_data);
 	cam->pix = f->fmt.pix;
 
-	cam->xclk = cam->cam_sensor->calc_xclk(&cam->pix,
-			       &cam->nominal_timeperframe, cam->sensor_data);
-	cam->cparm.timeperframe = cam->nominal_timeperframe;
-	cam->xclk = cam->cam_hardware->set_xclk(cam->xclk, cam->hardware_data);
-	return cam->cam_sensor->configure(&cam->pix, cam->xclk,
-				  &cam->cparm.timeperframe, cam->sensor_data);
+	rval = vidioc_int_s_fmt_cap(cam->sdev, f);
+	camera_sensor_if_enable(cam);
+
+	return rval;
 }
 
 static int vidioc_try_fmt_cap(struct file *file, void *fh,
@@ -458,7 +554,7 @@ static int vidioc_try_fmt_cap(struct file *file, void *fh,
 	struct camera_fh *ofh = fh;
 	struct camera_device *cam = ofh->cam;
 
-	return cam->cam_sensor->try_format(&f->fmt.pix, cam->sensor_data);
+	return vidioc_int_try_fmt_cap(cam->sdev, f);
 }
 
 static int vidioc_reqbufs(struct file *file, void *fh,
@@ -563,7 +659,7 @@ static int vidioc_queryctrl(struct file *file, void *fh,
 	struct camera_fh *ofh = fh;
 	struct camera_device *cam = ofh->cam;
 
-	return cam->cam_sensor->query_control(a, cam->sensor_data);
+	return vidioc_int_queryctrl(cam->sdev, a);
 }
 
 static int vidioc_g_ctrl(struct file *file, void *fh,
@@ -572,7 +668,7 @@ static int vidioc_g_ctrl(struct file *file, void *fh,
 	struct camera_fh *ofh = fh;
 	struct camera_device *cam = ofh->cam;
 
-	return cam->cam_sensor->get_control(a, cam->sensor_data);
+	return vidioc_int_g_ctrl(cam->sdev, a);
 }
 
 static int vidioc_s_ctrl(struct file *file, void *fh,
@@ -581,7 +677,7 @@ static int vidioc_s_ctrl(struct file *file, void *fh,
 	struct camera_fh *ofh = fh;
 	struct camera_device *cam = ofh->cam;
 
-	return cam->cam_sensor->set_control(a, cam->sensor_data);
+	return vidioc_int_s_ctrl(cam->sdev, a);
 }
 
 static int vidioc_g_fbuf(struct file *file, void *fh,
@@ -723,7 +819,7 @@ camera_core_read(struct file *file, char *data, size_t count, loff_t *ppos)
 				GFP_KERNEL | GFP_DMA);
 	}
 	if (!cam->capture_base) {
-		dev_err(&cam->dev, "cannot allocate capture buffer\n");
+		dev_err(cam->dev, "cannot allocate capture buffer\n");
 		return 0;
 	}
 
@@ -744,7 +840,7 @@ camera_core_read(struct file *file, char *data, size_t count, loff_t *ppos)
 		timeout = interruptible_sleep_on_timeout
 				(&cam->new_video_frame, timeout);
 		if (timeout == 0) {
-			dev_err(&cam->dev, "timeout waiting video frame\n");
+			dev_err(cam->dev, "timeout waiting video frame\n");
 			return -EIO; /* time out */
 		}
 	}
@@ -796,6 +892,8 @@ camera_core_release(struct inode *inode, struct file *file)
 		kfree(fh->vbq.read_buf);
 	}
 
+	module_put(cam->sdev->module);
+
 	cam->cam_hardware->close(cam->hardware_data);
 	cam->active = 0;
 	return 0;
@@ -807,6 +905,8 @@ camera_core_open(struct inode *inode, struct file *file)
 	int minor = iminor(inode);
 	struct camera_device *cam = camera_dev;
 	struct camera_fh *fh;
+	struct v4l2_format format;
+	int rval;
 
 	if (!cam || !cam->vfd || (cam->vfd->minor != minor))
 		return -ENODEV;
@@ -821,11 +921,20 @@ camera_core_open(struct inode *inode, struct file *file)
 
 	spin_lock(&cam->img_lock);
 	if (cam->active == 1) {
-		dev_err(&cam->dev, "Camera device Active\n");
+		dev_err(cam->dev, "Camera device Active\n");
 		spin_unlock(&cam->img_lock);
-		return -EPERM;
+		rval = -EPERM;
+		goto err;
 	}
 	cam->active = 1;
+
+	if (cam->sdev == NULL || !try_module_get(cam->sdev->module)) {
+		spin_unlock(&cam->img_lock);
+		rval = -ENODEV;
+		goto err;
+	}
+
+	vidioc_int_g_fmt_cap(cam->sdev, &format);
 	spin_unlock(&cam->img_lock);
 
 	videobuf_queue_init(&fh->vbq, &cam->vbq_ops, NULL, &cam->vbq_lock,
@@ -835,60 +944,64 @@ camera_core_open(struct inode *inode, struct file *file)
 	cam->capture_started = 0;
 
 	if (cam->cam_hardware->open(cam->hardware_data)) {
-		dev_err(&cam->dev, "Camera IF configuration failed\n");
+		dev_err(cam->dev, "Camera IF configuration failed\n");
 		cam->active = 0;
-		return -ENODEV;
+		rval = -ENODEV;
+		goto err;
 	}
-
-	cam->xclk = cam->cam_hardware->set_xclk(cam->xclk, cam->hardware_data);
-	/* program the sensor for the capture format and rate */
-	if (cam->cam_sensor->configure(&cam->pix, cam->xclk,
-				&cam->cparm.timeperframe, cam->sensor_data)) {
-		dev_err(&cam->dev, "Camera sensor configuration failed\n");
+	rval = vidioc_s_fmt_cap(file, fh, &format);
+	if (rval) {
+		dev_err(cam->dev, "Camera sensor configuration failed (%d)\n", rval);
 		cam->cam_hardware->close(cam->hardware_data);
 		cam->active = 0;
-		return -ENODEV;
+		rval = -ENODEV;
+		goto err;
 	}
 
 	return 0;
+
+err:
+	module_put(cam->sdev->module);
+	kfree(fh);
+	return rval;
 }
 
 #ifdef CONFIG_PM
 static int camera_core_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct camera_device *cam = platform_get_drvdata(pdev);
-	int ret = 0;
 
 	spin_lock(&cam->img_lock);
 	if (cam->active)
 		cam->cam_hardware->close(cam->hardware_data);
 
-	cam->cam_sensor->power_off(cam->sensor_data);
+	vidioc_int_s_power(cam->sdev, 0);
 	spin_unlock(&cam->img_lock);
 
-	return ret;
+	return 0;
 }
 
 static int camera_core_resume(struct platform_device *pdev)
 {
 	struct camera_device *cam = platform_get_drvdata(pdev);
-	int ret = 0;
 
 	spin_lock(&cam->img_lock);
-	cam->cam_sensor->power_on(cam->sensor_data);
+	vidioc_int_s_power(cam->sdev, 1);
 	if (cam->active) {
+		struct v4l2_format format;
+
 		cam->capture_completed = 1;
 		cam->cam_hardware->open(cam->hardware_data);
-		cam->cam_hardware->set_xclk(cam->xclk, cam->hardware_data);
 
-		cam->cam_sensor->configure(&cam->pix, cam->xclk,
-					   &cam->cparm.timeperframe,
-					   cam->sensor_data);
+		vidioc_int_g_fmt_cap(cam->sdev, &format);
+		vidioc_int_s_fmt_cap(cam->sdev, &format);
+		camera_sensor_if_enable(cam);
+
 		camera_core_sgdma_process(cam);
 	}
 	spin_unlock(&cam->img_lock);
 
-	return ret;
+	return 0;
 }
 #endif	/* CONFIG_PM */
 
@@ -902,29 +1015,50 @@ static struct file_operations camera_core_fops = {
 	.open			= camera_core_open,
 	.release		= camera_core_release,
 };
+static ssize_t
+camera_streaming_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct camera_device *cam = dev_get_drvdata(dev);
 
-static int __init camera_core_probe(struct platform_device *pdev)
+	return sprintf(buf, "%s\n", cam->streaming ?  "active" : "inactive");
+}
+
+static DEVICE_ATTR(streaming, S_IRUGO, camera_streaming_show, NULL);
+
+static void camera_device_unregister(struct v4l2_int_device *ctl)
 {
-	struct camera_device *cam;
+	struct camera_device *cam = ctl->priv;
+
+	camera_sensor_exit(cam);
+}
+
+static int camera_device_register(struct v4l2_int_device *ctl,
+				       struct v4l2_int_device *s)
+{
+	struct camera_device *cam = ctl->priv;
 	struct video_device *vfd;
-	int	status;
+	int rval;
+	/*Initialise the pointer to the sensor interface and camera interface */
 
-	cam = kzalloc(sizeof(struct camera_device), GFP_KERNEL);
-	if (!cam) {
-		dev_err(&cam->dev, "could not allocate memory\n");
-		status = -ENOMEM;
-		goto err0;
-	}
+	/* We already have a slave. */
+	if (cam->sdev)
+		return -EBUSY;
 
-	/* Save the pointer to camera device in a global variable */
-	camera_dev = cam;
+	cam->sdev = s;
+
+	if (device_create_file(cam->dev, &dev_attr_streaming) != 0) {
+		dev_err(cam->dev, "could not register sysfs entry\n");
+		rval = -EBUSY;
+		goto err;
+	}
 
 	/* initialize the video_device struct */
 	vfd = cam->vfd = video_device_alloc();
 	if (!vfd) {
-		dev_err(&cam->dev, " could not allocate video device struct\n");
-		status = -ENOMEM;
-		goto err1;
+		dev_err(cam->dev, " could not allocate video device struct\n");
+		rval = -ENOMEM;
+		goto err;
 	}
 
 	vfd->release = video_device_release;
@@ -959,6 +1093,74 @@ static int __init camera_core_probe(struct platform_device *pdev)
 	vfd->vidioc_s_fbuf = vidioc_s_fbuf;
 	vfd->vidioc_overlay = vidioc_overlay;
 
+
+	dev_info(cam->dev, "%s interface with %s sensor\n",
+		cam->cam_hardware->name, cam->sdev->name);
+
+	if (video_register_device(vfd, VFL_TYPE_GRABBER, video_nr) < 0) {
+		dev_err(cam->dev, "could not register Video for Linux device\n");
+		rval = -ENODEV;
+		goto err;
+	}
+
+
+	rval = camera_sensor_init(cam);
+	if (rval)
+		goto err;
+
+	/* Disable the Camera after detection */
+	cam->cam_hardware->disable(cam->hardware_data);
+
+	return 0;
+
+err:
+	camera_device_unregister(ctl);
+
+	return rval;
+}
+
+static struct v4l2_int_master camera_master = {
+	.attach = camera_device_register,
+	.detach = camera_device_unregister,
+};
+
+static struct v4l2_int_device camera = {
+	.module	= THIS_MODULE,
+	.name	= CAM_NAME,
+	.type	= v4l2_int_type_master,
+	.u	= {
+		.master = &camera_master
+	},
+};
+
+static int __init camera_core_probe(struct platform_device *pdev)
+{
+	struct camera_device *cam;
+	int	status = 0;
+
+	cam = kzalloc(sizeof(struct camera_device), GFP_KERNEL);
+	if (!cam) {
+		dev_err(&pdev->dev, "could not allocate memory\n");
+		status = -ENOMEM;
+		goto err;
+	}
+
+	platform_set_drvdata(pdev, cam);
+
+	cam->dev = &pdev->dev;
+
+	/* initialize the camera interface */
+	cam->cam_hardware = &camera_hardware_if;
+	cam->hardware_data = cam->cam_hardware->init();
+	if (!cam->hardware_data) {
+		dev_err(cam->dev, "cannot initialize interface hardware\n");
+		status = -ENODEV;
+		goto err;
+	}
+
+	/* Save the pointer to camera device in a global variable */
+	camera_dev = cam;
+
 	/* initialize the videobuf queue ops */
 	cam->vbq_ops.buf_setup = camera_core_vbq_setup;
 	cam->vbq_ops.buf_prepare = camera_core_vbq_prepare;
@@ -973,102 +1175,38 @@ static int __init camera_core_probe(struct platform_device *pdev)
 					(dma_addr_t *) &cam->overlay_base_phys,
 					GFP_KERNEL | GFP_DMA);
 		if (!cam->overlay_base) {
-			dev_err(&cam->dev, "cannot allocate overlay framebuffer\n");
+			dev_err(cam->dev, "cannot allocate overlay framebuffer\n");
 			status = -ENOMEM;
-			goto err2;
+			goto err;
 		}
 	}
 	memset((void*)cam->overlay_base, 0, cam->overlay_size);
 	spin_lock_init(&cam->overlay_lock);
 	spin_lock_init(&cam->capture_lock);
 
-	/*Initialise the pointer to the sensor interface and camera interface */
-	cam->cam_sensor = &camera_sensor_if;
-	cam->cam_hardware = &camera_hardware_if;
-
-	/* initialize the camera interface */
-	cam->hardware_data = cam->cam_hardware->init();
-	if (!cam->hardware_data) {
-		dev_err(&cam->dev, "cannot initialize interface hardware\n");
-		status = -ENODEV;
-		goto err3;
-	}
-
 	/* initialize the spinlock used to serialize access to the image
 	 * parameters
 	 */
 	spin_lock_init(&cam->img_lock);
 
-	/* initialize the streaming capture parameters */
-	cam->cparm.capability = V4L2_CAP_TIMEPERFRAME;
-	cam->cparm.readbuffers = 1;
-
-	/* Enable the xclk output.  The sensor may (and does, in the case of
-	 * the OV9640) require an xclk input in order for its initialization
-	 * routine to work.
-	 */
-	cam->xclk = 21000000;	/* choose an arbitrary xclk frequency */
-	cam->xclk = cam->cam_hardware->set_xclk(cam->xclk, cam->hardware_data);
-
-	/* initialize the sensor and define a default capture format cam->pix */
-	cam->sensor_data = cam->cam_sensor->init(&cam->pix);
-	if (!cam->sensor_data) {
-		cam->cam_hardware->disable(cam->hardware_data);
-		dev_err(&cam->dev, "cannot initialize sensor\n");
-		status = -ENODEV;
-		goto err4;
-	}
-
-	dev_info(&cam->dev, "%s interface with %s sensor\n",
-		cam->cam_hardware->name, cam->cam_sensor->name);
-
-	/* select an arbitrary default capture frame rate of 15fps */
-	cam->nominal_timeperframe.numerator = 1;
-	cam->nominal_timeperframe.denominator = 15;
-
-	/* calculate xclk based on the default capture format and default
-	 * frame rate
-	 */
-	cam->xclk = cam->cam_sensor->calc_xclk(&cam->pix,
-		&cam->nominal_timeperframe, cam->sensor_data);
-	cam->cparm.timeperframe = cam->nominal_timeperframe;
-
 	/* initialise the wait queue */
 	init_waitqueue_head(&cam->new_video_frame);
 
 	/* Initialise the DMA structures */
 	camera_core_sgdma_init(cam);
 
-	/* Disable the Camera after detection */
-	cam->cam_hardware->disable(cam->hardware_data);
-
 	platform_set_drvdata(pdev, cam);
 
-	if (video_register_device(vfd, VFL_TYPE_GRABBER, video_nr) < 0) {
-		dev_err(&cam->dev, "could not register Video for Linux device\n");
-		status = -ENODEV;
-		goto err5;
-	}
+	camera.priv = cam;
 
-	dev_info(&cam->dev, "registered device video%d [v4l2]\n", vfd->minor);
+	if (v4l2_int_device_register(&camera))
+		goto err;
 
 	return 0;
 
- err5:
-	cam->cam_sensor->cleanup(cam->sensor_data);
- err4:
-	cam->cam_hardware->cleanup(cam->hardware_data);
- err3:
-	dma_free_coherent(NULL, cam->overlay_size,
-				(void *)cam->overlay_base,
-				cam->overlay_base_phys);
+ err:
+	vidioc_int_dev_exit(cam->sdev);
 	cam->overlay_base = 0;
- err2:
-	video_device_release(vfd);
- err1:
-	kfree(cam);
-	camera_dev = NULL;
- err0:
 	return status;
 }
 
@@ -1100,7 +1238,7 @@ static int camera_core_remove(struct platform_device *pdev)
 	}
 	cam->overlay_base_phys = 0;
 
-	cam->cam_sensor->cleanup(cam->sensor_data);
+	vidioc_int_dev_exit(cam->sdev);
 	cam->cam_hardware->cleanup(cam->hardware_data);
 	kfree(cam);
 	camera_dev = NULL;
diff --git a/drivers/media/video/omap/camera_core.h b/drivers/media/video/omap/camera_core.h
index a300d67..e156cc3 100644
--- a/drivers/media/video/omap/camera_core.h
+++ b/drivers/media/video/omap/camera_core.h
@@ -19,6 +19,7 @@ struct camera_fh;
 
 #include <media/video-buf.h>
 #include <asm/scatterlist.h>
+#include <media/v4l2-int-device.h>
 
 struct camera_device;
 typedef void (*dma_callback_t)(void *arg1, void *arg2);
@@ -39,7 +40,7 @@ struct sgdma_state {
 
 /* per-device data structure */
 struct camera_device {
-	struct device dev;
+	struct device *dev;
 	struct video_device *vfd;
 
 	spinlock_t overlay_lock;        /* spinlock for overlay DMA counter */
@@ -80,18 +81,18 @@ struct camera_device {
 	 */
 	struct camera_fh *previewing;
 
-	/* capture parameters (frame rate, number of buffers) */
-	struct v4l2_captureparm cparm;
-
-	/* This is the frame period actually requested by the user. */
-	struct v4l2_fract nominal_timeperframe;
-
-	/* frequency (in Hz) of camera interface xclk output */
-	unsigned long xclk;
-
+	/*
+	 * Sensor interface parameters: interface type, CC_CTRL
+	 * register value and interface specific data.
+	 */
+	int if_type;
+	union {
+		struct parallel {
+			u32 xclk;
+		} bt656;
+	} if_u;
 	/* Pointer to the sensor interface ops */
-	struct omap_camera_sensor *cam_sensor;
-	void *sensor_data;
+	struct v4l2_int_device *sdev;
 
 	/* Pointer to the camera interface hardware ops */
 	struct camera_hardware *cam_hardware;
@@ -104,7 +105,6 @@ struct camera_device {
 	 * VIDIOC_S_FMT/VIDIOC_G_FMT ioctls with a CAPTURE buffer type.
 	 */
 	struct v4l2_pix_format pix;
-	struct v4l2_pix_format pix2;
 
 	/* crop defines the size and offset of the video overlay source window
 	 * within the framebuffer.  These parameters are set/queried by the
-- 
1.5.3.4.206.g58ba4

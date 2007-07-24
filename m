From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [PATCH] OMAP VIDEO: Convert printk to dev_{dbg,err,info} macros
Date: Tue, 24 Jul 2007 14:28:08 -0400
Message-ID: <11853016943744-git-send-email-felipe.lima@indt.org.br>
References: <11853016883587-git-send-email-felipe.lima@indt.org.br>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11853016883587-git-send-email-felipe.lima@indt.org.br>
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

Use dev_* macros instead of direct printks. Better readability
for camera_core.c

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---
 drivers/media/video/omap/camera_core.c |   38 +++++++++++++------------------
 1 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/media/video/omap/camera_core.c b/drivers/media/video/omap/camera_core.c
index 669c472..dcf3f6d 100644
--- a/drivers/media/video/omap/camera_core.c
+++ b/drivers/media/video/omap/camera_core.c
@@ -69,7 +69,7 @@ camera_core_callback_sgdma(void *arg1, void *arg2)
 	if (!sgdma->queued_sglist)
 	{
 		spin_unlock(&cam->sg_lock);
-		printk(KERN_ERR CAM_NAME ": SGDMA completed when none queued\n");
+		dev_err(&cam->dev, "SGDMA completed when none queued\n");
 		return;
 	}
 	if (!--sgdma->queued_sglist) {
@@ -384,8 +384,7 @@ camera_core_vbq_queue(struct videobuf_queue *q, struct videobuf_buffer *vb)
 		* scatter-gather DMA slots as video buffers so that can't
 		* happen.
 		*/
-		printk(KERN_DEBUG CAM_NAME
-			": Failed to queue a video buffer for SGDMA\n");
+		dev_dbg(&cam->dev, "Failed to queue a video buffer for SGDMA\n");
 		vb->state = state;
 	}
 }
@@ -754,8 +753,7 @@ camera_core_read(struct file *file, char *data, size_t count, loff_t *ppos)
 				GFP_KERNEL | GFP_DMA);
 	}
 	if (!cam->capture_base) {
-		printk(KERN_ERR CAM_NAME
-			": cannot allocate capture buffer\n");
+		dev_err(&cam->dev, "cannot allocate capture buffer\n");
 		return 0;
 	}
 
@@ -776,7 +774,7 @@ camera_core_read(struct file *file, char *data, size_t count, loff_t *ppos)
 		timeout = interruptible_sleep_on_timeout
 				(&cam->new_video_frame, timeout);
 		if (timeout == 0) {
-			printk(KERN_ERR CAM_NAME ": timeout waiting video frame\n");
+			dev_err(&cam->dev, "timeout waiting video frame\n");
 			return -EIO; /* time out */
 		}
 	}
@@ -862,7 +860,7 @@ camera_core_open(struct inode *inode, struct file *file)
 
 	spin_lock(&cam->img_lock);
 	if (cam->active == 1) {
-		printk (KERN_ERR CAM_NAME ": Camera device Active\n");
+		dev_err(&cam->dev, "Camera device Active\n");
 		spin_unlock(&cam->img_lock);
 		return -EPERM;
 	}
@@ -877,17 +875,17 @@ camera_core_open(struct inode *inode, struct file *file)
 
 	if (cam->cam_hardware->open(cam->hardware_data))
 	{
-		printk (KERN_ERR CAM_NAME ": Camera IF configuration failed\n");
+		dev_err(&cam->dev, "Camera IF configuration failed\n");
 		cam->active = 0;
 		return -ENODEV;
 	}
 
 	cam->xclk = cam->cam_hardware->set_xclk(cam->xclk, cam->hardware_data);
 	/* program the sensor for the capture format and rate */
-	if (cam->cam_sensor->configure(&cam->pix, cam->xclk, 
+	if (cam->cam_sensor->configure(&cam->pix, cam->xclk,
 				&cam->cparm.timeperframe, cam->sensor_data))
 	{
-		printk (KERN_ERR CAM_NAME ": Camera sensor configuration failed\n");
+		dev_err(&cam->dev, "Camera sensor configuration failed\n");
 		cam->cam_hardware->close(cam->hardware_data);
 		cam->active = 0;
 		return -ENODEV;
@@ -955,7 +953,7 @@ static int __init camera_core_probe(struct platform_device *pdev)
 
 	cam = kzalloc(sizeof(struct camera_device), GFP_KERNEL);
 	if (!cam) {
-		printk(KERN_ERR CAM_NAME ": could not allocate memory\n");
+		dev_err(&cam->dev, "could not allocate memory\n");
 		status = -ENOMEM;
 		goto err0;
 	}
@@ -966,8 +964,7 @@ static int __init camera_core_probe(struct platform_device *pdev)
 	/* initialize the video_device struct */
 	vfd = cam->vfd = video_device_alloc();
 	if (!vfd) {
-		printk(KERN_ERR CAM_NAME 
-			": could not allocate video device struct\n");
+		dev_err(&cam->dev, " could not allocate video device struct\n");
 		status = -ENOMEM;
 		goto err1;
 	}
@@ -998,8 +995,7 @@ static int __init camera_core_probe(struct platform_device *pdev)
 					(dma_addr_t *) &cam->overlay_base_phys,
 					GFP_KERNEL | GFP_DMA);
 		if (!cam->overlay_base) {
-			printk(KERN_ERR CAM_NAME
-				": cannot allocate overlay framebuffer\n");
+			dev_err(&cam->dev, "cannot allocate overlay framebuffer\n");
 			status = -ENOMEM;
 			goto err2;
 		}
@@ -1015,7 +1011,7 @@ static int __init camera_core_probe(struct platform_device *pdev)
 	/* initialize the camera interface */
 	cam->hardware_data = cam->cam_hardware->init();
 	if (!cam->hardware_data) {
-		printk(KERN_ERR CAM_NAME ": cannot initialize interface hardware\n");
+		dev_err(&cam->dev, "cannot initialize interface hardware\n");
 		status = -ENODEV;
 		goto err3;
 	}
@@ -1040,12 +1036,12 @@ static int __init camera_core_probe(struct platform_device *pdev)
 	cam->sensor_data = cam->cam_sensor->init(&cam->pix);
 	if (!cam->sensor_data) {
 		cam->cam_hardware->disable(cam->hardware_data);
-		printk(KERN_ERR CAM_NAME ": cannot initialize sensor\n");
+		dev_err(&cam->dev, "cannot initialize sensor\n");
 		status = -ENODEV;
 		goto err4;
 	}
 
-	printk(KERN_INFO CAM_NAME ": %s interface with %s sensor\n",
+	dev_info(&cam->dev, "%s interface with %s sensor\n",
 		cam->cam_hardware->name, cam->cam_sensor->name);
 
 	/* select an arbitrary default capture frame rate of 15fps */
@@ -1071,14 +1067,12 @@ static int __init camera_core_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, cam);
 
 	if (video_register_device(vfd, VFL_TYPE_GRABBER, video_nr) < 0) {
-		printk(KERN_ERR CAM_NAME
-			": could not register Video for Linux device\n");
+		dev_err(&cam->dev, "could not register Video for Linux device\n");
 		status = -ENODEV;
 		goto err5;
 	}
 
-	printk(KERN_INFO CAM_NAME
-	       ": registered device video%d [v4l2]\n", vfd->minor);
+	dev_info(&cam->dev, "registered device video%d [v4l2]\n", vfd->minor);
 
 	return 0;
 
-- 
1.5.3.rc2.29.gc4640f

From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] OMAP1: camera core : Use platform driver structure
Date: Thu, 23 Feb 2006 04:53:12 -0800 (PST)
Message-ID: <20060223125312.64171.qmail@web32913.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1288171005-1140699192=:63068"
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

--0-1288171005-1140699192=:63068
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Jian/David,

Attached patch uses the platform driver structure and introduced probe
and remove function from init and cleanup. It builds for H2, but unable
to test as not having H2 board access.

Please review it and if possible test it.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1288171005-1140699192=:63068
Content-Type: text/x-patch; name="camplatform.patch"
Content-Description: 2437325919-camplatform.patch
Content-Disposition: inline; filename="camplatform.patch"

diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
diff --git a/drivers/media/video/omap/camera_core.c b/drivers/media/video/omap/camera_core.c
index 12c1fd1..f5f916d 100644
--- a/drivers/media/video/omap/camera_core.c
+++ b/drivers/media/video/omap/camera_core.c
@@ -914,9 +914,9 @@ camera_core_open(struct inode *inode, st
 }
 
 #ifdef CONFIG_PM
-static int camera_core_suspend(struct device *dev, pm_message_t state)
+static int camera_core_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	struct camera_device *cam = dev_get_drvdata(dev);
+	struct camera_device *cam = platform_get_drvdata(pdev);
 	int ret = 0;
 
 	spin_lock(&cam->img_lock);
@@ -925,12 +925,13 @@ static int camera_core_suspend(struct de
 	}
 	cam->cam_sensor->power_off(cam->sensor_data);
 	spin_unlock(&cam->img_lock);
+
 	return ret;
 }
 
-static int camera_core_resume(struct device *dev)
+static int camera_core_resume(struct platform_device *pdev)
 {
-	struct camera_device *cam = dev_get_drvdata(dev);
+	struct camera_device *cam = platform_get_drvdata(pdev);
 	int ret = 0;
 
 	spin_lock(&cam->img_lock);
@@ -946,7 +947,7 @@ static int camera_core_resume(struct dev
 		camera_core_sgdma_process(cam);
 	}
 	spin_unlock(&cam->img_lock);
-
+	
 	return ret;
 }
 #endif	/* CONFIG_PM */
@@ -963,90 +964,29 @@ static struct file_operations camera_cor
 	.release		= camera_core_release,
 };
 
-static struct device_driver camera_core_driver = {
-	.name			= CAM_NAME,
-	.bus			= &platform_bus_type,
-	.probe			= NULL,
-	.remove			= NULL,
-#ifdef CONFIG_PM
-	.suspend		= camera_core_suspend,
-	.resume			= camera_core_resume,
-#endif
-	.shutdown		= NULL,
-};
-
-static struct platform_device camera_core_device = {
-	.name	= CAM_NAME,
-	.dev	= {
-			.release 	= NULL,
-		  },
-	.id	= 0,
-};
-
-void
-camera_core_cleanup(void)
-{
-	struct camera_device *cam = camera_dev;
-	struct video_device *vfd;
-
-	if (!cam)
-		return;
-
-	vfd = cam->vfd;
-	if (vfd) {
-		if (vfd->minor == -1) {
-			/* The device never got registered, so release the 
-			** video_device struct directly
-			*/
-			video_device_release(vfd);
-		} else {
-			/* The unregister function will release the video_device
-			** struct as well as unregistering it.
-			*/
-			video_unregister_device(vfd);
-			driver_unregister(&camera_core_driver);
-			platform_device_unregister(&camera_core_device);
-		}
-		cam->vfd = NULL;
-	}
-	if (cam->overlay_base) {
-		dma_free_coherent(NULL, cam->overlay_size,
-					(void *)cam->overlay_base, 
-					cam->overlay_base_phys);
-		cam->overlay_base = 0;
-	}	
-	cam->overlay_base_phys = 0;
-
-	cam->cam_sensor->cleanup(cam->sensor_data);
-	cam->cam_hardware->cleanup(cam->hardware_data);
-	kfree(cam);
-	camera_dev = NULL;
-
-	return;
-}
-
-
-int __init 
-camera_core_init(void)
+static int __init camera_core_probe(struct platform_device *pdev)
 {
 	struct camera_device *cam;
 	struct video_device *vfd;
+	int	status;
 
 	cam = kzalloc(sizeof(struct camera_device), GFP_KERNEL);
 	if (!cam) {
 		printk(KERN_ERR CAM_NAME ": could not allocate memory\n");
-		goto init_error;
+		status = -ENOMEM;
+		goto err0;
 	}
-	
+
 	/* Save the pointer to camera device in a global variable */
 	camera_dev = cam;
-
+	
 	/* initialize the video_device struct */
 	vfd = cam->vfd = video_device_alloc();
 	if (!vfd) {
 		printk(KERN_ERR CAM_NAME 
 			": could not allocate video device struct\n");
-		goto init_error;
+		status = -ENOMEM;
+		goto err1;
 	}
 	
  	vfd->release = video_device_release;
@@ -1077,7 +1017,8 @@ camera_core_init(void)
 		if (!cam->overlay_base) {
 			printk(KERN_ERR CAM_NAME
 				": cannot allocate overlay framebuffer\n");
-			goto init_error;
+			status = -ENOMEM;
+			goto err2;
 		}
 	}
 	memset((void*)cam->overlay_base, 0, cam->overlay_size);
@@ -1092,7 +1033,8 @@ camera_core_init(void)
 	cam->hardware_data = cam->cam_hardware->init();
 	if (!cam->hardware_data) {
 		printk(KERN_ERR CAM_NAME ": cannot initialize interface hardware\n");
-		goto init_error;
+		status = -ENODEV;
+		goto err3;
 	}
  	 
 	/* initialize the spinlock used to serialize access to the image 
@@ -1116,7 +1058,8 @@ camera_core_init(void)
 	if (!cam->sensor_data) {
 		cam->cam_hardware->disable(cam->hardware_data);
 		printk(KERN_ERR CAM_NAME ": cannot initialize sensor\n");
-		goto init_error;
+		status = -ENODEV;
+		goto err4;
 	}
 
 	printk(KERN_INFO CAM_NAME ": %s interface with %s sensor\n",
@@ -1141,35 +1084,116 @@ camera_core_init(void)
 
 	/* Disable the Camera after detection */
 	cam->cam_hardware->disable(cam->hardware_data);
-
-	dev_set_drvdata(&camera_core_device.dev, (void *)cam);
-	if (platform_device_register(&camera_core_device) < 0) {
-		printk(KERN_ERR CAM_NAME
-			": could not register platform_device\n");
-		goto init_error;
-	}
-
-	if (driver_register(&camera_core_driver) < 0) {
-		printk(KERN_ERR CAM_NAME
-			": could not register driver\n");
-		platform_device_unregister(&camera_core_device);
-		goto init_error;
-	}
+	
+	platform_set_drvdata(pdev, cam);
+	
 	if (video_register_device(vfd, VFL_TYPE_GRABBER, video_nr) < 0) {
 		printk(KERN_ERR CAM_NAME 
 			": could not register Video for Linux device\n");
-		platform_device_unregister(&camera_core_device);
-		driver_unregister(&camera_core_driver);
-		goto init_error;
+		status = -ENODEV;
+		goto err5;
 	}
 
 	printk(KERN_INFO CAM_NAME 
-		": registered device video%d [v4l2]\n", vfd->minor);
+	       ": registered device video%d [v4l2]\n", vfd->minor);
+
 	return 0;
 
-init_error:
-	camera_core_cleanup();
-	return -ENODEV;
+ err5:
+	cam->cam_sensor->cleanup(cam->sensor_data);
+ err4:
+	cam->cam_hardware->cleanup(cam->hardware_data);
+ err3:
+	dma_free_coherent(NULL, cam->overlay_size,
+				(void *)cam->overlay_base, 
+				cam->overlay_base_phys);
+	cam->overlay_base = 0;
+ err2:
+	video_device_release(vfd);
+ err1:
+	kfree(cam);
+	camera_dev = NULL;
+ err0:
+	return status;
+}
+
+static int camera_core_remove(struct platform_device *pdev)
+{
+	struct camera_device *cam = platform_get_drvdata(pdev);
+	struct video_device *vfd;
+
+	vfd = cam->vfd;
+	if (vfd) {
+		if (vfd->minor == -1) {
+			/* The device never got registered, so release the 
+			** video_device struct directly
+			*/
+			video_device_release(vfd);
+		} else {
+			/* The unregister function will release the video_device
+			** struct as well as unregistering it.
+			*/
+			video_unregister_device(vfd);
+		}
+		cam->vfd = NULL;
+	}
+	if (cam->overlay_base) {
+		dma_free_coherent(NULL, cam->overlay_size,
+					(void *)cam->overlay_base, 
+					cam->overlay_base_phys);
+		cam->overlay_base = 0;
+	}	
+	cam->overlay_base_phys = 0;
+
+	cam->cam_sensor->cleanup(cam->sensor_data);
+	cam->cam_hardware->cleanup(cam->hardware_data);
+	kfree(cam);
+	camera_dev = NULL;
+
+	return 0;
+}
+
+static struct platform_driver camera_core_driver = {
+	.driver = {
+		.name		= CAM_NAME,
+		.owner		= THIS_MODULE,
+	},
+	.probe			= camera_core_probe,
+	.remove			= camera_core_remove,
+#ifdef CONFIG_PM
+	.suspend		= camera_core_suspend,
+	.resume			= camera_core_resume,
+#endif
+};
+
+static struct platform_device camera_core_device = {
+	.name	= CAM_NAME,
+	.dev	= {
+			.release 	= NULL,
+		  },
+	.id	= 0,
+};
+
+void __exit
+camera_core_cleanup(void)
+{
+	platform_driver_unregister(&camera_core_driver);
+	platform_device_unregister(&camera_core_device);
+
+	return;
+}
+
+static char banner[] __initdata = KERN_INFO "OMAP Camera driver initialzing\n";
+
+int __init 
+camera_core_init(void)
+{
+
+	printk(banner);
+	platform_device_register(&camera_core_device);
+	platform_driver_register(&camera_core_driver);
+
+	return 0;
 }
 
 MODULE_AUTHOR("Texas Instruments.");
@@ -1185,4 +1209,3 @@ MODULE_PARM_DESC(capture_mem,
 module_init(camera_core_init);
 module_exit(camera_core_cleanup);
 
-

--0-1288171005-1140699192=:63068
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-1288171005-1140699192=:63068--

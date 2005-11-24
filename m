From: David Cohen <david.cohen@indt.org.br>
Subject: camera: omap24xxcam.c with device model
Date: Thu, 24 Nov 2005 14:09:31 -0400
Message-ID: <438601DB.6040307@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010803090407070708070900"
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
To: "Linux-omap-open-source@linux.omap.com" <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------010803090407070708070900
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

sorry... the patch :)

David


--------------010803090407070708070900
Content-Type: text/plain;
 name="diff_omap24xxcam_devmodel"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff_omap24xxcam_devmodel"

--- ../linux-ti/linux/drivers/media/video/omap/omap24xxcam.c	2004-11-09 00:01:51.000000000 -0400
+++ drivers/media/video/omap/omap24xxcam.c	2005-11-24 13:52:23.000000000 -0400
@@ -37,6 +37,8 @@
 #include <linux/dma-mapping.h>
 #include <linux/device.h>
 #include <linux/input.h>
+#include <linux/version.h>
+#include <linux/platform_device.h>
 
 #include <asm/io.h>
 #include <asm/byteorder.h>
@@ -44,7 +46,6 @@
 #include <asm/irq.h>
 #include <asm/semaphore.h>
 #include <asm/processor.h>
-#include <asm/arch/bus.h>
 
 #include "omap24xxcam.h"
 
@@ -57,6 +58,10 @@
 /* configuration macros */
 #define CAM_NAME "omap24xxcam"
 #define CONFIG_H4
+
+/* Should be moved from here */
+#define INT_CAM_MPU_IRQ 24
+
 extern struct camera_sensor camera_sensor_if;
 
 void omap24xxcam_cleanup(void);
@@ -2689,9 +2694,9 @@
 };
 
 /* -------------------------------------------------------------------------- */
-static int omap24xxcam_suspend(struct omap_dev *dev, u32 state)
+static int omap24xxcam_suspend(struct device *dev, u32 state)
 {
-	struct omap24xxcam_device *cam = omap_get_drvdata(dev);
+	struct omap24xxcam_device *cam = dev_get_drvdata(dev);
 
 	/* disable previewing */
 	spin_lock(&cam->img_lock);
@@ -2721,9 +2726,9 @@
 
 	return 0;	
 }
-static int omap24xxcam_resume(struct omap_dev *dev)
+static int omap24xxcam_resume(struct device *dev)
 {
-	struct omap24xxcam_device *cam = omap_get_drvdata(dev);
+	struct omap24xxcam_device *cam = dev_get_drvdata(dev);
 	/* power up the sensor */
 	cam->cam_sensor->power_on(cam->sensor);
 	
@@ -2747,55 +2752,10 @@
 
 	return 0;
 }
-static int omap24xxcam_probe (struct omap_dev *dev)
-{
-	return 0;
-}
-
-static void 
-omap_24xxcam_release(struct device *dev)
-{
-}
-static struct omap_dev omap24xxcam_dev = {
-	.name		= CAM_NAME,
-	.devid		= OMAP24xx_CAM_DEVID,
-	.dev		= {
-				.release = omap_24xxcam_release,
-				},
-	.busid		= OMAP_BUS_L3,
-	.irq		= {
-				INT_CAM_MPU_IRQ,
-			  },
-		
-};
-
-static struct omap_driver omap24xxcam_driver = {
-	.drv = {
-		.name		= CAM_NAME,
-	       },
-	.devid		= OMAP24xx_CAM_DEVID,
-	.busid		= OMAP_BUS_L3,
-	.clocks		= 0,
-	.probe		= omap24xxcam_probe,
-	.suspend	= omap24xxcam_suspend,
-	.resume		= omap24xxcam_resume,
-};
- 
-int __init 
-omap24xxcam_init(void)
+static int omap24xxcam_probe (struct device *dev)
 {
 	struct omap24xxcam_device *cam;
 	struct video_device *vfd;
-	int ret;
-
-	ret = omap_driver_register(&omap24xxcam_driver);
-	if (ret != 0)
-		return ret;
-	ret = omap_device_register(&omap24xxcam_dev);
-	if ( ret != 0) {
-		omap_driver_unregister(&omap24xxcam_driver);
-		return ret;
-	}
 
 	cam = kmalloc(sizeof(struct omap24xxcam_device), GFP_KERNEL);
 	if (!cam) {
@@ -2990,7 +2950,7 @@
 		goto init_error;
 	}
 	/* set driver specific data to use in power management functions */
-	omap_set_drvdata(&omap24xxcam_dev, cam);
+	dev_set_drvdata(dev, cam);
 
 	printk(KERN_INFO CAM_NAME 
 		": registered device video%d [v4l2]\n", vfd->minor);
@@ -3021,6 +2981,76 @@
 	return -ENODEV;
 }
 
+static void 
+omap_24xxcam_release(struct device *dev)
+{
+}
+
+#if 0
+static struct omap_dev omap24xxcam_dev = {
+	.name		= CAM_NAME,
+	.devid		= OMAP24xx_CAM_DEVID,
+	.dev		= {
+				.release = omap_24xxcam_release,
+				},
+	.busid		= OMAP_BUS_L3,
+	.irq		= {
+				INT_CAM_MPU_IRQ,
+			  },
+		
+};
+
+static struct omap_driver omap24xxcam_driver = {
+	.drv = {
+		.name		= CAM_NAME,
+	       },
+	.devid		= OMAP24xx_CAM_DEVID,
+	.busid		= OMAP_BUS_L3,
+	.clocks		= 0,
+	.probe		= omap24xxcam_probe,
+	.suspend	= omap24xxcam_suspend,
+	.resume		= omap24xxcam_resume,
+};
+#endif
+
+static struct device_driver omap24xxcam_driver = {
+	.name		= CAM_NAME,
+	.bus		= &platform_bus_type,
+	.probe		= omap24xxcam_probe,
+	.remove		= omap24xxcam_release,
+#ifdef CONFIG_PM
+	.suspend	= omap24xxcam_suspend,
+	.resume		= omap24xxcam_resume,
+#endif
+	.shutdown	= NULL,
+};
+
+static struct platform_device omap24xxcam_dev = {
+	.name		= CAM_NAME,
+	.dev		=
+	{
+		.release	= NULL,
+	},
+	.id		= 0,
+};
+ 
+int __init 
+omap24xxcam_init(void)
+{
+	int ret;
+
+	ret = driver_register(&omap24xxcam_driver);
+	if (ret != 0)
+		return ret;
+	ret = platform_device_register(&omap24xxcam_dev);
+	if ( ret != 0) {
+		driver_unregister(&omap24xxcam_driver);
+		return ret;
+	}
+
+	return 0;
+}
+
 void
 omap24xxcam_cleanup(void)
 {
@@ -3086,8 +3116,8 @@
 		cam->cam_mmio_base_phys = 0;
 	}
 
-	omap_device_unregister(&omap24xxcam_dev);
-	omap_driver_unregister(&omap24xxcam_driver);
+	platform_device_unregister(&omap24xxcam_dev);
+	driver_unregister(&omap24xxcam_driver);
 
 	kfree(cam);
 	saved_cam = NULL;

--------------010803090407070708070900
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source

--------------010803090407070708070900--

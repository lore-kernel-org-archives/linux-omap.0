From: David Cohen <david.cohen@indt.org.br>
Subject: camera: a compilable omap24xxcam.c
Date: Thu, 24 Nov 2005 15:31:26 -0400
Message-ID: <4386150E.1050708@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090406030208020909030204"
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
--------------090406030208020909030204
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,

Here a compilable omap24xxcam.c :) While the new version are coming, we
can use this. If anyone could test it too, will be good...

Regards,

David

--------------090406030208020909030204
Content-Type: text/plain;
 name="diff_omap24xxcam"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff_omap24xxcam"

--- ../linux-ti/linux/drivers/media/video/omap/omap24xxcam.c	2004-11-09 00:01:51.000000000 -0400
+++ drivers/media/video/omap/omap24xxcam.c	2005-11-24 15:24:49.000000000 -0400
@@ -12,6 +12,10 @@
  * This file is licensed under the terms of the GNU General Public License 
  * version 2. This program is licensed "as is" without any warranty of any 
  * kind, whether express or implied.
+ *
+ * History:
+ * 2005/nov - David Cohen <david.cohen@indt.org.br>
+ *            Updated the driver for the Linux Device Model and new version of V4L2.
  */
 
 #include <linux/config.h>
@@ -37,6 +41,8 @@
 #include <linux/dma-mapping.h>
 #include <linux/device.h>
 #include <linux/input.h>
+#include <linux/version.h>
+#include <linux/platform_device.h>
 
 #include <asm/io.h>
 #include <asm/byteorder.h>
@@ -44,7 +50,6 @@
 #include <asm/irq.h>
 #include <asm/semaphore.h>
 #include <asm/processor.h>
-#include <asm/arch/bus.h>
 
 #include "omap24xxcam.h"
 
@@ -57,6 +62,10 @@
 /* configuration macros */
 #define CAM_NAME "omap24xxcam"
 #define CONFIG_H4
+
+/* Should be moved from here */
+#define INT_CAM_MPU_IRQ 24
+
 extern struct camera_sensor camera_sensor_if;
 
 void omap24xxcam_cleanup(void);
@@ -79,6 +88,8 @@
 */
 static int video2_mem = 320*240*2;
 
+static struct clk * cam_fck;
+
 /* -------------------------------------------------------------------------- */
 
 /* Set the value of the CC_CTRL register in cam->cc_ctrl that is required to 
@@ -1801,7 +1812,7 @@
 }
 
 static void
-omap24xxcam_vbq_release(struct file *file, struct videobuf_buffer *vb)
+omap24xxcam_vbq_release(struct videobuf_queue *vbq, struct videobuf_buffer *vb)
 {
 	videobuf_waiton(vb, 0, 0);
 	videobuf_dma_pci_unmap(NULL, &vb->dma);
@@ -1815,9 +1826,9 @@
  * amount of memory permitted for kernel capture buffers.
  */
 static int
-omap24xxcam_vbq_setup(struct file *file, unsigned int *cnt, unsigned int *size)
+omap24xxcam_vbq_setup(struct videobuf_queue *vbq, unsigned int *cnt, unsigned int *size)
 {
-	struct omap24xxcam_fh *fh = file->private_data;
+	struct omap24xxcam_fh *fh = vbq->priv_data;
 	struct omap24xxcam_device *cam = fh->cam;
 
 	if (*cnt <= 0)
@@ -1839,10 +1850,10 @@
 }
 
 static int
-omap24xxcam_vbq_prepare(struct file *file, struct videobuf_buffer *vb, 
+omap24xxcam_vbq_prepare(struct videobuf_queue *vbq, struct videobuf_buffer *vb, 
 	enum v4l2_field field)
 {
-	struct omap24xxcam_fh *fh = file->private_data;
+	struct omap24xxcam_fh *fh = vbq->priv_data;
 	struct omap24xxcam_device *cam = fh->cam;
 	int err = 0;
 
@@ -1867,7 +1878,7 @@
 				 * need to free and reallocate it.
 				 */
 				spin_unlock(&cam->img_lock);
-				omap24xxcam_vbq_release(file, vb);
+				omap24xxcam_vbq_release(vbq, vb);
 				spin_lock(&cam->img_lock);
 				vb->size = cam->pix.sizeimage;
 			}
@@ -1893,15 +1904,15 @@
 	if (!err)
 		vb->state = STATE_PREPARED;
 	else
-		omap24xxcam_vbq_release(file, vb);
+		omap24xxcam_vbq_release(vbq, vb);
 
 	return err;
 }
 
 static void
-omap24xxcam_vbq_queue(struct file *file, struct videobuf_buffer *vb)
+omap24xxcam_vbq_queue(struct videobuf_queue *vbq, struct videobuf_buffer *vb)
 {
-	struct omap24xxcam_fh *fh = file->private_data;
+	struct omap24xxcam_fh *fh = vbq->priv_data;
 	struct omap24xxcam_device *cam = fh->cam;
 	enum videobuf_state state = vb->state;
 	int err;
@@ -2356,16 +2367,16 @@
 		}
 
 		case VIDIOC_REQBUFS:
-			return videobuf_reqbufs(file, &fh->vbq, arg);
+			return videobuf_reqbufs(&fh->vbq, arg);
 
 		case VIDIOC_QUERYBUF:
 			return videobuf_querybuf(&fh->vbq, arg);
 
 		case VIDIOC_QBUF:
-			return videobuf_qbuf(file, &fh->vbq, arg);
+			return videobuf_qbuf(&fh->vbq, arg);
 
 		case VIDIOC_DQBUF:
-			return videobuf_dqbuf(file, &fh->vbq, arg);
+			return videobuf_dqbuf(&fh->vbq, arg, file->f_flags & O_NONBLOCK);
 
 		case VIDIOC_STREAMON:
 		{
@@ -2379,12 +2390,12 @@
 			spin_unlock(&cam->img_lock);
 
 			omap24xxcam_dma_notify(cam, omap24xxcam_cc_enable);
-			return videobuf_streamon(file, &fh->vbq);
+			return videobuf_streamon(&fh->vbq);
 		}
 
 		case VIDIOC_STREAMOFF:
 		{
-			err = videobuf_streamoff(file, &fh->vbq);
+			err = videobuf_streamoff(&fh->vbq);
 			if (err < 0)
 				return err;
 
@@ -2527,14 +2538,14 @@
 			}
 			fh->vbq.read_buf->memory = V4L2_MEMORY_USERPTR;
 			field = videobuf_next_field(&fh->vbq);
-			if (fh->vbq.ops->buf_prepare(file, fh->vbq.read_buf, 
+			if (fh->vbq.ops->buf_prepare(&fh->vbq, fh->vbq.read_buf, 
 				field) != 0)
 			{
 				up(&fh->vbq.lock);
 				return POLLERR;
 			}
 			
-			fh->vbq.ops->buf_queue(file, fh->vbq.read_buf);
+			fh->vbq.ops->buf_queue(&fh->vbq, fh->vbq.read_buf);
 			fh->vbq.read_off = 0;
 		}
 		up(&fh->vbq.lock);
@@ -2570,7 +2581,7 @@
 	** to capture the image pretending that we want to read one pixel
 	** less than the actual image size.
 	*/
-	err = videobuf_read_one(file, &fh->vbq, data, count - 2, ppos);
+	err = videobuf_read_one(&fh->vbq, data, count - 2, ppos, file->f_flags & O_NONBLOCK);
 
 	return err;
 }
@@ -2605,7 +2616,7 @@
 {
 	struct omap24xxcam_fh *fh = file->private_data;
 
-	return videobuf_mmap_mapper(vma, &fh->vbq);
+	return videobuf_mmap_mapper(&fh->vbq, vma);
 }
 
 static int
@@ -2634,14 +2645,14 @@
 	if (cam->streaming == fh) {
 		cam->streaming = NULL;
 		spin_unlock(&cam->img_lock);
-		videobuf_streamoff(file, &fh->vbq);
+		videobuf_streamoff(&fh->vbq);
 		spin_lock(&cam->img_lock);
 	}
 	spin_unlock(&cam->img_lock);
 
 	/* release read_buf videobuf_buffer struct */
 	if (fh->vbq.read_buf) {
-		omap24xxcam_vbq_release(file, fh->vbq.read_buf);
+		omap24xxcam_vbq_release(&fh->vbq, fh->vbq.read_buf);
 		kfree(fh->vbq.read_buf);
 	}
 
@@ -2670,7 +2681,7 @@
 	fh->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 
 	videobuf_queue_init(&fh->vbq, &cam->vbq_ops, NULL, &cam->vbq_lock, 
-		fh->type, V4L2_FIELD_NONE, sizeof(struct videobuf_buffer));
+		fh->type, V4L2_FIELD_NONE, sizeof(struct videobuf_buffer), fh);
 
 	return 0;
 }
@@ -2689,9 +2700,9 @@
 };
 
 /* -------------------------------------------------------------------------- */
-static int omap24xxcam_suspend(struct omap_dev *dev, u32 state)
+static int omap24xxcam_suspend(struct device *dev, u32 state)
 {
-	struct omap24xxcam_device *cam = omap_get_drvdata(dev);
+	struct omap24xxcam_device *cam = dev_get_drvdata(dev);
 
 	/* disable previewing */
 	spin_lock(&cam->img_lock);
@@ -2721,9 +2732,9 @@
 
 	return 0;	
 }
-static int omap24xxcam_resume(struct omap_dev *dev)
+static int omap24xxcam_resume(struct device *dev)
 {
-	struct omap24xxcam_device *cam = omap_get_drvdata(dev);
+	struct omap24xxcam_device *cam = dev_get_drvdata(dev);
 	/* power up the sensor */
 	cam->cam_sensor->power_on(cam->sensor);
 	
@@ -2747,55 +2758,10 @@
 
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
@@ -2919,6 +2885,8 @@
 
 	/* initialize the camera interface functional clock frequency */
 	cam->mclk = 96000000;	/* 96MHz */
+	cam_fck = clk_get(0, "cam_fck");
+	clk_use(cam_fck);
 
 	/* initialize the streaming capture parameters */
 	cam->cparm.readbuffers = 1;
@@ -2990,7 +2958,7 @@
 		goto init_error;
 	}
 	/* set driver specific data to use in power management functions */
-	omap_set_drvdata(&omap24xxcam_dev, cam);
+	dev_set_drvdata(dev, cam);
 
 	printk(KERN_INFO CAM_NAME 
 		": registered device video%d [v4l2]\n", vfd->minor);
@@ -3021,6 +2989,52 @@
 	return -ENODEV;
 }
 
+static int omap24xxcam_remove(struct device *dev)
+{
+	return 0;
+}
+
+static struct device_driver omap24xxcam_driver = {
+	.name		= CAM_NAME,
+	.bus		= &platform_bus_type,
+	.probe		= omap24xxcam_probe,
+	.remove		= omap24xxcam_remove,
+#ifdef CONFIG_PM
+	.suspend	= omap24xxcam_suspend,
+	.resume		= omap24xxcam_resume,
+#else
+	.suspend	= NULL,
+	.resume		= NULL,
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
@@ -3086,8 +3100,8 @@
 		cam->cam_mmio_base_phys = 0;
 	}
 
-	omap_device_unregister(&omap24xxcam_dev);
-	omap_driver_unregister(&omap24xxcam_driver);
+	platform_device_unregister(&omap24xxcam_dev);
+	driver_unregister(&omap24xxcam_driver);
 
 	kfree(cam);
 	saved_cam = NULL;

--------------090406030208020909030204
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source

--------------090406030208020909030204--

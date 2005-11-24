From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] camera: sensor cleanup
Date: Thu, 24 Nov 2005 04:10:31 -0800 (PST)
Message-ID: <20051124121032.13342.qmail@web32903.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1946700909-1132834231=:8489"
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

--0-1946700909-1132834231=:8489
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Jian/Tony,

Attached patch for
o sensor powerup/down cleanup
o camera build infrastructure
o kmalloc -> kzalloc 

looks good? 

Someone need to test this patch on H3. I have just tried building the
kernel for h3 and h2. I don't have access to H3. Sanjiv?

---Komal Shah
http://komalshah.blogspot.com/


		
__________________________________ 
Yahoo! Music Unlimited 
Access over 1 million songs. Try it free. 
http://music.yahoo.com/unlimited/
--0-1946700909-1132834231=:8489
Content-Type: text/plain; name="sensorclean.patch"
Content-Description: 3238187756-sensorclean.patch
Content-Disposition: inline; filename="sensorclean.patch"

diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
index 0c7f1e1..4208417 100644
--- a/drivers/media/video/Kconfig
+++ b/drivers/media/video/Kconfig
@@ -347,9 +347,6 @@ config VIDEO_DECODER
 	  Say Y here to compile drivers for SAA7115, SAA7127 and CX25840
 	  video  decoders.
 
-config VIDEO_OMAP_CAMERA
-	tristate "OMAP Video for Linux camera driver"
-	depends on VIDEO_DEV && ARCH_OMAP16XX
-	select VIDEO_BUF
+source drivers/media/video/omap/Kconfig
 
 endmenu
diff --git a/drivers/media/video/omap/Makefile b/drivers/media/video/omap/Makefile
index 1f6476a..bc46804 100644
--- a/drivers/media/video/omap/Makefile
+++ b/drivers/media/video/omap/Makefile
@@ -1,7 +1,13 @@
-# Makefile for camera driver for H2/H3
+# Makefile for OMAP1/2 camera driver
 
-omapCamera-objs :=  camera_core.o omap16xxcam.o sensor_ov9640.o  
+obj-$(CONFIG_VIDEO_OMAP_CAMERA) += omapcamera.o
+obj-$(CONFIG_VIDEO_CAMERA_SENSOR_OV9640) += sensor_ov9640.o
 
-obj-y += omapCamera.o
+objs-yy := camera_core.o
+
+objs-y$(CONFIG_ARCH_OMAP16XX) += omap16xxcam.o
+objs-y$(CONFIG_MACH_OMAP_H3) += h3_sensor_power.o
+
+omapcamera-objs := $(objs-yy) 
 
 EXTRA_CFLAGS = -I$(src)/..
diff --git a/drivers/media/video/omap/camera_core.c b/drivers/media/video/omap/camera_core.c
index e9e84b1..12c1fd1 100644
--- a/drivers/media/video/omap/camera_core.c
+++ b/drivers/media/video/omap/camera_core.c
@@ -1032,12 +1032,11 @@ camera_core_init(void)
 	struct camera_device *cam;
 	struct video_device *vfd;
 
-	cam = kmalloc(sizeof(struct camera_device), GFP_KERNEL);
+	cam = kzalloc(sizeof(struct camera_device), GFP_KERNEL);
 	if (!cam) {
 		printk(KERN_ERR CAM_NAME ": could not allocate memory\n");
 		goto init_error;
 	}
-	memset(cam, 0, sizeof(struct camera_device));
 	
 	/* Save the pointer to camera device in a global variable */
 	camera_dev = cam;
diff --git a/drivers/media/video/omap/h3_sensor_power.c b/drivers/media/video/omap/h3_sensor_power.c
new file mode 100644
index 0000000..e543433
--- /dev/null
+++ b/drivers/media/video/omap/h3_sensor_power.c
@@ -0,0 +1,63 @@
+/*
+ * drivers/media/video/omap/h3_sensor_power.c
+ *
+ * H3 sensor powerup/down functions.
+ *
+ * Author: Andy Lowe (source@mvista.com)
+ *
+ * Copyright (C) 2004 MontaVista Software, Inc.
+ * Copyright (C) 2004 Texas Instruments.
+ *
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+
+#include <asm/arch/gpioexpander.h>
+
+int h3_sensor_powerup(void);
+int h3_sensor_powerdown(void);
+
+int
+h3_sensor_powerup(void)
+{	
+	unsigned char expa;
+	int err;
+
+	/* read the current state of GPIO EXPA output */
+	if (( err = read_gpio_expa(&expa, 0x27))){
+		printk(KERN_ERR "Error reading GPIO EXPA \n");
+		return err;
+	}
+	/* set GPIO EXPA P7 CAMERA_MOD_EN to power-up sensor */
+	if ((err = write_gpio_expa(expa | 0x80, 0x27))) {
+		printk(KERN_ERR "Error writing to GPIO EXPA \n");
+		return err;
+	}
+	return 0;
+}
+
+int
+h3_sensor_powerdown(void)
+{
+	unsigned char expa;
+	int err;
+
+	/* read the current state of GPIO EXPA output */
+	if (( err = read_gpio_expa(&expa, 0x27))){
+		printk(KERN_ERR "Error reading GPIO EXPA \n");
+		return err;
+	}
+	/* clear GPIO EXPA P7 CAMERA_MOD_EN to power-up sensor */
+	if ((err = write_gpio_expa(expa & ~0x80, 0x27))) {
+		printk(KERN_ERR "Error writing to GPIO EXPA \n");
+		return err;
+	}
+	return 0;
+}
+
+EXPORT_SYMBOL(h3_sensor_powerup);
+EXPORT_SYMBOL(h3_sensor_powerdown);
diff --git a/drivers/media/video/omap/h3sensorpower.h b/drivers/media/video/omap/h3sensorpower.h
new file mode 100644
index 0000000..2944e52
--- /dev/null
+++ b/drivers/media/video/omap/h3sensorpower.h
@@ -0,0 +1,17 @@
+/*
+ * drivers/media/video/omap/h3sensorpower.h
+ *
+ * Copyright (C) 2005 Texas Instruments.
+ *
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ */
+
+#ifndef H3SENSORPOWER_H
+#define H3SENSORPOWER_H
+
+int h3_sensor_powerup(void);
+int h3_sensor_powerdown(void);
+
+#endif /*H3SENSORPOWER_H*/
diff --git a/drivers/media/video/omap/sensor_ov9640.c b/drivers/media/video/omap/sensor_ov9640.c
index 9b4606f..c7691d1 100644
--- a/drivers/media/video/omap/sensor_ov9640.c
+++ b/drivers/media/video/omap/sensor_ov9640.c
@@ -20,10 +20,10 @@
 #include <media/video-buf.h>
 #include <linux/delay.h>
 #include <asm/mach-types.h>
-#include <asm/arch/gpioexpander.h>
 
 #include "sensor_if.h"
 #include "ov9640.h"
+#include "h3sensorpower.h"
 
 #define CAMERA_OV9640
 #ifdef CAMERA_OV9640
@@ -669,21 +669,15 @@ ov9640_configure(struct i2c_client *clie
 static int
 ov9640_powerup(void)
 {
-	unsigned char expa;
 	int err;
 
 	if (machine_is_omap_h2())
 		return 0;
 
-	/* read the current state of GPIO EXPA output */
-	if (( err = read_gpio_expa(&expa, 0x27))){
-		printk(KERN_ERR "Error reading GPIO EXPA \n");
-		return err;
-	}
-	/* set GPIO EXPA P7 CAMERA_MOD_EN to power-up sensor */
-	if ((err = write_gpio_expa(expa | 0x80, 0x27))) {
-		printk(KERN_ERR "Error writing to GPIO EXPA \n");
-		return err;
+	if (machine_is_omap_h3()) {
+		err = h3_sensor_powerup();
+		if (err)
+			return err;
 	}
 
 	return 0;
@@ -691,22 +685,17 @@ ov9640_powerup(void)
 static int
 ov9640_powerdown(void)
 {
-	unsigned char expa;
 	int err;
 
 	if (machine_is_omap_h2())
 		return 0;
 
-	/* read the current state of GPIO EXPA output */
-	if (( err = read_gpio_expa(&expa, 0x27))){
-		printk(KERN_ERR "Error reading GPIO EXPA \n");
-		return err;
-	}
-	/* clear GPIO EXPA P7 CAMERA_MOD_EN to power-up sensor */
-	if ((err = write_gpio_expa(expa & ~0x80, 0x27))) {
-		printk(KERN_ERR "Error writing to GPIO EXPA \n");
-		return err;
+	if (machine_is_omap_h3()) {
+		err = h3_sensor_powerdown();
+		if (err)
+			return err;
 	}
+
 	return 0;
 }
 

--0-1946700909-1132834231=:8489
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source

--0-1946700909-1132834231=:8489--

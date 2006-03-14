From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] Fix OV9640 sensor and add h4 sensor power functions
Date: Tue, 14 Mar 2006 07:20:33 -0800 (PST)
Message-ID: <20060314152033.17597.qmail@web32915.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1625457168-1142349633=:17026"
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

--0-1625457168-1142349633=:17026
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

David/Jian,

In the current sensor_ov9640.c implemention in git tree, strlcpy in
ov9640_sensor_init crashes, so it better to move it outside
ov9640_sensor structure. Also the patch adds h4 sensor power function.

David, you should have faced this error, if you are working on porting
the camera driver to latest git tree :)


---
Move i2c_driver out of ov9640_sensor structure and
add H4 camera sensor powerup/down functions.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1625457168-1142349633=:17026
Content-Type: text/x-patch; name="ov9640sensor.patch"
Content-Description: 3044381098-ov9640sensor.patch
Content-Disposition: inline; filename="ov9640sensor.patch"

diff --git a/drivers/media/video/omap/Makefile b/drivers/media/video/omap/Makefile
index c4c5a81..10987be 100644
--- a/drivers/media/video/omap/Makefile
+++ b/drivers/media/video/omap/Makefile
@@ -7,6 +7,7 @@ objs-yy := camera_core.o
 
 objs-y$(CONFIG_ARCH_OMAP16XX) += omap16xxcam.o
 objs-y$(CONFIG_MACH_OMAP_H3) += h3_sensor_power.o
+objs-y$(CONFIG_MACH_OMAP_H4) += h4_sensor_power.o
 
 omapcamera-objs := $(objs-yy)
 
diff --git a/drivers/media/video/omap/h4_sensor_power.c b/drivers/media/video/omap/h4_sensor_power.c
new file mode 100644
index 0000000..f8db956
--- /dev/null
+++ b/drivers/media/video/omap/h4_sensor_power.c
@@ -0,0 +1,76 @@
+/*
+ * drivers/media/video/omap/h4_sensor_power.c
+ *
+ * H4 sensor powerup/down functions.
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
+int h4_sensor_powerup(void);
+int h4_sensor_powerdown(void);
+
+int
+h4_sensor_powerup(void)
+{
+	unsigned char expa;
+	int err;
+
+	/* read current state of GPIO EXPA outputs */
+	if ((err = read_gpio_expa(&expa, 0x20))) {
+		printk(KERN_ERR "Error reading GPIO EXPA\n");
+		return err;
+	}
+	/* Set GPIO EXPA P3 (CAMERA_MODULE_EN) to power-up sensor */
+	if ((err = write_gpio_expa(expa | 0x08, 0x20))) {
+		printk(KERN_ERR "Error writing to GPIO EXPA\n");
+		return err;
+	}
+
+	/* read current state of GPIO EXPA outputs */
+	if ((err = read_gpio_expa(&expa, 0x22))) {
+		printk(KERN_ERR "Error reading GPIO EXPA\n");
+		return err;
+	}
+	/* Clear GPIO EXPA P7 (CAM_RST) */
+	if ((err = write_gpio_expa(expa & ~0x80, 0x22))) {
+		printk(KERN_ERR "Error writing to GPIO EXPA\n");
+		return err;
+	}
+
+	return 0;
+}
+
+int
+h4_sensor_powerdown(void)
+{
+	unsigned char expa;
+	int err;
+
+	/* read current state of GPIO EXPA outputs */
+	if ((err = read_gpio_expa(&expa, 0x20))) {
+		printk(KERN_ERR "Error reading GPIO EXPA\n");
+		return err;
+	}
+	/* Clear GPIO EXPA P3 (CAMERA_MODULE_EN) to power-down sensor */
+	if ((err = write_gpio_expa(expa & ~0x08, 0x20))) {
+		printk(KERN_ERR "Error writing to GPIO EXPA\n");
+		return err;
+	}
+
+	return 0;
+}
+
+EXPORT_SYMBOL(h4_sensor_powerup);
+EXPORT_SYMBOL(h4_sensor_powerdown);
diff --git a/drivers/media/video/omap/h4sensorpower.h b/drivers/media/video/omap/h4sensorpower.h
new file mode 100644
index 0000000..4eeae11
--- /dev/null
+++ b/drivers/media/video/omap/h4sensorpower.h
@@ -0,0 +1,17 @@
+/*
+ * drivers/media/video/omap/h4sensorpower.h
+ *
+ * Copyright (C) 2005 Texas Instruments.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef H4SENSORPOWER_H
+#define H4SENSORPOWER_H
+
+int h4_sensor_powerup(void);
+int h4_sensor_powerdown(void);
+
+#endif /*H4SENSORPOWER_H*/
diff --git a/drivers/media/video/omap/sensor_ov9640.c b/drivers/media/video/omap/sensor_ov9640.c
index 788f41d..fe071e2 100644
--- a/drivers/media/video/omap/sensor_ov9640.c
+++ b/drivers/media/video/omap/sensor_ov9640.c
@@ -24,6 +24,7 @@
 #include "sensor_if.h"
 #include "ov9640.h"
 #include "h3sensorpower.h"
+#include "h4sensorpower.h"
 
 #define CAMERA_OV9640
 #ifdef CAMERA_OV9640
@@ -31,7 +32,6 @@
 struct ov9640_sensor {
 	/* I2C parameters */
 	struct i2c_client client;
-	struct i2c_driver driver;
 	int ver; /* OV9640 version */
 };
 
@@ -680,6 +680,12 @@ ov9640_powerup(void)
 			return err;
 	}
 
+	if (machine_is_omap_h4()) {
+		err = h4_sensor_powerup();
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 static int
@@ -696,6 +702,12 @@ ov9640_powerdown(void)
 			return err;
 	}
 
+	if (machine_is_omap_h4()) {
+		err = h4_sensor_powerdown();
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -750,6 +762,8 @@ ov9640_detect(struct i2c_client *client)
 	return ver;
 }
 
+static struct i2c_driver ov9640sensor_i2c_driver;
+
 /* This function registers an I2C client via i2c_attach_client() for an OV9640 
  * sensor device.  If 'probe' is non-zero, then the I2C client is only 
  * registered if the device can be detected.  If 'probe' is zero, then no 
@@ -768,7 +782,7 @@ ov9640_i2c_attach_client(struct i2c_adap
 		return -EBUSY;	/* our client is already attached */
 
 	client->addr = addr;
-	client->driver = &sensor->driver;
+	client->driver = &ov9640sensor_i2c_driver;
 	client->adapter = adap;
 
 	err = i2c_attach_client(client);
@@ -1081,12 +1095,23 @@ ov9640sensor_cleanup(void *priv)
 	struct ov9640_sensor *sensor = (struct ov9640_sensor *) priv;
 
 	if (sensor) {
-		i2c_del_driver(&sensor->driver);
+		i2c_del_driver(&ov9640sensor_i2c_driver);
 		ov9640_powerdown();
  	}
 	return 0;
 }
 
+
+static struct i2c_driver ov9640sensor_i2c_driver = {
+	.driver {
+		.name		= "ov9640",
+	},
+	.id		= I2C_DRIVERID_MISC, /*FIXME:accroding to i2c-ids.h */
+	.attach_adapter	= ov9640_i2c_probe_adapter,
+	.detach_client	= ov9640_i2c_detach_client,
+};
+
+
 /* Initialize the OV9640 sensor.
  * This routine allocates and initializes the data structure for the sensor, 
  * powers up the sensor, registers the I2C driver, and sets a default image 
@@ -1099,7 +1124,6 @@ static void *
 ov9640sensor_init(struct v4l2_pix_format *pix)
 {
 	struct ov9640_sensor *sensor = &ov9640;
-	struct i2c_driver *driver = &sensor->driver;
  	int err;
 
 	memset(sensor, 0, sizeof(*sensor));
@@ -1108,12 +1132,7 @@ ov9640sensor_init(struct v4l2_pix_format
 	if (ov9640_powerup())
 		return NULL;
 
-	strlcpy(driver->driver.name, "OV9640 I2C driver", sizeof(driver->driver.name));
-	driver->id = I2C_DRIVERID_MISC;
-	driver->attach_adapter = ov9640_i2c_probe_adapter;
-	driver->detach_client = ov9640_i2c_detach_client;
-
-	err = i2c_add_driver(driver);
+	err = i2c_add_driver(&ov9640sensor_i2c_driver);
 	if (err) {
 		printk(KERN_ERR "Failed to register OV9640 I2C client.\n");
 		return NULL;

--0-1625457168-1142349633=:17026
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-1625457168-1142349633=:17026--

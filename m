From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.23-rc2-omap1] tsc210x cleanup
Date: Mon, 13 Aug 2007 22:38:13 -0700
Message-ID: <200708132238.13676.david-b@pacbell.net>
References: <fb249edb0706040644w55ac4c55k495ae2050f94aea0@mail.gmail.com>
	<200708102004.59747.david-b@pacbell.net>
	<20070813070512.GC13948@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070813070512.GC13948@atomide.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, andrzej zaborowski <balrogg@gmail.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is mostly cleanup of the tsc210x patch, but some bugs were fixed so now
it works on tsc2101 too.  Also, a few issues are now noted in the code:

 Tool-reported:
  - Address checkpatch.pl issues in the original patch
  - And also "sparse" issues

 Previously wrong:
  - Cope with CONFIG_SOUND_MODULE
  - Register accessor routines will now return error codes
  - ... many callers now abort cleanly after errors
  - Don't depend on seeing only a rev #1 tsc2102 chip!
  - Add missing EXPORT_SYMBOL declarations

 Style issues:
  - BUG_ON() is strongly to be avoided
  - So are macros that capture variables
  - And needless casting from void pointers
  - And type punning
  - Use dev_*() for messaging where practical
  - Use u16 not uint16_t, etc
  - Various other whitespace issues
  - Avoid __FUNCTION__
  - Single-lines for file-top comments; no whole paths

 Object code size and Other cleanup:
  - Compile most strings out unless -DDEBUG is configured (saving space)
  - Move some code into exit sections (then it may well vanish, saving space)
  - Add some header comments

 Open issues:
  - Hwmon needs to know VREF and the chip type, and to scale its values
  - Upstream push should exclude audio until some version is working
  - Audio will needs to export symbols to modules, too
  - Lots of the I/O calls (especially audio) still don't handle errors
  - How could board init code get board-specific temp calibration data?
 
Also the Kconfig is more open-ended; tsc210x might in the future include the
tsc2100 and tsc2111, it doesn't need to be limited to tsc2101 and tsc2102.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/hwmon/Kconfig                  |    4 
 drivers/hwmon/tsc210x_sensors.c        |  140 ++++++++----
 drivers/input/touchscreen/Kconfig      |    4 
 drivers/input/touchscreen/tsc210x_ts.c |   65 +++--
 drivers/spi/Kconfig                    |   13 -
 drivers/spi/tsc210x.c                  |  366 +++++++++++++++++++--------------
 include/linux/spi/tsc210x.h            |   33 +-
 7 files changed, 381 insertions(+), 244 deletions(-)

--- h4.orig/drivers/hwmon/Kconfig	2007-08-13 15:40:13.000000000 -0700
+++ h4/drivers/hwmon/Kconfig	2007-08-13 15:40:31.000000000 -0700
@@ -685,11 +685,11 @@ config SENSORS_APPLESMC
 	  the awesome power of applesmc.
 
 config SENSORS_TSC210X
-	tristate "TI TSC2101/2102 battery & temperature sensors"
+	tristate "TI TSC210x battery & temperature sensors"
 	depends on HWMON && SPI_MASTER
 	select SPI_TSC210X
 	help
-	  Say Y if your board has a TSC210X chip and you want to
+	  Say Y if your board has a TSC210x chip and you want to
 	  have its battery state, auxiliary input and/or temperature
 	  sensors exported through hwmon.
 
--- h4.orig/drivers/hwmon/tsc210x_sensors.c	2007-08-13 15:40:13.000000000 -0700
+++ h4/drivers/hwmon/tsc210x_sensors.c	2007-08-13 21:59:18.000000000 -0700
@@ -1,7 +1,5 @@
 /*
- * drivers/hwmon/tsc210x_sensors.c
- *
- * hwmon interface for TSC210X sensors
+ * tsc210x_sensors.c - hwmon interface to TI TSC210x sensors
  *
  * Copyright (c) 2005-2007 Andrzej Zaborowski  <balrog@zabor.org>
  *
@@ -32,54 +30,92 @@
 
 #include <linux/spi/tsc210x.h>
 
+
+/*
+ * TI TSC210x chips include an ADC that's shared between various
+ * sensors (temperature, battery, vAUX, etc) and the touchscreen.
+ * This driver packages access to the non-touchscreen sensors
+ * available on a given board.
+ */
+
 struct tsc210x_hwmon {
 	int bat[2], aux[2], temp[2];
 
 	struct class_device *dev;
 	struct tsc210x_config *pdata;
 #ifdef CONFIG_APM
+	/* prevent APM from colliding with normal hwmon accessors */
 	spinlock_t apm_lock;
 #endif
 };
 
 #ifdef CONFIG_APM
-# define apm_lock()	spin_lock(&hwmon->apm_lock)
-# define apm_unlock()	spin_unlock(&hwmon->apm_lock)
+# define apm_lock(h)	spin_lock(&(h)->apm_lock)
+# define apm_unlock(h)	spin_unlock(&(h)->apm_lock)
 #else
-# define apm_lock()
-# define apm_unlock()
+# define apm_lock(h)	do { } while (0)
+# define apm_unlock(h)	do { } while (0)
 #endif
 
-static void tsc210x_ports(struct tsc210x_hwmon *hwmon, int bat[], int aux[])
+static void tsc210x_ports(void *context, int bat[], int aux[])
 {
-	apm_lock();
+	struct tsc210x_hwmon	*hwmon = context;
+
+	apm_lock(hwmon);
+
+	/* FIXME for tsc2101 and tsc2111, battery voltage is:
+	 *	VBAT = (5 * VREF * (bat[x])) / (2 ^ bits)
+	 * For tsc2100 and tsc2102, use "6" not "5"; that formula ignores
+	 * an external 100-300 Ohm resistor making the right value be just
+	 * a bit over 5 (or 6).
+	 *
+	 * FIXME the vAUX measurements need scaling too, but in that case
+	 * there's no *internal* voltage divider so just scale to VREF.
+	 *
+	 *  --> This code needs to know VREF, the VBAT multiplier, and
+	 *	the precision.  For now, assume VREF 1.25V and 12 bits.
+	 *	When an external reference is used, it normally won't
+	 *	match the 1.25V (or 2.5V) values supported internally...
+	 *
+	 *  --> Output units should become milliVolts; currently they are
+	 *	dimensionless...
+	 */
 	hwmon->bat[0] = bat[0];
 	hwmon->bat[1] = bat[1];
+
 	hwmon->aux[0] = aux[0];
 	hwmon->aux[1] = aux[1];
-	apm_unlock();
+
+	apm_unlock(hwmon);
 }
 
-static void tsc210x_temp1(struct tsc210x_hwmon *hwmon, int temp)
+/* FIXME temp sensors also need scaling so values are milliVolts...
+ * temperature (given calibration data) should be millidegrees C.
+ */
+
+static void tsc210x_temp1(void *context, int temp)
 {
-	apm_lock();
+	struct tsc210x_hwmon	*hwmon = context;
+
+	apm_lock(hwmon);
 	hwmon->temp[0] = temp;
-	apm_unlock();
+	apm_unlock(hwmon);
 }
 
-static void tsc210x_temp2(struct tsc210x_hwmon *hwmon, int temp)
+static void tsc210x_temp2(void *context, int temp)
 {
-	apm_lock();
+	struct tsc210x_hwmon	*hwmon = context;
+
+	apm_lock(hwmon);
 	hwmon->temp[1] = temp;
-	apm_unlock();
+	apm_unlock(hwmon);
 }
 
 #define TSC210X_INPUT(devname, field)	\
 static ssize_t tsc_show_ ## devname(struct device *dev,	\
 		struct device_attribute *devattr, char *buf)	\
 {	\
-	struct tsc210x_hwmon *hwmon = (struct tsc210x_hwmon *)	\
-		platform_get_drvdata(to_platform_device(dev));	\
+	struct tsc210x_hwmon *hwmon = dev_get_drvdata(dev);	\
 	return sprintf(buf, "%i\n", hwmon->field);	\
 }	\
 static DEVICE_ATTR(devname ## _input, S_IRUGO, tsc_show_ ## devname, NULL);
@@ -94,13 +130,11 @@ TSC210X_INPUT(in5, temp[1])
 static ssize_t tsc_show_temp1(struct device *dev,
 		struct device_attribute *devattr, char *buf)
 {
-	struct tsc210x_hwmon *hwmon = (struct tsc210x_hwmon *)
-		platform_get_drvdata(to_platform_device(dev));
-	int t1, t2;
-	int diff, value;
-
-	t1 = hwmon->temp[0];
-	t2 = hwmon->temp[1];
+	struct tsc210x_hwmon *hwmon = dev_get_drvdata(dev);
+	int t1 = hwmon->temp[0];
+	int t2 = hwmon->temp[1];
+	int diff;
+	int value;
 
 	/*
 	 * Use method #2 (differential) to calculate current temperature.
@@ -114,7 +148,6 @@ static ssize_t tsc_show_temp1(struct dev
 	 * 273150 is zero degrees Celcius.
 	 */
 	diff = hwmon->pdata->temp_at25c[1] - hwmon->pdata->temp_at25c[0];
-	BUG_ON(diff == 0);
 	value = (t2 - t1) * 298150 / diff;	/* This is in Kelvins now */
 
 	value -= 273150;			/* Celcius millidegree */
@@ -128,9 +161,10 @@ static struct tsc210x_hwmon *apm_hwmon;
 static void tsc210x_get_power_status(struct apm_power_info *info)
 {
 	struct tsc210x_hwmon *hwmon = apm_hwmon;
-	apm_lock();
+
+	apm_lock(hwmon);
 	hwmon->pdata->apm_report(info, hwmon->bat);
-	apm_unlock();
+	apm_unlock(hwmon);
 }
 #endif
 
@@ -143,15 +177,14 @@ static int tsc210x_hwmon_probe(struct pl
 	hwmon = (struct tsc210x_hwmon *)
 		kzalloc(sizeof(struct tsc210x_hwmon), GFP_KERNEL);
 	if (!hwmon) {
-		printk(KERN_ERR "%s: allocation failed\n", __FUNCTION__);
+		dev_dbg(&pdev->dev, "allocation failed\n");
 		return -ENOMEM;
 	}
 
 	hwmon->dev = hwmon_device_register(&pdev->dev);
 	if (IS_ERR(hwmon->dev)) {
 		kfree(hwmon);
-		printk(KERN_ERR "%s: Class registration failed\n",
-				__FUNCTION__);
+		dev_dbg(&pdev->dev, "registration failed\n");
 		return PTR_ERR(hwmon->dev);
 	}
 
@@ -170,19 +203,19 @@ static int tsc210x_hwmon_probe(struct pl
 
 	if (pdata->monitor & (TSC_BAT1 | TSC_BAT2 | TSC_AUX1 | TSC_AUX2))
 		status |= tsc210x_ports_cb(pdev->dev.parent,
-				(tsc210x_ports_t) tsc210x_ports, hwmon);
+				tsc210x_ports, hwmon);
 	if (pdata->monitor & TSC_TEMP) {
 		status |= tsc210x_temp1_cb(pdev->dev.parent,
-				(tsc210x_temp_t) tsc210x_temp1, hwmon);
+				tsc210x_temp1, hwmon);
 		status |= tsc210x_temp2_cb(pdev->dev.parent,
-				(tsc210x_temp_t) tsc210x_temp2, hwmon);
+				tsc210x_temp2, hwmon);
 	}
 
 	if (status) {
-		tsc210x_ports_cb(pdev->dev.parent, 0, 0);
-		tsc210x_temp1_cb(pdev->dev.parent, 0, 0);
-		tsc210x_temp2_cb(pdev->dev.parent, 0, 0);
-		platform_set_drvdata(pdev, 0);
+		tsc210x_ports_cb(pdev->dev.parent, NULL, NULL);
+		tsc210x_temp1_cb(pdev->dev.parent, NULL, NULL);
+		tsc210x_temp2_cb(pdev->dev.parent, NULL, NULL);
+		platform_set_drvdata(pdev, NULL);
 #ifdef CONFIG_APM
 		if (pdata->apm_report)
 			apm_get_power_status = 0;
@@ -203,23 +236,28 @@ static int tsc210x_hwmon_probe(struct pl
 	if (pdata->monitor & TSC_TEMP) {
 		status |= device_create_file(&pdev->dev, &dev_attr_in4_input);
 		status |= device_create_file(&pdev->dev, &dev_attr_in5_input);
-		status |= device_create_file(&pdev->dev, &dev_attr_temp1_input);
+
+		if ((pdata->temp_at25c[1] - pdata->temp_at25c[0]) == 0)
+			dev_warn(&pdev->dev, "No temp calibration data.\n");
+		else
+			status |= device_create_file(&pdev->dev,
+						&dev_attr_temp1_input);
 	}
 	if (status)	/* Not fatal */
-		printk(KERN_ERR "%s: Creating one or more "
-				"attribute files failed\n", __FUNCTION__);
+		dev_dbg(&pdev->dev, "Creating one or more "
+				"attribute files failed\n");
 
 	return 0;
 }
 
-static int tsc210x_hwmon_remove(struct platform_device *pdev)
+static int __exit tsc210x_hwmon_remove(struct platform_device *pdev)
 {
 	struct tsc210x_hwmon *dev = platform_get_drvdata(pdev);
 
-	tsc210x_ports_cb(pdev->dev.parent, 0, 0);
-	tsc210x_temp1_cb(pdev->dev.parent, 0, 0);
-	tsc210x_temp2_cb(pdev->dev.parent, 0, 0);
-	platform_set_drvdata(pdev, 0);
+	tsc210x_ports_cb(pdev->dev.parent, NULL, NULL);
+	tsc210x_temp1_cb(pdev->dev.parent, NULL, NULL);
+	tsc210x_temp2_cb(pdev->dev.parent, NULL, NULL);
+	platform_set_drvdata(pdev, NULL);
 #ifdef CONFIG_APM
 	if (dev->pdata->apm_report)
 		apm_get_power_status = 0;
@@ -230,8 +268,8 @@ static int tsc210x_hwmon_remove(struct p
 }
 
 static struct platform_driver tsc210x_hwmon_driver = {
-	.probe 		= tsc210x_hwmon_probe,
-	.remove 	= tsc210x_hwmon_remove,
+	.probe		= tsc210x_hwmon_probe,
+	.remove		= __exit_p(tsc210x_hwmon_remove),
 	/* Nothing to do on suspend/resume */
 	.driver		= {
 		.name	= "tsc210x-hwmon",
@@ -240,15 +278,17 @@ static struct platform_driver tsc210x_hw
 
 static int __init tsc210x_hwmon_init(void)
 {
+	/* can't use driver_probe() here since the parent device
+	 * gets registered "late"
+	 */
 	return platform_driver_register(&tsc210x_hwmon_driver);
 }
+module_init(tsc210x_hwmon_init);
 
 static void __exit tsc210x_hwmon_exit(void)
 {
 	platform_driver_unregister(&tsc210x_hwmon_driver);
 }
-
-module_init(tsc210x_hwmon_init);
 module_exit(tsc210x_hwmon_exit);
 
 MODULE_AUTHOR("Andrzej Zaborowski");
--- h4.orig/drivers/input/touchscreen/Kconfig	2007-08-13 15:40:13.000000000 -0700
+++ h4/drivers/input/touchscreen/Kconfig	2007-08-13 15:40:31.000000000 -0700
@@ -193,12 +193,12 @@ config TOUCHSCREEN_TSC2102
 	  module will be called tsc2102_ts.
 
 config TOUCHSCREEN_TSC210X
-	tristate "TSC 2101/2102 based touchscreens"
+	tristate "TI TSC210x based touchscreens"
 	depends on SPI_MASTER
 	select SPI_TSC210X
 	help
 	  Say Y here if you have a touchscreen interface using a
-	  TI TSC 210x controller, and your board-specific initialisation
+	  TI TSC210x controller, and your board-specific initialisation
 	  code includes that in its table of SPI devices.
 
 	  If unsure, say N (but it's safe to say "Y").
--- h4.orig/drivers/input/touchscreen/tsc210x_ts.c	2007-08-13 15:40:13.000000000 -0700
+++ h4/drivers/input/touchscreen/tsc210x_ts.c	2007-08-13 22:00:03.000000000 -0700
@@ -1,7 +1,5 @@
 /*
- * input/touchscreen/tsc210x_ts.c
- *
- * Touchscreen input device driver for the TSC 2101/2102 chips.
+ * tsc210x_ts.c - touchscreen input device for TI TSC210x chips
  *
  * Copyright (c) 2006-2007 Andrzej Zaborowski  <balrog@zabor.org>
  *
@@ -29,8 +27,23 @@
 
 #include <linux/spi/tsc210x.h>
 
-static void tsc210x_touch(struct input_dev *dev, int touching)
+
+/*
+ * The sensor ADC on tsc210x chips is most often used with the smart
+ * touchscreen controller.   Those controllers can be made to improve
+ * sample quality directly by multi-sampling and by taking the mean or
+ * median of various numbers of samples.  They also take X, Y, and
+ * pressure measurements automatically, so this driver has relatively
+ * little to do.
+ *
+ * There are a few chips in this family that don't have quite the same
+ * touchscreen interface, e.g. no "median" mode.
+ */
+
+static void tsc210x_touch(void *context, int touching)
 {
+	struct input_dev *dev = context;
+
 	if (!touching) {
 		input_report_abs(dev, ABS_X, 0);
 		input_report_abs(dev, ABS_Y, 0);
@@ -41,8 +54,9 @@ static void tsc210x_touch(struct input_d
 	input_report_key(dev, BTN_TOUCH, touching);
 }
 
-static void tsc210x_coords(struct input_dev *dev, int x, int y, int z1, int z2)
+static void tsc210x_coords(void *context, int x, int y, int z1, int z2)
 {
+	struct input_dev *dev = context;
 	int p;
 
 	/* Calculate the touch resistance a la equation #1 */
@@ -66,17 +80,15 @@ static int tsc210x_ts_probe(struct platf
 	if (!dev)
 		return -ENOMEM;
 
-	status = tsc210x_touch_cb(pdev->dev.parent,
-			(tsc210x_touch_t) tsc210x_touch, dev);
+	status = tsc210x_touch_cb(pdev->dev.parent, tsc210x_touch, dev);
 	if (status) {
 		input_free_device(dev);
 		return status;
 	}
 
-	status = tsc210x_coords_cb(pdev->dev.parent,
-			(tsc210x_coords_t) tsc210x_coords, dev);
+	status = tsc210x_coords_cb(pdev->dev.parent, tsc210x_coords, dev);
 	if (status) {
-		tsc210x_touch_cb(pdev->dev.parent, 0, 0);
+		tsc210x_touch_cb(pdev->dev.parent, NULL, NULL);
 		input_free_device(dev);
 		return status;
 	}
@@ -94,8 +106,8 @@ static int tsc210x_ts_probe(struct platf
 
 	status = input_register_device(dev);
 	if (status) {
-		tsc210x_coords_cb(pdev->dev.parent, 0, 0);
-		tsc210x_touch_cb(pdev->dev.parent, 0, 0);
+		tsc210x_coords_cb(pdev->dev.parent, NULL, NULL);
+		tsc210x_touch_cb(pdev->dev.parent, NULL, NULL);
 		input_free_device(dev);
 		return status;
 	}
@@ -105,14 +117,13 @@ static int tsc210x_ts_probe(struct platf
 	return 0;
 }
 
-static int tsc210x_ts_remove(struct platform_device *pdev)
+static int __exit tsc210x_ts_remove(struct platform_device *pdev)
 {
-	struct input_dev *dev = (struct input_dev *)
-		platform_get_drvdata(pdev);
+	struct input_dev *dev = platform_get_drvdata(pdev);
 
-	tsc210x_touch_cb(pdev->dev.parent, 0, 0);
-	tsc210x_coords_cb(pdev->dev.parent, 0, 0);
-	platform_set_drvdata(pdev, 0);
+	tsc210x_touch_cb(pdev->dev.parent, NULL, NULL);
+	tsc210x_coords_cb(pdev->dev.parent, NULL, NULL);
+	platform_set_drvdata(pdev, NULL);
 	input_unregister_device(dev);
 	input_free_device(dev);
 
@@ -120,8 +131,8 @@ static int tsc210x_ts_remove(struct plat
 }
 
 static struct platform_driver tsc210x_ts_driver = {
-	.probe 		= tsc210x_ts_probe,
-	.remove 	= tsc210x_ts_remove,
+	.probe		= tsc210x_ts_probe,
+	.remove		= __exit_p(tsc210x_ts_remove),
 	/* Nothing to do on suspend/resume */
 	.driver		= {
 		.name	= "tsc210x-ts",
@@ -131,21 +142,17 @@ static struct platform_driver tsc210x_ts
 
 static int __init tsc210x_ts_init(void)
 {
-	int ret;
-
-	ret = platform_driver_register(&tsc210x_ts_driver);
-	if (ret)
-		return -ENODEV;
-
-	return 0;
+	/* can't use driver_probe() here since the parent device
+	 * gets registered "late"
+	 */
+	return platform_driver_register(&tsc210x_ts_driver);
 }
+module_init(tsc210x_ts_init);
 
 static void __exit tsc210x_ts_exit(void)
 {
 	platform_driver_unregister(&tsc210x_ts_driver);
 }
-
-module_init(tsc210x_ts_init);
 module_exit(tsc210x_ts_exit);
 
 MODULE_AUTHOR("Andrzej Zaborowski");
--- h4.orig/drivers/spi/Kconfig	2007-08-13 15:40:13.000000000 -0700
+++ h4/drivers/spi/Kconfig	2007-08-13 15:40:31.000000000 -0700
@@ -229,10 +229,17 @@ config SPI_TSC2102
 
 config SPI_TSC210X
 	depends on SPI_MASTER && EXPERIMENTAL
-	tristate "TSC2101/TSC2102 chips support"
+	tristate "TI TSC210x (TSC2101/TSC2102) support"
 	help
-	  Say Y here if you want support for the TSC210x chips.  It
-	  will be needed for the touchscreen driver on some boards.
+	  Say Y here if you want support for the TSC210x chips.  Some
+	  boards use these for touchscreen and audio support.
+
+	  These are members of a family of highly integrated PDA analog
+	  interface circuit.  They include a 12-bit ADC used for battery,
+	  temperature, touchscreen, and other sensors.  They also have
+	  an audio DAC and amplifier, and in some models an audio ADC.
+	  The audio support is highly chip-specific, but most of the
+	  sensor support works the same.
 
 	  Note that the device has to be present in the board's SPI
 	  devices table for this driver to load.  This driver doesn't
--- h4.orig/drivers/spi/tsc210x.c	2007-08-13 15:40:13.000000000 -0700
+++ h4/drivers/spi/tsc210x.c	2007-08-13 22:00:16.000000000 -0700
@@ -1,7 +1,5 @@
 /*
- * drivers/spi/tsc210x.c
- *
- * TSC2101/2102 interface driver.
+ * tsc210x.c - TSC2101/2102/... driver core
  *
  * Copyright (c) 2005-2007 Andrzej Zaborowski  <balrog@zabor.org>
  *
@@ -35,6 +33,13 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/tsc210x.h>
 
+
+/* NOTE:  It should be straightforward to make this driver framework handle
+ * tsc2100 and tsc2111 chips, and maybe others too.  The main differences
+ * are in the audio codec capabilities, but there are also some differences
+ * in how the various sensors (including touchscreen) are handled.
+ */
+
 /* Bit field definitions for chip registers */
 
 /* Scan X, Y, Z1, Z2, chip controlled, 12-bit, 16 samples, 500 usec */
@@ -86,7 +91,8 @@
 
 struct tsc210x_spi_req {
 	struct spi_device *dev;
-	uint16_t command, data;
+	u16 command;
+	u16 data;
 	struct spi_message message;
 };
 
@@ -103,14 +109,19 @@ struct tsc210x_dev {
 	struct delayed_work sensor_worker;	/* Scan the ADC inputs */
 	spinlock_t queue_lock;
 	struct completion data_avail;
+
 	tsc210x_touch_t touch_cb;
 	void *touch_cb_ctx;
+
 	tsc210x_coords_t coords_cb;
 	void *coords_cb_ctx;
+
 	tsc210x_ports_t ports_cb;
 	void *ports_cb_ctx;
+
 	tsc210x_temp_t temp1_cb;
 	void *temp2_cb_ctx;
+
 	tsc210x_temp_t temp2_cb;
 	void *temp1_cb_ctx;
 
@@ -123,7 +134,8 @@ struct tsc210x_dev {
 
 	int pendown;
 	int flushing;			/* Queue flush in progress */
-	uint16_t status, adc_data[4];
+	u16 status;
+	u16 adc_data[4];
 	int bat[2], aux[2], temp[2];
 };
 
@@ -138,7 +150,7 @@ MODULE_PARM_DESC(touch_check_msecs, "Pen
 module_param_named(sensor_scan_msecs, settings.mode_msecs, uint, 0);
 MODULE_PARM_DESC(sensor_scan_msecs, "Temperature & battery scan interval");
 
-void tsc210x_write_sync(struct tsc210x_dev *dev,
+int tsc210x_write_sync(struct tsc210x_dev *dev,
 		int page, u8 address, u16 data)
 {
 	static struct tsc210x_spi_req req;
@@ -150,13 +162,13 @@ void tsc210x_write_sync(struct tsc210x_d
 	/* Address */
 	req.command = (page << 11) | (address << 5);
 	transfer[0].tx_buf = &req.command;
-	transfer[0].rx_buf = 0;
+	transfer[0].rx_buf = NULL;
 	transfer[0].len = 2;
 	spi_message_add_tail(&transfer[0], &req.message);
 
 	/* Data */
 	transfer[1].tx_buf = &data;
-	transfer[1].rx_buf = 0;
+	transfer[1].rx_buf = NULL;
 	transfer[1].len = 2;
 	transfer[1].cs_change = CS_CHANGE(1);
 	spi_message_add_tail(&transfer[1], &req.message);
@@ -164,20 +176,22 @@ void tsc210x_write_sync(struct tsc210x_d
 	ret = spi_sync(dev->spi, &req.message);
 	if (!ret && req.message.status)
 		ret = req.message.status;
-
 	if (ret)
-		printk(KERN_ERR "%s: error %i in SPI request\n",
-				__FUNCTION__, ret);
+		dev_dbg(&dev->spi->dev, "write_sync --> %d\n", ret);
+
+	return ret;
 }
+EXPORT_SYMBOL(tsc210x_write_sync);
 
-void tsc210x_reads_sync(struct tsc210x_dev *dev,
+int tsc210x_reads_sync(struct tsc210x_dev *dev,
 		int page, u8 startaddress, u16 *data, int numregs)
 {
 	static struct tsc210x_spi_req req;
 	static struct spi_transfer transfer[6];
 	int ret, i, j;
 
-	BUG_ON(numregs + 1 > ARRAY_SIZE(transfer));
+	if (numregs + 1 > ARRAY_SIZE(transfer))
+		return -EINVAL;
 
 	spi_message_init(&req.message);
 	i = 0;
@@ -186,13 +200,13 @@ void tsc210x_reads_sync(struct tsc210x_d
 	/* Address */
 	req.command = 0x8000 | (page << 11) | (startaddress << 5);
 	transfer[i].tx_buf = &req.command;
-	transfer[i].rx_buf = 0;
+	transfer[i].rx_buf = NULL;
 	transfer[i].len = 2;
 	spi_message_add_tail(&transfer[i ++], &req.message);
 
 	/* Data */
 	while (j < numregs) {
-		transfer[i].tx_buf = 0;
+		transfer[i].tx_buf = NULL;
 		transfer[i].rx_buf = &data[j ++];
 		transfer[i].len = 2;
 		transfer[i].cs_change = CS_CHANGE(j == numregs);
@@ -202,18 +216,23 @@ void tsc210x_reads_sync(struct tsc210x_d
 	ret = spi_sync(dev->spi, &req.message);
 	if (!ret && req.message.status)
 		ret = req.message.status;
-
 	if (ret)
-		printk(KERN_ERR "%s: error %i in SPI request\n",
-				__FUNCTION__, ret);
+		dev_dbg(&dev->spi->dev, "reads_sync --> %d\n", ret);
+
+	return ret;
 }
+EXPORT_SYMBOL(tsc210x_reads_sync);
 
-uint16_t tsc210x_read_sync(struct tsc210x_dev *dev, int page, uint8_t address)
+int tsc210x_read_sync(struct tsc210x_dev *dev, int page, u8 address)
 {
-	uint16_t ret;
-	tsc210x_reads_sync(dev, page, address, &ret, 1);
-	return ret;
+	u16 ret;
+	int status;
+
+	status = tsc210x_reads_sync(dev, page, address, &ret, 1);
+	return status ? : ret;
 }
+EXPORT_SYMBOL(tsc210x_read_sync);
+
 
 static void tsc210x_submit_async(struct tsc210x_spi_req *spi)
 {
@@ -221,13 +240,13 @@ static void tsc210x_submit_async(struct 
 
 	ret = spi_async(spi->dev, &spi->message);
 	if (ret)
-		printk(KERN_ERR "%s: error %i in SPI request\n",
+		dev_dbg(&spi->dev->dev, "%s: error %i in SPI request\n",
 				__FUNCTION__, ret);
 }
 
 static void tsc210x_request_alloc(struct tsc210x_dev *dev,
 		struct tsc210x_spi_req *spi, int direction,
-		int page, u8 startaddress, int numregs, uint16_t *data,
+		int page, u8 startaddress, int numregs, u16 *data,
 		void (*complete)(struct tsc210x_dev *context),
 		struct spi_transfer **transfer)
 {
@@ -248,7 +267,7 @@ static void tsc210x_request_alloc(struct
 		spi->command |= 1 << 15;
 
 	(*transfer)->tx_buf = &spi->command;
-	(*transfer)->rx_buf = 0;
+	(*transfer)->rx_buf = NULL;
 	(*transfer)->len = 2;
 	spi_message_add_tail((*transfer) ++, &spi->message);
 
@@ -257,7 +276,7 @@ static void tsc210x_request_alloc(struct
 		if (direction == 1)
 			(*transfer)->tx_buf = &spi->data;
 		else
-			(*transfer)->rx_buf = data ++;
+			(*transfer)->rx_buf = data++;
 		(*transfer)->len = 2;
 		(*transfer)->cs_change = CS_CHANGE(numregs != 1);
 		spi_message_add_tail((*transfer) ++, &spi->message);
@@ -267,13 +286,12 @@ static void tsc210x_request_alloc(struct
 #define tsc210x_cb_register_func(cb, cb_t)	\
 int tsc210x_ ## cb(struct device *dev, cb_t handler, void *context)	\
 {	\
-	struct tsc210x_dev *tsc = (struct tsc210x_dev *)	\
-		platform_get_drvdata(to_platform_device(dev));	\
+	struct tsc210x_dev *tsc = dev_get_drvdata(dev);	\
 	\
 	/* Lock the module */	\
 	if (handler && !tsc->cb)	\
 		if (!try_module_get(THIS_MODULE)) {	\
-			printk(KERN_INFO "Failed to get TSC module\n");	\
+			dev_err(dev, "Failed to get TSC module\n");	\
 		}	\
 	if (!handler && tsc->cb)	\
 		module_put(THIS_MODULE);	\
@@ -281,7 +299,8 @@ int tsc210x_ ## cb(struct device *dev, c
 	tsc->cb = handler;	\
 	tsc->cb ## _ctx = context;	\
 	return 0;	\
-}
+} \
+EXPORT_SYMBOL(tsc210x_ ## cb);
 
 tsc210x_cb_register_func(touch_cb, tsc210x_touch_t)
 tsc210x_cb_register_func(coords_cb, tsc210x_coords_t)
@@ -290,35 +309,30 @@ tsc210x_cb_register_func(temp1_cb, tsc21
 tsc210x_cb_register_func(temp2_cb, tsc210x_temp_t)
 
 #ifdef DEBUG
-static void tsc210x_print_dav(void)
+static void tsc210x_print_dav(struct tsc210x_dev *dev)
 {
-	u16 status = tsc210x_read_sync(dev, TSC210X_TS_STATUS_CTRL);
-	if (status & 0x0fff)
-		printk("TSC210x: data in");
-	if (status & 0x0400)
-		printk(" X");
-	if (status & 0x0200)
-		printk(" Y");
-	if (status & 0x0100)
-		printk(" Z1");
-	if (status & 0x0080)
-		printk(" Z2");
-	if (status & 0x0040)
-		printk(" BAT1");
-	if (status & 0x0020)
-		printk(" BAT2");
-	if (status & 0x0010)
-		printk(" AUX1");
-	if (status & 0x0008)
-		printk(" AUX2");
-	if (status & 0x0004)
-		printk(" TEMP1");
-	if (status & 0x0002)
-		printk(" TEMP2");
-	if (status & 0x0001)
-		printk(" KP");
-	if (status & 0x0fff)
-		printk(".\n");
+	int status = tsc210x_read_sync(dev, TSC210X_TS_STATUS_CTRL);
+
+	if (status < 0) {
+		dev_dbg(&dev->spi->dev, "status %d\n", status);
+		return;
+	}
+
+	if (!(status & 0x0fff))
+		return;
+
+	dev_dbg(&dev->spi->dev, "data in %s%s%s%s%s%s%s%s%s%s%s\n",
+		(status & 0x0400) ? " X" : "",
+		(status & 0x0200) ? " Y" : "",
+		(status & 0x0100) ? " Z1" : "",
+		(status & 0x0080) ? " Z2" : "",
+		(status & 0x0040) ? " BAT1" : "",
+		(status & 0x0020) ? " BAT2" : "",
+		(status & 0x0010) ? " AUX1" : "",
+		(status & 0x0008) ? " AUX2" : "",
+		(status & 0x0004) ? " TEMP1" : "",
+		(status & 0x0002) ? " TEMP2" : "",
+		(status & 0x0001) ? " KP" : "");
 }
 #endif
 
@@ -365,18 +379,20 @@ static void tsc210x_queue_scan(struct ts
 {
 	if (dev->pdata->monitor)
 		if (!queue_delayed_work(dev->queue,
-					&dev->sensor_worker,
-					msecs_to_jiffies(settings.mode_msecs)))
-			printk(KERN_ERR "%s: can't queue measurements\n",
+				&dev->sensor_worker,
+				msecs_to_jiffies(settings.mode_msecs)))
+			dev_err(&dev->spi->dev,
+					"%s: can't queue measurements\n",
 					__FUNCTION__);
 }
 
 static void tsc210x_queue_penup(struct tsc210x_dev *dev)
 {
 	if (!queue_delayed_work(dev->queue,
-				&dev->ts_worker,
-				msecs_to_jiffies(settings.ts_msecs)))
-		printk(KERN_ERR "%s: can't queue pen-up poll\n",
+			&dev->ts_worker,
+			msecs_to_jiffies(settings.ts_msecs)))
+		dev_err(&dev->spi->dev,
+				"%s: can't queue pen-up poll\n",
 				__FUNCTION__);
 }
 
@@ -398,16 +414,17 @@ static void tsc210x_status_report(struct
 		tsc210x_submit_async(&dev->req_adc);
 	}
 
-	if (dev->status & (TSC210X_PS_DAV | TSC210X_T1_DAV |TSC210X_T2_DAV))
+	if (dev->status & (TSC210X_PS_DAV | TSC210X_T1_DAV | TSC210X_T2_DAV))
 		complete(&dev->data_avail);
 }
 
 static void tsc210x_data_report(struct tsc210x_dev *dev)
 {
-	uint16_t adc_data[4];
+	u16 adc_data[4];
 
 	if (dev->status & TSC210X_PS_DAV) {
 		tsc210x_reads_sync(dev, TSC210X_TS_BAT1, adc_data, 4);
+		/* NOTE: reads_sync() could fail */
 
 		dev->bat[0] = adc_data[0];
 		dev->bat[1] = adc_data[1];
@@ -420,14 +437,14 @@ static void tsc210x_data_report(struct t
 	if (dev->status & TSC210X_T1_DAV) {
 		dev->temp[0] = tsc210x_read_sync(dev, TSC210X_TS_TEMP1);
 
-		if (dev->temp1_cb)
+		if (dev->temp[0] >= 0 && dev->temp1_cb)
 			dev->temp1_cb(dev->temp1_cb_ctx, dev->temp[0]);
 	}
 
 	if (dev->status & TSC210X_T2_DAV) {
 		dev->temp[1] = tsc210x_read_sync(dev, TSC210X_TS_TEMP2);
 
-		if (dev->temp2_cb)
+		if (dev->temp[1] >= 0 && dev->temp2_cb)
 			dev->temp2_cb(dev->temp2_cb_ctx, dev->temp[1]);
 	}
 }
@@ -456,16 +473,20 @@ static void tsc210x_pressure(struct work
 {
 	struct tsc210x_dev *dev =
 		container_of(work, struct tsc210x_dev, ts_worker.work);
-	uint16_t adc_status;
+	int adc_status;
 
-	BUG_ON(!dev->pendown);
+	WARN_ON(!dev->pendown);
 
 	adc_status = tsc210x_read_sync(dev, TSC210X_TS_ADC_CTRL);
+	if (adc_status < 0) {
+		dev_dbg(&dev->spi->dev, "pressure, err %d\n", adc_status);
+		return;
+	}
 
-	if ((adc_status & TSC210X_ADC_PSTCM) ||
-			!(adc_status & TSC210X_ADC_ADST)) {
+	if ((adc_status & TSC210X_ADC_PSTCM) != 0
+			|| !(adc_status & TSC210X_ADC_ADST))
 		tsc210x_queue_penup(dev);
-	} else {
+	else {
 		dev->pendown = 0;
 		if (dev->touch_cb)
 			dev->touch_cb(dev->touch_cb_ctx, 0);
@@ -519,17 +540,26 @@ static irqreturn_t tsc210x_handler(int i
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_SOUND
+#if defined(CONFIG_SOUND) || defined(CONFIG_SOUND_MODULE)
+
+/*
+ * FIXME the audio support shouldn't be included in upstream patches
+ * until it's ready.  They might be better as utility functions linked
+ * with a chip-specific tsc21xx audio module ... e.g. chips with input
+ * channels need more, as will ones with multiple output channels and
+ * so on.  Each of these functions should probably return a fault code,
+ * and will need to be exported so the sound drier can be modular.
+ */
+
 /*
  * Volume level values should be in the range [0, 127].
  * Higher values mean lower volume.
  */
-void tsc210x_set_dac_volume(struct device *dev,
-		uint8_t left_ch, uint8_t right_ch)
+void tsc210x_set_dac_volume(struct device *dev, u8 left_ch, u8 right_ch)
 {
-	struct tsc210x_dev *tsc = (struct tsc210x_dev *)
-		platform_get_drvdata(to_platform_device(dev));
-	u16 val;
+	struct tsc210x_dev *tsc = dev_get_drvdata(dev);
+	int val;
+
 	if (tsc->kind == tsc2102) {
 		/* All 0's or all 1's */
 		if (left_ch == 0x00 || left_ch == 0x7f)
@@ -539,34 +569,46 @@ void tsc210x_set_dac_volume(struct devic
 	}
 
 	val = tsc210x_read_sync(tsc, TSC210X_DAC_GAIN_CTRL);
+	if (val < 0) {
+		dev_dbg(dev, "%s, err %d\n", __FUNCTION__, val);
+		return;
+	}
 
 	val &= 0x8080;	/* Preserve mute-bits */
 	val |= (left_ch << 8) | right_ch;
 
 	tsc210x_write_sync(tsc, TSC210X_DAC_GAIN_CTRL, val);
+	/* NOTE: write_sync() could fail */
 }
 
 void tsc210x_set_dac_mute(struct device *dev, int left_ch, int right_ch)
 {
-	struct tsc210x_dev *tsc = (struct tsc210x_dev *)
-		platform_get_drvdata(to_platform_device(dev));
-	u16 val;
+	struct tsc210x_dev *tsc = dev_get_drvdata(dev);
+	int val;
 
 	val = tsc210x_read_sync(tsc, TSC210X_DAC_GAIN_CTRL);
+	if (val < 0) {
+		dev_dbg(dev, "%s, err %d\n", __FUNCTION__, val);
+		return;
+	}
 
 	val &= 0x7f7f;	/* Preserve volume settings */
 	val |= (left_ch << 15) | (right_ch << 7);
 
 	tsc210x_write_sync(tsc, TSC210X_DAC_GAIN_CTRL, val);
+	/* NOTE: write_sync() could fail */
 }
 
 void tsc210x_get_dac_mute(struct device *dev, int *left_ch, int *right_ch)
 {
-	struct tsc210x_dev *tsc = (struct tsc210x_dev *)
-		platform_get_drvdata(to_platform_device(dev));
-	u16 val;
+	struct tsc210x_dev *tsc = dev_get_drvdata(dev);
+	int val;
 
 	val = tsc210x_read_sync(tsc, TSC210X_DAC_GAIN_CTRL);
+	if (val < 0) {
+		dev_dbg(dev, "%s, err %d\n", __FUNCTION__, val);
+		return;
+	}
 
 	*left_ch = !!(val & (1 << 15));
 	*right_ch = !!(val & (1 << 7));
@@ -574,10 +616,14 @@ void tsc210x_get_dac_mute(struct device 
 
 void tsc210x_set_deemphasis(struct device *dev, int enable)
 {
-	struct tsc210x_dev *tsc = (struct tsc210x_dev *)
-		platform_get_drvdata(to_platform_device(dev));
-	u16 val;
+	struct tsc210x_dev *tsc = dev_get_drvdata(dev);
+	int val;
+
 	val = tsc210x_read_sync(tsc, TSC210X_POWER_CTRL);
+	if (val < 0) {
+		dev_dbg(dev, "%s, err %d\n", __FUNCTION__, val);
+		return;
+	}
 
 	if (enable)
 		val &= ~TSC210X_DEEMPF;
@@ -585,14 +631,19 @@ void tsc210x_set_deemphasis(struct devic
 		val |= TSC210X_DEEMPF;
 
 	tsc210x_write_sync(tsc, TSC210X_POWER_CTRL, val);
+	/* NOTE: write_sync() could fail */
 }
 
 void tsc2102_set_bassboost(struct device *dev, int enable)
 {
-	struct tsc210x_dev *tsc = (struct tsc210x_dev *)
-		platform_get_drvdata(to_platform_device(dev));
-	u16 val;
+	struct tsc210x_dev *tsc = dev_get_drvdata(dev);
+	int val;
+
 	val = tsc210x_read_sync(tsc, TSC210X_POWER_CTRL);
+	if (val < 0) {
+		dev_dbg(dev, "%s, err %d\n", __FUNCTION__, val);
+		return;
+	}
 
 	if (enable)
 		val &= ~TSC2102_BASSBC;
@@ -600,6 +651,7 @@ void tsc2102_set_bassboost(struct device
 		val |= TSC2102_BASSBC;
 
 	tsc210x_write_sync(tsc, TSC210X_POWER_CTRL, val);
+	/* NOTE: write_sync() could fail */
 }
 
 /*	{rate, dsor, fsref}	*/
@@ -629,7 +681,7 @@ static const struct tsc210x_rate_info_s 
 	{44100,	0,	1},
 	{48000,	0,	0},
 
-	{0,	0, 	0},
+	{0,	0,	0},
 };
 
 /*	{rate, dsor, fsref}	*/
@@ -659,15 +711,14 @@ static const struct tsc210x_rate_info_s 
 	{44100,	0,	1},
 	{48000,	0,	0},
 
-	{0,	0, 	0},
+	{0,	0,	0},
 };
 
 int tsc210x_set_rate(struct device *dev, int rate)
 {
-	struct tsc210x_dev *tsc = (struct tsc210x_dev *)
-		platform_get_drvdata(to_platform_device(dev));
+	struct tsc210x_dev *tsc = dev_get_drvdata(dev);
 	int i;
-	uint16_t val;
+	int val;
 	const struct tsc210x_rate_info_s *rates;
 
 	if (tsc->kind == tsc2101)
@@ -679,21 +730,30 @@ int tsc210x_set_rate(struct device *dev,
 		if (rates[i].sample_rate == rate)
 			break;
 	if (rates[i].sample_rate == 0) {
-		printk(KERN_ERR "Unknown sampling rate %i.0 Hz\n", rate);
+		dev_err(dev, "Unknown sampling rate %i.0 Hz\n", rate);
 		return -EINVAL;
 	}
 
 	if (tsc->kind == tsc2101) {
-		val = tsc210x_read_sync(tsc, TSC210X_AUDIO1_CTRL) &
-			~((7 << 3) | (7 << 0));
+		val = tsc210x_read_sync(tsc, TSC210X_AUDIO1_CTRL);
+		if (val < 0) {
+			dev_dbg(dev, "%s, err %d\n", __FUNCTION__, val);
+			return val;
+		}
+		val &= ~((7 << 3) | (7 << 0));
 		val |= rates[i].divisor << 3;
 		val |= rates[i].divisor << 0;
 	} else
 		val = rates[i].divisor;
 
 	tsc210x_write_sync(tsc, TSC210X_AUDIO1_CTRL, val);
+	/* NOTE: write_sync() could fail */
 
 	val = tsc210x_read_sync(tsc, TSC210X_AUDIO3_CTRL);
+	if (val < 0) {
+		dev_dbg(dev, "%s, err %d\n", __FUNCTION__, val);
+		return val;
+	}
 
 	if (tsc2102_rates[i].fs_44k) {
 		tsc210x_write_sync(tsc,
@@ -717,9 +777,9 @@ int tsc210x_set_rate(struct device *dev,
  */
 void tsc210x_dac_power(struct device *dev, int on)
 {
-	struct tsc210x_dev *tsc = (struct tsc210x_dev *)
-		platform_get_drvdata(to_platform_device(dev));
+	struct tsc210x_dev *tsc = dev_get_drvdata(dev);
 
+	/* NOTE: write_sync() could fail */
 	if (on) {
 		/* 16-bit words, DSP mode, sample at Fsref */
 		tsc210x_write_sync(tsc,
@@ -760,12 +820,16 @@ void tsc210x_dac_power(struct device *de
 
 void tsc210x_set_i2s_master(struct device *dev, int state)
 {
-	struct tsc210x_dev *tsc = (struct tsc210x_dev *)
-		platform_get_drvdata(to_platform_device(dev));
-	uint16_t val;
+	struct tsc210x_dev *tsc = dev_get_drvdata(dev);
+	int val;
 
 	val = tsc210x_read_sync(tsc, TSC210X_AUDIO3_CTRL);
+	if (val < 0) {
+		dev_dbg(dev, "%s, err %d\n", __FUNCTION__, val);
+		return;
+	}
 
+	/* NOTE: write_sync() could fail */
 	if (state)
 		tsc210x_write_sync(tsc, TSC210X_AUDIO3_CTRL,
 				val | TSC210X_SLVMS);
@@ -777,6 +841,8 @@ void tsc210x_set_i2s_master(struct devic
 
 static int tsc210x_configure(struct tsc210x_dev *dev)
 {
+	/* NOTE: write_sync() could fail */
+
 	/* Reset the chip */
 	tsc210x_write_sync(dev, TSC210X_TS_RESET_CTRL, TSC210X_RESET);
 
@@ -798,19 +864,17 @@ static int tsc210x_configure(struct tsc2
 	return 0;
 }
 
-/*
- * Retrieves chip revision.  Should be always 1.
- */
-int tsc210x_get_revision(struct tsc210x_dev *dev)
-{
-	return tsc210x_read_sync(dev, TSC210X_AUDIO3_CTRL) & 7;
-}
-
 void tsc210x_keyclick(struct tsc210x_dev *dev,
 		int amplitude, int freq, int length)
 {
-	u16 val;
+	int val;
+
 	val = tsc210x_read_sync(dev, TSC210X_AUDIO2_CTRL);
+	if (val < 0) {
+		dev_dbg(&dev->spi->dev, "%s, err %d\n",
+				__FUNCTION__, val);
+		return;
+	}
 	val &= 0x800f;
 
 	/* Set amplitude */
@@ -845,8 +909,10 @@ void tsc210x_keyclick(struct tsc210x_dev
 	/* Enable keyclick */
 	val |= 0x8000;
 
+	/* NOTE: write_sync() could fail */
 	tsc210x_write_sync(dev, TSC210X_AUDIO2_CTRL, val);
 }
+EXPORT_SYMBOL(tsc210x_keyclick);
 
 #ifdef CONFIG_PM
 /*
@@ -873,8 +939,7 @@ tsc210x_suspend(struct spi_device *spi, 
 
 	/* Abort current conversion and power down the ADC */
 	tsc210x_write_sync(dev, TSC210X_TS_ADC_CTRL, TSC210X_ADC_ADST);
-
-	dev->spi->dev.power.power_state = state;
+	/* NOTE: write_sync() could fail */
 
 	return 0;
 }
@@ -890,8 +955,6 @@ static int tsc210x_resume(struct spi_dev
 	if (!dev)
 		return 0;
 
-	dev->spi->dev.power.power_state = PMSG_ON;
-
 	spin_lock(&dev->queue_lock);
 	err = tsc210x_configure(dev);
 
@@ -905,19 +968,20 @@ static int tsc210x_resume(struct spi_dev
 #define tsc210x_resume	NULL
 #endif
 
+/* REVISIT don't make these static */
 static struct platform_device tsc210x_ts_device = {
-	.name 		= "tsc210x-ts",
-	.id 		= -1,
+	.name		= "tsc210x-ts",
+	.id		= -1,
 };
 
 static struct platform_device tsc210x_hwmon_device = {
-	.name 		= "tsc210x-hwmon",
-	.id 		= -1,
+	.name		= "tsc210x-hwmon",
+	.id		= -1,
 };
 
 static struct platform_device tsc210x_alsa_device = {
-	.name 		= "tsc210x-alsa",
-	.id 		= -1,
+	.name		= "tsc210x-alsa",
+	.id		= -1,
 };
 
 static int tsc210x_probe(struct spi_device *spi, enum tsc_type type)
@@ -925,22 +989,23 @@ static int tsc210x_probe(struct spi_devi
 	struct tsc210x_config *pdata = spi->dev.platform_data;
 	struct spi_transfer *spi_buffer;
 	struct tsc210x_dev *dev;
+	int reg;
 	int err = 0;
 
 	if (!pdata) {
-		printk(KERN_ERR "TSC210x: Platform data not supplied\n");
+		dev_dbg(&spi->dev, "Platform data not supplied\n");
 		return -ENOENT;
 	}
 
 	if (!spi->irq) {
-		printk(KERN_ERR "TSC210x: Invalid irq value\n");
+		dev_dbg(&spi->dev, "Invalid irq value\n");
 		return -EINVAL;
 	}
 
 	dev = (struct tsc210x_dev *)
 		kzalloc(sizeof(struct tsc210x_dev), GFP_KERNEL);
 	if (!dev) {
-		printk(KERN_ERR "TSC210x: No memory\n");
+		dev_dbg(&spi->dev, "No memory\n");
 		return -ENOMEM;
 	}
 
@@ -950,7 +1015,7 @@ static int tsc210x_probe(struct spi_devi
 	dev->kind = type;
 	dev->queue = create_singlethread_workqueue(spi->dev.driver->name);
 	if (!dev->queue) {
-		printk(KERN_ERR "TSC210x: Can't make a workqueue\n");
+		dev_dbg(&spi->dev, "Can't make a workqueue\n");
 		err = -ENOMEM;
 		goto err_queue;
 	}
@@ -961,7 +1026,7 @@ static int tsc210x_probe(struct spi_devi
 	/* Allocate enough struct spi_transfer's for all requests */
 	spi_buffer = kzalloc(sizeof(struct spi_transfer) * 16, GFP_KERNEL);
 	if (!spi_buffer) {
-		printk(KERN_ERR "TSC210x: No memory for SPI buffers\n");
+		dev_dbg(&spi->dev, "No memory for SPI buffers\n");
 		err = -ENOMEM;
 		goto err_buffers;
 	}
@@ -974,10 +1039,10 @@ static int tsc210x_probe(struct spi_devi
 			TSC210X_TS_STATUS_CTRL, 1, &dev->status,
 			tsc210x_status_report, &spi_buffer);
 	tsc210x_request_alloc(dev, &dev->req_mode, 1,
-			TSC210X_TS_ADC_CTRL, 1, 0,
+			TSC210X_TS_ADC_CTRL, 1, NULL,
 			tsc210x_complete_dummy, &spi_buffer);
 	tsc210x_request_alloc(dev, &dev->req_stop, 1,
-			TSC210X_TS_ADC_CTRL, 1, 0,
+			TSC210X_TS_ADC_CTRL, 1, NULL,
 			tsc210x_complete_dummy, &spi_buffer);
 
 	if (pdata->bclk) {
@@ -985,7 +1050,7 @@ static int tsc210x_probe(struct spi_devi
 		dev->bclk_ck = clk_get(&spi->dev, pdata->bclk);
 		if (IS_ERR(dev->bclk_ck)) {
 			err = PTR_ERR(dev->bclk_ck);
-			printk(KERN_ERR "Unable to get '%s': %i\n",
+			dev_dbg(&spi->dev, "Unable to get '%s': %i\n",
 					pdata->bclk, err);
 			goto err_clk;
 		}
@@ -998,20 +1063,36 @@ static int tsc210x_probe(struct spi_devi
 
 	/* Setup the communication bus */
 	dev_set_drvdata(&spi->dev, dev);
-	spi->dev.power.power_state = PMSG_ON;
 	spi->mode = SPI_MODE_1;
 	spi->bits_per_word = 16;
 	err = spi_setup(spi);
 	if (err)
 		goto err_spi;
 
-	/* Now try to detect the chip, make first contact */
-	if (tsc210x_get_revision(dev) != 0x1) {
-		printk(KERN_ERR "No TI %s chip found!\n",
-				spi->dev.driver->name);
-		err = -ENODEV;
+	/* Now try to detect the chip, make first contact.  These chips
+	 * don't self-identify, but we can expect that the status register
+	 * reports the ADC is idle and use that as a sanity check.  (It'd
+	 * be even better if we did a soft reset first...)
+	 */
+	reg = tsc210x_read_sync(dev, TSC210X_TS_ADC_CTRL);
+	if (reg < 0) {
+		err = reg;
+		dev_dbg(&dev->spi->dev, "adc_ctrl, err %d\n", err);
 		goto err_spi;
 	}
+	if (!(reg & (1 << 14))) {
+		err = -EIO;
+		dev_dbg(&dev->spi->dev, "adc_ctrl, busy? - %04x\n", reg);
+		goto err_spi;
+	}
+
+	reg = tsc210x_read_sync(dev, TSC210X_AUDIO3_CTRL);
+	if (reg < 0) {
+		err = reg;
+		dev_dbg(&dev->spi->dev, "revision, err %d\n", err);
+		goto err_spi;
+	}
+	dev_info(&spi->dev, "rev %d, irq %d\n", reg & 0x0007, spi->irq);
 
 	err = tsc210x_configure(dev);
 	if (err)
@@ -1024,7 +1105,7 @@ static int tsc210x_probe(struct spi_devi
 	if (request_irq(spi->irq, tsc210x_handler, IRQF_SAMPLE_RANDOM |
 				IRQF_TRIGGER_FALLING, spi->dev.driver->name,
 				dev)) {
-		printk(KERN_ERR "Could not allocate touchscreen IRQ!\n");
+		dev_dbg(&spi->dev, "Could not allocate touchscreen IRQ!\n");
 		err = -EINVAL;
 		goto err_irq;
 	}
@@ -1098,6 +1179,7 @@ static int tsc210x_remove(struct spi_dev
 
 	/* Abort current conversion and power down the ADC */
 	tsc210x_write_sync(dev, TSC210X_TS_ADC_CTRL, TSC210X_ADC_ADST);
+	/* NOTE: write_sync() could fail */
 
 	destroy_workqueue(dev->queue);
 
@@ -1161,21 +1243,15 @@ static int __init tsc210x_init(void)
 
 	return err;
 }
+module_init(tsc210x_init);
 
 static void __exit tsc210x_exit(void)
 {
 	spi_unregister_driver(&tsc2101_driver);
 	spi_unregister_driver(&tsc2102_driver);
 }
-
-module_init(tsc210x_init);
 module_exit(tsc210x_exit);
 
-EXPORT_SYMBOL(tsc210x_read_sync);
-EXPORT_SYMBOL(tsc210x_reads_sync);
-EXPORT_SYMBOL(tsc210x_write_sync);
-EXPORT_SYMBOL(tsc210x_keyclick);
-
 MODULE_AUTHOR("Andrzej Zaborowski");
 MODULE_DESCRIPTION("Interface driver for TI TSC210x chips.");
 MODULE_LICENSE("GPL");
--- h4.orig/include/linux/spi/tsc210x.h	2007-08-13 15:40:13.000000000 -0700
+++ h4/include/linux/spi/tsc210x.h	2007-08-13 22:10:26.000000000 -0700
@@ -24,15 +24,16 @@
 #define __LINUX_SPI_TSC210X_H
 
 struct apm_power_info;
+
 struct tsc210x_config {
 	int use_internal;	/* Use internal reference voltage */
-	uint32_t monitor;	/* What inputs are relevant */
+	u32 monitor;		/* What inputs are wired on this board */
 	int temp_at25c[2];	/* Thermometer calibration data */
 	void (*apm_report)(struct apm_power_info *info, int battery[]);
 				/* Report status to APM based on battery[] */
 	void *alsa_config;	/* .platform_data for the ALSA device */
-	const char *mclk;	/* Optional: bclk name */
-	const char *bclk;	/* Optional: mclk name */
+	const char *mclk;	/* Optional: mclk name */
+	const char *bclk;	/* Optional: bclk name */
 };
 
 #define TSC_BAT1	(1 << 0)
@@ -45,16 +46,25 @@ struct tsc210x_config {
 #define TSC_VBAT	TSC_BAT1
 
 struct tsc210x_dev;
-extern u16 tsc210x_read_sync(struct tsc210x_dev *dev, int page, u8 address);
-extern void tsc210x_reads_sync(struct tsc210x_dev *dev, int page,
+
+/* Drivers for tsc210x components like touchscreen, sensor, and audio
+ * are packaged as platform drivers which can issue synchronous register
+ * acceses, and may also register a callback to process their particular
+ * type of data when that data is automatically sampled.  The platform
+ * device is a child of the TSC spi device.
+ */
+
+extern int tsc210x_read_sync(struct tsc210x_dev *dev, int page, u8 address);
+extern int tsc210x_reads_sync(struct tsc210x_dev *dev, int page,
 		u8 startaddress, u16 *data, int numregs);
-extern void tsc210x_write_sync(struct tsc210x_dev *dev, int page,
+extern int tsc210x_write_sync(struct tsc210x_dev *dev, int page,
 		u8 address, u16 data);
 
 typedef void (*tsc210x_touch_t)(void *context, int touching);
 typedef void (*tsc210x_coords_t)(void *context, int x, int y, int z1, int z2);
 typedef void (*tsc210x_ports_t)(void *context, int bat[], int aux[]);
 typedef void (*tsc210x_temp_t)(void *context, int temp);
+
 extern int tsc210x_touch_cb(struct device *dev,
 		tsc210x_touch_t handler, void *context);
 extern int tsc210x_coords_cb(struct device *dev,
@@ -66,13 +76,10 @@ extern int tsc210x_temp1_cb(struct devic
 extern int tsc210x_temp2_cb(struct device *dev,
 		tsc210x_temp_t handler, void *context);
 
-#ifdef CONFIG_SOUND
-extern void tsc210x_set_dac_volume(struct device *dev,
-		uint8_t left_ch, uint8_t right_ch);
-extern void tsc210x_set_dac_mute(struct device *dev,
-		int left_ch, int right_ch);
-extern void tsc210x_get_dac_mute(struct device *dev,
-		int *left_ch, int *right_ch);
+#if defined(CONFIG_SOUND) || defined(CONFIG_SOUND_MODULE)
+extern void tsc210x_set_dac_volume(struct device *dev, u8 left, u8 right);
+extern void tsc210x_set_dac_mute(struct device *dev, int left, int right);
+extern void tsc210x_get_dac_mute(struct device *dev, int *left, int *right);
 extern void tsc210x_dac_power(struct device *dev, int on);
 extern int tsc210x_set_rate(struct device *dev, int rate);
 extern void tsc210x_set_i2s_master(struct device *dev, int state);

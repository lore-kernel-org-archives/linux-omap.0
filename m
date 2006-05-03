From: David Brownell <david-b@pacbell.net>
Subject: [PATCH 2.6.17-rc3-omap] ads7846 updates, mostly for hwmon
Date: Tue, 2 May 2006 22:21:25 -0700
Message-ID: <200605022221.26049.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_W3DWElJsOn2kU67"
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

--Boundary-00=_W3DWElJsOn2kU67
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here's a patch for the ads7846 driver ... mostly adds hwmon support, but
it also handles the byte order correctly.  (That is, the fix should not
have been in the OMAP tree's ads7846 code, but in omap_uwire instead.)

It goes no top of the omap_uwire patch, and also the OSK/Mistral update
I sent a few days ago.

(I've sent a separate version of this patch upstream already, which doesn't
need to revert those byteswap changes).

- Dave


--Boundary-00=_W3DWElJsOn2kU67
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ads7846-hwmon.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ads7846-hwmon.patch"

The ads784x chips include not just touchscreen sensors but also temperature
and voltage sensors, which are traditional hwmon fodder.

 - Register with the hwmon framework
    * hwmon needs to use subsys_init() so it's available early enough
 - Adopt hwmon convention for presenting voltages:
    * Report voltages in millivolts
    * Attribute names are "in[0-8]_input" (meaningless, ugh)
 - Be more accurate for the hwmon values:
    * vBATT gets range-adjusted
    * Discard the extra bit sent before the sample.

Battery measurements help during battery recharge monitoring.  On OSK/Mistral,
the measured voltage agreed with a multimeter until the fourth decimal place.

NOTE:  this version is only for the OMAP tree, which has some byteswap bugs
(and other changes) that are not found in the upstream kernels.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>


Index: osk/drivers/input/touchscreen/Kconfig
===================================================================
--- osk.orig/drivers/input/touchscreen/Kconfig	2006-05-02 19:18:31.000000000 -0700
+++ osk/drivers/input/touchscreen/Kconfig	2006-05-02 19:18:46.000000000 -0700
@@ -14,10 +14,13 @@ if INPUT_TOUCHSCREEN
 config TOUCHSCREEN_ADS7846
 	tristate "ADS 7846 based touchscreens"
 	depends on SPI_MASTER
+	select HWMON
 	help
 	  Say Y here if you have a touchscreen interface using the
 	  ADS7846 controller, and your board-specific initialization
-	  code includes that in its table of SPI devices.
+	  code includes that in its table of SPI devices.  You will
+	  also get hwmon interfaces for the temperature and voltage
+	  sensors this chip provides.
 
 	  If unsure, say N (but it's safe to say "Y").
 
Index: osk/drivers/hwmon/hwmon.c
===================================================================
--- osk.orig/drivers/hwmon/hwmon.c	2006-05-02 19:18:31.000000000 -0700
+++ osk/drivers/hwmon/hwmon.c	2006-05-02 19:18:46.000000000 -0700
@@ -102,7 +102,7 @@ static void __exit hwmon_exit(void)
 	class_destroy(hwmon_class);
 }
 
-module_init(hwmon_init);
+subsys_initcall(hwmon_init);
 module_exit(hwmon_exit);
 
 EXPORT_SYMBOL_GPL(hwmon_device_register);
Index: osk/drivers/input/touchscreen/ads7846.c
===================================================================
--- osk.orig/drivers/input/touchscreen/ads7846.c	2006-05-02 19:18:31.000000000 -0700
+++ osk/drivers/input/touchscreen/ads7846.c	2006-05-02 20:11:03.000000000 -0700
@@ -16,8 +16,9 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
-#include <linux/device.h>
+#include <linux/hwmon.h>
 #include <linux/init.h>
+#include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
@@ -36,13 +37,9 @@
 
 /*
  * This code has been heavily tested on a Nokia 770, and lightly
- * tested on an other ads7846 device.
+ * tested on other ads7846 devices (OSK/Mistral, Lubbock).
  * Support for ads7843 and ads7845 has only been stubbed in.
  *
- * Not yet done:  How accurate are the temperature and voltage
- * readings? (System-specific calibration should support
- * accuracy of 0.3 degrees C; otherwise it's 2.0 degrees.)
- *
  * IRQ handling needs a workaround because of a shortcoming in handling
  * edge triggered IRQs on some platforms like the OMAP1/2. These
  * platforms don't handle the ARM lazy IRQ disabling properly, thus we
@@ -78,6 +75,7 @@ struct ads7846 {
 	char			phys[32];
 
 	struct spi_device	*spi;
+	struct class_device	*hwmon;
 	u16			model;
 	u16			vref_delay_usecs;
 	u16			x_plate_ohms;
@@ -164,7 +162,12 @@ struct ads7846 {
 
 /*
  * Non-touchscreen sensors only use single-ended conversions.
+ * The range is GND..vREF. The ads7843 and ads7835 must use external vREF;
+ * ads7846 lets that pin be unconnected, to use internal vREF.
+ *
+ * FIXME make external vREF_mV be a module option, and use that as needed...
  */
+static const unsigned vREF_mV = 2500;
 
 struct ser_req {
 	u8			ref_on;
@@ -186,50 +189,55 @@ static int ads7846_read12_ser(struct dev
 	struct ser_req		*req = kzalloc(sizeof *req, SLAB_KERNEL);
 	int			status;
 	int			sample;
-	int			i;
+	int			use_internal;
 
 	if (!req)
 		return -ENOMEM;
 
 	spi_message_init(&req->msg);
 
-	/* activate reference, so it has time to settle; */
-	req->ref_on = REF_ON;
-	req->xfer[0].tx_buf = &req->ref_on;
-	req->xfer[0].len = 1;
-	req->xfer[1].rx_buf = &req->scratch;
-	req->xfer[1].len = 2;
-
-	/*
-	 * for external VREF, 0 usec (and assume it's always on);
-	 * for 1uF, use 800 usec;
-	 * no cap, 100 usec.
-	 */
-	req->xfer[1].delay_usecs = ts->vref_delay_usecs;
+	/* FIXME boards with ads7846 might use external vref instead ... */
+	use_internal = (ts->model == 7846);
+
+	/* maybe turn on internal vREF, and let it settle */
+	if (use_internal) {
+		req->ref_on = REF_ON;
+		req->xfer[0].tx_buf = &req->ref_on;
+		req->xfer[0].len = 1;
+		spi_message_add_tail(&req->xfer[0], &req->msg);
+
+		req->xfer[1].rx_buf = &req->scratch;
+		req->xfer[1].len = 2;
+
+		/* for 1uF, settle for 800 usec; no cap, 100 usec.  */
+		req->xfer[1].delay_usecs = ts->vref_delay_usecs;
+		spi_message_add_tail(&req->xfer[1], &req->msg);
+	}
 
 	/* take sample */
 	req->command = (u8) command;
 	req->xfer[2].tx_buf = &req->command;
 	req->xfer[2].len = 1;
+	spi_message_add_tail(&req->xfer[2], &req->msg);
+
 	req->xfer[3].rx_buf = &req->sample;
 	req->xfer[3].len = 2;
+	spi_message_add_tail(&req->xfer[3], &req->msg);
 
 	/* REVISIT:  take a few more samples, and compare ... */
 
-	/* turn off reference */
-	req->ref_off = REF_OFF;
-	req->xfer[4].tx_buf = &req->ref_off;
-	req->xfer[4].len = 1;
-	req->xfer[5].rx_buf = &req->scratch;
-	req->xfer[5].len = 2;
-
-	CS_CHANGE(req->xfer[5]);
-
-	/* group all the transfers together, so we can't interfere with
-	 * reading touchscreen state; disable penirq while sampling
-	 */
-	for (i = 0; i < 6; i++)
-		spi_message_add_tail(&req->xfer[i], &req->msg);
+	/* maybe off internal vREF */
+	if (use_internal) {
+		req->ref_off = REF_OFF;
+		req->xfer[4].tx_buf = &req->ref_off;
+		req->xfer[4].len = 1;
+		spi_message_add_tail(&req->xfer[4], &req->msg);
+
+		req->xfer[5].rx_buf = &req->scratch;
+		req->xfer[5].len = 2;
+		CS_CHANGE(req->xfer[5]);
+		spi_message_add_tail(&req->xfer[5], &req->msg);
+	}
 
 	disable_irq(spi->irq);
 	status = spi_sync(spi, &req->msg);
@@ -237,28 +245,70 @@ static int ads7846_read12_ser(struct dev
 
 	if (req->msg.status)
 		status = req->msg.status;
+
+	/* on-wire is a must-ignore bit, a BE12 value, then padding */
 	sample = be16_to_cpu(req->sample);
-	sample = sample >> 4;
-	kfree(req);
+	sample = sample >> 3;
+	sample &= 0x0fff;
 
+	kfree(req);
 	return status ? status : sample;
 }
 
-#define SHOW(name) static ssize_t \
+#define SHOW(name,var,adjust) static ssize_t \
 name ## _show(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
+	struct ads7846 *ts = dev_get_drvdata(dev); \
 	ssize_t v = ads7846_read12_ser(dev, \
-			READ_12BIT_SER(name) | ADS_PD10_ALL_ON); \
+			READ_12BIT_SER(var) | ADS_PD10_ALL_ON); \
 	if (v < 0) \
 		return v; \
-	return sprintf(buf, "%u\n", (unsigned) v); \
+	return sprintf(buf, "%u\n", adjust(ts, v)); \
 } \
 static DEVICE_ATTR(name, S_IRUGO, name ## _show, NULL);
 
-SHOW(temp0)
-SHOW(temp1)
-SHOW(vaux)
-SHOW(vbatt)
+
+/* Sysfs conventions report temperatures in millidegrees Celcius.
+ * We could use the low-accuracy two-sample scheme, but can't do the high
+ * accuracy scheme without calibration data.  For now we won't try either;
+ * userspace sees raw sensor values, and must scale appropriately.
+ */
+static inline unsigned null_adjust(struct ads7846 *ts, ssize_t v)
+{
+	return v;
+}
+
+SHOW(temp0, temp0, null_adjust)		// temp1_input
+SHOW(temp1, temp1, null_adjust)		// temp2_input
+
+
+/* sysfs conventions report voltages in millivolts.  We can convert voltages
+ * if we know vREF.  userspace may need to scale vAUX to match the board's
+ * external resistors; we assume that vBATT only uses the internal ones.
+ */
+static inline unsigned vaux_adjust(struct ads7846 *ts, ssize_t v)
+{
+	unsigned retval = v;
+
+	/* external resistors may scale vAUX into 0..vREF */
+	retval *= vREF_mV;
+	retval = retval >> 12;
+	return retval;
+}
+
+static inline unsigned vbatt_adjust(struct ads7846 *ts, ssize_t v)
+{
+	unsigned retval = vaux_adjust(ts, v);
+
+	/* ads7846 has a resistor ladder to scale this signal down */
+	if (ts->model == 7846)
+		retval *= 4;
+	return retval;
+}
+
+SHOW(in0_input, vaux, vaux_adjust)
+SHOW(in1_input, vbatt, vbatt_adjust)
+
 
 static int is_pen_down(struct device *dev)
 {
@@ -326,13 +376,13 @@ static void ads7846_rx(void *ads)
 	u16			x, y, z1, z2;
 	unsigned long		flags;
 
-	/* adjust:  12 bit samples (left aligned), built from
-	 * two 8 bit values writen msb-first.
+	/* adjust:  on-wire is a must-ignore bit, a BE12 value, then padding;
+	 * built from two 8 bit values written msb-first.
 	 */
-	x = ts->tc.x >> 3;
-	y = ts->tc.y >> 3;
-	z1 = ts->tc.z1 >> 3;
-	z2 = ts->tc.z2 >> 3;
+	x = (be16_to_cpu(ts->tc.x) >> 3) & 0x0fff;
+	y = (be16_to_cpu(ts->tc.y) >> 3) & 0x0fff;
+	z1 = (be16_to_cpu(ts->tc.z1) >> 3) & 0x0fff;
+	z2 = (be16_to_cpu(ts->tc.z2) >> 3) & 0x0fff;
 
 	/* range filtering */
 	if (x == MAX_12BIT)
@@ -560,6 +610,7 @@ static int __devinit ads7846_probe(struc
 {
 	struct ads7846			*ts;
 	struct input_dev		*input_dev;
+	struct class_device		*hwmon = ERR_PTR(-ENOMEM);
 	struct ads7846_platform_data	*pdata = spi->dev.platform_data;
 	struct spi_message		*m;
 	struct spi_transfer		*x;
@@ -585,12 +636,14 @@ static int __devinit ads7846_probe(struc
 	/* We'd set the wordsize to 12 bits ... except that some controllers
 	 * will then treat the 8 bit command words as 12 bits (and drop the
 	 * four MSBs of the 12 bit result).  Result: inputs must be shifted
-	 * to discard the four garbage LSBs.
+	 * to discard the four garbage LSBs.  (Also, not all controllers can
+	 * support 12 bit words.)
 	 */
 
 	ts = kzalloc(sizeof(struct ads7846), GFP_KERNEL);
 	input_dev = input_allocate_device();
-	if (!ts || !input_dev) {
+	hwmon = hwmon_device_register(&spi->dev);
+	if (!ts || !input_dev || IS_ERR(hwmon)) {
 		err = -ENOMEM;
 		goto err_free_mem;
 	}
@@ -600,6 +653,7 @@ static int __devinit ads7846_probe(struc
 
 	ts->spi = spi;
 	ts->input = input_dev;
+	ts->hwmon = hwmon;
 
 	init_timer(&ts->timer);
 	ts->timer.data = (unsigned long) ts;
@@ -737,27 +791,29 @@ static int __devinit ads7846_probe(struc
 		goto err_free_mem;
 	}
 
-	dev_info(&spi->dev, "touchscreen, irq %d\n", spi->irq);
+	dev_info(&spi->dev, "touchscreen + hwmon, irq %d\n", spi->irq);
 
-	/* take a first sample, leaving nPENIRQ active; avoid
+	/* take a first sample, leaving nPENIRQ active and vREF off; avoid
 	 * the touchscreen, in case it's not connected.
 	 */
 	(void) ads7846_read12_ser(&spi->dev,
 			  READ_12BIT_SER(vaux) | ADS_PD10_ALL_ON);
 
 	/* ads7843/7845 don't have temperature sensors, and
-	 * use the other sensors a bit differently too
+	 * use the other ADC lines a bit differently too
 	 */
 	if (ts->model == 7846) {
 		device_create_file(&spi->dev, &dev_attr_temp0);
 		device_create_file(&spi->dev, &dev_attr_temp1);
 	}
+	/* in1 == vBAT (7846), or a non-scaled ADC input */
 	if (ts->model != 7845)
-		device_create_file(&spi->dev, &dev_attr_vbatt);
-	device_create_file(&spi->dev, &dev_attr_vaux);
+		device_create_file(&spi->dev, &dev_attr_in1_input);
+	/* in0 == a non-scaled ADC input */
+	device_create_file(&spi->dev, &dev_attr_in0_input);
 
+	/* non-hwmon device attributes */
 	device_create_file(&spi->dev, &dev_attr_pen_down);
-
 	device_create_file(&spi->dev, &dev_attr_disable);
 
 	err = input_register_device(input_dev);
@@ -774,11 +830,13 @@ static int __devinit ads7846_probe(struc
 		device_remove_file(&spi->dev, &dev_attr_temp0);
 	}
 	if (ts->model != 7845)
-		device_remove_file(&spi->dev, &dev_attr_vbatt);
-	device_remove_file(&spi->dev, &dev_attr_vaux);
+		device_remove_file(&spi->dev, &dev_attr_in1_input);
+	device_remove_file(&spi->dev, &dev_attr_in0_input);
 
 	free_irq(spi->irq, ts);
  err_free_mem:
+	if (!IS_ERR(hwmon))
+		hwmon_device_unregister(hwmon);
 	input_free_device(input_dev);
 	kfree(ts);
 	return err;
@@ -788,6 +846,7 @@ static int __devexit ads7846_remove(stru
 {
 	struct ads7846		*ts = dev_get_drvdata(&spi->dev);
 
+	hwmon_device_unregister(ts->hwmon);
 	input_unregister_device(ts->input);
 
 	ads7846_suspend(spi, PMSG_SUSPEND);
@@ -799,8 +858,8 @@ static int __devexit ads7846_remove(stru
 		device_remove_file(&spi->dev, &dev_attr_temp0);
 	}
 	if (ts->model != 7845)
-		device_remove_file(&spi->dev, &dev_attr_vbatt);
-	device_remove_file(&spi->dev, &dev_attr_vaux);
+		device_remove_file(&spi->dev, &dev_attr_in1_input);
+	device_remove_file(&spi->dev, &dev_attr_in0_input);
 
 	free_irq(ts->spi->irq, ts);
 	if (ts->irq_disabled)
@@ -853,7 +912,7 @@ static int __init ads7846_init(void)
 
 	return spi_register_driver(&ads7846_driver);
 }
-module_init(ads7846_init);
+device_initcall(ads7846_init);
 
 static void __exit ads7846_exit(void)
 {

--Boundary-00=_W3DWElJsOn2kU67
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_W3DWElJsOn2kU67--

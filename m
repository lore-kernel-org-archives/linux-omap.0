From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH] ads7846: Add disable sysfs entry / fix spin lock init,
	driver cleanup
Date: Fri, 17 Mar 2006 17:46:50 +0200
Message-ID: <1142610410.17258.85.camel@mammoth.research.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-uN4em+q1zsTEw1AeLLdQ"
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
To: omap-linux <linux-omap-open-source@linux.omap.com>
Cc: "Yrjola Juha (Nokia-M/Helsinki)" <Juha.Yrjola@nokia.com>
List-Id: linux-omap@vger.kernel.org


--=-uN4em+q1zsTEw1AeLLdQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Add disable attribute to support device locking mode, where a
unintentional touch event shouldn't wake up the system.

Add missing spin_lock_init.

Do device resume with the lock held.

Do cleanup calls / free memory in the reverse order of initialization.

Signed-off-by: Imre Deak <imre.deak@nokia.com>

--=-uN4em+q1zsTEw1AeLLdQ
Content-Disposition: attachment; filename=ads7846_omap_disable-patch.diff
Content-Type: text/x-patch; name=ads7846_omap_disable-patch.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 6da8348..527ab2d 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -2,6 +2,7 @@
  * ADS7846 based touchscreen and sensor driver
  *
  * Copyright (c) 2005 David Brownell
+ * Copyright (c) 2006 Imre Deak <imre.deak@nokia.com>
  *
  * Using code from:
  *  - corgi_ts.c
@@ -33,17 +34,25 @@
 
 
 /*
- * This code has been lightly tested on an ads7846.
+ * This code has been tested on an ads7846 / N770 device.
  * Support for ads7843 and ads7845 has only been stubbed in.
  *
- * Not yet done:  investigate the values reported.  Are x/y/pressure
- * event values sane enough for X11?  How accurate are the temperature
- * and voltage readings?  (System-specific calibration should support
+ * Not yet done:  How accurate are the temperature and voltage
+ * readings? (System-specific calibration should support
  * accuracy of 0.3 degrees C; otherwise it's 2.0 degrees.)
  *
+ * IRQ handling needs a workaround because of a shortcoming in handling
+ * edge triggered IRQs on some platforms like the OMAP1/2. These
+ * platforms don't handle the ARM lazy IRQ disabling properly, thus we
+ * have to maintain our own SW IRQ disabled status. This should be
+ * removed as soon as the affected platform's IRQ handling is fixed.
+ *
  * app note sbaa036 talks in more detail about accurate sampling...
  * that ought to help in situations like LCDs inducing noise (which
  * can also be helped by using synch signals) and more generally.
+ * This driver tries to utilize the measures described in the app
+ * note. The strength of filtering can be set in the board-* specific
+ * files.
  */
 
 #define	TS_POLL_PERIOD	msecs_to_jiffies(10)
@@ -90,6 +99,7 @@ struct ads7846 {
 	unsigned		pending:1;	/* P: lock */
 // FIXME remove "irq_disabled"
 	unsigned		irq_disabled:1;	/* P: lock */
+	unsigned		disabled:1;
 };
 
 /* leave chip selected when we're done, for quicker re-select? */
@@ -160,6 +170,9 @@ struct ser_req {
 	struct spi_transfer	xfer[6];
 };
 
+static void ads7846_enable(struct ads7846 *ts);
+static void ads7846_disable(struct ads7846 *ts);
+
 static int ads7846_read12_ser(struct device *dev, unsigned command)
 {
 	struct spi_device	*spi = to_spi_device(dev);
@@ -256,6 +269,38 @@ static ssize_t ads7846_pen_down_show(str
 
 static DEVICE_ATTR(pen_down, S_IRUGO, ads7846_pen_down_show, NULL);
 
+static ssize_t ads7846_disable_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct ads7846	*ts = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", ts->disabled);
+}
+
+static ssize_t ads7846_disable_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct ads7846 *ts = dev_get_drvdata(dev);
+	unsigned long flags;
+	char *endp;
+	int i;
+
+	i = simple_strtoul(buf, &endp, 10);
+	spin_lock_irqsave(&ts->lock, flags);
+
+	if (i)
+		ads7846_disable(ts);
+	else
+		ads7846_enable(ts);
+
+	spin_unlock_irqrestore(&ts->lock, flags);
+
+	return count;
+}
+
+static DEVICE_ATTR(disable, 0664, ads7846_disable_show, ads7846_disable_store);
+
 /*--------------------------------------------------------------------------*/
 
 /*
@@ -394,12 +439,9 @@ static irqreturn_t ads7846_irq(int irq, 
 {
 	struct ads7846 *ts = handle;
 	unsigned long flags;
-	int r = IRQ_HANDLED;
 
 	spin_lock_irqsave(&ts->lock, flags);
-	if (ts->irq_disabled)
-		r = IRQ_HANDLED;
-	else {
+	if (likely(!ts->irq_disabled && !ts->disabled)) {
 		if (!ts->irq_disabled) {
 			ts->irq_disabled = 1;
 			/* The following has at the moment no effect whatsoever
@@ -413,20 +455,17 @@ static irqreturn_t ads7846_irq(int irq, 
 		}
 	}
 	spin_unlock_irqrestore(&ts->lock, flags);
-	return r;
+
+	return IRQ_HANDLED;
 }
 
 /*--------------------------------------------------------------------------*/
 
-static int
-ads7846_suspend(struct spi_device *spi, pm_message_t message)
+/* Must be called with ts->lock held */
+static void ads7846_disable(struct ads7846 *ts)
 {
-	struct ads7846 *ts = dev_get_drvdata(&spi->dev);
-	unsigned long	flags;
-
-	spin_lock_irqsave(&ts->lock, flags);
-
-	spi->dev.power.power_state = message;
+	if (ts->disabled)
+		return;
 
 	/* are we waiting for IRQ, or polling? */
 	if (!ts->pendown) {
@@ -435,6 +474,8 @@ ads7846_suspend(struct spi_device *spi, 
 			disable_irq(ts->spi->irq);
 		}
 	} else {
+		unsigned long flags;
+
 		/* polling; force a final SPI completion;
 		 * that will clean things up neatly
 		 */
@@ -452,17 +493,48 @@ ads7846_suspend(struct spi_device *spi, 
 	 * leave it that way after every request
 	 */
 
+	ts->disabled = 1;
+}
+
+/* Must be called with ts->lock held */
+static void ads7846_enable(struct ads7846 *ts)
+{
+	if (!ts->disabled)
+		return;
+
+	ts->disabled = 0;
+	ts->irq_disabled = 0;
+	enable_irq(ts->spi->irq);
+}
+
+static int ads7846_suspend(struct spi_device *spi, pm_message_t message)
+{
+	struct ads7846 *ts = dev_get_drvdata(&spi->dev);
+	unsigned long	flags;
+
+	spin_lock_irqsave(&ts->lock, flags);
+
+	spi->dev.power.power_state = message;
+	ads7846_disable(ts);
+
 	spin_unlock_irqrestore(&ts->lock, flags);
+
 	return 0;
+
 }
 
 static int ads7846_resume(struct spi_device *spi)
 {
 	struct ads7846 *ts = dev_get_drvdata(&spi->dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&ts->lock, flags);
 
-	ts->irq_disabled = 0;
-	enable_irq(ts->spi->irq);
 	spi->dev.power.power_state = PMSG_ON;
+	ads7846_enable(ts);
+
+	spin_unlock_irqrestore(&ts->lock, flags);
+
 	return 0;
 }
 
@@ -515,6 +587,8 @@ static int __devinit ads7846_probe(struc
 	ts->timer.data = (unsigned long) ts;
 	ts->timer.function = ads7846_timer;
 
+	spin_lock_init(&ts->lock);
+
 	ts->model = pdata->model ? : 7846;
 	ts->vref_delay_usecs = pdata->vref_delay_usecs ? : 100;
 	ts->x_plate_ohms = pdata->x_plate_ohms ? : 400;
@@ -665,13 +739,25 @@ static int __devinit ads7846_probe(struc
 
 	device_create_file(&spi->dev, &dev_attr_pen_down);
 
+	device_create_file(&spi->dev, &dev_attr_disable);
+
 	err = input_register_device(input_dev);
 	if (err)
-		goto err_free_irq;
+		goto err_remove_attr;
 
 	return 0;
 
- err_free_irq:
+ err_remove_attr:
+	device_remove_file(&spi->dev, &dev_attr_disable);
+	device_remove_file(&spi->dev, &dev_attr_pen_down);
+	if (ts->model == 7846) {
+		device_remove_file(&spi->dev, &dev_attr_temp1);
+		device_remove_file(&spi->dev, &dev_attr_temp0);
+	}
+	if (ts->model != 7845)
+		device_remove_file(&spi->dev, &dev_attr_vbatt);
+	device_remove_file(&spi->dev, &dev_attr_vaux);
+
 	free_irq(spi->irq, ts);
  err_free_mem:
 	input_free_device(input_dev);
@@ -683,22 +769,24 @@ static int __devexit ads7846_remove(stru
 {
 	struct ads7846		*ts = dev_get_drvdata(&spi->dev);
 
+	input_unregister_device(ts->input);
+
 	ads7846_suspend(spi, PMSG_SUSPEND);
-	free_irq(ts->spi->irq, ts);
-	if (ts->irq_disabled)
-		enable_irq(ts->spi->irq);
 
+	device_remove_file(&spi->dev, &dev_attr_disable);
 	device_remove_file(&spi->dev, &dev_attr_pen_down);
-
 	if (ts->model == 7846) {
-		device_remove_file(&spi->dev, &dev_attr_temp0);
 		device_remove_file(&spi->dev, &dev_attr_temp1);
+		device_remove_file(&spi->dev, &dev_attr_temp0);
 	}
 	if (ts->model != 7845)
 		device_remove_file(&spi->dev, &dev_attr_vbatt);
 	device_remove_file(&spi->dev, &dev_attr_vaux);
 
-	input_unregister_device(ts->input);
+	free_irq(ts->spi->irq, ts);
+	if (ts->irq_disabled)
+		enable_irq(ts->spi->irq);
+
 	kfree(ts);
 
 	dev_dbg(&spi->dev, "unregistered touchscreen\n");

--=-uN4em+q1zsTEw1AeLLdQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-uN4em+q1zsTEw1AeLLdQ--

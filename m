From: Phil Carmody <ext-phil.2.carmody@nokia.com>
Subject: [PATCH 1/2] OMAP: tsc2005: Bringing driver's configuration (e.g. of IRQ/SPI) up to date.
Date: Mon, 16 Feb 2009 15:49:30 +0200
Message-ID: <cad4802ce1266717a82d5bb73118713de1fdfd15.1234789985.git.ext-phil.2.carmody@nokia.com>
References: <>
 <1234792171-4095-1-git-send-email-ext-phil.2.carmody@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:46224 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756346AbZBPNwn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Feb 2009 08:52:43 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1GDqVnC027010
	for <linux-omap@vger.kernel.org>; Mon, 16 Feb 2009 15:52:40 +0200
In-Reply-To: <1234792171-4095-1-git-send-email-ext-phil.2.carmody@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ext-phil.2.carmody@nokia.com

Configuration of the driver's IRQ now happens in a different place,
it's a function of SPI now.

Some of the magic constants were wrong according to TI data-sheet
errata.

Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
---
 drivers/input/touchscreen/tsc2005.c |   64 ++++++++++++-----------------------
 1 files changed, 22 insertions(+), 42 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 03c3a10..e3e63a5 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -77,8 +77,8 @@
 #define TSC2005_CMD_AUX_CONT	(8 << 3)
 #define TSC2005_CMD_TEST_X_CONN	(9 << 3)
 #define TSC2005_CMD_TEST_Y_CONN	(10 << 3)
-/* command 11 reserved */
-#define TSC2005_CMD_TEST_SHORT	(12 << 3)
+#define TSC2005_CMD_TEST_SHORT	(11 << 3)
+/* command 12 reserved, according to 2008-03 erratum */
 #define TSC2005_CMD_DRIVE_XX	(13 << 3)
 #define TSC2005_CMD_DRIVE_YY	(14 << 3)
 #define TSC2005_CMD_DRIVE_YX	(15 << 3)
@@ -213,8 +213,6 @@ struct tsc2005 {
 	int			stab_time;
 	int			p_max;
 	int			touch_pressure;
-	int			irq;
-	s16			dav_gpio;
 	/* status */
 	u8			sample_sent;
 	u8			pen_down;
@@ -225,7 +223,7 @@ struct tsc2005 {
 
 static void tsc2005_cmd(struct tsc2005 *ts, u8 cmd)
 {
-	u16 data = TSC2005_CMD | TSC2005_CMD_12BIT | cmd;
+	u8 data = TSC2005_CMD | TSC2005_CMD_12BIT | cmd;
 	struct spi_message msg;
 	struct spi_transfer xfer = { 0 };
 
@@ -304,7 +302,7 @@ static void tsc2005_ts_rx(void *arg)
 		goto out;
 
 	/* skip coords if the pressure-components are out of range */
-	if (z1 < 100 || z2 > 4000)
+	if (z1 < 100 || z2 > MAX_12BIT || z1 >= z2)
 		goto out;
 
 	/* don't run average on the "pen down" event */
@@ -329,11 +327,8 @@ static void tsc2005_ts_rx(void *arg)
 	ts->avg_z1 = 0;
 	ts->avg_z2 = 0;
 
-	if (z1) {
 		pressure = x * (z2 - z1) / z1;
 		pressure = pressure * ts->x_plate_ohm / 4096;
-	} else
-		goto out;
 
 	pressure_limit = ts->sample_sent? ts->p_max: ts->touch_pressure;
 	if (pressure > pressure_limit)
@@ -458,7 +453,7 @@ static void tsc2005_disable(struct tsc2005 *ts)
 	if (ts->disable_depth++ != 0)
 		return;
 
-	disable_irq(ts->irq);
+	disable_irq(ts->spi->irq);
 
 	/* wait until penup timer expire normally */
 	do {
@@ -473,7 +468,7 @@ static void tsc2005_enable(struct tsc2005 *ts)
 	if (--ts->disable_depth != 0)
 		return;
 
-	enable_irq(ts->irq);
+	enable_irq(ts->spi->irq);
 
 	tsc2005_start_scan(ts);
 }
@@ -494,8 +489,9 @@ static ssize_t tsc2005_disable_store(struct device *dev,
 	unsigned long res;
 	int i;
 
-	i = strict_strtoul(buf, 10, &res);
-	i = i ? 1 : 0;
+	if (strict_strtoul(buf, 10, &res) < 0)
+		return -EINVAL;
+	i = res ? 1 : 0;
 
 	mutex_lock(&tsc->mutex);
 	if (i == tsc->disabled)
@@ -519,27 +515,10 @@ static int __devinit tsc2005_ts_init(struct tsc2005 *ts,
 				     struct tsc2005_platform_data *pdata)
 {
 	struct input_dev *idev;
-	int dav_gpio, r;
+	int r;
 	int x_max, y_max;
 	int x_fudge, y_fudge, p_fudge;
 
-	if (pdata->dav_gpio < 0) {
-		dev_err(&ts->spi->dev, "need DAV GPIO");
-		return -EINVAL;
-	}
-	dav_gpio = pdata->dav_gpio;
-	ts->dav_gpio = dav_gpio;
-	dev_dbg(&ts->spi->dev, "TSC2005: DAV GPIO = %d\n", dav_gpio);
-
-	r = gpio_request(dav_gpio, "TSC2005 dav");
-	if (r < 0) {
-		dev_err(&ts->spi->dev, "unable to get DAV GPIO");
-		goto err1;
-	}
-	gpio_direction_input(dav_gpio);
-	ts->irq = gpio_to_irq(dav_gpio);
-	dev_dbg(&ts->spi->dev, "TSC2005: DAV IRQ = %d\n", ts->irq);
-
 	init_timer(&ts->penup_timer);
 	setup_timer(&ts->penup_timer, tsc2005_ts_penup_timer_handler,
 			(unsigned long)ts);
@@ -561,7 +540,7 @@ static int __devinit tsc2005_ts_init(struct tsc2005 *ts,
 	idev = input_allocate_device();
 	if (idev == NULL) {
 		r = -ENOMEM;
-		goto err2;
+		goto err1;
 	}
 
 	idev->name = "TSC2005 touchscreen";
@@ -581,20 +560,20 @@ static int __devinit tsc2005_ts_init(struct tsc2005 *ts,
 
 	tsc2005_start_scan(ts);
 
-	r = request_irq(ts->irq, tsc2005_ts_irq_handler,
+	r = request_irq(ts->spi->irq, tsc2005_ts_irq_handler,
 			IRQF_TRIGGER_FALLING | IRQF_DISABLED |
 			IRQF_SAMPLE_RANDOM, "tsc2005", ts);
 	if (r < 0) {
 		dev_err(&ts->spi->dev, "unable to get DAV IRQ");
-		goto err3;
+		goto err2;
 	}
 
-	set_irq_wake(ts->irq, 1);
+	set_irq_wake(ts->spi->irq, 1);
 
 	r = input_register_device(idev);
 	if (r < 0) {
 		dev_err(&ts->spi->dev, "can't register touchscreen device\n");
-		goto err4;
+		goto err3;
 	}
 
 	/* We can tolerate these failing */
@@ -602,13 +581,11 @@ static int __devinit tsc2005_ts_init(struct tsc2005 *ts,
 	if (device_create_file(&ts->spi->dev, &dev_attr_disable_ts));
 
 	return 0;
-err4:
-	free_irq(ts->irq, ts);
 err3:
+	free_irq(ts->spi->irq, ts);
+err2:
 	tsc2005_stop_scan(ts);
 	input_free_device(idev);
-err2:
-	gpio_free(dav_gpio);
 err1:
 	return r;
 }
@@ -619,6 +596,10 @@ static int __devinit tsc2005_probe(struct spi_device *spi)
 	struct tsc2005_platform_data	*pdata = spi->dev.platform_data;
 	int r;
 
+	if (spi->irq < 0) {
+		dev_dbg(&spi->dev, "no irq?\n");
+		return -ENODEV;
+	}
 	if (!pdata) {
 		dev_dbg(&spi->dev, "no platform data?\n");
 		return -ENODEV;
@@ -663,10 +644,9 @@ static int __devexit tsc2005_remove(struct spi_device *spi)
 	device_remove_file(&ts->spi->dev, &dev_attr_disable_ts);
 	device_remove_file(&ts->spi->dev, &dev_attr_pen_down);
 
-	free_irq(ts->irq, ts);
+	free_irq(ts->spi->irq, ts);
 	input_unregister_device(ts->idev);
 
-	gpio_free(ts->dav_gpio);
 	kfree(ts);
 
 	return 0;
-- 
1.5.4.3


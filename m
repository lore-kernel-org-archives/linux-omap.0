From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 2/4] Input: tsc2005 - convert to regmap
Date: Wed, 15 Jul 2015 14:13:26 +0200
Message-ID: <1436962408-5206-3-git-send-email-sre@kernel.org>
References: <1436962408-5206-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436962408-5206-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Michael Welling <mwelling@emacinc.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Convert driver, so that it uses regmap instead of directly
using spi_transfer for all register accesses.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/input/touchscreen/tsc2005.c | 170 ++++++++++++------------------------
 1 file changed, 58 insertions(+), 112 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 87038b2..0aec45a 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -34,6 +34,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/tsc2005.h>
 #include <linux/regulator/consumer.h>
+#include <linux/regmap.h>
 
 /*
  * The touchscreen interface operates as follows:
@@ -120,20 +121,36 @@
 #define TSC2005_SPI_MAX_SPEED_HZ	10000000
 #define TSC2005_PENUP_TIME_MS		40
 
-struct tsc2005_spi_rd {
-	struct spi_transfer	spi_xfer;
-	u32			spi_tx;
-	u32			spi_rx;
+static const struct regmap_range tsc2005_writable_ranges[] = {
+	regmap_reg_range(TSC2005_REG_AUX_HIGH, TSC2005_REG_CFR2),
 };
 
+static const struct regmap_access_table tsc2005_writable_table = {
+	.yes_ranges = tsc2005_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(tsc2005_writable_ranges),
+};
+
+static struct regmap_config tsc2005_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.reg_stride = 0x08,
+	.max_register = 0x78,
+	.read_flag_mask = TSC2005_REG_READ,
+	.wr_table = &tsc2005_writable_table,
+	.use_single_rw = true,
+};
+
+struct tsc2005_data {
+	u16 x;
+	u16 y;
+	u16 z1;
+	u16 z2;
+} __packed;
+#define TSC2005_DATA_REGS 4
+
 struct tsc2005 {
 	struct spi_device	*spi;
-
-	struct spi_message      spi_read_msg;
-	struct tsc2005_spi_rd	spi_x;
-	struct tsc2005_spi_rd	spi_y;
-	struct tsc2005_spi_rd	spi_z1;
-	struct tsc2005_spi_rd	spi_z2;
+	struct regmap		*regmap;
 
 	struct input_dev	*idev;
 	char			phys[32];
@@ -190,62 +207,6 @@ static int tsc2005_cmd(struct tsc2005 *ts, u8 cmd)
 	return 0;
 }
 
-static int tsc2005_write(struct tsc2005 *ts, u8 reg, u16 value)
-{
-	u32 tx = ((reg | TSC2005_REG_PND0) << 16) | value;
-	struct spi_transfer xfer = {
-		.tx_buf		= &tx,
-		.len		= 4,
-		.bits_per_word	= 24,
-	};
-	struct spi_message msg;
-	int error;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-
-	error = spi_sync(ts->spi, &msg);
-	if (error) {
-		dev_err(&ts->spi->dev,
-			"%s: failed, register: %x, value: %x, error: %d\n",
-			__func__, reg, value, error);
-		return error;
-	}
-
-	return 0;
-}
-
-static void tsc2005_setup_read(struct tsc2005_spi_rd *rd, u8 reg, bool last)
-{
-	memset(rd, 0, sizeof(*rd));
-
-	rd->spi_tx		   = (reg | TSC2005_REG_READ) << 16;
-	rd->spi_xfer.tx_buf	   = &rd->spi_tx;
-	rd->spi_xfer.rx_buf	   = &rd->spi_rx;
-	rd->spi_xfer.len	   = 4;
-	rd->spi_xfer.bits_per_word = 24;
-	rd->spi_xfer.cs_change	   = !last;
-}
-
-static int tsc2005_read(struct tsc2005 *ts, u8 reg, u16 *value)
-{
-	struct tsc2005_spi_rd spi_rd;
-	struct spi_message msg;
-	int error;
-
-	tsc2005_setup_read(&spi_rd, reg, true);
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&spi_rd.spi_xfer, &msg);
-
-	error = spi_sync(ts->spi, &msg);
-	if (error)
-		return error;
-
-	*value = spi_rd.spi_rx;
-	return 0;
-}
-
 static void tsc2005_update_pen_state(struct tsc2005 *ts,
 				     int x, int y, int pressure)
 {
@@ -274,26 +235,23 @@ static irqreturn_t tsc2005_irq_thread(int irq, void *_ts)
 	struct tsc2005 *ts = _ts;
 	unsigned long flags;
 	unsigned int pressure;
-	u32 x, y;
-	u32 z1, z2;
+	struct tsc2005_data tsdata;
 	int error;
 
 	/* read the coordinates */
-	error = spi_sync(ts->spi, &ts->spi_read_msg);
+	error = regmap_bulk_read(ts->regmap, TSC2005_REG_X, &tsdata,
+				 TSC2005_DATA_REGS);
 	if (unlikely(error))
 		goto out;
 
-	x = ts->spi_x.spi_rx;
-	y = ts->spi_y.spi_rx;
-	z1 = ts->spi_z1.spi_rx;
-	z2 = ts->spi_z2.spi_rx;
-
 	/* validate position */
-	if (unlikely(x > MAX_12BIT || y > MAX_12BIT))
+	if (unlikely(tsdata.x > MAX_12BIT || tsdata.y > MAX_12BIT))
 		goto out;
 
 	/* Skip reading if the pressure components are out of range */
-	if (unlikely(z1 == 0 || z2 > MAX_12BIT || z1 >= z2))
+	if (unlikely(tsdata.z1 == 0 || tsdata.z2 > MAX_12BIT))
+		goto out;
+	if (unlikely(tsdata.z1 >= tsdata.z2))
 		goto out;
 
        /*
@@ -301,8 +259,8 @@ static irqreturn_t tsc2005_irq_thread(int irq, void *_ts)
 	* the value before pen-up - that implies SPI fed us stale data
 	*/
 	if (!ts->pen_down &&
-	    ts->in_x == x && ts->in_y == y &&
-	    ts->in_z1 == z1 && ts->in_z2 == z2) {
+	    ts->in_x == tsdata.x && ts->in_y == tsdata.y &&
+	    ts->in_z1 == tsdata.z1 && ts->in_z2 == tsdata.z2) {
 		goto out;
 	}
 
@@ -310,20 +268,20 @@ static irqreturn_t tsc2005_irq_thread(int irq, void *_ts)
 	 * At this point we are happy we have a valid and useful reading.
 	 * Remember it for later comparisons. We may now begin downsampling.
 	 */
-	ts->in_x = x;
-	ts->in_y = y;
-	ts->in_z1 = z1;
-	ts->in_z2 = z2;
+	ts->in_x = tsdata.x;
+	ts->in_y = tsdata.y;
+	ts->in_z1 = tsdata.z1;
+	ts->in_z2 = tsdata.z2;
 
 	/* Compute touch pressure resistance using equation #1 */
-	pressure = x * (z2 - z1) / z1;
+	pressure = tsdata.x * (tsdata.z2 - tsdata.z1) / tsdata.z1;
 	pressure = pressure * ts->x_plate_ohm / 4096;
 	if (unlikely(pressure > MAX_12BIT))
 		goto out;
 
 	spin_lock_irqsave(&ts->lock, flags);
 
-	tsc2005_update_pen_state(ts, x, y, pressure);
+	tsc2005_update_pen_state(ts, tsdata.x, tsdata.y, pressure);
 	mod_timer(&ts->penup_timer,
 		  jiffies + msecs_to_jiffies(TSC2005_PENUP_TIME_MS));
 
@@ -346,9 +304,9 @@ static void tsc2005_penup_timer(unsigned long data)
 
 static void tsc2005_start_scan(struct tsc2005 *ts)
 {
-	tsc2005_write(ts, TSC2005_REG_CFR0, TSC2005_CFR0_INITVALUE);
-	tsc2005_write(ts, TSC2005_REG_CFR1, TSC2005_CFR1_INITVALUE);
-	tsc2005_write(ts, TSC2005_REG_CFR2, TSC2005_CFR2_INITVALUE);
+	regmap_write(ts->regmap, TSC2005_REG_CFR0, TSC2005_CFR0_INITVALUE);
+	regmap_write(ts->regmap, TSC2005_REG_CFR1, TSC2005_CFR1_INITVALUE);
+	regmap_write(ts->regmap, TSC2005_REG_CFR2, TSC2005_CFR2_INITVALUE);
 	tsc2005_cmd(ts, TSC2005_CMD_NORMAL);
 }
 
@@ -398,9 +356,9 @@ static ssize_t tsc2005_selftest_show(struct device *dev,
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct tsc2005 *ts = spi_get_drvdata(spi);
-	u16 temp_high;
-	u16 temp_high_orig;
-	u16 temp_high_test;
+	unsigned int temp_high;
+	unsigned int temp_high_orig;
+	unsigned int temp_high_test;
 	bool success = true;
 	int error;
 
@@ -411,7 +369,7 @@ static ssize_t tsc2005_selftest_show(struct device *dev,
 	 */
 	__tsc2005_disable(ts);
 
-	error = tsc2005_read(ts, TSC2005_REG_TEMP_HIGH, &temp_high_orig);
+	error = regmap_read(ts->regmap, TSC2005_REG_TEMP_HIGH, &temp_high_orig);
 	if (error) {
 		dev_warn(dev, "selftest failed: read error %d\n", error);
 		success = false;
@@ -420,14 +378,14 @@ static ssize_t tsc2005_selftest_show(struct device *dev,
 
 	temp_high_test = (temp_high_orig - 1) & MAX_12BIT;
 
-	error = tsc2005_write(ts, TSC2005_REG_TEMP_HIGH, temp_high_test);
+	error = regmap_write(ts->regmap, TSC2005_REG_TEMP_HIGH, temp_high_test);
 	if (error) {
 		dev_warn(dev, "selftest failed: write error %d\n", error);
 		success = false;
 		goto out;
 	}
 
-	error = tsc2005_read(ts, TSC2005_REG_TEMP_HIGH, &temp_high);
+	error = regmap_read(ts->regmap, TSC2005_REG_TEMP_HIGH, &temp_high);
 	if (error) {
 		dev_warn(dev, "selftest failed: read error %d after write\n",
 			 error);
@@ -450,7 +408,7 @@ static ssize_t tsc2005_selftest_show(struct device *dev,
 		goto out;
 
 	/* test that the reset really happened */
-	error = tsc2005_read(ts, TSC2005_REG_TEMP_HIGH, &temp_high);
+	error = regmap_read(ts->regmap, TSC2005_REG_TEMP_HIGH, &temp_high);
 	if (error) {
 		dev_warn(dev, "selftest failed: read error %d after reset\n",
 			 error);
@@ -503,7 +461,7 @@ static void tsc2005_esd_work(struct work_struct *work)
 {
 	struct tsc2005 *ts = container_of(work, struct tsc2005, esd_work.work);
 	int error;
-	u16 r;
+	unsigned int r;
 
 	if (!mutex_trylock(&ts->mutex)) {
 		/*
@@ -519,7 +477,7 @@ static void tsc2005_esd_work(struct work_struct *work)
 		goto out;
 
 	/* We should be able to read register without disabling interrupts. */
-	error = tsc2005_read(ts, TSC2005_REG_CFR0, &r);
+	error = regmap_read(ts->regmap, TSC2005_REG_CFR0, &r);
 	if (!error &&
 	    !((r ^ TSC2005_CFR0_INITVALUE) & TSC2005_CFR0_RW_MASK)) {
 		goto out;
@@ -583,20 +541,6 @@ static void tsc2005_close(struct input_dev *input)
 	mutex_unlock(&ts->mutex);
 }
 
-static void tsc2005_setup_spi_xfer(struct tsc2005 *ts)
-{
-	tsc2005_setup_read(&ts->spi_x, TSC2005_REG_X, false);
-	tsc2005_setup_read(&ts->spi_y, TSC2005_REG_Y, false);
-	tsc2005_setup_read(&ts->spi_z1, TSC2005_REG_Z1, false);
-	tsc2005_setup_read(&ts->spi_z2, TSC2005_REG_Z2, true);
-
-	spi_message_init(&ts->spi_read_msg);
-	spi_message_add_tail(&ts->spi_x.spi_xfer, &ts->spi_read_msg);
-	spi_message_add_tail(&ts->spi_y.spi_xfer, &ts->spi_read_msg);
-	spi_message_add_tail(&ts->spi_z1.spi_xfer, &ts->spi_read_msg);
-	spi_message_add_tail(&ts->spi_z2.spi_xfer, &ts->spi_read_msg);
-}
-
 static int tsc2005_probe(struct spi_device *spi)
 {
 	const struct tsc2005_platform_data *pdata = dev_get_platdata(&spi->dev);
@@ -661,6 +605,10 @@ static int tsc2005_probe(struct spi_device *spi)
 	ts->spi = spi;
 	ts->idev = input_dev;
 
+	ts->regmap = devm_regmap_init_spi(spi, &tsc2005_regmap_config);
+	if (IS_ERR(ts->regmap))
+		return PTR_ERR(ts->regmap);
+
 	ts->x_plate_ohm = x_plate_ohm;
 	ts->esd_timeout = esd_timeout;
 
@@ -700,8 +648,6 @@ static int tsc2005_probe(struct spi_device *spi)
 
 	INIT_DELAYED_WORK(&ts->esd_work, tsc2005_esd_work);
 
-	tsc2005_setup_spi_xfer(ts);
-
 	snprintf(ts->phys, sizeof(ts->phys),
 		 "%s/input-ts", dev_name(&spi->dev));
 
-- 
2.1.4

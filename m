From: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
Subject: [PATCH 4/4] SPI: tsc2102 support for tsc2xxx core
Date: Tue, 14 Aug 2007 15:13:02 -0400
Message-ID: <20070814191302.27333.6343.stgit@localhost.localdomain>
References: <20070814191229.27333.62004.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070814191229.27333.62004.stgit@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: david-b@pacbell.net
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

From: Ragner Magalhaes <ragner.magalhaes@indt.org.br>

Add support for tsc2xxx core api

Signed-off-by: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
---

 drivers/spi/Kconfig         |    5 -
 drivers/spi/tsc2102.c       |  343 +++++++++++++------------------------------
 include/linux/spi/tsc2102.h |   95 ++++++------
 3 files changed, 150 insertions(+), 293 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a4b112a..54483f6 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -226,8 +226,9 @@ config SPI_TSC2101
 	 as well as a way to enable the MCLK clock.
 	 
 config SPI_TSC2102
-       depends on SPI_MASTER
-       tristate "TSC2102 codec support"
+	depends on SPI_MASTER
+	tristate "TSC2102 codec support"
+	select SPI_TSC2XXX
        ---help---
          Say Y here if you want support for the TSC2102 chip.  It
 	 will be needed for the touchscreen driver on some boards.
diff --git a/drivers/spi/tsc2102.c b/drivers/spi/tsc2102.c
index 59171ca..865fe6c 100644
--- a/drivers/spi/tsc2102.c
+++ b/drivers/spi/tsc2102.c
@@ -30,6 +30,7 @@
 #include <linux/interrupt.h>
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/tsc2xxx.h>
 #include <linux/spi/tsc2102.h>
 #include <linux/err.h>
 #include <linux/hwmon.h>
@@ -76,14 +77,6 @@
 
 #define CS_CHANGE(val)			0
 
-struct tsc2102_spi_req {
-	struct spi_device *dev;
-	uint16_t command;
-	uint16_t data;
-	struct spi_transfer *transfer;
-	struct spi_message message;
-};
-
 struct tsc2102_dev {
 	struct tsc2102_config *pdata;
 	spinlock_t lock, lock_sync;
@@ -104,12 +97,6 @@ struct tsc2102_dev {
 	unsigned int mode_msecs;	/* Interval for .mode_timer */
 
 	struct spi_device *spi;
-	struct spi_transfer *transfers;
-	struct tsc2102_spi_req req_adc;
-	struct tsc2102_spi_req req_status;
-	struct tsc2102_spi_req req_pressure;
-	struct tsc2102_spi_req req_stopadc;
-	struct tsc2102_spi_req req_mode;
 
 	int bat[2], aux[1], temp[2];
 	struct class_device *hwmondev;
@@ -123,168 +110,41 @@ MODULE_PARM_DESC(touch_check_msecs, "Pen-up polling interval in msecs");
 module_param_named(sensor_scan_msecs, tsc.mode_msecs, uint, 0);
 MODULE_PARM_DESC(sensor_scan_msecs, "Temperature & battery scan interval");
 
-void tsc2102_write_sync(int page, u8 address, u16 data)
+int tsc2102_write_sync(struct spi_device *spi, u32 reg, u16 data)
 {
-	static struct tsc2102_spi_req req;
-	static struct spi_transfer transfer[2];
-	int ret;
-
-	spi_message_init(&req.message);
-	req.transfer = transfer;
-
-	/* Address */
-	req.command = (page << 11) | (address << 5);
-	req.transfer[0].tx_buf = &req.command;
-	req.transfer[0].rx_buf = 0;
-	req.transfer[0].len = 2;
-	spi_message_add_tail(&req.transfer[0], &req.message);
-
-	/* Data */
-	req.transfer[1].tx_buf = &data;
-	req.transfer[1].rx_buf = 0;
-	req.transfer[1].len = 2;
-	req.transfer[1].cs_change = CS_CHANGE(1);
-	spi_message_add_tail(&req.transfer[1], &req.message);
-
-	ret = spi_sync(tsc.spi, &req.message);
-	if (!ret && req.message.status)
-		ret = req.message.status;
-
-	if (ret)
-		printk(KERN_ERR "%s: error %i in SPI request\n",
-				__FUNCTION__, ret);
+	return tsc2xxx_write_sync(tsc.spi, reg, data);
 }
 
-void tsc2102_reads_sync(int page, u8 startaddress, u16 *data, int numregs)
+int tsc2102_reads_sync(struct spi_device *spi, u32 reg,
+		u16 *data, int numregs)
 {
-	static struct tsc2102_spi_req req;
-	static struct spi_transfer transfer[6];
-	int ret, i, j;
-
-	BUG_ON(numregs + 1 > ARRAY_SIZE(transfer));
-
-	spi_message_init(&req.message);
-	req.transfer = transfer;
-	i = 0;
-	j = 0;
-
-	/* Address */
-	req.command = 0x8000 | (page << 11) | (startaddress << 5);
-	req.transfer[i].tx_buf = &req.command;
-	req.transfer[i].rx_buf = 0;
-	req.transfer[i].len = 2;
-	spi_message_add_tail(&req.transfer[i ++], &req.message);
-
-	/* Data */
-	while (j < numregs) {
-		req.transfer[i].tx_buf = 0;
-		req.transfer[i].rx_buf = &data[j ++];
-		req.transfer[i].len = 2;
-		req.transfer[i].cs_change = CS_CHANGE(j == numregs);
-		spi_message_add_tail(&req.transfer[i ++], &req.message);
-	}
-
-	ret = spi_sync(tsc.spi, &req.message);
-	if (!ret && req.message.status)
-		ret = req.message.status;
-
-	if (ret)
-		printk(KERN_ERR "%s: error %i in SPI request\n",
-				__FUNCTION__, ret);
+	return tsc2xxx_read_buf_sync(spi, reg, data, numregs);
 }
 
-u16 tsc2102_read_sync(int page, u8 address)
-{
-	u16 ret;
-	tsc2102_reads_sync(page, address, &ret, 1);
-	return ret;
-}
-
-static void tsc2102_write_async(
-		struct tsc2102_spi_req *spi, int page, u8 address, u16 data,
-		void (*complete)(struct tsc2102_dev *context))
+u16 tsc2102_read_sync(struct spi_device *spi, u32 reg)
 {
-	int ret;
-
-	spi_message_init(&spi->message);
-	spi->message.complete = (void (*)(void *)) complete;
-	spi->message.context = &tsc;
-
-	/* Address */
-	spi->command = (page << 11) | (address << 5);
-	spi->transfer[0].tx_buf = &spi->command;
-	spi->transfer[0].rx_buf = 0;
-	spi->transfer[0].len = 2;
-	spi_message_add_tail(&spi->transfer[0], &spi->message);
-
-	/* Data */
-	spi->data = data;
-	spi->transfer[1].tx_buf = &spi->data;
-	spi->transfer[1].rx_buf = 0;
-	spi->transfer[1].len = 2;
-	spi->transfer[1].cs_change = CS_CHANGE(1);
-	spi_message_add_tail(&spi->transfer[1], &spi->message);
-
-	ret = spi_async(spi->dev, &spi->message);
-	if (ret)
-		printk(KERN_ERR "%s: error %i in SPI request\n",
-				__FUNCTION__, ret);
+	return tsc2xxx_read_sync(spi, reg);
 }
 
-static void tsc2102_reads_async(struct tsc2102_spi_req *spi,
-		int page, u8 startaddress, u16 *data, int numregs,
-		void (*complete)(struct tsc2102_dev *context))
+static int tsc2102_write_async( struct spi_device *spi, u32 reg,
+		u16 data, void (*complete)(struct tsc2102_dev *context))
 {
-	int ret, i, j;
-
-	spi_message_init(&spi->message);
-	spi->message.complete = (void (*)(void *)) complete;
-	spi->message.context = &tsc;
-	i = 0;
-	j = 0;
-
-	/* Address */
-	spi->command = 0x8000 | (page << 11) | (startaddress << 5);
-	spi->transfer[i].tx_buf = &spi->command;
-	spi->transfer[i].rx_buf = 0;
-	spi->transfer[i].len = 2;
-	spi_message_add_tail(&spi->transfer[i ++], &spi->message);
-
-	/* Data */
-	while (j < numregs) {
-		spi->transfer[i].tx_buf = 0;
-		spi->transfer[i].rx_buf = &data[j ++];
-		spi->transfer[i].len = 2;
-		spi->transfer[i].cs_change = CS_CHANGE(j == numregs);
-		spi_message_add_tail(&spi->transfer[i ++], &spi->message);
-	}
-
-	ret = spi_async(spi->dev, &spi->message);
-	if (ret)
-		printk(KERN_ERR "%s: error %i in SPI request\n",
-				__FUNCTION__, ret);
+	return tsc2xxx_write_async(spi, reg, data,
+			(void (*)(void *)) complete);
 }
 
-static void tsc2102_read_async(struct tsc2102_spi_req *spi,
-		int page, u8 address, u16 *ret,
+static int tsc2102_reads_async(struct spi_device *spi, u32 reg,
+		u16 *data, int numregs,
 		void (*complete)(struct tsc2102_dev *context))
 {
-	tsc2102_reads_async(spi, page, address, ret, 1, complete);
+	return tsc2xxx_read_buf_async(spi, reg, data, numregs,
+			(void (*)(void *)) complete);
 }
 
-static void tsc2102_request_alloc(struct tsc2102_dev *dev,
-		struct tsc2102_spi_req *spi, int direction, int numregs,
-		struct spi_transfer **buffer)
+static u16 tsc2102_read_async(struct spi_device *spi, u32 reg,
+		u16 *ret, void (*complete)(struct tsc2102_dev *context))
 {
-	spi->dev = dev->spi;
-
-	if (direction == 1)	/* Write */
-		numregs = 2;
-	else			/* Read */
-		numregs += 1;
-
-	spi->transfer = *buffer;
-	*buffer += numregs;
+	return tsc2xxx_read_async(spi, reg, (void (*)(void *)) complete);
 }
 
 #define tsc2102_cb_register_func(cb, cb_t)	\
@@ -315,7 +175,7 @@ tsc2102_cb_register_func(temp2_cb, tsc2102_temp_t)
 #ifdef DEBUG
 static void tsc2102_print_dav(void)
 {
-	u16 status = tsc2102_read_sync(TSC2102_TS_STATUS_CTRL);
+	u16 status = tsc2102_read_sync(tsc.spi, TSC2102_TS_STATUS_CTRL);
 	if (status & 0x0fff)
 		printk("TSC2102: data in");
 	if (status & 0x0400)
@@ -352,33 +212,29 @@ static void tsc2102_complete_dummy(struct tsc2102_dev *dev)
 static inline void tsc2102_touchscreen_mode(struct tsc2102_dev *dev)
 {
 	/* Scan X, Y, Z1, Z2, chip controlled, 12-bit, 16 samples, 500 usec */
-	tsc2102_write_async(&dev->req_mode,
-			TSC2102_TS_ADC_CTRL, TSC2102_ADC_TS_CONTROL,
-			tsc2102_complete_dummy);
+	tsc2102_write_async(dev->spi, TSC2102_TS_ADC_CTRL,
+			TSC2102_ADC_TS_CONTROL, tsc2102_complete_dummy);
 }
 
 static inline void tsc2102_portscan_mode(struct tsc2102_dev *dev)
 {
 	/* Scan BAT1, BAT2, AUX, 12-bit, 16 samples, 500 usec */
-	tsc2102_write_async(&dev->req_mode,
-			TSC2102_TS_ADC_CTRL, TSC2102_ADC_SCAN_CONTROL,
-			tsc2102_complete_dummy);
+	tsc2102_write_async(dev->spi, TSC2102_TS_ADC_CTRL,
+			TSC2102_ADC_SCAN_CONTROL, tsc2102_complete_dummy);
 }
 
 static inline void tsc2102_temp1_mode(struct tsc2102_dev *dev)
 {
 	/* Scan TEMP1, 12-bit, 16 samples, 500 usec */
-	tsc2102_write_async(&dev->req_mode,
-			TSC2102_TS_ADC_CTRL, TSC2102_ADC_T1_CONTROL,
-			tsc2102_complete_dummy);
+	tsc2102_write_async(dev->spi, TSC2102_TS_ADC_CTRL,
+			TSC2102_ADC_T1_CONTROL, tsc2102_complete_dummy);
 }
 
 static inline void tsc2102_temp2_mode(struct tsc2102_dev *dev)
 {
 	/* Scan TEMP2, 12-bit, 16 samples, 500 usec */
-	tsc2102_write_async(&dev->req_mode,
-			TSC2102_TS_ADC_CTRL, TSC2102_ADC_T2_CONTROL,
-			tsc2102_complete_dummy);
+	tsc2102_write_async(dev->spi, TSC2102_TS_ADC_CTRL,
+			TSC2102_ADC_T2_CONTROL, tsc2102_complete_dummy);
 }
 
 static void tsc2102_mode(struct tsc2102_dev *dev)
@@ -407,9 +263,8 @@ static void tsc2102_mode(struct tsc2102_dev *dev)
 static void tsc2102_new_mode(struct tsc2102_dev *dev)
 {
 	/* Abort current conversion if any */
-	tsc2102_write_async(&dev->req_stopadc,
-			TSC2102_TS_ADC_CTRL, TSC2102_ADC_ADST,
-			tsc2102_complete_dummy);
+	tsc2102_write_async(dev->spi, TSC2102_TS_ADC_CTRL,
+			TSC2102_ADC_ADST, tsc2102_complete_dummy);
 
 	dev->state ++;
 	tsc2102_mode(dev);
@@ -487,7 +342,7 @@ static void tsc2102_status_report(struct tsc2102_dev *dev)
 	 * so that the ADC can move on to a new conversion.
 	 */
 	if (dev->status & TSC2102_TS_DAV) {
-		tsc2102_reads_async(&dev->req_adc, TSC2102_TS_X,
+		tsc2102_reads_async(dev->spi, TSC2102_TS_X,
 				dev->adc_data, 4, tsc2102_data_report);
 		if (!dev->pendown) {
 			dev->pendown = 1;
@@ -500,17 +355,17 @@ static void tsc2102_status_report(struct tsc2102_dev *dev)
 	}
 
 	if (dev->status & TSC2102_PS_DAV) {
-		tsc2102_reads_async(&dev->req_adc, TSC2102_TS_BAT1,
+		tsc2102_reads_async(dev->spi, TSC2102_TS_BAT1,
 				dev->adc_data, 3, tsc2102_data_report);
 	}
 
 	if (dev->status & TSC2102_T1_DAV) {
-		tsc2102_read_async(&dev->req_adc, TSC2102_TS_TEMP1,
+		tsc2102_read_async(dev->spi, TSC2102_TS_TEMP1,
 				dev->adc_data, tsc2102_data_report);
 	}
 
 	if (dev->status & TSC2102_T2_DAV) {
-		tsc2102_read_async(&dev->req_adc, TSC2102_TS_TEMP2,
+		tsc2102_read_async(dev->spi, TSC2102_TS_TEMP2,
 				dev->adc_data, tsc2102_data_report);
 	}
 
@@ -526,7 +381,7 @@ static void tsc2102_status_report(struct tsc2102_dev *dev)
 
 static void tsc2102_check_status(struct tsc2102_dev *dev)
 {
-	tsc2102_read_async(&dev->req_status, TSC2102_TS_STATUS_CTRL,
+	tsc2102_read_async(dev->spi, TSC2102_TS_STATUS_CTRL,
 			&dev->status, tsc2102_status_report);
 }
 
@@ -579,7 +434,7 @@ static void tsc2102_pressure(unsigned long data)
 
 	BUG_ON(!dev->pendown);
 
-	tsc2102_read_async(&dev->req_pressure, TSC2102_TS_ADC_CTRL,
+	tsc2102_read_async(dev->spi, TSC2102_TS_ADC_CTRL,
 			&dev->adc_status, tsc2102_pressure_report);
 }
 
@@ -599,12 +454,12 @@ void tsc2102_set_volume(uint8_t left_ch, uint8_t right_ch)
 
 	spin_lock(&tsc.lock_sync);
 
-	val = tsc2102_read_sync(TSC2102_DAC_GAIN_CTRL);
+	val = tsc2102_read_sync(tsc.spi, TSC2102_DAC_GAIN_CTRL);
 
 	val &= 0x8080;	/* Preserve mute-bits */
 	val |= (left_ch << 8) | right_ch;
 
-	tsc2102_write_sync(TSC2102_DAC_GAIN_CTRL, val);
+	tsc2102_write_sync(tsc.spi, TSC2102_DAC_GAIN_CTRL, val);
 
 	spin_unlock(&tsc.lock_sync);
 }
@@ -615,12 +470,12 @@ void tsc2102_set_mute(int left_ch, int right_ch)
 	u16 val;
 	spin_lock(&tsc.lock_sync);
 
-	val = tsc2102_read_sync(TSC2102_DAC_GAIN_CTRL);
+	val = tsc2102_read_sync(tsc.spi, TSC2102_DAC_GAIN_CTRL);
 
 	val &= 0x7f7f;	/* Preserve volume settings */
 	val |= (left_ch << 15) | (right_ch << 7);
 
-	tsc2102_write_sync(TSC2102_DAC_GAIN_CTRL, val);
+	tsc2102_write_sync(tsc.spi, TSC2102_DAC_GAIN_CTRL, val);
 
 	spin_unlock(&tsc.lock_sync);
 }
@@ -631,7 +486,7 @@ void tsc2102_get_mute(int *left_ch, int *right_ch)
 	u16 val;
 	spin_lock(&tsc.lock_sync);
 
-	val = tsc2102_read_sync(TSC2102_DAC_GAIN_CTRL);
+	val = tsc2102_read_sync(tsc.spi, TSC2102_DAC_GAIN_CTRL);
 
 	spin_unlock(&tsc.lock_sync);
 
@@ -643,14 +498,14 @@ void tsc2102_set_deemphasis(int enable)
 {
 	u16 val;
 	spin_lock(&tsc.lock_sync);
-	val = tsc2102_read_sync(TSC2102_DAC_POWER_CTRL);
+	val = tsc2102_read_sync(tsc.spi, TSC2102_DAC_POWER_CTRL);
 
 	if (enable)
 		val &= ~TSC2102_DEEMPF;
 	else
 		val |= TSC2102_DEEMPF;
 
-	tsc2102_write_sync(TSC2102_DAC_POWER_CTRL, val);
+	tsc2102_write_sync(tsc.spi, TSC2102_DAC_POWER_CTRL, val);
 	spin_unlock(&tsc.lock_sync);
 }
 EXPORT_SYMBOL_GPL(tsc2102_set_deemphasis);
@@ -659,14 +514,14 @@ void tsc2102_set_bassboost(int enable)
 {
 	u16 val;
 	spin_lock(&tsc.lock_sync);
-	val = tsc2102_read_sync(TSC2102_DAC_POWER_CTRL);
+	val = tsc2102_read_sync(tsc.spi, TSC2102_DAC_POWER_CTRL);
 
 	if (enable)
 		val &= ~TSC2102_BASSBC;
 	else
 		val |= TSC2102_BASSBC;
 
-	tsc2102_write_sync(TSC2102_DAC_POWER_CTRL, val);
+	tsc2102_write_sync(tsc.spi, TSC2102_DAC_POWER_CTRL, val);
 	spin_unlock(&tsc.lock_sync);
 }
 EXPORT_SYMBOL_GPL(tsc2102_set_bassboost);
@@ -716,20 +571,27 @@ int tsc2102_set_rate(int rate)
 
 	spin_lock(&tsc.lock_sync);
 
-	tsc2102_write_sync(TSC2102_AUDIO1_CTRL, tsc2102_rates[i].divisor);
+	tsc2102_write_sync(tsc.spi, TSC2102_AUDIO1_CTRL,
+			tsc2102_rates[i].divisor);
 
-	val = tsc2102_read_sync(TSC2102_AUDIO3_CTRL);
+	val = tsc2102_read_sync(tsc.spi, TSC2102_AUDIO3_CTRL);
 
 	if (tsc2102_rates[i].fs_44k) {
-		tsc2102_write_sync(TSC2102_AUDIO3_CTRL, val | TSC2102_FS44K);
+		tsc2102_write_sync(tsc.spi, TSC2102_AUDIO3_CTRL,
+				val | TSC2102_FS44K);
 		/* Enable Phase-locked-loop, set up clock dividers */
-		tsc2102_write_sync(TSC2102_PLL1_CTRL, TSC2102_PLL1_44K);
-		tsc2102_write_sync(TSC2102_PLL2_CTRL, TSC2102_PLL2_44K);
+		tsc2102_write_sync(tsc.spi, TSC2102_PLL1_CTRL,
+				TSC2102_PLL1_44K);
+		tsc2102_write_sync(tsc.spi, TSC2102_PLL2_CTRL,
+				TSC2102_PLL2_44K);
 	} else {
-		tsc2102_write_sync(TSC2102_AUDIO3_CTRL, val & ~TSC2102_FS44K);
+		tsc2102_write_sync(tsc.spi, TSC2102_AUDIO3_CTRL,
+				val & ~TSC2102_FS44K);
 		/* Enable Phase-locked-loop, set up clock dividers */
-		tsc2102_write_sync(TSC2102_PLL1_CTRL, TSC2102_PLL1_48K);
-		tsc2102_write_sync(TSC2102_PLL2_CTRL, TSC2102_PLL2_48K);
+		tsc2102_write_sync(tsc.spi, TSC2102_PLL1_CTRL,
+				TSC2102_PLL1_48K);
+		tsc2102_write_sync(tsc.spi, TSC2102_PLL2_CTRL,
+				TSC2102_PLL2_48K);
 	}
 
 	spin_unlock(&tsc.lock_sync);
@@ -746,24 +608,30 @@ void tsc2102_dac_power(int state)
 
 	if (state) {
 		/* 16-bit words, DSP mode, sample at Fsref */
-		tsc2102_write_sync(TSC2102_AUDIO1_CTRL, 0x0100);
+		tsc2102_write_sync(tsc.spi, TSC2102_AUDIO1_CTRL, 0x0100);
 		/* Keyclicks off, soft-stepping at normal rate */
-		tsc2102_write_sync(TSC2102_AUDIO2_CTRL, TSC2102_KEYCLICK_OFF);
+		tsc2102_write_sync(tsc.spi, TSC2102_AUDIO2_CTRL,
+				TSC2102_KEYCLICK_OFF);
 		/* 44.1 kHz Fsref, continuous transfer mode, master DAC */
-		tsc2102_write_sync(TSC2102_AUDIO3_CTRL, 0x2800);
+		tsc2102_write_sync(tsc.spi, TSC2102_AUDIO3_CTRL, 0x2800);
 		/* Soft-stepping enabled */
-		tsc2102_write_sync(TSC2102_AUDIO4_CTRL, 0x0000);
+		tsc2102_write_sync(tsc.spi, TSC2102_AUDIO4_CTRL, 0x0000);
 
 		/* PLL generates 44.1 kHz */
-		tsc2102_write_sync(TSC2102_PLL1_CTRL, TSC2102_PLL1_44K);
-		tsc2102_write_sync(TSC2102_PLL2_CTRL, TSC2102_PLL2_44K);
+		tsc2102_write_sync(tsc.spi, TSC2102_PLL1_CTRL,
+				TSC2102_PLL1_44K);
+		tsc2102_write_sync(tsc.spi, TSC2102_PLL2_CTRL,
+				TSC2102_PLL2_44K);
 
 		/* Codec & DAC power up, virtual ground disabled */
-		tsc2102_write_sync(TSC2102_DAC_POWER_CTRL, TSC2102_DAC_ON);
+		tsc2102_write_sync(tsc.spi, TSC2102_DAC_POWER_CTRL,
+				TSC2102_DAC_ON);
 	} else {
 		/* All off */
-		tsc2102_write_sync(TSC2102_AUDIO4_CTRL, TSC2102_KEYCLICK_OFF);
-		tsc2102_write_sync(TSC2102_PLL1_CTRL, TSC2102_PLL1_OFF);
+		tsc2102_write_sync(tsc.spi, TSC2102_AUDIO4_CTRL,
+				TSC2102_KEYCLICK_OFF);
+		tsc2102_write_sync(tsc.spi, TSC2102_PLL1_CTRL,
+				TSC2102_PLL1_OFF);
 	}
 
 	spin_unlock(&tsc.lock_sync);
@@ -775,12 +643,14 @@ void tsc2102_set_i2s_master(int state)
 	uint16_t val;
 	spin_lock(&tsc.lock_sync);
 
-	val = tsc2102_read_sync(TSC2102_AUDIO3_CTRL);
+	val = tsc2102_read_sync(tsc.spi, TSC2102_AUDIO3_CTRL);
 
 	if (state)
-		tsc2102_write_sync(TSC2102_AUDIO3_CTRL, val | TSC2102_SLVMS);
+		tsc2102_write_sync(tsc.spi, TSC2102_AUDIO3_CTRL,
+				val | TSC2102_SLVMS);
 	else
-		tsc2102_write_sync(TSC2102_AUDIO3_CTRL, val & ~TSC2102_SLVMS);
+		tsc2102_write_sync(tsc.spi, TSC2102_AUDIO3_CTRL,
+				val & ~TSC2102_SLVMS);
 
 	spin_unlock(&tsc.lock_sync);
 }
@@ -791,19 +661,23 @@ EXPORT_SYMBOL_GPL(tsc2102_set_i2s_master);
 static int tsc2102_configure(struct tsc2102_dev *dev)
 {
 	/* Reset the chip */
-	tsc2102_write_sync(TSC2102_TS_RESET_CTRL, TSC2102_RESET);
+	tsc2102_write_sync(tsc.spi, TSC2102_TS_RESET_CTRL, TSC2102_RESET);
 
 	/* Reference mode, 100 usec delay, 1.25 V reference */
 	if (dev->pdata->use_internal)
-		tsc2102_write_sync(TSC2102_TS_REF_CTRL, TSC2102_ADC_INT_REF);
+		tsc2102_write_sync(tsc.spi, TSC2102_TS_REF_CTRL,
+				TSC2102_ADC_INT_REF);
 	else
-		tsc2102_write_sync(TSC2102_TS_REF_CTRL, TSC2102_ADC_EXT_REF);
+		tsc2102_write_sync(tsc.spi, TSC2102_TS_REF_CTRL,
+				TSC2102_ADC_EXT_REF);
 
 	/* 84 usec precharge time, 32 usec sense time */
-	tsc2102_write_sync(TSC2102_TS_CONFIG_CTRL, TSC2102_CONFIG_TIMES);
+	tsc2102_write_sync(tsc.spi, TSC2102_TS_CONFIG_CTRL,
+			TSC2102_CONFIG_TIMES);
 
 	/* PINT/DAV acts as DAV */
-	tsc2102_write_sync(TSC2102_TS_STATUS_CTRL, TSC2102_ADC_DAV);
+	tsc2102_write_sync(tsc.spi, TSC2102_TS_STATUS_CTRL,
+			TSC2102_ADC_DAV);
 
 	tsc2102_mode(dev);
 	mod_timer(&dev->mode_timer, jiffies +
@@ -816,7 +690,7 @@ static int tsc2102_configure(struct tsc2102_dev *dev)
  */
 int tsc2102_get_revision(void)
 {
-	return tsc2102_read_sync(TSC2102_AUDIO3_CTRL) & 7;
+	return tsc2102_read_sync(tsc.spi, TSC2102_AUDIO3_CTRL) & 7;
 }
 
 /*
@@ -834,7 +708,7 @@ void tsc2102_keyclick(int amplitude, int freq, int length)
 {
 	u16 val;
 	spin_lock(&tsc.lock_sync);
-	val = tsc2102_read_sync(TSC2102_AUDIO2_CTRL);
+	val = tsc2102_read_sync(tsc.spi, TSC2102_AUDIO2_CTRL);
 	val &= 0x800f;
 
 	/* Set amplitude */
@@ -865,7 +739,7 @@ void tsc2102_keyclick(int amplitude, int freq, int length)
 	/* Enable keyclick */
 	val |= 0x8000;
 
-	tsc2102_write_sync(TSC2102_AUDIO2_CTRL, val);
+	tsc2102_write_sync(tsc.spi, TSC2102_AUDIO2_CTRL, val);
 	spin_unlock(&tsc.lock_sync);
 }
 
@@ -945,7 +819,7 @@ tsc2102_suspend(struct spi_device *spi, pm_message_t state)
 		dev->touch_cb(0);
 
 	/* Abort current conversion and power down the ADC */
-	tsc2102_write_sync(TSC2102_TS_ADC_CTRL, TSC2102_ADC_ADST);
+	tsc2102_write_sync(tsc.spi, TSC2102_TS_ADC_CTRL, TSC2102_ADC_ADST);
 
 	dev->spi->dev.power.power_state = state;
 
@@ -994,16 +868,15 @@ static struct platform_device tsc2102_alsa_device = {
 static int tsc2102_probe(struct spi_device *spi)
 {
 	struct tsc2102_config *pdata = spi->dev.platform_data;
-	struct spi_transfer *spi_buffer;
 	int err = 0;
 
 	if (!pdata) {
-		printk(KERN_ERR "TSC2102: Platform data not supplied\n");
+		dev_err(&spi->dev, "TSC2102: Platform data not supplied\n");
 		return -ENOENT;
 	}
 
 	if (!spi->irq) {
-		printk(KERN_ERR "TSC2102: Invalid irq value\n");
+		dev_err(&spi->dev, "TSC2102: Invalid irq value\n");
 		return -ENOENT;
 	}
 
@@ -1015,27 +888,13 @@ static int tsc2102_probe(struct spi_device *spi)
 	tsc.mode_msecs = 1000;
 	tsc.spi = spi;
 
-	/* Allocate enough struct spi_transfer's for all requests */
-	spi_buffer = kzalloc(sizeof(struct spi_transfer) * 16, GFP_KERNEL);
-	if (!spi_buffer) {
-		printk(KERN_ERR "TSC2102: No memory for SPI buffers\n");
-		return -ENOMEM;
-	}
-
-	tsc.transfers = spi_buffer;
-	tsc2102_request_alloc(&tsc, &tsc.req_adc, 0, 4, &spi_buffer);
-	tsc2102_request_alloc(&tsc, &tsc.req_status, 0, 1, &spi_buffer);
-	tsc2102_request_alloc(&tsc, &tsc.req_pressure, 0, 1, &spi_buffer);
-	tsc2102_request_alloc(&tsc, &tsc.req_stopadc, 1, 1, &spi_buffer);
-	tsc2102_request_alloc(&tsc, &tsc.req_mode, 1, 1, &spi_buffer);
-
 	spin_lock_init(&tsc.lock);
 	spin_lock(&tsc.lock_sync);
 
 	/* Get the BCLK - assuming the rate is at 12000000 */
 	tsc.bclk_ck = clk_get(0, "bclk");
 	if (!tsc.bclk_ck) {
-		printk(KERN_ERR "Unable to get the clock BCLK\n");
+		dev_err(&spi->dev, "Unable to get the clock BCLK\n");
 		err = -EPERM;
 		goto done;
 	}
@@ -1044,7 +903,7 @@ static int tsc2102_probe(struct spi_device *spi)
 
 	if (request_irq(spi->irq, tsc2102_handler, IRQF_SAMPLE_RANDOM |
 				IRQF_TRIGGER_FALLING, "tsc2102", &tsc)) {
-		printk(KERN_ERR "Could not allocate touchscreen IRQ!\n");
+		dev_err(&spi->dev, "Could not allocate touchscreen IRQ!\n");
 		err = -EINVAL;
 		goto err_clk;
 	}
@@ -1065,7 +924,7 @@ static int tsc2102_probe(struct spi_device *spi)
 
 	/* Now try to detect the chip, make first contact */
 	if (tsc2102_get_revision() != 0x1) {
-		printk(KERN_ERR "No TI TSC2102 chip found!\n");
+		dev_err(&spi->dev, "No TI TSC2102 chip found!\n");
 		goto err_timer;
 	}
 
@@ -1089,7 +948,7 @@ static int tsc2102_probe(struct spi_device *spi)
 #ifdef CONFIG_HWMON
 	tsc.hwmondev = hwmon_device_register(&spi->dev);
 	if (IS_ERR(tsc.hwmondev)) {
-		printk(KERN_ERR "tsc2102_hwmon: Device registration failed\n");
+		dev_err(&spi->dev, "tsc2102_hwmon: Device registration failed\n");
 		err = PTR_ERR(tsc.hwmondev);
 		goto err_alsa;
 	}
@@ -1107,7 +966,7 @@ static int tsc2102_probe(struct spi_device *spi)
 	}
 
 	if (err)
-		printk(KERN_ERR "tsc2102_hwmon: Creating one or more "
+		dev_err(&spi->dev, "tsc2102_hwmon: Creating one or more "
 				"attribute files failed\n");
 	err = 0;	/* Not fatal */
 #endif
@@ -1154,8 +1013,6 @@ static int tsc2102_remove(struct spi_device *spi)
 	del_timer(&tsc.mode_timer);
 	del_timer(&tsc.ts_timer);
 
-	kfree(tsc.transfers);
-
 #ifdef CONFIG_HWMON
 	hwmon_device_unregister(dev->hwmondev);
 #endif
diff --git a/include/linux/spi/tsc2102.h b/include/linux/spi/tsc2102.h
index be13300..4c7e3c6 100644
--- a/include/linux/spi/tsc2102.h
+++ b/include/linux/spi/tsc2102.h
@@ -38,10 +38,11 @@ struct tsc2102_config {
 #define TSC_AUX		(1 << 2)
 #define TSC_TEMP	(1 << 4)
 
-extern u16 tsc2102_read_sync(int page, u8 address);
-extern void tsc2102_reads_sync(int page, u8 startaddress, u16 *data,
-		int numregs);
-extern void tsc2102_write_sync(int page, u8 address, u16 data);
+extern u16 tsc2102_read_sync(struct spi_device *spi, u32 reg);
+extern int tsc2102_reads_sync(struct spi_device *spi, u32 reg,
+		u16 *data, int numregs);
+extern int tsc2102_write_sync(struct spi_device *spi, u32 reg,
+		u16 data);
 
 typedef void (*tsc2102_touch_t)(int touching);
 typedef void (*tsc2102_coords_t)(int x, int y, int z1, int z2);
@@ -66,55 +67,53 @@ extern void tsc2102_set_bassboost(int enable);
 
 extern void tsc2102_keyclick(int amplitude, int freq, int length);
 
-#define TSC2102_REG(pg, addr)		pg, addr
-
 /* Page 0, Touch Screen & Keypad Data registers */
-#define TSC2102_TS_X			TSC2102_REG(0, 0x00)
-#define TSC2102_TS_Y			TSC2102_REG(0, 0x01)
-#define TSC2102_TS_Z1			TSC2102_REG(0, 0x02)
-#define TSC2102_TS_Z2			TSC2102_REG(0, 0x03)
-#define TSC2102_TS_BAT1			TSC2102_REG(0, 0x05)
-#define TSC2102_TS_BAT2			TSC2102_REG(0, 0x06)
-#define TSC2102_TS_AUX			TSC2102_REG(0, 0x07)
-#define TSC2102_TS_TEMP1		TSC2102_REG(0, 0x09)
-#define TSC2102_TS_TEMP2		TSC2102_REG(0, 0x0a)
+#define TSC2102_TS_X			TSC2XXX_REG(0, 0x00)
+#define TSC2102_TS_Y			TSC2XXX_REG(0, 0x01)
+#define TSC2102_TS_Z1			TSC2XXX_REG(0, 0x02)
+#define TSC2102_TS_Z2			TSC2XXX_REG(0, 0x03)
+#define TSC2102_TS_BAT1 		TSC2XXX_REG(0, 0x05)
+#define TSC2102_TS_BAT2 		TSC2XXX_REG(0, 0x06)
+#define TSC2102_TS_AUX			TSC2XXX_REG(0, 0x07)
+#define TSC2102_TS_TEMP1		TSC2XXX_REG(0, 0x09)
+#define TSC2102_TS_TEMP2		TSC2XXX_REG(0, 0x0a)
 
 /* Page 1, Touch Screen & Keypad Control registers */
-#define TSC2102_TS_ADC_CTRL		TSC2102_REG(1, 0x00)
-#define TSC2102_TS_STATUS_CTRL		TSC2102_REG(1, 0x01)
-#define TSC2102_TS_REF_CTRL		TSC2102_REG(1, 0x03)
-#define TSC2102_TS_RESET_CTRL		TSC2102_REG(1, 0x04)
-#define TSC2102_TS_CONFIG_CTRL		TSC2102_REG(1, 0x05)
+#define TSC2102_TS_ADC_CTRL		TSC2XXX_REG(1, 0x00)
+#define TSC2102_TS_STATUS_CTRL		TSC2XXX_REG(1, 0x01)
+#define TSC2102_TS_REF_CTRL		TSC2XXX_REG(1, 0x03)
+#define TSC2102_TS_RESET_CTRL		TSC2XXX_REG(1, 0x04)
+#define TSC2102_TS_CONFIG_CTRL		TSC2XXX_REG(1, 0x05)
 
 /* Page 2, Audio Control registers */
-#define TSC2102_AUDIO1_CTRL		TSC2102_REG(2, 0x00)
-#define TSC2102_DAC_GAIN_CTRL		TSC2102_REG(2, 0x02)
-#define TSC2102_AUDIO2_CTRL		TSC2102_REG(2, 0x04)
-#define TSC2102_DAC_POWER_CTRL		TSC2102_REG(2, 0x05)
-#define TSC2102_AUDIO3_CTRL		TSC2102_REG(2, 0x06)
-#define TSC2102_LCH_BASS_BOOST_N0	TSC2102_REG(2, 0x07)
-#define TSC2102_LCH_BASS_BOOST_N1	TSC2102_REG(2, 0x08)
-#define TSC2102_LCH_BASS_BOOST_N2	TSC2102_REG(2, 0x09)
-#define TSC2102_LCH_BASS_BOOST_N3	TSC2102_REG(2, 0x0a)
-#define TSC2102_LCH_BASS_BOOST_N4	TSC2102_REG(2, 0x0b)
-#define TSC2102_LCH_BASS_BOOST_N5	TSC2102_REG(2, 0x0c)
-#define TSC2102_LCH_BASS_BOOST_D1	TSC2102_REG(2, 0x0d)
-#define TSC2102_LCH_BASS_BOOST_D2	TSC2102_REG(2, 0x0e)
-#define TSC2102_LCH_BASS_BOOST_D4	TSC2102_REG(2, 0x0f)
-#define TSC2102_LCH_BASS_BOOST_D5	TSC2102_REG(2, 0x10)
-#define TSC2102_RCH_BASS_BOOST_N0	TSC2102_REG(2, 0x11)
-#define TSC2102_RCH_BASS_BOOST_N1	TSC2102_REG(2, 0x12)
-#define TSC2102_RCH_BASS_BOOST_N2	TSC2102_REG(2, 0x13)
-#define TSC2102_RCH_BASS_BOOST_N3	TSC2102_REG(2, 0x14)
-#define TSC2102_RCH_BASS_BOOST_N4	TSC2102_REG(2, 0x15)
-#define TSC2102_RCH_BASS_BOOST_N5	TSC2102_REG(2, 0x16)
-#define TSC2102_RCH_BASS_BOOST_D1	TSC2102_REG(2, 0x17)
-#define TSC2102_RCH_BASS_BOOST_D2	TSC2102_REG(2, 0x18)
-#define TSC2102_RCH_BASS_BOOST_D4	TSC2102_REG(2, 0x19)
-#define TSC2102_RCH_BASS_BOOST_D5	TSC2102_REG(2, 0x1a)
-#define TSC2102_PLL1_CTRL		TSC2102_REG(2, 0x1b)
-#define TSC2102_PLL2_CTRL		TSC2102_REG(2, 0x1c)
-#define TSC2102_AUDIO4_CTRL		TSC2102_REG(2, 0x1d)
+#define TSC2102_AUDIO1_CTRL		TSC2XXX_REG(2, 0x00)
+#define TSC2102_DAC_GAIN_CTRL		TSC2XXX_REG(2, 0x02)
+#define TSC2102_AUDIO2_CTRL		TSC2XXX_REG(2, 0x04)
+#define TSC2102_DAC_POWER_CTRL		TSC2XXX_REG(2, 0x05)
+#define TSC2102_AUDIO3_CTRL		TSC2XXX_REG(2, 0x06)
+#define TSC2102_LCH_BASS_BOOST_N0	TSC2XXX_REG(2, 0x07)
+#define TSC2102_LCH_BASS_BOOST_N1	TSC2XXX_REG(2, 0x08)
+#define TSC2102_LCH_BASS_BOOST_N2	TSC2XXX_REG(2, 0x09)
+#define TSC2102_LCH_BASS_BOOST_N3	TSC2XXX_REG(2, 0x0a)
+#define TSC2102_LCH_BASS_BOOST_N4	TSC2XXX_REG(2, 0x0b)
+#define TSC2102_LCH_BASS_BOOST_N5	TSC2XXX_REG(2, 0x0c)
+#define TSC2102_LCH_BASS_BOOST_D1	TSC2XXX_REG(2, 0x0d)
+#define TSC2102_LCH_BASS_BOOST_D2	TSC2XXX_REG(2, 0x0e)
+#define TSC2102_LCH_BASS_BOOST_D4	TSC2XXX_REG(2, 0x0f)
+#define TSC2102_LCH_BASS_BOOST_D5	TSC2XXX_REG(2, 0x10)
+#define TSC2102_RCH_BASS_BOOST_N0	TSC2XXX_REG(2, 0x11)
+#define TSC2102_RCH_BASS_BOOST_N1	TSC2XXX_REG(2, 0x12)
+#define TSC2102_RCH_BASS_BOOST_N2	TSC2XXX_REG(2, 0x13)
+#define TSC2102_RCH_BASS_BOOST_N3	TSC2XXX_REG(2, 0x14)
+#define TSC2102_RCH_BASS_BOOST_N4	TSC2XXX_REG(2, 0x15)
+#define TSC2102_RCH_BASS_BOOST_N5	TSC2XXX_REG(2, 0x16)
+#define TSC2102_RCH_BASS_BOOST_D1	TSC2XXX_REG(2, 0x17)
+#define TSC2102_RCH_BASS_BOOST_D2	TSC2XXX_REG(2, 0x18)
+#define TSC2102_RCH_BASS_BOOST_D4	TSC2XXX_REG(2, 0x19)
+#define TSC2102_RCH_BASS_BOOST_D5	TSC2XXX_REG(2, 0x1a)
+#define TSC2102_PLL1_CTRL		TSC2XXX_REG(2, 0x1b)
+#define TSC2102_PLL2_CTRL		TSC2XXX_REG(2, 0x1c)
+#define TSC2102_AUDIO4_CTRL		TSC2XXX_REG(2, 0x1d)
 
 /* Field masks for Audio Control 1 */
 #define AC1_WLEN(ARG)			(((ARG) & 0x03) << 10)

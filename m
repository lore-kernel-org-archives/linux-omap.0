From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v4 4/8] drivers:input:tsc2007: add iio interface to read external ADC input and temperature
Date: Mon, 17 Oct 2016 15:57:52 +0200
Message-ID: <4d3c600bf0a6b75a74212a103bf31525505290a0.1476712675.git.hns@goldelico.com>
References: <cover.1476712675.git.hns@goldelico.com>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <cover.1476712675.git.hns@goldelico.com>
In-Reply-To: <cover.1476712675.git.hns@goldelico.com>
References: <cover.1476712675.git.hns@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, Sebastian Reichel <sre@kernel.org>, "Andrew F. Davis" <afd@ti.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, linux-iio@vger.kernel.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

The tsc2007 chip not only has a resistive touch screen controller but
also an external AUX adc imput which can be used for an ambient
light sensor, battery voltage monitoring or any general purpose.

Additionally it can measure the chip temperature.

This extension provides an iio interface for these adc channels.

Since it is not wasting much resources and is very straightforward,
we simply provide all other adc channels as optional iio interfaces
as weel. This can be used for debugging or special applications.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/input/touchscreen/tsc2007.c | 151 +++++++++++++++++++++++++++++++++++-
 1 file changed, 150 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index c314331..b4a9504 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -30,6 +30,7 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/input/touchscreen.h>
+#include <linux/iio/iio.h>
 
 #define TSC2007_MEASURE_TEMP0		(0x0 << 4)
 #define TSC2007_MEASURE_AUX		(0x2 << 4)
@@ -61,6 +62,16 @@
 #define READ_X		(ADC_ON_12BIT | TSC2007_MEASURE_X)
 #define PWRDOWN		(TSC2007_12BIT | TSC2007_POWER_OFF_IRQ_EN)
 
+#define TSC2007_CHAN_IIO(_chan, _name, _type, _chan_info) \
+{ \
+	.datasheet_name = _name, \
+	.type = _type, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
+			BIT(_chan_info), \
+	.indexed = 1, \
+	.channel = _chan, \
+}
+
 struct ts_event {
 	u16	x;
 	u16	y;
@@ -69,9 +80,13 @@ struct ts_event {
 
 struct tsc2007 {
 	struct input_dev	*input;
+#ifdef CONFIG_IIO
+	struct iio_dev		*indio;
+#endif
 	char			phys[32];
 
 	struct i2c_client	*client;
+	struct mutex		mlock;
 
 	u16			model;
 	u16			x_plate_ohms;
@@ -192,7 +207,10 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 	while (!ts->stopped && tsc2007_is_pen_down(ts)) {
 
 		/* pen is down, continue with the measurement */
+
+		mutex_lock(&ts->mlock);
 		tsc2007_read_values(ts, &tc);
+		mutex_unlock(&ts->mlock);
 
 		rt = tsc2007_calculate_resistance(ts, &tc);
 
@@ -319,6 +337,89 @@ static void tsc2007_close(struct input_dev *input_dev)
 	tsc2007_stop(ts);
 }
 
+#ifdef CONFIG_IIO
+
+static const struct iio_chan_spec tsc2007_iio_channel[] = {
+	TSC2007_CHAN_IIO(0, "x", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
+	TSC2007_CHAN_IIO(1, "y", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
+	TSC2007_CHAN_IIO(2, "z1", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
+	TSC2007_CHAN_IIO(3, "z2", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
+	TSC2007_CHAN_IIO(4, "adc", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
+	TSC2007_CHAN_IIO(5, "rt", IIO_VOLTAGE, IIO_CHAN_INFO_RAW), /* Ohms? */
+	TSC2007_CHAN_IIO(6, "pen", IIO_PRESSURE, IIO_CHAN_INFO_RAW),
+	TSC2007_CHAN_IIO(7, "temp0", IIO_TEMP, IIO_CHAN_INFO_RAW),
+	TSC2007_CHAN_IIO(8, "temp1", IIO_TEMP, IIO_CHAN_INFO_RAW),
+};
+
+static int tsc2007_read_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
+{
+	struct  tsc2007 *tsc = iio_priv(indio_dev);
+	int adc_chan = chan->channel;
+	int ret = 0;
+
+	if (adc_chan >= ARRAY_SIZE(tsc2007_iio_channel))
+		return -EINVAL;
+
+	if (mask != IIO_CHAN_INFO_RAW)
+		return -EINVAL;
+
+	mutex_lock(&tsc->mlock);
+
+	switch (chan->channel) {
+	case 0:
+		*val = tsc2007_xfer(tsc, READ_X);
+		break;
+	case 1:
+		*val = tsc2007_xfer(tsc, READ_Y);
+		break;
+	case 2:
+		*val = tsc2007_xfer(tsc, READ_Z1);
+		break;
+	case 3:
+		*val = tsc2007_xfer(tsc, READ_Z2);
+		break;
+	case 4:
+		*val = tsc2007_xfer(tsc, (ADC_ON_12BIT | TSC2007_MEASURE_AUX));
+		break;
+	case 5: {
+		struct ts_event tc;
+
+		tc.x = tsc2007_xfer(tsc, READ_X);
+		tc.z1 = tsc2007_xfer(tsc, READ_Z1);
+		tc.z2 = tsc2007_xfer(tsc, READ_Z2);
+		*val = tsc2007_calculate_resistance(tsc, &tc);
+		break;
+	}
+	case 6:
+		*val = tsc2007_is_pen_down(tsc);
+		break;
+	case 7:
+		*val = tsc2007_xfer(tsc,
+				    (ADC_ON_12BIT | TSC2007_MEASURE_TEMP0));
+		break;
+	case 8:
+		*val = tsc2007_xfer(tsc,
+				    (ADC_ON_12BIT | TSC2007_MEASURE_TEMP1));
+		break;
+	}
+
+	/* Prepare for next touch reading - power down ADC, enable PENIRQ */
+	tsc2007_xfer(tsc, PWRDOWN);
+
+	mutex_unlock(&tsc->mlock);
+
+	ret = IIO_VAL_INT;
+
+	return ret;
+}
+
+static const struct iio_info tsc2007_iio_info = {
+	.read_raw = tsc2007_read_raw,
+	.driver_module = THIS_MODULE,
+};
+#endif
+
 #ifdef CONFIG_OF
 static int tsc2007_get_pendown_state_gpio(struct device *dev)
 {
@@ -453,26 +554,56 @@ static int tsc2007_probe(struct i2c_client *client,
 	const struct tsc2007_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct tsc2007 *ts;
 	struct input_dev *input_dev;
+#ifdef CONFIG_IIO
+	struct iio_dev *indio_dev;
+#endif
 	int err;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_READ_WORD_DATA))
 		return -EIO;
 
+#ifdef CONFIG_IIO
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*ts));
+	if (!indio_dev) {
+		dev_err(&client->dev, "iio_device_alloc failed\n");
+		return -ENOMEM;
+	}
+
+	ts = iio_priv(indio_dev);
+#else
 	ts = devm_kzalloc(&client->dev, sizeof(struct tsc2007), GFP_KERNEL);
 	if (!ts)
 		return -ENOMEM;
-
+#endif
 	input_dev = devm_input_allocate_device(&client->dev);
 	if (!input_dev)
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, ts);
 
+#ifdef CONFIG_IIO
+	indio_dev->name = "tsc2007";
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &tsc2007_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = tsc2007_iio_channel;
+	indio_dev->num_channels = ARRAY_SIZE(tsc2007_iio_channel);
+
+	err = iio_device_register(indio_dev);
+	if (err < 0) {
+		dev_err(&client->dev, "iio_device_register() failed: %d\n",
+			err);
+		return err;
+	}
+	ts->indio = indio_dev;
+#endif
+
 	ts->client = client;
 	ts->irq = client->irq;
 	ts->input = input_dev;
 	init_waitqueue_head(&ts->wait);
+	mutex_init(&ts->mlock);
 
 	snprintf(ts->phys, sizeof(ts->phys),
 		 "%s/input0", dev_name(&client->dev));
@@ -543,7 +674,9 @@ static int tsc2007_probe(struct i2c_client *client,
 	if (err < 0) {
 		dev_err(&client->dev,
 			"Failed to setup chip: %d\n", err);
+#ifdef CONFIG_IIO
 		iio_device_unregister(indio_dev);
+#endif
 		return err;	/* usually, chip does not respond */
 	}
 
@@ -557,6 +690,21 @@ static int tsc2007_probe(struct i2c_client *client,
 	return 0;
 }
 
+static int tsc2007_remove(struct i2c_client *client)
+{
+	struct tsc2007 *ts = i2c_get_clientdata(client);
+	struct input_dev *input_dev = ts->input;
+#ifdef CONFIG_IIO
+	struct iio_dev *indio_dev = ts->indio;
+#endif
+	input_unregister_device(input_dev);
+
+#ifdef CONFIG_IIO
+	iio_device_unregister(indio_dev);
+#endif
+	return 0;
+}
+
 static const struct i2c_device_id tsc2007_idtable[] = {
 	{ "tsc2007", 0 },
 	{ }
@@ -579,6 +727,7 @@ static struct i2c_driver tsc2007_driver = {
 	},
 	.id_table	= tsc2007_idtable,
 	.probe		= tsc2007_probe,
+	.remove		= tsc2007_remove,
 };
 
 module_i2c_driver(tsc2007_driver);
-- 
2.7.3


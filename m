From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v7 4/9] drivers:input:tsc2007: add iio interface to read
 external ADC input and temperature
Date: Sat, 12 Nov 2016 14:19:30 +0000
Message-ID: <b4d79a26-4353-9860-a884-49c751bbe617@kernel.org>
References: <cover.1478890925.git.hns@goldelico.com>
 <6c64bb0331ad05840a2886bef6c3cfa64c866cb6.1478890925.git.hns@goldelico.com>
 <fc901399-0bde-d936-b9e2-4c591549eb55@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fc901399-0bde-d936-b9e2-4c591549eb55@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, linux-iio@vger.kernel.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

On 12/11/16 14:04, Jonathan Cameron wrote:
> On 11/11/16 19:02, H. Nikolaus Schaller wrote:
>> The tsc2007 chip not only has a resistive touch screen controller but
>> also an external AUX adc imput which can be used for an ambient
>> light sensor, battery voltage monitoring or any general purpose.
>>
>> Additionally it can measure the chip temperature.
>>
>> This extension provides an iio interface for these adc channels.
>>
>> Since it is not wasting much resources and is very straightforward,
>> we simply provide all other adc channels as optional iio interfaces
>> as weel. This can be used for debugging or special applications.
>>
>> This patch also splits the tsc2007 driver in several source files:
>> tsc2007.h -- constants, structs and stubs
>> tsc2007_core.c -- functional parts of the original driver
>> tsc2007_iio.c -- the optional iio stuff
>>
>> Makefile magic allows to conditionally link the iio
>> stuff if CONFIG_IIO=y in a way that it works with
>> CONFIG_TOUCHSCREEN_TSC2007=m.
>>
> 
> I ran a quick build test and it blows up in a number of ways related to
> the #ifdef CONFIG_IIO.
> 
> I'm not entirely sure why but
> #if IS_ENABLED(CONFIG_IIO) works fine.
Ah, I'm being sleepy today.  It's because I'm building IIO as a module
and the symbol defined would therefore be CONFIG_IIO_MODULE.

The IS_ENABLED macro takes care of both cases.
> 
> Otherwise looks good to me
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
>> ---
>>  drivers/input/touchscreen/Makefile                 |   2 +
>>  drivers/input/touchscreen/tsc2007.h                | 118 ++++++++++++++++
>>  .../touchscreen/{tsc2007.c => tsc2007_core.c}      | 119 ++++++----------
>>  drivers/input/touchscreen/tsc2007_iio.c            | 152 +++++++++++++++++++++
>>  4 files changed, 310 insertions(+), 81 deletions(-)
>>  create mode 100644 drivers/input/touchscreen/tsc2007.h
>>  rename drivers/input/touchscreen/{tsc2007.c => tsc2007_core.c} (85%)
>>  create mode 100644 drivers/input/touchscreen/tsc2007_iio.c
>>
>> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
>> index 81b8645..d932e2d 100644
>> --- a/drivers/input/touchscreen/Makefile
>> +++ b/drivers/input/touchscreen/Makefile
>> @@ -80,6 +80,8 @@ obj-$(CONFIG_TOUCHSCREEN_TSC_SERIO)	+= tsc40.o
>>  obj-$(CONFIG_TOUCHSCREEN_TSC200X_CORE)	+= tsc200x-core.o
>>  obj-$(CONFIG_TOUCHSCREEN_TSC2004)	+= tsc2004.o
>>  obj-$(CONFIG_TOUCHSCREEN_TSC2005)	+= tsc2005.o
>> +tsc2007-y				:= tsc2007_core.o
>> +tsc2007-$(CONFIG_IIO)			+= tsc2007_iio.o
>>  obj-$(CONFIG_TOUCHSCREEN_TSC2007)	+= tsc2007.o
>>  obj-$(CONFIG_TOUCHSCREEN_UCB1400)	+= ucb1400_ts.o
>>  obj-$(CONFIG_TOUCHSCREEN_WACOM_W8001)	+= wacom_w8001.o
>> diff --git a/drivers/input/touchscreen/tsc2007.h b/drivers/input/touchscreen/tsc2007.h
>> new file mode 100644
>> index 0000000..5049bf8
>> --- /dev/null
>> +++ b/drivers/input/touchscreen/tsc2007.h
>> @@ -0,0 +1,118 @@
>> +/*
>> + * drivers/input/touchscreen/tsc2007.h
>> + *
>> + * Copyright (c) 2008 MtekVision Co., Ltd.
>> + *	Kwangwoo Lee <kwlee@mtekvision.com>
>> + *
>> + * Using code from:
>> + *  - ads7846.c
>> + *	Copyright (c) 2005 David Brownell
>> + *	Copyright (c) 2006 Nokia Corporation
>> + *  - corgi_ts.c
>> + *	Copyright (C) 2004-2005 Richard Purdie
>> + *  - omap_ts.[hc], ads7846.h, ts_osk.c
>> + *	Copyright (C) 2002 MontaVista Software
>> + *	Copyright (C) 2004 Texas Instruments
>> + *	Copyright (C) 2005 Dirk Behme
>> + *
>> + *  This program is free software; you can redistribute it and/or modify
>> + *  it under the terms of the GNU General Public License version 2 as
>> + *  published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/input/touchscreen.h>
>> +
>> +#define TSC2007_MEASURE_TEMP0		(0x0 << 4)
>> +#define TSC2007_MEASURE_AUX		(0x2 << 4)
>> +#define TSC2007_MEASURE_TEMP1		(0x4 << 4)
>> +#define TSC2007_ACTIVATE_XN		(0x8 << 4)
>> +#define TSC2007_ACTIVATE_YN		(0x9 << 4)
>> +#define TSC2007_ACTIVATE_YP_XN		(0xa << 4)
>> +#define TSC2007_SETUP			(0xb << 4)
>> +#define TSC2007_MEASURE_X		(0xc << 4)
>> +#define TSC2007_MEASURE_Y		(0xd << 4)
>> +#define TSC2007_MEASURE_Z1		(0xe << 4)
>> +#define TSC2007_MEASURE_Z2		(0xf << 4)
>> +
>> +#define TSC2007_POWER_OFF_IRQ_EN	(0x0 << 2)
>> +#define TSC2007_ADC_ON_IRQ_DIS0		(0x1 << 2)
>> +#define TSC2007_ADC_OFF_IRQ_EN		(0x2 << 2)
>> +#define TSC2007_ADC_ON_IRQ_DIS1		(0x3 << 2)
>> +
>> +#define TSC2007_12BIT			(0x0 << 1)
>> +#define TSC2007_8BIT			(0x1 << 1)
>> +
>> +#define	MAX_12BIT			((1 << 12) - 1)
>> +
>> +#define ADC_ON_12BIT	(TSC2007_12BIT | TSC2007_ADC_ON_IRQ_DIS0)
>> +
>> +#define READ_Y		(ADC_ON_12BIT | TSC2007_MEASURE_Y)
>> +#define READ_Z1		(ADC_ON_12BIT | TSC2007_MEASURE_Z1)
>> +#define READ_Z2		(ADC_ON_12BIT | TSC2007_MEASURE_Z2)
>> +#define READ_X		(ADC_ON_12BIT | TSC2007_MEASURE_X)
>> +#define PWRDOWN		(TSC2007_12BIT | TSC2007_POWER_OFF_IRQ_EN)
>> +
>> +struct ts_event {
>> +	u16	x;
>> +	u16	y;
>> +	u16	z1, z2;
>> +};
>> +
>> +struct tsc2007 {
>> +	struct input_dev	*input;
>> +	char			phys[32];
>> +
>> +	struct i2c_client	*client;
>> +
>> +	u16			model;
>> +	u16			x_plate_ohms;
>> +
>> +	struct touchscreen_properties prop;
>> +
>> +	bool			report_resistance;
>> +	u16			min_x;
>> +	u16			min_y;
>> +	u16			max_x;
>> +	u16			max_y;
>> +	u16			max_rt;
>> +	unsigned long		poll_period; /* in jiffies */
>> +	int			fuzzx;
>> +	int			fuzzy;
>> +	int			fuzzz;
>> +
>> +	unsigned int		gpio;
>> +	int			irq;
>> +
>> +	wait_queue_head_t	wait;
>> +	bool			stopped;
>> +	bool			pendown;
>> +
>> +	int			(*get_pendown_state)(struct device *);
>> +	void			(*clear_penirq)(void);
>> +
>> +	struct mutex		mlock;
>> +	struct iio_dev		*iio_dev;	/* optional */
>> +};
>> +
>> +int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd);
>> +u32 tsc2007_calculate_resistance(struct tsc2007 *tsc,
>> +					struct ts_event *tc);
>> +bool tsc2007_is_pen_down(struct tsc2007 *ts);
>> +
>> +#ifdef CONFIG_IIO
>> +
>> +/* defined in tsc2007_iio.c */
>> +int tsc2007_iio_configure(struct tsc2007 *ts);
>> +void tsc2007_iio_unconfigure(struct tsc2007 *ts);
>> +
>> +#else /* CONFIG_IIO */
>> +
>> +static inline int tsc2007_iio_configure(struct tsc2007 *ts)
>> +{
>> +	return 0;
>> +}
>> +static inline void tsc2007_iio_unconfigure(struct tsc2007 *ts)
>> +{
>> +}
>> +
>> +#endif /* CONFIG_IIO */
>> diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007_core.c
>> similarity index 85%
>> rename from drivers/input/touchscreen/tsc2007.c
>> rename to drivers/input/touchscreen/tsc2007_core.c
>> index 5e3c4bf..72775ae 100644
>> --- a/drivers/input/touchscreen/tsc2007.c
>> +++ b/drivers/input/touchscreen/tsc2007_core.c
>> @@ -27,80 +27,10 @@
>>  #include <linux/i2c.h>
>>  #include <linux/i2c/tsc2007.h>
>>  #include <linux/of_device.h>
>> -#include <linux/of.h>
>>  #include <linux/of_gpio.h>
>> -#include <linux/input/touchscreen.h>
>> -
>> -#define TSC2007_MEASURE_TEMP0		(0x0 << 4)
>> -#define TSC2007_MEASURE_AUX		(0x2 << 4)
>> -#define TSC2007_MEASURE_TEMP1		(0x4 << 4)
>> -#define TSC2007_ACTIVATE_XN		(0x8 << 4)
>> -#define TSC2007_ACTIVATE_YN		(0x9 << 4)
>> -#define TSC2007_ACTIVATE_YP_XN		(0xa << 4)
>> -#define TSC2007_SETUP			(0xb << 4)
>> -#define TSC2007_MEASURE_X		(0xc << 4)
>> -#define TSC2007_MEASURE_Y		(0xd << 4)
>> -#define TSC2007_MEASURE_Z1		(0xe << 4)
>> -#define TSC2007_MEASURE_Z2		(0xf << 4)
>> -
>> -#define TSC2007_POWER_OFF_IRQ_EN	(0x0 << 2)
>> -#define TSC2007_ADC_ON_IRQ_DIS0		(0x1 << 2)
>> -#define TSC2007_ADC_OFF_IRQ_EN		(0x2 << 2)
>> -#define TSC2007_ADC_ON_IRQ_DIS1		(0x3 << 2)
>> -
>> -#define TSC2007_12BIT			(0x0 << 1)
>> -#define TSC2007_8BIT			(0x1 << 1)
>> -
>> -#define	MAX_12BIT			((1 << 12) - 1)
>> -
>> -#define ADC_ON_12BIT	(TSC2007_12BIT | TSC2007_ADC_ON_IRQ_DIS0)
>> -
>> -#define READ_Y		(ADC_ON_12BIT | TSC2007_MEASURE_Y)
>> -#define READ_Z1		(ADC_ON_12BIT | TSC2007_MEASURE_Z1)
>> -#define READ_Z2		(ADC_ON_12BIT | TSC2007_MEASURE_Z2)
>> -#define READ_X		(ADC_ON_12BIT | TSC2007_MEASURE_X)
>> -#define PWRDOWN		(TSC2007_12BIT | TSC2007_POWER_OFF_IRQ_EN)
>> -
>> -struct ts_event {
>> -	u16	x;
>> -	u16	y;
>> -	u16	z1, z2;
>> -};
>> -
>> -struct tsc2007 {
>> -	struct input_dev	*input;
>> -	char			phys[32];
>> -
>> -	struct i2c_client	*client;
>> -
>> -	u16			model;
>> -	u16			x_plate_ohms;
>> -
>> -	struct touchscreen_properties prop;
>> -
>> -	bool			report_resistance;
>> -	u16			min_x;
>> -	u16			min_y;
>> -	u16			max_x;
>> -	u16			max_y;
>> -	u16			max_rt;
>> -	unsigned long		poll_period; /* in jiffies */
>> -	int			fuzzx;
>> -	int			fuzzy;
>> -	int			fuzzz;
>> +#include "tsc2007.h"
>>  
>> -	unsigned		gpio;
>> -	int			irq;
>> -
>> -	wait_queue_head_t	wait;
>> -	bool			stopped;
>> -	bool			pendown;
>> -
>> -	int			(*get_pendown_state)(struct device *);
>> -	void			(*clear_penirq)(void);
>> -};
>> -
>> -static inline int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd)
>> +int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd)
>>  {
>>  	s32 data;
>>  	u16 val;
>> @@ -121,6 +51,7 @@ static inline int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd)
>>  
>>  	return val;
>>  }
>> +EXPORT_SYMBOL(tsc2007_xfer);
>>  
>>  static void tsc2007_read_values(struct tsc2007 *tsc, struct ts_event *tc)
>>  {
>> @@ -138,7 +69,7 @@ static void tsc2007_read_values(struct tsc2007 *tsc, struct ts_event *tc)
>>  	tsc2007_xfer(tsc, PWRDOWN);
>>  }
>>  
>> -static u32 tsc2007_calculate_resistance(struct tsc2007 *tsc,
>> +u32 tsc2007_calculate_resistance(struct tsc2007 *tsc,
>>  					struct ts_event *tc)
>>  {
>>  	u32 rt = 0;
>> @@ -158,8 +89,9 @@ static u32 tsc2007_calculate_resistance(struct tsc2007 *tsc,
>>  
>>  	return rt;
>>  }
>> +EXPORT_SYMBOL(tsc2007_calculate_resistance);
>>  
>> -static bool tsc2007_is_pen_down(struct tsc2007 *ts)
>> +bool tsc2007_is_pen_down(struct tsc2007 *ts)
>>  {
>>  	/*
>>  	 * NOTE: We can't rely on the pressure to determine the pen down
>> @@ -180,6 +112,7 @@ static bool tsc2007_is_pen_down(struct tsc2007 *ts)
>>  
>>  	return ts->get_pendown_state(&ts->client->dev);
>>  }
>> +EXPORT_SYMBOL(tsc2007_is_pen_down);
>>  
>>  static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
>>  {
>> @@ -192,7 +125,10 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
>>  	while (!ts->stopped && tsc2007_is_pen_down(ts)) {
>>  
>>  		/* pen is down, continue with the measurement */
>> +
>> +		mutex_lock(&ts->mlock);
>>  		tsc2007_read_values(ts, &tc);
>> +		mutex_unlock(&ts->mlock);
>>  
>>  		rt = tsc2007_calculate_resistance(ts, &tc);
>>  
>> @@ -450,7 +386,8 @@ static void tsc2007_call_exit_platform_hw(void *data)
>>  static int tsc2007_probe(struct i2c_client *client,
>>  			 const struct i2c_device_id *id)
>>  {
>> -	const struct tsc2007_platform_data *pdata = dev_get_platdata(&client->dev);
>> +	const struct tsc2007_platform_data *pdata =
>> +		dev_get_platdata(&client->dev);
>>  	struct tsc2007 *ts;
>>  	struct input_dev *input_dev;
>>  	int err;
>> @@ -472,7 +409,13 @@ static int tsc2007_probe(struct i2c_client *client,
>>  	ts->client = client;
>>  	ts->irq = client->irq;
>>  	ts->input = input_dev;
>> +
>> +	err = tsc2007_iio_configure(ts);
>> +	if (err < 0)
>> +		return err;
>> +
>>  	init_waitqueue_head(&ts->wait);
>> +	mutex_init(&ts->mlock);
>>  
>>  	snprintf(ts->phys, sizeof(ts->phys),
>>  		 "%s/input0", dev_name(&client->dev));
>> @@ -494,7 +437,7 @@ static int tsc2007_probe(struct i2c_client *client,
>>  	if (pdata) {
>>  		err = tsc2007_probe_pdev(client, ts, pdata, id);
>>  		if (err)
>> -			return err;
>> +			goto probe_err;
>>  		input_set_abs_params(input_dev, ABS_X, 0, ts->max_x-ts->min_x,
>>  							  ts->fuzzx, 0);
>>  		input_set_abs_params(input_dev, ABS_Y, 0, ts->max_y-ts->min_y,
>> @@ -504,7 +447,7 @@ static int tsc2007_probe(struct i2c_client *client,
>>  	} else {
>>  		err = tsc2007_probe_dt(client, ts);
>>  		if (err)
>> -			return err;
>> +			goto probe_err;
>>  	}
>>  
>>  	if (pdata) {
>> @@ -516,7 +459,7 @@ static int tsc2007_probe(struct i2c_client *client,
>>  				dev_err(&client->dev,
>>  					"Failed to register exit_platform_hw action, %d\n",
>>  					err);
>> -				return err;
>> +				goto probe_err;
>>  			}
>>  		}
>>  
>> @@ -533,7 +476,7 @@ static int tsc2007_probe(struct i2c_client *client,
>>  	if (err) {
>>  		dev_err(&client->dev, "Failed to request irq %d: %d\n",
>>  			ts->irq, err);
>> -		return err;
>> +		goto probe_err;
>>  	}
>>  
>>  	tsc2007_stop(ts);
>> @@ -543,17 +486,30 @@ static int tsc2007_probe(struct i2c_client *client,
>>  	if (err < 0) {
>>  		dev_err(&client->dev,
>>  			"Failed to setup chip: %d\n", err);
>> -		return err;	/* usually, chip does not respond */
>> +		goto probe_err;	/* chip does not respond */
>>  	}
>>  
>>  	err = input_register_device(input_dev);
>>  	if (err) {
>>  		dev_err(&client->dev,
>>  			"Failed to register input device: %d\n", err);
>> -		return err;
>> +		goto probe_err;
>>  	}
>>  
>>  	return 0;
>> +
>> +probe_err:
>> +	tsc2007_iio_unconfigure(ts);
>> +	return err;
>> +}
>> +
>> +static int tsc2007_remove(struct i2c_client *client)
>> +{
>> +	struct tsc2007 *ts = i2c_get_clientdata(client);
>> +
>> +	tsc2007_iio_unconfigure(ts);
>> +	input_unregister_device(ts->input);
>> +	return 0;
>>  }
>>  
>>  static const struct i2c_device_id tsc2007_idtable[] = {
>> @@ -578,6 +534,7 @@ static struct i2c_driver tsc2007_driver = {
>>  	},
>>  	.id_table	= tsc2007_idtable,
>>  	.probe		= tsc2007_probe,
>> +	.remove		= tsc2007_remove,
>>  };
>>  
>>  module_i2c_driver(tsc2007_driver);
>> diff --git a/drivers/input/touchscreen/tsc2007_iio.c b/drivers/input/touchscreen/tsc2007_iio.c
>> new file mode 100644
>> index 0000000..e492bba
>> --- /dev/null
>> +++ b/drivers/input/touchscreen/tsc2007_iio.c
>> @@ -0,0 +1,152 @@
>> +/*
>> + * drivers/input/touchscreen/tsc2007_iio.c
>> + *
>> + * Copyright (c) 2016 Golden Delicious Comp. GmbH&Co. KG
>> + *	Nikolaus Schaller <hns@goldelico.com>
>> + *
>> + *  This program is free software; you can redistribute it and/or modify
>> + *  it under the terms of the GNU General Public License version 2 as
>> + *  published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/i2c.h>
>> +#include <linux/iio/iio.h>
>> +#include "tsc2007.h"
>> +
>> +struct tsc2007_iio {
>> +	struct tsc2007 *ts;
>> +};
>> +
>> +#define TSC2007_CHAN_IIO(_chan, _name, _type, _chan_info) \
>> +{ \
>> +	.datasheet_name = _name, \
>> +	.type = _type, \
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
>> +			BIT(_chan_info), \
>> +	.indexed = 1, \
>> +	.channel = _chan, \
>> +}
>> +
>> +static const struct iio_chan_spec tsc2007_iio_channel[] = {
>> +	TSC2007_CHAN_IIO(0, "x", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>> +	TSC2007_CHAN_IIO(1, "y", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>> +	TSC2007_CHAN_IIO(2, "z1", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>> +	TSC2007_CHAN_IIO(3, "z2", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>> +	TSC2007_CHAN_IIO(4, "adc", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>> +	TSC2007_CHAN_IIO(5, "rt", IIO_VOLTAGE, IIO_CHAN_INFO_RAW), /* Ohms? */
>> +	TSC2007_CHAN_IIO(6, "pen", IIO_PRESSURE, IIO_CHAN_INFO_RAW),
>> +	TSC2007_CHAN_IIO(7, "temp0", IIO_TEMP, IIO_CHAN_INFO_RAW),
>> +	TSC2007_CHAN_IIO(8, "temp1", IIO_TEMP, IIO_CHAN_INFO_RAW),
>> +};
>> +
>> +static int tsc2007_read_raw(struct iio_dev *indio_dev,
>> +	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
>> +{
>> +	struct tsc2007_iio *iio = iio_priv(indio_dev);
>> +	struct tsc2007 *tsc = iio->ts;
>> +	int adc_chan = chan->channel;
>> +	int ret = 0;
>> +
>> +	if (adc_chan >= ARRAY_SIZE(tsc2007_iio_channel))
>> +		return -EINVAL;
>> +
>> +	if (mask != IIO_CHAN_INFO_RAW)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&tsc->mlock);
>> +
>> +	switch (chan->channel) {
>> +	case 0:
>> +		*val = tsc2007_xfer(tsc, READ_X);
>> +		break;
>> +	case 1:
>> +		*val = tsc2007_xfer(tsc, READ_Y);
>> +		break;
>> +	case 2:
>> +		*val = tsc2007_xfer(tsc, READ_Z1);
>> +		break;
>> +	case 3:
>> +		*val = tsc2007_xfer(tsc, READ_Z2);
>> +		break;
>> +	case 4:
>> +		*val = tsc2007_xfer(tsc, (ADC_ON_12BIT | TSC2007_MEASURE_AUX));
>> +		break;
>> +	case 5: {
>> +		struct ts_event tc;
>> +
>> +		tc.x = tsc2007_xfer(tsc, READ_X);
>> +		tc.z1 = tsc2007_xfer(tsc, READ_Z1);
>> +		tc.z2 = tsc2007_xfer(tsc, READ_Z2);
>> +		*val = tsc2007_calculate_resistance(tsc, &tc);
>> +		break;
>> +	}
>> +	case 6:
>> +		*val = tsc2007_is_pen_down(tsc);
>> +		break;
>> +	case 7:
>> +		*val = tsc2007_xfer(tsc,
>> +				    (ADC_ON_12BIT | TSC2007_MEASURE_TEMP0));
>> +		break;
>> +	case 8:
>> +		*val = tsc2007_xfer(tsc,
>> +				    (ADC_ON_12BIT | TSC2007_MEASURE_TEMP1));
>> +		break;
>> +	}
>> +
>> +	/* Prepare for next touch reading - power down ADC, enable PENIRQ */
>> +	tsc2007_xfer(tsc, PWRDOWN);
>> +
>> +	mutex_unlock(&tsc->mlock);
>> +
>> +	ret = IIO_VAL_INT;
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct iio_info tsc2007_iio_info = {
>> +	.read_raw = tsc2007_read_raw,
>> +	.driver_module = THIS_MODULE,
>> +};
>> +
>> +int tsc2007_iio_configure(struct tsc2007 *ts)
>> +{
>> +	int err;
>> +	struct iio_dev *indio_dev;
>> +	struct tsc2007_iio *iio;
>> +
>> +	indio_dev = devm_iio_device_alloc(&ts->client->dev,
>> +		sizeof(struct tsc2007_iio));
>> +	if (!indio_dev) {
>> +		dev_err(&ts->client->dev, "iio_device_alloc failed\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	iio = iio_priv(indio_dev);
>> +	iio->ts = ts;
>> +	ts->iio_dev = (void *) indio_dev;
>> +
>> +	indio_dev->name = "tsc2007";
>> +	indio_dev->dev.parent = &ts->client->dev;
>> +	indio_dev->info = &tsc2007_iio_info;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->channels = tsc2007_iio_channel;
>> +	indio_dev->num_channels = ARRAY_SIZE(tsc2007_iio_channel);
>> +
>> +	err = iio_device_register(indio_dev);
>> +	if (err < 0) {
>> +		dev_err(&ts->client->dev, "iio_device_register() failed: %d\n",
>> +			err);
>> +		return err;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(tsc2007_iio_configure);
>> +
>> +void tsc2007_iio_unconfigure(struct tsc2007 *ts)
>> +{
>> +	struct iio_dev *indio_dev = ts->iio_dev;
>> +
>> +	iio_device_unregister(indio_dev);
>> +}
>> +EXPORT_SYMBOL(tsc2007_iio_unconfigure);
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

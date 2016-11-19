From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 4/8] drivers:input:tsc2007: add iio interface to read
 external ADC input and temperature
Date: Sat, 19 Nov 2016 10:36:15 -0800
Message-ID: <20161119183615.GC20446@dtor-ws>
References: <cover.1477557860.git.hns@goldelico.com>
 <810571cc83159c674116f6f55624ca6227510f96.1477557860.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <810571cc83159c674116f6f55624ca6227510f96.1477557860.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Sangwon Jee <jeesw-iQTvn4YitUrQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel@openphoe
List-Id: linux-omap@vger.kernel.org

Hi Nikolaus,

On Thu, Oct 27, 2016 at 10:44:17AM +0200, H. Nikolaus Schaller wrote:
> The tsc2007 chip not only has a resistive touch screen controller but
> also an external AUX adc imput which can be used for an ambient
> light sensor, battery voltage monitoring or any general purpose.
> 
> Additionally it can measure the chip temperature.
> 
> This extension provides an iio interface for these adc channels.
> 
> Since it is not wasting much resources and is very straightforward,
> we simply provide all other adc channels as optional iio interfaces
> as weel. This can be used for debugging or special applications.
> 
> This patch also splits the tsc2007 driver in several source files:
> tsc2007.h -- constants, structs and stubs
> tsc2007_core.c -- functional parts of the original driver
> tsc2007_iio.c -- the optional iio stuff
> 
> Makefile magic allows to conditionally link the iio
> stuff if CONFIG_IIO=y in a way that it works with
> CONFIG_TOUCHSCREEN_TSC2007=m.

What about CONFIG_TOUCHSCREEN_TSC2007=y and CONFIG_IIO=m?

> 
> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> ---
>  drivers/input/touchscreen/Makefile                 |   2 +
>  drivers/input/touchscreen/tsc2007.h                | 129 ++++++++++++++++++
>  .../touchscreen/{tsc2007.c => tsc2007_core.c}      | 127 ++++++-----------
>  drivers/input/touchscreen/tsc2007_iio.c            | 151 +++++++++++++++++++++
>  4 files changed, 320 insertions(+), 89 deletions(-)
>  create mode 100644 drivers/input/touchscreen/tsc2007.h
>  rename drivers/input/touchscreen/{tsc2007.c => tsc2007_core.c} (84%)
>  create mode 100644 drivers/input/touchscreen/tsc2007_iio.c
> 
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 81b8645..d932e2d 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -80,6 +80,8 @@ obj-$(CONFIG_TOUCHSCREEN_TSC_SERIO)	+= tsc40.o
>  obj-$(CONFIG_TOUCHSCREEN_TSC200X_CORE)	+= tsc200x-core.o
>  obj-$(CONFIG_TOUCHSCREEN_TSC2004)	+= tsc2004.o
>  obj-$(CONFIG_TOUCHSCREEN_TSC2005)	+= tsc2005.o
> +tsc2007-y				:= tsc2007_core.o
> +tsc2007-$(CONFIG_IIO)			+= tsc2007_iio.o
>  obj-$(CONFIG_TOUCHSCREEN_TSC2007)	+= tsc2007.o
>  obj-$(CONFIG_TOUCHSCREEN_UCB1400)	+= ucb1400_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_WACOM_W8001)	+= wacom_w8001.o
> diff --git a/drivers/input/touchscreen/tsc2007.h b/drivers/input/touchscreen/tsc2007.h
> new file mode 100644
> index 0000000..87d5ce5
> --- /dev/null
> +++ b/drivers/input/touchscreen/tsc2007.h
> @@ -0,0 +1,129 @@
> +/*
> + * drivers/input/touchscreen/tsc2007.h

No file names in comments please.

> + *
> + * Copyright (c) 2008 MtekVision Co., Ltd.
> + *	Kwangwoo Lee <kwlee-ec7hoAtq5SbSUeElwK9/Pw@public.gmane.org>
> + *
> + * Using code from:
> + *  - ads7846.c
> + *	Copyright (c) 2005 David Brownell
> + *	Copyright (c) 2006 Nokia Corporation
> + *  - corgi_ts.c
> + *	Copyright (C) 2004-2005 Richard Purdie
> + *  - omap_ts.[hc], ads7846.h, ts_osk.c
> + *	Copyright (C) 2002 MontaVista Software
> + *	Copyright (C) 2004 Texas Instruments
> + *	Copyright (C) 2005 Dirk Behme
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c/tsc2007.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/input/touchscreen.h>
> +
> +#define TSC2007_MEASURE_TEMP0		(0x0 << 4)
> +#define TSC2007_MEASURE_AUX		(0x2 << 4)
> +#define TSC2007_MEASURE_TEMP1		(0x4 << 4)
> +#define TSC2007_ACTIVATE_XN		(0x8 << 4)
> +#define TSC2007_ACTIVATE_YN		(0x9 << 4)
> +#define TSC2007_ACTIVATE_YP_XN		(0xa << 4)
> +#define TSC2007_SETUP			(0xb << 4)
> +#define TSC2007_MEASURE_X		(0xc << 4)
> +#define TSC2007_MEASURE_Y		(0xd << 4)
> +#define TSC2007_MEASURE_Z1		(0xe << 4)
> +#define TSC2007_MEASURE_Z2		(0xf << 4)
> +
> +#define TSC2007_POWER_OFF_IRQ_EN	(0x0 << 2)
> +#define TSC2007_ADC_ON_IRQ_DIS0		(0x1 << 2)
> +#define TSC2007_ADC_OFF_IRQ_EN		(0x2 << 2)
> +#define TSC2007_ADC_ON_IRQ_DIS1		(0x3 << 2)
> +
> +#define TSC2007_12BIT			(0x0 << 1)
> +#define TSC2007_8BIT			(0x1 << 1)
> +
> +#define	MAX_12BIT			((1 << 12) - 1)
> +
> +#define ADC_ON_12BIT	(TSC2007_12BIT | TSC2007_ADC_ON_IRQ_DIS0)
> +
> +#define READ_Y		(ADC_ON_12BIT | TSC2007_MEASURE_Y)
> +#define READ_Z1		(ADC_ON_12BIT | TSC2007_MEASURE_Z1)
> +#define READ_Z2		(ADC_ON_12BIT | TSC2007_MEASURE_Z2)
> +#define READ_X		(ADC_ON_12BIT | TSC2007_MEASURE_X)
> +#define PWRDOWN		(TSC2007_12BIT | TSC2007_POWER_OFF_IRQ_EN)
> +
> +struct ts_event {
> +	u16	x;
> +	u16	y;
> +	u16	z1, z2;
> +};
> +
> +struct tsc2007 {
> +	struct input_dev	*input;
> +	char			phys[32];
> +
> +	struct i2c_client	*client;
> +
> +	u16			model;
> +	u16			x_plate_ohms;
> +
> +	struct touchscreen_properties prop;
> +
> +	bool			report_resistance;
> +	u16			min_x;
> +	u16			min_y;
> +	u16			max_x;
> +	u16			max_y;
> +	u16			max_rt;
> +	unsigned long		poll_period; /* in jiffies */
> +	int			fuzzx;
> +	int			fuzzy;
> +	int			fuzzz;
> +
> +	unsigned int		gpio;
> +	int			irq;
> +
> +	wait_queue_head_t	wait;
> +	bool			stopped;
> +	bool			pendown;
> +
> +	int			(*get_pendown_state)(struct device *);
> +	void			(*clear_penirq)(void);
> +
> +	struct mutex		mlock;
> +#ifdef CONFIG_IIO
> +	void			*private;
> +#endif
> +};
> +
> +int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd);
> +u32 tsc2007_calculate_resistance(struct tsc2007 *tsc,
> +					struct ts_event *tc);
> +bool tsc2007_is_pen_down(struct tsc2007 *ts);
> +
> +#ifdef CONFIG_IIO
> +
> +/* defined in tsc2007_iio.c */
> +int tsc2007_iio_configure(struct tsc2007 *ts);
> +void tsc2007_iio_unconfigure(struct tsc2007 *ts);
> +
> +#else /* CONFIG_IIO */
> +
> +static inline int tsc2007_iio_configure(struct tsc2007 *ts)
> +{
> +	return 0;
> +}
> +static inline void tsc2007_iio_unconfigure(struct tsc2007 *ts)
> +{
> +}
> +
> +#endif /* CONFIG_IIO */
> diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007_core.c
> similarity index 84%
> rename from drivers/input/touchscreen/tsc2007.c
> rename to drivers/input/touchscreen/tsc2007_core.c
> index 5e3c4bf..56c9a52 100644
> --- a/drivers/input/touchscreen/tsc2007.c
> +++ b/drivers/input/touchscreen/tsc2007_core.c
> @@ -20,87 +20,9 @@
>   *  published by the Free Software Foundation.
>   */
>  
> -#include <linux/module.h>
> -#include <linux/slab.h>
> -#include <linux/input.h>
> -#include <linux/interrupt.h>
> -#include <linux/i2c.h>
> -#include <linux/i2c/tsc2007.h>
> -#include <linux/of_device.h>
> -#include <linux/of.h>
> -#include <linux/of_gpio.h>
> -#include <linux/input/touchscreen.h>
> -
> -#define TSC2007_MEASURE_TEMP0		(0x0 << 4)
> -#define TSC2007_MEASURE_AUX		(0x2 << 4)
> -#define TSC2007_MEASURE_TEMP1		(0x4 << 4)
> -#define TSC2007_ACTIVATE_XN		(0x8 << 4)
> -#define TSC2007_ACTIVATE_YN		(0x9 << 4)
> -#define TSC2007_ACTIVATE_YP_XN		(0xa << 4)
> -#define TSC2007_SETUP			(0xb << 4)
> -#define TSC2007_MEASURE_X		(0xc << 4)
> -#define TSC2007_MEASURE_Y		(0xd << 4)
> -#define TSC2007_MEASURE_Z1		(0xe << 4)
> -#define TSC2007_MEASURE_Z2		(0xf << 4)
> -
> -#define TSC2007_POWER_OFF_IRQ_EN	(0x0 << 2)
> -#define TSC2007_ADC_ON_IRQ_DIS0		(0x1 << 2)
> -#define TSC2007_ADC_OFF_IRQ_EN		(0x2 << 2)
> -#define TSC2007_ADC_ON_IRQ_DIS1		(0x3 << 2)
> -
> -#define TSC2007_12BIT			(0x0 << 1)
> -#define TSC2007_8BIT			(0x1 << 1)
> -
> -#define	MAX_12BIT			((1 << 12) - 1)
> -
> -#define ADC_ON_12BIT	(TSC2007_12BIT | TSC2007_ADC_ON_IRQ_DIS0)
> -
> -#define READ_Y		(ADC_ON_12BIT | TSC2007_MEASURE_Y)
> -#define READ_Z1		(ADC_ON_12BIT | TSC2007_MEASURE_Z1)
> -#define READ_Z2		(ADC_ON_12BIT | TSC2007_MEASURE_Z2)
> -#define READ_X		(ADC_ON_12BIT | TSC2007_MEASURE_X)
> -#define PWRDOWN		(TSC2007_12BIT | TSC2007_POWER_OFF_IRQ_EN)
> -
> -struct ts_event {
> -	u16	x;
> -	u16	y;
> -	u16	z1, z2;
> -};
> -
> -struct tsc2007 {
> -	struct input_dev	*input;
> -	char			phys[32];
> -
> -	struct i2c_client	*client;
> -
> -	u16			model;
> -	u16			x_plate_ohms;
> -
> -	struct touchscreen_properties prop;
> -
> -	bool			report_resistance;
> -	u16			min_x;
> -	u16			min_y;
> -	u16			max_x;
> -	u16			max_y;
> -	u16			max_rt;
> -	unsigned long		poll_period; /* in jiffies */
> -	int			fuzzx;
> -	int			fuzzy;
> -	int			fuzzz;
> +#include "tsc2007.h"
>  
> -	unsigned		gpio;
> -	int			irq;
> -
> -	wait_queue_head_t	wait;
> -	bool			stopped;
> -	bool			pendown;
> -
> -	int			(*get_pendown_state)(struct device *);
> -	void			(*clear_penirq)(void);
> -};
> -
> -static inline int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd)
> +int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd)
>  {
>  	s32 data;
>  	u16 val;
> @@ -121,6 +43,7 @@ static inline int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd)
>  
>  	return val;
>  }
> +EXPORT_SYMBOL(tsc2007_xfer);

Why do you export all these symbols? As far as I can tell it is still
the same module, but now comprising of maybe 2 object files liked
together. You do not need to export symbols in this case, liker will
resolve them when building the module.

>  
>  static void tsc2007_read_values(struct tsc2007 *tsc, struct ts_event *tc)
>  {
> @@ -138,7 +61,7 @@ static void tsc2007_read_values(struct tsc2007 *tsc, struct ts_event *tc)
>  	tsc2007_xfer(tsc, PWRDOWN);
>  }
>  
> -static u32 tsc2007_calculate_resistance(struct tsc2007 *tsc,
> +u32 tsc2007_calculate_resistance(struct tsc2007 *tsc,
>  					struct ts_event *tc)
>  {
>  	u32 rt = 0;
> @@ -158,8 +81,9 @@ static u32 tsc2007_calculate_resistance(struct tsc2007 *tsc,
>  
>  	return rt;
>  }
> +EXPORT_SYMBOL(tsc2007_calculate_resistance);
>  
> -static bool tsc2007_is_pen_down(struct tsc2007 *ts)
> +bool tsc2007_is_pen_down(struct tsc2007 *ts)
>  {
>  	/*
>  	 * NOTE: We can't rely on the pressure to determine the pen down
> @@ -180,6 +104,7 @@ static bool tsc2007_is_pen_down(struct tsc2007 *ts)
>  
>  	return ts->get_pendown_state(&ts->client->dev);
>  }
> +EXPORT_SYMBOL(tsc2007_is_pen_down);
>  
>  static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
>  {
> @@ -192,7 +117,10 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
>  	while (!ts->stopped && tsc2007_is_pen_down(ts)) {
>  
>  		/* pen is down, continue with the measurement */
> +
> +		mutex_lock(&ts->mlock);
>  		tsc2007_read_values(ts, &tc);
> +		mutex_unlock(&ts->mlock);
>  
>  		rt = tsc2007_calculate_resistance(ts, &tc);
>  
> @@ -450,7 +378,8 @@ static void tsc2007_call_exit_platform_hw(void *data)
>  static int tsc2007_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> -	const struct tsc2007_platform_data *pdata = dev_get_platdata(&client->dev);
> +	const struct tsc2007_platform_data *pdata =
> +		dev_get_platdata(&client->dev);
>  	struct tsc2007 *ts;
>  	struct input_dev *input_dev;
>  	int err;
> @@ -472,7 +401,13 @@ static int tsc2007_probe(struct i2c_client *client,
>  	ts->client = client;
>  	ts->irq = client->irq;
>  	ts->input = input_dev;
> +
> +	err = tsc2007_iio_configure(ts);

No, this is not going to work. From teh cursory glance at the new iio
code it uses resources that you set up later in tsc2007_probe(). I'd say
this needs to go last.

> +	if (err < 0)
> +		return err;
> +
>  	init_waitqueue_head(&ts->wait);
> +	mutex_init(&ts->mlock);
>  
>  	snprintf(ts->phys, sizeof(ts->phys),
>  		 "%s/input0", dev_name(&client->dev));
> @@ -494,7 +429,7 @@ static int tsc2007_probe(struct i2c_client *client,
>  	if (pdata) {
>  		err = tsc2007_probe_pdev(client, ts, pdata, id);
>  		if (err)
> -			return err;
> +			goto probe_err;
>  		input_set_abs_params(input_dev, ABS_X, 0, ts->max_x-ts->min_x,
>  							  ts->fuzzx, 0);
>  		input_set_abs_params(input_dev, ABS_Y, 0, ts->max_y-ts->min_y,
> @@ -504,7 +439,7 @@ static int tsc2007_probe(struct i2c_client *client,
>  	} else {
>  		err = tsc2007_probe_dt(client, ts);
>  		if (err)
> -			return err;
> +			goto probe_err;
>  	}
>  
>  	if (pdata) {
> @@ -516,7 +451,7 @@ static int tsc2007_probe(struct i2c_client *client,
>  				dev_err(&client->dev,
>  					"Failed to register exit_platform_hw action, %d\n",
>  					err);
> -				return err;
> +				goto probe_err;
>  			}
>  		}
>  
> @@ -533,7 +468,7 @@ static int tsc2007_probe(struct i2c_client *client,
>  	if (err) {
>  		dev_err(&client->dev, "Failed to request irq %d: %d\n",
>  			ts->irq, err);
> -		return err;
> +		goto probe_err;
>  	}
>  
>  	tsc2007_stop(ts);
> @@ -543,17 +478,30 @@ static int tsc2007_probe(struct i2c_client *client,
>  	if (err < 0) {
>  		dev_err(&client->dev,
>  			"Failed to setup chip: %d\n", err);
> -		return err;	/* usually, chip does not respond */
> +		goto probe_err;	/* chip does not respond */
>  	}
>  
>  	err = input_register_device(input_dev);
>  	if (err) {
>  		dev_err(&client->dev,
>  			"Failed to register input device: %d\n", err);
> -		return err;
> +		goto probe_err;
>  	}
>  
>  	return 0;
> +
> +probe_err:
> +	tsc2007_iio_unconfigure(ts);
> +	return err;
> +}
> +
> +static int tsc2007_remove(struct i2c_client *client)
> +{
> +	struct tsc2007 *ts = i2c_get_clientdata(client);
> +
> +	tsc2007_iio_unconfigure(ts);
> +	input_unregister_device(ts->input);

Why did you add input_unregister_device() for devm-managed device?

> +	return 0;
>  }
>  
>  static const struct i2c_device_id tsc2007_idtable[] = {
> @@ -578,6 +526,7 @@ static struct i2c_driver tsc2007_driver = {
>  	},
>  	.id_table	= tsc2007_idtable,
>  	.probe		= tsc2007_probe,
> +	.remove		= tsc2007_remove,
>  };
>  
>  module_i2c_driver(tsc2007_driver);
> diff --git a/drivers/input/touchscreen/tsc2007_iio.c b/drivers/input/touchscreen/tsc2007_iio.c
> new file mode 100644
> index 0000000..0375d8b
> --- /dev/null
> +++ b/drivers/input/touchscreen/tsc2007_iio.c
> @@ -0,0 +1,151 @@
> +/*
> + * drivers/input/touchscreen/tsc2007_iio.c
> + *
> + * Copyright (c) 2016 Golden Delicious Comp. GmbH&Co. KG
> + *	Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + */
> +
> +#include "tsc2007.h"
> +#include <linux/iio/iio.h>
> +
> +struct tsc2007_iio {
> +	struct tsc2007 *ts;
> +};
> +
> +#define TSC2007_CHAN_IIO(_chan, _name, _type, _chan_info) \
> +{ \
> +	.datasheet_name = _name, \
> +	.type = _type, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
> +			BIT(_chan_info), \
> +	.indexed = 1, \
> +	.channel = _chan, \
> +}
> +
> +static const struct iio_chan_spec tsc2007_iio_channel[] = {
> +	TSC2007_CHAN_IIO(0, "x", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
> +	TSC2007_CHAN_IIO(1, "y", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
> +	TSC2007_CHAN_IIO(2, "z1", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
> +	TSC2007_CHAN_IIO(3, "z2", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
> +	TSC2007_CHAN_IIO(4, "adc", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
> +	TSC2007_CHAN_IIO(5, "rt", IIO_VOLTAGE, IIO_CHAN_INFO_RAW), /* Ohms? */
> +	TSC2007_CHAN_IIO(6, "pen", IIO_PRESSURE, IIO_CHAN_INFO_RAW),
> +	TSC2007_CHAN_IIO(7, "temp0", IIO_TEMP, IIO_CHAN_INFO_RAW),
> +	TSC2007_CHAN_IIO(8, "temp1", IIO_TEMP, IIO_CHAN_INFO_RAW),
> +};
> +
> +static int tsc2007_read_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
> +{
> +	struct tsc2007_iio *iio = iio_priv(indio_dev);
> +	struct tsc2007 *tsc = iio->ts;
> +	int adc_chan = chan->channel;
> +	int ret = 0;
> +
> +	if (adc_chan >= ARRAY_SIZE(tsc2007_iio_channel))
> +		return -EINVAL;
> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	mutex_lock(&tsc->mlock);
> +
> +	switch (chan->channel) {
> +	case 0:
> +		*val = tsc2007_xfer(tsc, READ_X);
> +		break;
> +	case 1:
> +		*val = tsc2007_xfer(tsc, READ_Y);
> +		break;
> +	case 2:
> +		*val = tsc2007_xfer(tsc, READ_Z1);
> +		break;
> +	case 3:
> +		*val = tsc2007_xfer(tsc, READ_Z2);
> +		break;
> +	case 4:
> +		*val = tsc2007_xfer(tsc, (ADC_ON_12BIT | TSC2007_MEASURE_AUX));
> +		break;
> +	case 5: {
> +		struct ts_event tc;
> +
> +		tc.x = tsc2007_xfer(tsc, READ_X);
> +		tc.z1 = tsc2007_xfer(tsc, READ_Z1);
> +		tc.z2 = tsc2007_xfer(tsc, READ_Z2);
> +		*val = tsc2007_calculate_resistance(tsc, &tc);
> +		break;
> +	}
> +	case 6:
> +		*val = tsc2007_is_pen_down(tsc);
> +		break;
> +	case 7:
> +		*val = tsc2007_xfer(tsc,
> +				    (ADC_ON_12BIT | TSC2007_MEASURE_TEMP0));
> +		break;
> +	case 8:
> +		*val = tsc2007_xfer(tsc,
> +				    (ADC_ON_12BIT | TSC2007_MEASURE_TEMP1));
> +		break;
> +	}
> +
> +	/* Prepare for next touch reading - power down ADC, enable PENIRQ */
> +	tsc2007_xfer(tsc, PWRDOWN);
> +
> +	mutex_unlock(&tsc->mlock);
> +
> +	ret = IIO_VAL_INT;
> +
> +	return ret;
> +}
> +
> +static const struct iio_info tsc2007_iio_info = {
> +	.read_raw = tsc2007_read_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +int tsc2007_iio_configure(struct tsc2007 *ts)
> +{
> +	int err;
> +	struct iio_dev *indio_dev;
> +	struct tsc2007_iio *iio;
> +
> +	indio_dev = devm_iio_device_alloc(&ts->client->dev,
> +		sizeof(struct tsc2007_iio));
> +	if (!indio_dev) {
> +		dev_err(&ts->client->dev, "iio_device_alloc failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	iio = iio_priv(indio_dev);
> +	iio->ts = ts;
> +	ts->private = (void *) indio_dev;
> +
> +	indio_dev->name = "tsc2007";
> +	indio_dev->dev.parent = &ts->client->dev;
> +	indio_dev->info = &tsc2007_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = tsc2007_iio_channel;
> +	indio_dev->num_channels = ARRAY_SIZE(tsc2007_iio_channel);
> +
> +	err = iio_device_register(indio_dev);
> +	if (err < 0) {
> +		dev_err(&ts->client->dev, "iio_device_register() failed: %d\n",
> +			err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(tsc2007_iio_configure);
> +
> +void tsc2007_iio_unconfigure(struct tsc2007 *ts)
> +{
> +	struct iio_dev *indio_dev = ts->private;
> +
> +	iio_device_unregister(indio_dev);
> +}
> +EXPORT_SYMBOL(tsc2007_iio_unconfigure);
> -- 
> 2.7.3
> 

Thanks.

-- 
Dmitry

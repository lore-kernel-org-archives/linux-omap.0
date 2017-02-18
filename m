From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v9 8/8] drivers:input:tsc2007: add iio interface to read external ADC input and temperature
Date: Sat, 18 Feb 2017 12:35:51 +0100
Message-ID: <6881064B-3DBD-44A3-9DCC-EB54FFD54A79@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <17a94568ffb91abedc9d12896b602022abb5f7e8.1482936802.git.hns@goldelico.com> <230fb5c0-2603-0bd1-a8da-ce5f7c450196@kernel.org> <20170217212724.GH13050@dtor-ws>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170217212724.GH13050@dtor-ws>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Petr Cvek <petr.cve>
List-Id: linux-omap@vger.kernel.org


> Am 17.02.2017 um 22:27 schrieb Dmitry Torokhov =
<dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>=20
> On Fri, Dec 30, 2016 at 08:36:30PM +0000, Jonathan Cameron wrote:
>> On 28/12/16 14:53, H. Nikolaus Schaller wrote:
>>> The tsc2007 chip not only has a resistive touch screen controller =
but
>>> also an external AUX adc imput which can be used for an ambient
>>> light sensor, battery voltage monitoring or any general purpose.
>>>=20
>>> Additionally it can measure the chip temperature.
>>>=20
>>> This extension provides an iio interface for these adc channels.
>>>=20
>>> Since it is not wasting much resources and is very straightforward,
>>> we simply provide all other adc channels as optional iio interfaces
>>> as weel. This can be used for debugging or special applications.
>>>=20
>>> This patch also splits the tsc2007 driver in several source files:
>>> tsc2007.h -- constants, structs and stubs
>>> tsc2007_core.c -- functional parts of the original driver
>>> tsc2007_iio.c -- the optional iio stuff
>>>=20
>>> Makefile magic allows to conditionally link the iio stuff
>>> if CONFIG_IIO=3Dy or =3Dm in a way that it works with
>>> CONFIG_TOUCHSCREEN_TSC2007=3Dm.
>>>=20
>>> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
>>> Reviewed-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Just for the record, I'm happy with the few changes from earlier =
versions.
>=20
> I untangled this from the rest of the patches (as it turned out to be
> the least controversial ;) ) and applied with some minor changes (see
> below). Please take a look at my tsc2007 branch on kernel.org to see =
if
> I missed anything.

Looks good!

BR and thanks,
Nikolaus

>=20
> Thanks.
>=20
>>=20
>> Jonathan
>>> ---
>>> drivers/input/touchscreen/Kconfig                  |  10 ++
>>> drivers/input/touchscreen/Makefile                 |   2 +
>>> drivers/input/touchscreen/tsc2007.h                | 116 =
++++++++++++++++
>>> .../touchscreen/{tsc2007.c =3D> tsc2007_core.c}      |  95 =
+++----------
>>> drivers/input/touchscreen/tsc2007_iio.c            | 150 =
+++++++++++++++++++++
>>> 5 files changed, 299 insertions(+), 74 deletions(-)
>>> create mode 100644 drivers/input/touchscreen/tsc2007.h
>>> rename drivers/input/touchscreen/{tsc2007.c =3D> tsc2007_core.c} =
(86%)
>>> create mode 100644 drivers/input/touchscreen/tsc2007_iio.c
>>>=20
>>> diff --git a/drivers/input/touchscreen/Kconfig =
b/drivers/input/touchscreen/Kconfig
>>> index efca013..1616a8d 100644
>>> --- a/drivers/input/touchscreen/Kconfig
>>> +++ b/drivers/input/touchscreen/Kconfig
>>> @@ -1035,6 +1035,16 @@ config TOUCHSCREEN_TSC2007
>>> 	  To compile this driver as a module, choose M here: the
>>> 	  module will be called tsc2007.
>>>=20
>>> +config TOUCHSCREEN_TSC2007_IIO
>>> +	bool "IIO interface for external ADC input and temperature"
>>> +	depends on TOUCHSCREEN_TSC2007
>>> +	depends on IIO=3Dy || IIO=3DTOUCHSCREEN_TSC2007
>>> +	help
>>> +	  Saying Y here adds an iio interface to the tsc2007 which
>>> +	  provides values for the AUX input (used for e.g. battery
>>> +	  or ambient light monitoring), temperature and raw input
>>> +	  values.
>>> +
>>> config TOUCHSCREEN_W90X900
>>> 	tristate "W90P910 touchscreen driver"
>>> 	depends on ARCH_W90X900
>>> diff --git a/drivers/input/touchscreen/Makefile =
b/drivers/input/touchscreen/Makefile
>>> index 81b8645..05d1cc8 100644
>>> --- a/drivers/input/touchscreen/Makefile
>>> +++ b/drivers/input/touchscreen/Makefile
>>> @@ -80,6 +80,8 @@ obj-$(CONFIG_TOUCHSCREEN_TSC_SERIO)	+=3D =
tsc40.o
>>> obj-$(CONFIG_TOUCHSCREEN_TSC200X_CORE)	+=3D tsc200x-core.o
>>> obj-$(CONFIG_TOUCHSCREEN_TSC2004)	+=3D tsc2004.o
>>> obj-$(CONFIG_TOUCHSCREEN_TSC2005)	+=3D tsc2005.o
>>> +tsc2007-y :=3D tsc2007_core.o
>>> +tsc2007-$(CONFIG_TOUCHSCREEN_TSC2007_IIO)	+=3D tsc2007_iio.o
>>> obj-$(CONFIG_TOUCHSCREEN_TSC2007)	+=3D tsc2007.o
>>> obj-$(CONFIG_TOUCHSCREEN_UCB1400)	+=3D ucb1400_ts.o
>>> obj-$(CONFIG_TOUCHSCREEN_WACOM_W8001)	+=3D wacom_w8001.o
>>> diff --git a/drivers/input/touchscreen/tsc2007.h =
b/drivers/input/touchscreen/tsc2007.h
>>> new file mode 100644
>>> index 0000000..16efb60
>>> --- /dev/null
>>> +++ b/drivers/input/touchscreen/tsc2007.h
>>> @@ -0,0 +1,116 @@
>>> +/*
>>> + * Copyright (c) 2008 MtekVision Co., Ltd.
>>> + *	Kwangwoo Lee <kwlee-ec7hoAtq5SbSUeElwK9/Pw@public.gmane.org>
>>> + *
>>> + * Using code from:
>>> + *  - ads7846.c
>>> + *	Copyright (c) 2005 David Brownell
>>> + *	Copyright (c) 2006 Nokia Corporation
>>> + *  - corgi_ts.c
>>> + *	Copyright (C) 2004-2005 Richard Purdie
>>> + *  - omap_ts.[hc], ads7846.h, ts_osk.c
>>> + *	Copyright (C) 2002 MontaVista Software
>>> + *	Copyright (C) 2004 Texas Instruments
>>> + *	Copyright (C) 2005 Dirk Behme
>>> + *
>>> + *  This program is free software; you can redistribute it and/or =
modify
>>> + *  it under the terms of the GNU General Public License version 2 =
as
>>> + *  published by the Free Software Foundation.
>>> + */
>>> +
>>> +#include <linux/input/touchscreen.h>
>>> +
>>> +#define TSC2007_MEASURE_TEMP0		(0x0 << 4)
>>> +#define TSC2007_MEASURE_AUX		(0x2 << 4)
>>> +#define TSC2007_MEASURE_TEMP1		(0x4 << 4)
>>> +#define TSC2007_ACTIVATE_XN		(0x8 << 4)
>>> +#define TSC2007_ACTIVATE_YN		(0x9 << 4)
>>> +#define TSC2007_ACTIVATE_YP_XN		(0xa << 4)
>>> +#define TSC2007_SETUP			(0xb << 4)
>>> +#define TSC2007_MEASURE_X		(0xc << 4)
>>> +#define TSC2007_MEASURE_Y		(0xd << 4)
>>> +#define TSC2007_MEASURE_Z1		(0xe << 4)
>>> +#define TSC2007_MEASURE_Z2		(0xf << 4)
>>> +
>>> +#define TSC2007_POWER_OFF_IRQ_EN	(0x0 << 2)
>>> +#define TSC2007_ADC_ON_IRQ_DIS0		(0x1 << 2)
>>> +#define TSC2007_ADC_OFF_IRQ_EN		(0x2 << 2)
>>> +#define TSC2007_ADC_ON_IRQ_DIS1		(0x3 << 2)
>>> +
>>> +#define TSC2007_12BIT			(0x0 << 1)
>>> +#define TSC2007_8BIT			(0x1 << 1)
>>> +
>>> +#define	MAX_12BIT			((1 << 12) - 1)
>>> +
>>> +#define ADC_ON_12BIT	(TSC2007_12BIT | =
TSC2007_ADC_ON_IRQ_DIS0)
>>> +
>>> +#define READ_Y		(ADC_ON_12BIT | TSC2007_MEASURE_Y)
>>> +#define READ_Z1		(ADC_ON_12BIT | TSC2007_MEASURE_Z1)
>>> +#define READ_Z2		(ADC_ON_12BIT | TSC2007_MEASURE_Z2)
>>> +#define READ_X		(ADC_ON_12BIT | TSC2007_MEASURE_X)
>>> +#define PWRDOWN		(TSC2007_12BIT | =
TSC2007_POWER_OFF_IRQ_EN)
>>> +
>>> +struct ts_event {
>>> +	u16	x;
>>> +	u16	y;
>>> +	u16	z1, z2;
>>> +};
>>> +
>>> +struct tsc2007 {
>>> +	struct input_dev	*input;
>>> +	char			phys[32];
>>> +
>>> +	struct i2c_client	*client;
>>> +
>>> +	u16			model;
>>> +	u16			x_plate_ohms;
>>> +
>>> +	struct touchscreen_properties prop;
>>> +
>>> +	bool			report_resistance;
>>> +	u16			min_x;
>>> +	u16			min_y;
>>> +	u16			max_x;
>>> +	u16			max_y;
>>> +	u16			max_rt;
>>> +	unsigned long		poll_period; /* in jiffies */
>>> +	int			fuzzx;
>>> +	int			fuzzy;
>>> +	int			fuzzz;
>>> +
>>> +	unsigned int		gpio;
>>> +	int			irq;
>>> +
>>> +	wait_queue_head_t	wait;
>>> +	bool			stopped;
>>> +	bool			pendown;
>>> +
>>> +	int			(*get_pendown_state)(struct device *);
>>> +	void			(*clear_penirq)(void);
>>> +
>>> +	struct mutex		mlock;
>>> +	struct iio_dev		*iio_dev;	/* optional */
>>> +};
>>> +
>>> +int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd);
>>> +u32 tsc2007_calculate_resistance(struct tsc2007 *tsc,
>>> +					struct ts_event *tc);
>>> +bool tsc2007_is_pen_down(struct tsc2007 *ts);
>>> +
>>> +#if IS_ENABLED(CONFIG_TOUCHSCREEN_TSC2007_IIO)
>>> +
>>> +/* defined in tsc2007_iio.c */
>>> +int tsc2007_iio_configure(struct tsc2007 *ts);
>>> +void tsc2007_iio_unconfigure(struct tsc2007 *ts);
>>> +
>>> +#else /* CONFIG_TOUCHSCREEN_TSC2007_IIO */
>>> +
>>> +static inline int tsc2007_iio_configure(struct tsc2007 *ts)
>>> +{
>>> +	return 0;
>>> +}
>>> +static inline void tsc2007_iio_unconfigure(struct tsc2007 *ts)
>>> +{
>>> +}
>>> +
>>> +#endif /* CONFIG_TOUCHSCREEN_TSC2007_IIO */
>>> diff --git a/drivers/input/touchscreen/tsc2007.c =
b/drivers/input/touchscreen/tsc2007_core.c
>>> similarity index 86%
>>> rename from drivers/input/touchscreen/tsc2007.c
>>> rename to drivers/input/touchscreen/tsc2007_core.c
>>> index 76b462b..812ded8 100644
>>> --- a/drivers/input/touchscreen/tsc2007.c
>>> +++ b/drivers/input/touchscreen/tsc2007_core.c
>>> @@ -27,79 +27,11 @@
>>> #include <linux/i2c.h>
>>> #include <linux/i2c/tsc2007.h>
>>> #include <linux/of_device.h>
>>> -#include <linux/of.h>
>>> #include <linux/of_gpio.h>
>>> -#include <linux/input/touchscreen.h>
>>> -
>>> -#define TSC2007_MEASURE_TEMP0		(0x0 << 4)
>>> -#define TSC2007_MEASURE_AUX		(0x2 << 4)
>>> -#define TSC2007_MEASURE_TEMP1		(0x4 << 4)
>>> -#define TSC2007_ACTIVATE_XN		(0x8 << 4)
>>> -#define TSC2007_ACTIVATE_YN		(0x9 << 4)
>>> -#define TSC2007_ACTIVATE_YP_XN		(0xa << 4)
>>> -#define TSC2007_SETUP			(0xb << 4)
>>> -#define TSC2007_MEASURE_X		(0xc << 4)
>>> -#define TSC2007_MEASURE_Y		(0xd << 4)
>>> -#define TSC2007_MEASURE_Z1		(0xe << 4)
>>> -#define TSC2007_MEASURE_Z2		(0xf << 4)
>>> -
>>> -#define TSC2007_POWER_OFF_IRQ_EN	(0x0 << 2)
>>> -#define TSC2007_ADC_ON_IRQ_DIS0		(0x1 << 2)
>>> -#define TSC2007_ADC_OFF_IRQ_EN		(0x2 << 2)
>>> -#define TSC2007_ADC_ON_IRQ_DIS1		(0x3 << 2)
>>> -
>>> -#define TSC2007_12BIT			(0x0 << 1)
>>> -#define TSC2007_8BIT			(0x1 << 1)
>>> -
>>> -#define	MAX_12BIT			((1 << 12) - 1)
>>> -
>>> -#define ADC_ON_12BIT	(TSC2007_12BIT | =
TSC2007_ADC_ON_IRQ_DIS0)
>>> -
>>> -#define READ_Y		(ADC_ON_12BIT | TSC2007_MEASURE_Y)
>>> -#define READ_Z1		(ADC_ON_12BIT | TSC2007_MEASURE_Z1)
>>> -#define READ_Z2		(ADC_ON_12BIT | TSC2007_MEASURE_Z2)
>>> -#define READ_X		(ADC_ON_12BIT | TSC2007_MEASURE_X)
>>> -#define PWRDOWN		(TSC2007_12BIT | =
TSC2007_POWER_OFF_IRQ_EN)
>>> -
>>> -struct ts_event {
>>> -	u16	x;
>>> -	u16	y;
>>> -	u16	z1, z2;
>>> -};
>>> -
>>> -struct tsc2007 {
>>> -	struct input_dev	*input;
>>> -	char			phys[32];
>>> -
>>> -	struct i2c_client	*client;
>>> -
>>> -	u16			model;
>>> -	u16			x_plate_ohms;
>>> -
>>> -	struct touchscreen_properties prop;
>>> -
>>> -	bool			report_resistance;
>>> -	u16			min_x;
>>> -	u16			min_y;
>>> -	u16			max_x;
>>> -	u16			max_y;
>>> -	u16			max_rt;
>>> -	unsigned long		poll_period; /* in jiffies */
>>> -	int			fuzzx;
>>> -	int			fuzzy;
>>> -	int			fuzzz;
>>> -
>>> -	unsigned		gpio;
>>> -	int			irq;
>>> -
>>> -	wait_queue_head_t	wait;
>>> -	bool			stopped;
>>> +#include "tsc2007.h"
>>>=20
>>> -	int			(*get_pendown_state)(struct device *);
>>> -	void			(*clear_penirq)(void);
>>> -};
>>>=20
>>> -static inline int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd)
>>> +int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd)
>>> {
>>> 	s32 data;
>>> 	u16 val;
>>> @@ -137,7 +69,7 @@ static void tsc2007_read_values(struct tsc2007 =
*tsc, struct ts_event *tc)
>>> 	tsc2007_xfer(tsc, PWRDOWN);
>>> }
>>>=20
>>> -static u32 tsc2007_calculate_resistance(struct tsc2007 *tsc,
>=20
> Kept as tsc2007_calculate_resistance for now.
>=20
>>> +u32 tsc2007_calculate_resistance(struct tsc2007 *tsc,
>>> 					struct ts_event *tc)
>>> {
>>> 	u32 rt =3D 0;
>>> @@ -158,7 +90,7 @@ static u32 tsc2007_calculate_resistance(struct =
tsc2007 *tsc,
>>> 	return rt;
>>> }
>>>=20
>>> -static bool tsc2007_is_pen_down(struct tsc2007 *ts)
>>> +bool tsc2007_is_pen_down(struct tsc2007 *ts)
>>> {
>>> 	/*
>>> 	 * NOTE: We can't rely on the pressure to determine the pen down
>>> @@ -191,7 +123,10 @@ static irqreturn_t tsc2007_soft_irq(int irq, =
void *handle)
>>> 	while (!ts->stopped && tsc2007_is_pen_down(ts)) {
>>>=20
>>> 		/* pen is down, continue with the measurement */
>>> +
>>> +		mutex_lock(&ts->mlock);
>>> 		tsc2007_read_values(ts, &tc);
>>> +		mutex_unlock(&ts->mlock);
>>>=20
>>> 		rt =3D tsc2007_calculate_resistance(ts, &tc);
>>>=20
>>> @@ -441,7 +376,8 @@ static void tsc2007_call_exit_platform_hw(void =
*data)
>>> static int tsc2007_probe(struct i2c_client *client,
>>> 			 const struct i2c_device_id *id)
>>> {
>>> -	const struct tsc2007_platform_data *pdata =3D =
dev_get_platdata(&client->dev);
>>> +	const struct tsc2007_platform_data *pdata =3D
>>> +		dev_get_platdata(&client->dev);
>>> 	struct tsc2007 *ts;
>>> 	struct input_dev *input_dev;
>>> 	int err;
>>> @@ -463,7 +399,9 @@ static int tsc2007_probe(struct i2c_client =
*client,
>>> 	ts->client =3D client;
>>> 	ts->irq =3D client->irq;
>>> 	ts->input =3D input_dev;
>>> +
>>> 	init_waitqueue_head(&ts->wait);
>>> +	mutex_init(&ts->mlock);
>>>=20
>>> 	snprintf(ts->phys, sizeof(ts->phys),
>>> 		 "%s/input0", dev_name(&client->dev));
>>> @@ -534,7 +472,7 @@ static int tsc2007_probe(struct i2c_client =
*client,
>>> 	if (err < 0) {
>>> 		dev_err(&client->dev,
>>> 			"Failed to setup chip: %d\n", err);
>>> -		return err;	/* usually, chip does not respond */
>>> +		return err;	/* chip does not respond */
>>> 	}
>>>=20
>>> 	err =3D input_register_device(input_dev);
>>> @@ -544,6 +482,14 @@ static int tsc2007_probe(struct i2c_client =
*client,
>>> 		return err;
>>> 	}
>>>=20
>>> +	return tsc2007_iio_configure(ts);
>>> +}
>>> +
>>> +static int tsc2007_remove(struct i2c_client *client)
>>> +{
>>> +	struct tsc2007 *ts =3D i2c_get_clientdata(client);
>>> +
>>> +	tsc2007_iio_unconfigure(ts);
>>> 	return 0;
>>> }
>>>=20
>>> @@ -569,6 +515,7 @@ static struct i2c_driver tsc2007_driver =3D {
>>> 	},
>>> 	.id_table	=3D tsc2007_idtable,
>>> 	.probe		=3D tsc2007_probe,
>>> +	.remove		=3D tsc2007_remove,
>>> };
>>>=20
>>> module_i2c_driver(tsc2007_driver);
>>> diff --git a/drivers/input/touchscreen/tsc2007_iio.c =
b/drivers/input/touchscreen/tsc2007_iio.c
>>> new file mode 100644
>>> index 0000000..ed79944
>>> --- /dev/null
>>> +++ b/drivers/input/touchscreen/tsc2007_iio.c
>>> @@ -0,0 +1,150 @@
>>> +/*
>>> + * Copyright (c) 2016 Golden Delicious Comp. GmbH&Co. KG
>>> + *	Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
>>> + *
>>> + *  This program is free software; you can redistribute it and/or =
modify
>>> + *  it under the terms of the GNU General Public License version 2 =
as
>>> + *  published by the Free Software Foundation.
>>> + */
>>> +
>>> +#include <linux/i2c.h>
>>> +#include <linux/iio/iio.h>
>>> +#include "tsc2007.h"
>>> +
>>> +struct tsc2007_iio {
>>> +	struct tsc2007 *ts;
>>> +};
>>> +
>>> +#define TSC2007_CHAN_IIO(_chan, _name, _type, _chan_info) \
>>> +{ \
>>> +	.datasheet_name =3D _name, \
>>> +	.type =3D _type, \
>>> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |	\
>>> +			BIT(_chan_info), \
>>> +	.indexed =3D 1, \
>>> +	.channel =3D _chan, \
>>> +}
>>> +
>>> +static const struct iio_chan_spec tsc2007_iio_channel[] =3D {
>>> +	TSC2007_CHAN_IIO(0, "x", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>>> +	TSC2007_CHAN_IIO(1, "y", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>>> +	TSC2007_CHAN_IIO(2, "z1", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>>> +	TSC2007_CHAN_IIO(3, "z2", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>>> +	TSC2007_CHAN_IIO(4, "adc", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>>> +	TSC2007_CHAN_IIO(5, "rt", IIO_VOLTAGE, IIO_CHAN_INFO_RAW), /* =
Ohms? */
>>> +	TSC2007_CHAN_IIO(6, "pen", IIO_PRESSURE, IIO_CHAN_INFO_RAW),
>>> +	TSC2007_CHAN_IIO(7, "temp0", IIO_TEMP, IIO_CHAN_INFO_RAW),
>>> +	TSC2007_CHAN_IIO(8, "temp1", IIO_TEMP, IIO_CHAN_INFO_RAW),
>>> +};
>>> +
>>> +static int tsc2007_read_raw(struct iio_dev *indio_dev,
>>> +	struct iio_chan_spec const *chan, int *val, int *val2, long =
mask)
>>> +{
>>> +	struct tsc2007_iio *iio =3D iio_priv(indio_dev);
>>> +	struct tsc2007 *tsc =3D iio->ts;
>>> +	int adc_chan =3D chan->channel;
>>> +	int ret =3D 0;
>>> +
>>> +	if (adc_chan >=3D ARRAY_SIZE(tsc2007_iio_channel))
>>> +		return -EINVAL;
>>> +
>>> +	if (mask !=3D IIO_CHAN_INFO_RAW)
>>> +		return -EINVAL;
>>> +
>>> +	mutex_lock(&tsc->mlock);
>>> +
>>> +	switch (chan->channel) {
>>> +	case 0:
>>> +		*val =3D tsc2007_xfer(tsc, READ_X);
>>> +		break;
>>> +	case 1:
>>> +		*val =3D tsc2007_xfer(tsc, READ_Y);
>>> +		break;
>>> +	case 2:
>>> +		*val =3D tsc2007_xfer(tsc, READ_Z1);
>>> +		break;
>>> +	case 3:
>>> +		*val =3D tsc2007_xfer(tsc, READ_Z2);
>>> +		break;
>>> +	case 4:
>>> +		*val =3D tsc2007_xfer(tsc, (ADC_ON_12BIT | =
TSC2007_MEASURE_AUX));
>>> +		break;
>>> +	case 5: {
>>> +		struct ts_event tc;
>>> +
>>> +		tc.x =3D tsc2007_xfer(tsc, READ_X);
>>> +		tc.z1 =3D tsc2007_xfer(tsc, READ_Z1);
>>> +		tc.z2 =3D tsc2007_xfer(tsc, READ_Z2);
>>> +		*val =3D tsc2007_calculate_resistance(tsc, &tc);
>>> +		break;
>>> +	}
>>> +	case 6:
>>> +		*val =3D tsc2007_is_pen_down(tsc);
>>> +		break;
>>> +	case 7:
>>> +		*val =3D tsc2007_xfer(tsc,
>>> +				    (ADC_ON_12BIT | =
TSC2007_MEASURE_TEMP0));
>>> +		break;
>>> +	case 8:
>>> +		*val =3D tsc2007_xfer(tsc,
>>> +				    (ADC_ON_12BIT | =
TSC2007_MEASURE_TEMP1));
>>> +		break;
>>> +	}
>>> +
>>> +	/* Prepare for next touch reading - power down ADC, enable =
PENIRQ */
>>> +	tsc2007_xfer(tsc, PWRDOWN);
>>> +
>>> +	mutex_unlock(&tsc->mlock);
>>> +
>>> +	ret =3D IIO_VAL_INT;
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static const struct iio_info tsc2007_iio_info =3D {
>>> +	.read_raw =3D tsc2007_read_raw,
>>> +	.driver_module =3D THIS_MODULE,
>>> +};
>>> +
>>> +int tsc2007_iio_configure(struct tsc2007 *ts)
>>> +{
>>> +	int err;
>>> +	struct iio_dev *indio_dev;
>>> +	struct tsc2007_iio *iio;
>>> +
>>> +	indio_dev =3D devm_iio_device_alloc(&ts->client->dev,
>>> +		sizeof(struct tsc2007_iio));
>>> +	if (!indio_dev) {
>>> +		dev_err(&ts->client->dev, "iio_device_alloc failed\n");
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	iio =3D iio_priv(indio_dev);
>>> +	iio->ts =3D ts;
>>> +	ts->iio_dev =3D (void *) indio_dev;
>>> +
>>> +	indio_dev->name =3D "tsc2007";
>>> +	indio_dev->dev.parent =3D &ts->client->dev;
>>> +	indio_dev->info =3D &tsc2007_iio_info;
>>> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
>>> +	indio_dev->channels =3D tsc2007_iio_channel;
>>> +	indio_dev->num_channels =3D ARRAY_SIZE(tsc2007_iio_channel);
>>> +
>>> +	err =3D iio_device_register(indio_dev);
>=20
> Changed this to devm.
>=20
>>> +	if (err < 0) {
>>> +		dev_err(&ts->client->dev, "iio_device_register() failed: =
%d\n",
>>> +			err);
>>> +		return err;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL(tsc2007_iio_configure);
>=20
> This is not a separate module, there is no need to export this symbol.
>=20
>>> +
>>> +void tsc2007_iio_unconfigure(struct tsc2007 *ts)
>>> +{
>>> +	struct iio_dev *indio_dev =3D ts->iio_dev;
>>> +
>>> +	iio_device_unregister(indio_dev);
>>> +}
>>> +EXPORT_SYMBOL(tsc2007_iio_unconfigure);
>=20
> Dropped this as not needed with devm.
>=20
> --=20
> Dmitry

From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v3 3/8] drivers:input:tsc2007: add iio interface to read external ADC input, temperature and raw conversion values
Date: Sat, 24 Sep 2016 19:42:32 +0200
Message-ID: <D6C1D76E-3FAA-427E-8A78-EB4519EA464C@goldelico.com>
References: <cover.1474634475.git.hns@goldelico.com> <909d06d4f54359c7ac0dcf36a49cbd3ff7e8ebf2.1474634475.git.hns@goldelico.com> <af39fdf1-b6e4-1ab7-9b41-ddb25bfab829@kernel.org> <8A30B517-FE25-418B-9921-407243B0B72B@goldelico.com> <7225226f-e782-19f3-be72-d3c890cb07c0@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7225226f-e782-19f3-be72-d3c890cb07c0@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?windows-1252?Q?Mika_Penttil=E4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, Sebastian Reichel <sre@kernel.org>, "Andrew F. Davis" <afd@ti.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, linux-iio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Jonathan,

> Am 24.09.2016 um 19:26 schrieb Jonathan Cameron <jic23@kernel.org>:
>=20
> On 24/09/16 18:07, H. Nikolaus Schaller wrote:
>> Hi Jonathan,
>>=20
>>> Am 24.09.2016 um 18:07 schrieb Jonathan Cameron <jic23@kernel.org>:
>>>=20
>>> On 23/09/16 13:41, H. Nikolaus Schaller wrote:
>>>> The tsc2007 chip not only has a resistive touch screen controller =
but
>>>> also an external AUX adc imput which can be used for an ambient
>>>> light sensor, battery voltage monitoring or any general purpose.
>>>>=20
>>>> Additionally it can measure the chip temperature.
>>>>=20
>>>> This extension provides an iio interface for these adc channels
>>>> in addition to the raw x, y, z values and the estimated touch
>>>> screen resistance. This can be used for debugging or special
>>>> applications.
>>> I'm unconvinced that exposing the touch related channels is terribly
>>> useful.
>>=20
>> Mostly for debugging of if someone wants to do a (better) touch =
detection
>> in user space.
> Not going to do anything at the rates you will get out of that =
interface.

Touch detection and processing does not need a fast interface. In =
standard
operation (input device) the tsc2007 is polled in multiples of jiffies.

And I don't know what people will do with it - in addition to debugging
and hardware testing which is what we are doing (and need in the =
upstream
driver - see below).

> I suspect this is a non starter. Lets see what Dmitry thinks.

Yes. More opinions are welcome.

>=20
> Jonathan
>>=20
>>> Fair enough on the aux channel and temperature though.
>>>=20
>>> Otherwise a few minor bits and bobs.
>>>=20
>>> Jonathan
>>>>=20
>>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>>> ---
>>>> drivers/input/touchscreen/Kconfig   |   1 +
>>>> drivers/input/touchscreen/tsc2007.c | 137 =
+++++++++++++++++++++++++++++++++++-
>>>> 2 files changed, 136 insertions(+), 2 deletions(-)
>>>>=20
>>>> diff --git a/drivers/input/touchscreen/Kconfig =
b/drivers/input/touchscreen/Kconfig
>>>> index 2fb1f43..84c28e8 100644
>>>> --- a/drivers/input/touchscreen/Kconfig
>>>> +++ b/drivers/input/touchscreen/Kconfig
>>>> @@ -1019,6 +1019,7 @@ config TOUCHSCREEN_TSC2005
>>>> config TOUCHSCREEN_TSC2007
>>>> 	tristate "TSC2007 based touchscreens"
>>>> 	depends on I2C
>>>> +	select IIO
>>> This is pulling quite a bit of core IIO code in for a feature a lot
>>> of users of this chip won't care about...
>>=20
>> Ah, yes.
>>=20
>> We didn't notice because we use many other IIO devices on the same =
board (GTA04).
>>=20
>> So I will add some #ifdef CONFIG_IIO where necessary.
> Cool

I have already prepared for PATCH V4 and tested w/o CONFIG_IIO and with.

>>=20
>>=20
>>>> 	help
>>>> 	  Say Y here if you have a TSC2007 based touchscreen.
>>>>=20
>>>> diff --git a/drivers/input/touchscreen/tsc2007.c =
b/drivers/input/touchscreen/tsc2007.c
>>>> index e9d5086..559cbc6 100644
>>>> --- a/drivers/input/touchscreen/tsc2007.c
>>>> +++ b/drivers/input/touchscreen/tsc2007.c
>>>> @@ -30,6 +30,9 @@
>>>> #include <linux/of.h>
>>>> #include <linux/of_gpio.h>
>>>> #include <linux/input/touchscreen.h>
>>>> +#include <linux/iio/iio.h>
>>>> +#include <linux/iio/machine.h>
>>> Why machine.h? (or driver.h for that reason).
>>=20
>> Good question. Header files sometimes get in during
>> development and are forgotten to take out... Or had
>> been necessary when development started a while ago.
>> Indeed I don't know why they are there.
>>=20
>>>=20
>>>> +#include <linux/iio/driver.h>
>>=20
>> I have checked and we really neither need machine.h nor driver.h.
>>=20
>>>>=20
>>>> #define TSC2007_MEASURE_TEMP0		(0x0 << 4)
>>>> #define TSC2007_MEASURE_AUX		(0x2 << 4)
>>>> @@ -61,6 +64,16 @@
>>>> #define READ_X		(ADC_ON_12BIT | TSC2007_MEASURE_X)
>>>> #define PWRDOWN		(TSC2007_12BIT | =
TSC2007_POWER_OFF_IRQ_EN)
>>>>=20
>>>> +#define TSC2007_CHAN_IIO(_chan, _name, _type, _chan_info) \
>>>> +{ \
>>>> +	.datasheet_name =3D _name, \
>>>> +	.type =3D _type, \
>>>> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |	\
>>>> +			BIT(_chan_info), \
>>>> +	.indexed =3D 1, \
>>>> +	.channel =3D _chan, \
>>>> +}
>>>> +
>>>> struct ts_event {
>>>> 	u16	x;
>>>> 	u16	y;
>>>> @@ -69,9 +82,11 @@ struct ts_event {
>>>>=20
>>>> struct tsc2007 {
>>>> 	struct input_dev	*input;
>>>> +	struct iio_dev		*indio;
>>>> 	char			phys[32];
>>>>=20
>>>> 	struct i2c_client	*client;
>>>> +	struct mutex		mlock;
>>>>=20
>>>> 	u16			model;
>>>> 	u16			x_plate_ohms;
>>>> @@ -192,7 +207,10 @@ static irqreturn_t tsc2007_soft_irq(int irq, =
void *handle)
>>>> 	while (!ts->stopped && tsc2007_is_pen_down(ts)) {
>>>>=20
>>>> 		/* pen is down, continue with the measurement */
>>>> +
>>>> +		mutex_lock(&ts->mlock);
>>>> 		tsc2007_read_values(ts, &tc);
>>>> +		mutex_unlock(&ts->mlock);
>>>>=20
>>>> 		rt =3D tsc2007_calculate_resistance(ts, &tc);
>>>>=20
>>>> @@ -319,6 +337,86 @@ static void tsc2007_close(struct input_dev =
*input_dev)
>>>> 	tsc2007_stop(ts);
>>>> }
>>>>=20
>>>> +static const struct iio_chan_spec tsc2007_iio_channel[] =3D {
>>>> +	TSC2007_CHAN_IIO(0, "x", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>>>> +	TSC2007_CHAN_IIO(1, "y", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>>>> +	TSC2007_CHAN_IIO(2, "z1", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>>>> +	TSC2007_CHAN_IIO(3, "z2", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>>>> +	TSC2007_CHAN_IIO(4, "adc", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>>>> +	TSC2007_CHAN_IIO(5, "rt", IIO_VOLTAGE, IIO_CHAN_INFO_RAW), /* =
Ohms? */
>>> This one needs some explanation.  What is it measuring?
>>=20
>> Well, it is reporting the raw conductivity of the touch under certain
>> conditions. But basically it is also a voltage measured by the ADC.
>>=20
>> The real pressure value reported to user space is calculated
>> using this and the z1 and z2 values.
>>=20
>> If not pressed, conductivity is 0 and if lightly touched it jumps
>> to some base value. When more pressed, conductivity increases
>> while resistance goes down to some 300 Ohms or so.
>>=20
>> But I have not found an IIO_OHM or IIO_MHO constant. Which would also
>> not be the best description because it is not scaled to real ohms.
>>=20
>>>=20
>>>> +	TSC2007_CHAN_IIO(6, "pen", IIO_PRESSURE, IIO_CHAN_INFO_RAW),
>>> At the moment this is defined as barometric pressure.
>>=20
>> Ok, I see.
>>=20
>>> I suppose there
>>> is no reason it can't extend to touch pressure though, even if it's =
a boolean
>>> like this...
>>=20
>> So let's keep it this way?
> Except I'm saying we should drop it entirely.
>>=20
>>>=20
>>>> +	TSC2007_CHAN_IIO(7, "temp0", IIO_TEMP, IIO_CHAN_INFO_RAW),
>>>> +	TSC2007_CHAN_IIO(8, "temp1", IIO_TEMP, IIO_CHAN_INFO_RAW),
>>> I would be tempted to only expose those channels that have a meaning
>>> outside of touch screen usage (e.g. adc, temp0 and temp1). =20
>>=20

The following is my main argument why we should not drop it (it also is
neither complex nor harmful if not used):

>> Well, for debugging and checking for non-responding or defective =
touch
>> it is very handy to have them in /sys/bus/iio for direct inspection.
>> For example we run a device test tool reading such values.

>=20
>> You might argue that we should run our own fork for this purpose to =
provide
>> a patched driver. But we want people to use the kernel from =
kernel.org
>> and still be able to do such debugging without asking them to replace =
the
>> kernel first.

In other words: we do neither want to run our own kernel fork (which =
might not
be the standard case) but also not loose (practically required) features =
we
need...


>>=20
>>>> +};
>>>> +
>>>> +static int tsc2007_read_raw(struct iio_dev *indio_dev,
>>>> +	struct iio_chan_spec const *chan, int *val, int *val2, long =
mask)
>>>> +{
>>>> +	struct  tsc2007 *tsc =3D iio_priv(indio_dev);
>>>> +	int adc_chan =3D chan->channel;
>>>> +	int ret =3D 0;
>>>> +
>>>> +	if (adc_chan >=3D ARRAY_SIZE(tsc2007_iio_channel))
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (mask !=3D IIO_CHAN_INFO_RAW)
>>>> +		return -EINVAL;
>>>> +
>>>> +	mutex_lock(&tsc->mlock);
>>>> +
>>>> +	switch (chan->channel) {
>>>> +	case 0:
>>>> +		*val =3D tsc2007_xfer(tsc, READ_X);
>>>> +		break;
>>>> +	case 1:
>>>> +		*val =3D tsc2007_xfer(tsc, READ_Y);
>>>> +		break;
>>>> +	case 2:
>>>> +		*val =3D tsc2007_xfer(tsc, READ_Z1);
>>>> +		break;
>>>> +	case 3:
>>>> +		*val =3D tsc2007_xfer(tsc, READ_Z2);
>>>> +		break;
>>>> +	case 4:
>>>> +		*val =3D tsc2007_xfer(tsc, (ADC_ON_12BIT | =
TSC2007_MEASURE_AUX));
>>>> +		break;
>>>> +	case 5: {
>>>> +		struct ts_event tc;
>>>> +
>>>> +		tc.x =3D tsc2007_xfer(tsc, READ_X);
>>>> +		tc.z1 =3D tsc2007_xfer(tsc, READ_Z1);
>>>> +		tc.z2 =3D tsc2007_xfer(tsc, READ_Z2);
>>>> +		*val =3D tsc2007_calculate_resistance(tsc, &tc);
>>>> +		break;
>>>> +	}
>>>> +	case 6:
>>>> +		*val =3D tsc2007_is_pen_down(tsc);
>>>> +		break;
>>>> +	case 7:
>>>> +		*val =3D tsc2007_xfer(tsc,
>>>> +				    (ADC_ON_12BIT | =
TSC2007_MEASURE_TEMP0));
>>>> +		break;
>>>> +	case 8:
>>>> +		*val =3D tsc2007_xfer(tsc,
>>>> +				    (ADC_ON_12BIT | =
TSC2007_MEASURE_TEMP1));
>>>> +		break;
>>>> +	}
>>>> +
>>>> +	/* Prepare for next touch reading - power down ADC, enable =
PENIRQ */
>>>> +	tsc2007_xfer(tsc, PWRDOWN);
>>>> +
>>>> +	mutex_unlock(&tsc->mlock);
>>>> +
>>>> +	ret =3D IIO_VAL_INT;
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static const struct iio_info tsc2007_iio_info =3D {
>>>> +	.read_raw =3D tsc2007_read_raw,
>>>> +	.driver_module =3D THIS_MODULE,
>>>> +};
>>>> +
>>>> #ifdef CONFIG_OF
>>>> static int tsc2007_get_pendown_state_gpio(struct device *dev)
>>>> {
>>>> @@ -453,15 +551,20 @@ static int tsc2007_probe(struct i2c_client =
*client,
>>>> 	const struct tsc2007_platform_data *pdata =3D =
dev_get_platdata(&client->dev);
>>>> 	struct tsc2007 *ts;
>>>> 	struct input_dev *input_dev;
>>>> +	struct iio_dev *indio_dev;
>>>> 	int err;
>>>>=20
>>>> 	if (!i2c_check_functionality(client->adapter,
>>>> 				     I2C_FUNC_SMBUS_READ_WORD_DATA))
>>>> 		return -EIO;
>>>>=20
>>>> -	ts =3D devm_kzalloc(&client->dev, sizeof(struct tsc2007), =
GFP_KERNEL);
>>>> -	if (!ts)
>>>> +	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*ts));
>>>> +	if (!indio_dev) {
>>>> +		dev_err(&client->dev, "iio_device_alloc failed\n");
>>>> 		return -ENOMEM;
>>>> +	}
>>>> +
>>>> +	ts =3D iio_priv(indio_dev);
>>>>=20
>>>> 	input_dev =3D devm_input_allocate_device(&client->dev);
>>>> 	if (!input_dev)
>>>> @@ -469,10 +572,26 @@ static int tsc2007_probe(struct i2c_client =
*client,
>>>>=20
>>>> 	i2c_set_clientdata(client, ts);
>>>>=20
>>>> +	indio_dev->name =3D "tsc2007";
>>>> +	indio_dev->dev.parent =3D &client->dev;
>>>> +	indio_dev->info =3D &tsc2007_iio_info;
>>>> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
>>>> +	indio_dev->channels =3D tsc2007_iio_channel;
>>>> +	indio_dev->num_channels =3D ARRAY_SIZE(tsc2007_iio_channel);
>>>> +
>>>> +	err =3D iio_device_register(indio_dev);
>>>> +	if (err < 0) {
>>>> +		dev_err(&client->dev, "iio_device_register() failed: =
%d\n",
>>>> +			err);
>>>> +		return err;
>>>> +	}
>>>> +
>>>> 	ts->client =3D client;
>>>> 	ts->irq =3D client->irq;
>>>> 	ts->input =3D input_dev;
>>>> +	ts->indio =3D indio_dev;
>>>> 	init_waitqueue_head(&ts->wait);
>>>> +	mutex_init(&ts->mlock);
>>>>=20
>>>> 	snprintf(ts->phys, sizeof(ts->phys),
>>>> 		 "%s/input0", dev_name(&client->dev));
>>>> @@ -548,6 +667,19 @@ static int tsc2007_probe(struct i2c_client =
*client,
>>>> 	return 0;
>>>> }
>>>>=20
>>>> +static int tsc2007_remove(struct i2c_client *client)
>>>> +{
>>>> +	struct tsc2007 *ts =3D i2c_get_clientdata(client);
>>>> +	struct input_dev *input_dev =3D ts->input;
>>>> +	struct iio_dev *indio_dev =3D ts->indio;
>>>> +
>>>> +	input_unregister_device(input_dev);
>>>> +
>>>> +	iio_device_unregister(indio_dev);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> static const struct i2c_device_id tsc2007_idtable[] =3D {
>>>> 	{ "tsc2007", 0 },
>>>> 	{ }
>>>> @@ -570,6 +702,7 @@ static struct i2c_driver tsc2007_driver =3D {
>>>> 	},
>>>> 	.id_table	=3D tsc2007_idtable,
>>>> 	.probe		=3D tsc2007_probe,
>>>> +	.remove		=3D tsc2007_remove,
>>>> };
>>>>=20
>>>> module_i2c_driver(tsc2007_driver);
>>>>=20
>>>=20
>>=20
>> BR and thanks,
>> Nikolaus

BR and thanks,
Nikolaus

From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/8] drivers:input:tsc2007: add iio interface to read
 external ADC input, temperature and raw conversion values
Date: Sat, 24 Sep 2016 18:26:15 +0100
Message-ID: <7225226f-e782-19f3-be72-d3c890cb07c0@kernel.org>
References: <cover.1474634475.git.hns@goldelico.com>
 <909d06d4f54359c7ac0dcf36a49cbd3ff7e8ebf2.1474634475.git.hns@goldelico.com>
 <af39fdf1-b6e4-1ab7-9b41-ddb25bfab829@kernel.org>
 <8A30B517-FE25-418B-9921-407243B0B72B@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8A30B517-FE25-418B-9921-407243B0B72B-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 24/09/16 18:07, H. Nikolaus Schaller wrote:
> Hi Jonathan,
> 
>> Am 24.09.2016 um 18:07 schrieb Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
>>
>> On 23/09/16 13:41, H. Nikolaus Schaller wrote:
>>> The tsc2007 chip not only has a resistive touch screen controller but
>>> also an external AUX adc imput which can be used for an ambient
>>> light sensor, battery voltage monitoring or any general purpose.
>>>
>>> Additionally it can measure the chip temperature.
>>>
>>> This extension provides an iio interface for these adc channels
>>> in addition to the raw x, y, z values and the estimated touch
>>> screen resistance. This can be used for debugging or special
>>> applications.
>> I'm unconvinced that exposing the touch related channels is terribly
>> useful.
> 
> Mostly for debugging of if someone wants to do a (better) touch detection
> in user space.
Not going to do anything at the rates you will get out of that interface.
I suspect this is a non starter. Lets see what Dmitry thinks.

Jonathan
> 
>>  Fair enough on the aux channel and temperature though.
>>
>> Otherwise a few minor bits and bobs.
>>
>> Jonathan
>>>
>>> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
>>> ---
>>> drivers/input/touchscreen/Kconfig   |   1 +
>>> drivers/input/touchscreen/tsc2007.c | 137 +++++++++++++++++++++++++++++++++++-
>>> 2 files changed, 136 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
>>> index 2fb1f43..84c28e8 100644
>>> --- a/drivers/input/touchscreen/Kconfig
>>> +++ b/drivers/input/touchscreen/Kconfig
>>> @@ -1019,6 +1019,7 @@ config TOUCHSCREEN_TSC2005
>>> config TOUCHSCREEN_TSC2007
>>> 	tristate "TSC2007 based touchscreens"
>>> 	depends on I2C
>>> +	select IIO
>> This is pulling quite a bit of core IIO code in for a feature a lot
>> of users of this chip won't care about...
> 
> Ah, yes.
> 
> We didn't notice because we use many other IIO devices on the same board (GTA04).
> 
> So I will add some #ifdef CONFIG_IIO where necessary.
Cool
> 
> 
>>> 	help
>>> 	  Say Y here if you have a TSC2007 based touchscreen.
>>>
>>> diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
>>> index e9d5086..559cbc6 100644
>>> --- a/drivers/input/touchscreen/tsc2007.c
>>> +++ b/drivers/input/touchscreen/tsc2007.c
>>> @@ -30,6 +30,9 @@
>>> #include <linux/of.h>
>>> #include <linux/of_gpio.h>
>>> #include <linux/input/touchscreen.h>
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/machine.h>
>> Why machine.h? (or driver.h for that reason).
> 
> Good question. Header files sometimes get in during
> development and are forgotten to take out... Or had
> been necessary when development started a while ago.
> Indeed I don't know why they are there.
> 
>>
>>> +#include <linux/iio/driver.h>
> 
> I have checked and we really neither need machine.h nor driver.h.
> 
>>>
>>> #define TSC2007_MEASURE_TEMP0		(0x0 << 4)
>>> #define TSC2007_MEASURE_AUX		(0x2 << 4)
>>> @@ -61,6 +64,16 @@
>>> #define READ_X		(ADC_ON_12BIT | TSC2007_MEASURE_X)
>>> #define PWRDOWN		(TSC2007_12BIT | TSC2007_POWER_OFF_IRQ_EN)
>>>
>>> +#define TSC2007_CHAN_IIO(_chan, _name, _type, _chan_info) \
>>> +{ \
>>> +	.datasheet_name = _name, \
>>> +	.type = _type, \
>>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
>>> +			BIT(_chan_info), \
>>> +	.indexed = 1, \
>>> +	.channel = _chan, \
>>> +}
>>> +
>>> struct ts_event {
>>> 	u16	x;
>>> 	u16	y;
>>> @@ -69,9 +82,11 @@ struct ts_event {
>>>
>>> struct tsc2007 {
>>> 	struct input_dev	*input;
>>> +	struct iio_dev		*indio;
>>> 	char			phys[32];
>>>
>>> 	struct i2c_client	*client;
>>> +	struct mutex		mlock;
>>>
>>> 	u16			model;
>>> 	u16			x_plate_ohms;
>>> @@ -192,7 +207,10 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
>>> 	while (!ts->stopped && tsc2007_is_pen_down(ts)) {
>>>
>>> 		/* pen is down, continue with the measurement */
>>> +
>>> +		mutex_lock(&ts->mlock);
>>> 		tsc2007_read_values(ts, &tc);
>>> +		mutex_unlock(&ts->mlock);
>>>
>>> 		rt = tsc2007_calculate_resistance(ts, &tc);
>>>
>>> @@ -319,6 +337,86 @@ static void tsc2007_close(struct input_dev *input_dev)
>>> 	tsc2007_stop(ts);
>>> }
>>>
>>> +static const struct iio_chan_spec tsc2007_iio_channel[] = {
>>> +	TSC2007_CHAN_IIO(0, "x", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>>> +	TSC2007_CHAN_IIO(1, "y", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>>> +	TSC2007_CHAN_IIO(2, "z1", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>>> +	TSC2007_CHAN_IIO(3, "z2", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>>> +	TSC2007_CHAN_IIO(4, "adc", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>>> +	TSC2007_CHAN_IIO(5, "rt", IIO_VOLTAGE, IIO_CHAN_INFO_RAW), /* Ohms? */
>> This one needs some explanation.  What is it measuring?
> 
> Well, it is reporting the raw conductivity of the touch under certain
> conditions. But basically it is also a voltage measured by the ADC.
> 
> The real pressure value reported to user space is calculated
> using this and the z1 and z2 values.
> 
> If not pressed, conductivity is 0 and if lightly touched it jumps
> to some base value. When more pressed, conductivity increases
> while resistance goes down to some 300 Ohms or so.
> 
> But I have not found an IIO_OHM or IIO_MHO constant. Which would also
> not be the best description because it is not scaled to real ohms.
> 
>>
>>> +	TSC2007_CHAN_IIO(6, "pen", IIO_PRESSURE, IIO_CHAN_INFO_RAW),
>> At the moment this is defined as barometric pressure.
> 
> Ok, I see.
> 
>>  I suppose there
>> is no reason it can't extend to touch pressure though, even if it's a boolean
>> like this...
> 
> So let's keep it this way?
Except I'm saying we should drop it entirely.
> 
>>
>>> +	TSC2007_CHAN_IIO(7, "temp0", IIO_TEMP, IIO_CHAN_INFO_RAW),
>>> +	TSC2007_CHAN_IIO(8, "temp1", IIO_TEMP, IIO_CHAN_INFO_RAW),
>> I would be tempted to only expose those channels that have a meaning
>> outside of touch screen usage (e.g. adc, temp0 and temp1).  
> 
> Well, for debugging and checking for non-responding or defective touch
> it is very handy to have them in /sys/bus/iio for direct inspection.
> For example we run a device test tool reading such values.
> 
> You might argue that we should run our own fork for this purpose to provide
> a patched driver. But we want people to use the kernel from kernel.org
> and still be able to do such debugging without asking them to replace the
> kernel first.
> 
>>> +};
>>> +
>>> +static int tsc2007_read_raw(struct iio_dev *indio_dev,
>>> +	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
>>> +{
>>> +	struct  tsc2007 *tsc = iio_priv(indio_dev);
>>> +	int adc_chan = chan->channel;
>>> +	int ret = 0;
>>> +
>>> +	if (adc_chan >= ARRAY_SIZE(tsc2007_iio_channel))
>>> +		return -EINVAL;
>>> +
>>> +	if (mask != IIO_CHAN_INFO_RAW)
>>> +		return -EINVAL;
>>> +
>>> +	mutex_lock(&tsc->mlock);
>>> +
>>> +	switch (chan->channel) {
>>> +	case 0:
>>> +		*val = tsc2007_xfer(tsc, READ_X);
>>> +		break;
>>> +	case 1:
>>> +		*val = tsc2007_xfer(tsc, READ_Y);
>>> +		break;
>>> +	case 2:
>>> +		*val = tsc2007_xfer(tsc, READ_Z1);
>>> +		break;
>>> +	case 3:
>>> +		*val = tsc2007_xfer(tsc, READ_Z2);
>>> +		break;
>>> +	case 4:
>>> +		*val = tsc2007_xfer(tsc, (ADC_ON_12BIT | TSC2007_MEASURE_AUX));
>>> +		break;
>>> +	case 5: {
>>> +		struct ts_event tc;
>>> +
>>> +		tc.x = tsc2007_xfer(tsc, READ_X);
>>> +		tc.z1 = tsc2007_xfer(tsc, READ_Z1);
>>> +		tc.z2 = tsc2007_xfer(tsc, READ_Z2);
>>> +		*val = tsc2007_calculate_resistance(tsc, &tc);
>>> +		break;
>>> +	}
>>> +	case 6:
>>> +		*val = tsc2007_is_pen_down(tsc);
>>> +		break;
>>> +	case 7:
>>> +		*val = tsc2007_xfer(tsc,
>>> +				    (ADC_ON_12BIT | TSC2007_MEASURE_TEMP0));
>>> +		break;
>>> +	case 8:
>>> +		*val = tsc2007_xfer(tsc,
>>> +				    (ADC_ON_12BIT | TSC2007_MEASURE_TEMP1));
>>> +		break;
>>> +	}
>>> +
>>> +	/* Prepare for next touch reading - power down ADC, enable PENIRQ */
>>> +	tsc2007_xfer(tsc, PWRDOWN);
>>> +
>>> +	mutex_unlock(&tsc->mlock);
>>> +
>>> +	ret = IIO_VAL_INT;
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static const struct iio_info tsc2007_iio_info = {
>>> +	.read_raw = tsc2007_read_raw,
>>> +	.driver_module = THIS_MODULE,
>>> +};
>>> +
>>> #ifdef CONFIG_OF
>>> static int tsc2007_get_pendown_state_gpio(struct device *dev)
>>> {
>>> @@ -453,15 +551,20 @@ static int tsc2007_probe(struct i2c_client *client,
>>> 	const struct tsc2007_platform_data *pdata = dev_get_platdata(&client->dev);
>>> 	struct tsc2007 *ts;
>>> 	struct input_dev *input_dev;
>>> +	struct iio_dev *indio_dev;
>>> 	int err;
>>>
>>> 	if (!i2c_check_functionality(client->adapter,
>>> 				     I2C_FUNC_SMBUS_READ_WORD_DATA))
>>> 		return -EIO;
>>>
>>> -	ts = devm_kzalloc(&client->dev, sizeof(struct tsc2007), GFP_KERNEL);
>>> -	if (!ts)
>>> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*ts));
>>> +	if (!indio_dev) {
>>> +		dev_err(&client->dev, "iio_device_alloc failed\n");
>>> 		return -ENOMEM;
>>> +	}
>>> +
>>> +	ts = iio_priv(indio_dev);
>>>
>>> 	input_dev = devm_input_allocate_device(&client->dev);
>>> 	if (!input_dev)
>>> @@ -469,10 +572,26 @@ static int tsc2007_probe(struct i2c_client *client,
>>>
>>> 	i2c_set_clientdata(client, ts);
>>>
>>> +	indio_dev->name = "tsc2007";
>>> +	indio_dev->dev.parent = &client->dev;
>>> +	indio_dev->info = &tsc2007_iio_info;
>>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>>> +	indio_dev->channels = tsc2007_iio_channel;
>>> +	indio_dev->num_channels = ARRAY_SIZE(tsc2007_iio_channel);
>>> +
>>> +	err = iio_device_register(indio_dev);
>>> +	if (err < 0) {
>>> +		dev_err(&client->dev, "iio_device_register() failed: %d\n",
>>> +			err);
>>> +		return err;
>>> +	}
>>> +
>>> 	ts->client = client;
>>> 	ts->irq = client->irq;
>>> 	ts->input = input_dev;
>>> +	ts->indio = indio_dev;
>>> 	init_waitqueue_head(&ts->wait);
>>> +	mutex_init(&ts->mlock);
>>>
>>> 	snprintf(ts->phys, sizeof(ts->phys),
>>> 		 "%s/input0", dev_name(&client->dev));
>>> @@ -548,6 +667,19 @@ static int tsc2007_probe(struct i2c_client *client,
>>> 	return 0;
>>> }
>>>
>>> +static int tsc2007_remove(struct i2c_client *client)
>>> +{
>>> +	struct tsc2007 *ts = i2c_get_clientdata(client);
>>> +	struct input_dev *input_dev = ts->input;
>>> +	struct iio_dev *indio_dev = ts->indio;
>>> +
>>> +	input_unregister_device(input_dev);
>>> +
>>> +	iio_device_unregister(indio_dev);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> static const struct i2c_device_id tsc2007_idtable[] = {
>>> 	{ "tsc2007", 0 },
>>> 	{ }
>>> @@ -570,6 +702,7 @@ static struct i2c_driver tsc2007_driver = {
>>> 	},
>>> 	.id_table	= tsc2007_idtable,
>>> 	.probe		= tsc2007_probe,
>>> +	.remove		= tsc2007_remove,
>>> };
>>>
>>> module_i2c_driver(tsc2007_driver);
>>>
>>
> 
> BR and thanks,
> Nikolaus
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

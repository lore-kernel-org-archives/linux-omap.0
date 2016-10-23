From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 4/8] drivers:input:tsc2007: add iio interface to read
 external ADC input and temperature
Date: Sun, 23 Oct 2016 19:50:32 +0100
Message-ID: <83de9532-6efe-cd9f-311f-44dc0b3316f8@kernel.org>
References: <cover.1476712675.git.hns@goldelico.com>
 <4d3c600bf0a6b75a74212a103bf31525505290a0.1476712675.git.hns@goldelico.com>
 <07bb4d52-a439-f9a9-8593-ddde8e93e6ee@kernel.org>
 <7A0E332C-4930-4F1A-8320-F87F864B53AE@goldelico.com>
 <1dd251db-7f45-78bf-c9dd-4ae29b0ed757@kernel.org>
 <976C7328-A6AA-4CD5-AAAA-3B14BA3BD793@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <976C7328-A6AA-4CD5-AAAA-3B14BA3BD793-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 23/10/16 10:57, H. Nikolaus Schaller wrote:
> Hi,
> 
>> Am 23.10.2016 um 11:24 schrieb Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
>>
>> On 22/10/16 21:46, H. Nikolaus Schaller wrote:
>>> Hi Jonathan,
>>>
>>>> Am 22.10.2016 um 20:33 schrieb Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
>>>>
>>>> On 17/10/16 14:57, H. Nikolaus Schaller wrote:
>>>>> The tsc2007 chip not only has a resistive touch screen controller but
>>>>> also an external AUX adc imput which can be used for an ambient
>>>>> light sensor, battery voltage monitoring or any general purpose.
>>>>>
>>>>> Additionally it can measure the chip temperature.
>>>>>
>>>>> This extension provides an iio interface for these adc channels.
>>>>>
>>>>> Since it is not wasting much resources and is very straightforward,
>>>>> we simply provide all other adc channels as optional iio interfaces
>>>>> as weel. This can be used for debugging or special applications.
>>>> well
>>>>>
>>>>> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
>>>> This could be cleaner done perhaps by factoring out the IIO stuff into a separate
>>>> file and using a header with stubs to deal with the no available case.
>>>>
>>>> There will only be a handful of stubs and it'll give you a lot cleaner code
>>>> in here.
>>>>
>>>> If def fun in .c files is always harder to deal with than in a header
>>>> where stubs are really obvious.
>>>
>>> Yes, it became a lot of #ifdefs spread over the source file.
>>>
>>> The easiest thing would be to require IIO to be enabled :)
>>>
>>> With your proposal to consider refactoring, I think the crucial part
>>> is the conditional allocation either through devm_iio_device_alloc()
>>> or devm_kzalloc(). This can be refactored into some conditional
>>> tsc2007_alloc().
>>>
>>> I have tried some draft (not tested and not tidied up) to check if the
>>> direction is good.
>>>
>>> This reduces the number of #ifdef CONFIG_IIO from 7 to 2 without introducing
>>> new files or includes. There are also 2 other #ifdef CONFIG_OF so it doesn't
>>> seem to be very complex now in comparison. And the patch itself has only a
>>> handful of hunks (8).
>>>
>>> Moving tsc2007_alloc into a separate file tsc2007_iio.c would only move around
>>> one #ifdef CONFIG_OF from tsc2007.c but IMHO makes it more difficult to understand
>>> because it is not really iio specific and one has to switch between two source
>>> files. And I would have to touch the Makefile as well.
>>>
>>> What do you think?
>> I'd still split it.  The only bit of the IIO block that isn't specific is
>> a tiny chunk of the allocation code (as you've highlighted).
>>
>> Even that can be avoided by adding a tiny bit more indirection than would
>> otherwise be needed (it's not pretty but it would give a clean separation).
> 
> I hope I understand what you mean (which is an indication that the result
> may be much easier to read for you but not me...).
> 
>> It's pretty much the way this sort of optional functionality should always
>> be done - means that if you don't care (i.e. it's not enabled) you don't
>> even have to see the code.
> 
>>
>> Jonathan
>>>
>>> If generally ok, I can include that in [PATCH v5].
>>>
>>> BR and thanks,
>>> Nikolaus
>>>
>>>
>>> diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
>>> index 5e3c4bf..691e79f 100644
>>> --- a/drivers/input/touchscreen/tsc2007.c
>>> +++ b/drivers/input/touchscreen/tsc2007.c
>>> @@ -30,6 +30,7 @@
>>> #include <linux/of.h>
>>> #include <linux/of_gpio.h>
>>> #include <linux/input/touchscreen.h>
>>> +#include <linux/iio/iio.h>
>>>
>>> #define TSC2007_MEASURE_TEMP0          (0x0 << 4)
>>> #define TSC2007_MEASURE_AUX            (0x2 << 4)
>>> @@ -69,9 +70,13 @@ struct ts_event {
>>>
>>> struct tsc2007 {
>>>        struct input_dev        *input;
>>> +#ifdef CONFIG_IIO
>>> +       struct iio_dev          *indio;
>>> +#endif
>> I wouldn't bother with this one.  Just have 
>> struct iio_dev; before this and it'll waste a whole
>> one pointer (+ you shouldn't need to have iio.h included
>> in here once you have spit the files).
> 
> Looks as if I have to make a knot in my brain before I start to understand...
> 
> How can I use struct iio_dev here w/o including iio.h?
you aren't using it.  You have a pointer to it.

So it (before this definition) you have a line that says
struct iio_dev;  you let the compiler know such a structure exists.
At that point you don't actually have to provide a definition of
what is in it as long as all you use is a pointer (they are always
the same size).
> 
>>>        char                    phys[32];
>>>
>>>        struct i2c_client       *client;
>>> +       struct mutex            mlock;
>>>
>>>        u16                     model;
>>>        u16                     x_plate_ohms;
>>> @@ -192,7 +197,10 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
>>>        while (!ts->stopped && tsc2007_is_pen_down(ts)) {
>>>
>>>                /* pen is down, continue with the measurement */
>>> +
>>> +               mutex_lock(&ts->mlock);
>>>                tsc2007_read_values(ts, &tc);
>>> +               mutex_unlock(&ts->mlock);
>>>
>>>                rt = tsc2007_calculate_resistance(ts, &tc);
>>>
>>> @@ -319,6 +327,162 @@ static void tsc2007_close(struct input_dev *input_dev)
>>>        tsc2007_stop(ts);
>>> }
>>>
>>> +#ifdef CONFIG_IIO
>>> +
>>> +#define TSC2007_CHAN_IIO(_chan, _name, _type, _chan_info) \
>>> +{ \
>>> +       .datasheet_name = _name, \
>>> +       .type = _type, \
>>> +       .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |  \
>>> +                       BIT(_chan_info), \
>>> +       .indexed = 1, \
>>> +       .channel = _chan, \
>>> +}
>>> +
>>> +static const struct iio_chan_spec tsc2007_iio_channel[] = {
>>> +       TSC2007_CHAN_IIO(0, "x", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>>> +       TSC2007_CHAN_IIO(1, "y", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>>> +       TSC2007_CHAN_IIO(2, "z1", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>>> +       TSC2007_CHAN_IIO(3, "z2", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>>> +       TSC2007_CHAN_IIO(4, "adc", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
>>> +       TSC2007_CHAN_IIO(5, "rt", IIO_VOLTAGE, IIO_CHAN_INFO_RAW), /* Ohms? */
>>> +       TSC2007_CHAN_IIO(6, "pen", IIO_PRESSURE, IIO_CHAN_INFO_RAW),
>>> +       TSC2007_CHAN_IIO(7, "temp0", IIO_TEMP, IIO_CHAN_INFO_RAW),
>>> +       TSC2007_CHAN_IIO(8, "temp1", IIO_TEMP, IIO_CHAN_INFO_RAW),
>>> +};
>>> +
>>> +static int tsc2007_read_raw(struct iio_dev *indio_dev,
>>> +       struct iio_chan_spec const *chan, int *val, int *val2, long mask)
>>> +{
>>> +       struct  tsc2007 *tsc = iio_priv(indio_dev);
>>> +       int adc_chan = chan->channel;
>>> +       int ret = 0;
>>> +
>>> +       if (adc_chan >= ARRAY_SIZE(tsc2007_iio_channel))
>>> +               return -EINVAL;
>>> +
>>> +       if (mask != IIO_CHAN_INFO_RAW)
>>> +               return -EINVAL;
>>> +
>>> +       mutex_lock(&tsc->mlock);
>>> +
>>> +       switch (chan->channel) {
>>> +       case 0:
>>> +               *val = tsc2007_xfer(tsc, READ_X);
>>> +               break;
>>> +       case 1:
>>> +               *val = tsc2007_xfer(tsc, READ_Y);
>>> +               break;
>>> +       case 2:
>>> +               *val = tsc2007_xfer(tsc, READ_Z1);
>>> +               break;
>>> +       case 3:
>>> +               *val = tsc2007_xfer(tsc, READ_Z2);
>>> +               break;
>>> +       case 4:
>>> +               *val = tsc2007_xfer(tsc, (ADC_ON_12BIT | TSC2007_MEASURE_AUX));
>>> +               break;
>>> +       case 5: {
>>> +               struct ts_event tc;
>>> +
>>> +               tc.x = tsc2007_xfer(tsc, READ_X);
>>> +               tc.z1 = tsc2007_xfer(tsc, READ_Z1);
>>> +               tc.z2 = tsc2007_xfer(tsc, READ_Z2);
>>> +               *val = tsc2007_calculate_resistance(tsc, &tc);
>>> +               break;
>>> +       }
>>> +       case 6:
>>> +               *val = tsc2007_is_pen_down(tsc);
>>> +               break;
>>> +       case 7:
>>> +               *val = tsc2007_xfer(tsc,
>>> +                                   (ADC_ON_12BIT | TSC2007_MEASURE_TEMP0));
>>> +               break;
>>> +       case 8:
>>> +               *val = tsc2007_xfer(tsc,
>>> +                                   (ADC_ON_12BIT | TSC2007_MEASURE_TEMP1));
>>> +               break;
>>> +       }
>>> +
>>> +       /* Prepare for next touch reading - power down ADC, enable PENIRQ */
>>> +       tsc2007_xfer(tsc, PWRDOWN);
>>> +
>>> +       mutex_unlock(&tsc->mlock);
>>> +
>>> +       ret = IIO_VAL_INT;
>>> +
>>> +       return ret;
>>> +}
>>> +
>>> +static const struct iio_info tsc2007_iio_info = {
>>> +       .read_raw = tsc2007_read_raw,
>>> +       .driver_module = THIS_MODULE,
>>> +};
>>> +
>>> +static int tsc2007_alloc(struct i2c_client *client, struct tsc2007 **ts,
>>> +                          struct input_dev **input_dev)
>>> +{
>>> +       int err;
>>> +       struct iio_dev *indio_dev;
>>> +
>>> +       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*ts));
>> Instead of doing this to reduce the delta between versions make 
>> iio_priv a struct tsc2007 **
>>
>> That is have a single pointer in there and do your allocation of struct
>> tsc2007 separately.
> 
> Sorry, but I think I do not completely understand what you mean here.
> 
> The problem is that we need to allocate some struct tsc2007 in both cases.
> But in one case managed directly by &client->dev and in the other managed
> indirectly. This is why I use the private area of struct iio_dev to store
> the full struct tsc2007 and not just a pointer.
> 
No you don't need to do what you are currently doing.

You need to have some means to navigate from struct iio_dev to the 
struct tsc2007 - that doesn't have to be because it actually is
in iio_priv.

You can instead put a point to it in iio_priv (and only that) and allocate
it the same way in both paths (stashing a copy of the address in the
pointer in iio_priv).


> What I mean is:
> 
>>> +       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*ts));
>>> 	*ts = iio_priv(indio_dev);
> 
> vs. 
> 
>>> 	 *ts = devm_kzalloc(&client->dev, sizeof(struct tsc2007), GFP_KERNEL);
> 
> 
> So how can the IIO case just extend/wrap devm_kzalloc(&client->dev...) and still
> be managed as well?
Not relevant if you just allocate it the same way both times.
> 
>>
>> Having doing that, you can have this CONFIG_IIO block as just
>> doing the iio stuff with the input elements pulled back into the main
>> probe function.
>>
>> Then define something like
>>
>> iio_configure (stubbed to nothing if no IIO)
>> and
>> iio_unconfigure (also stubbed to nothing if no IIO).
>>
>> A couple of additions in the header to make it all work
>> (the struct tsc2007 and tsc2007_xfer() + a few of the
>> register defines..
>>
>> Nothing big and gets all the CONFIG_IIO into some really
>> obvious stubbing out in the header.
> 
> 
> Is there some example driver which is doing it that way to be optionally IIO
> compatible? That might be easier to understand and copy than a description.
This particular combination is unusual - but it similar to how we
do optional buffer or trigger support in various iio drivers.

Perhaps see include/linux/iio/common/st_sensors.h and look for CONFIG_IIO_TRIGGER
> 
>>
>>> +       if (!indio_dev) {
>>> +               dev_err(&client->dev, "iio_device_alloc failed\n");
>>> +               return -ENOMEM;
>>> +       }
>>> +
>>> +       *ts = iio_priv(indio_dev);
>>> +
>>> +       *input_dev = devm_input_allocate_device(&client->dev);
>>> +       if (!*input_dev)
>>> +               return -ENOMEM;
>>> +
>>> +       i2c_set_clientdata(client, *ts);
>>> +       (*ts)->indio = indio_dev;
>>> +
>>> +       indio_dev->name = "tsc2007";
>>> +       indio_dev->dev.parent = &client->dev;
>>> +       indio_dev->info = &tsc2007_iio_info;
>>> +       indio_dev->modes = INDIO_DIRECT_MODE;
>>> +       indio_dev->channels = tsc2007_iio_channel;
>>> +       indio_dev->num_channels = ARRAY_SIZE(tsc2007_iio_channel);
>>> +
>>> +       err = iio_device_register(indio_dev);
>>> +       if (err < 0) {
>>> +               dev_err(&client->dev, "iio_device_register() failed: %d\n",
>>> +                       err);
>>> +               return err;
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +#define tsc2007_iio_device_unregister(ts) iio_device_unregister(ts->indio)
>>> +
>>> +#else /* CONFIG_IIO */
>>> +
>>> +static int tsc2007_alloc(struct i2c_client *client, struct tsc2007 **ts,
>>> +                          struct input_dev **input_dev)
>>> +{
>>> +       int err;
>>> +
>>> +       *ts = devm_kzalloc(&client->dev, sizeof(struct tsc2007), GFP_KERNEL);
>>> +       if (!*ts)
>>> +               return -ENOMEM;
>>> +
>>> +       *input_dev = devm_input_allocate_device(&client->dev);
>>> +       if (!*input_dev)
>>> +               return -ENOMEM;
>>> +
>>> +       i2c_set_clientdata(client, *ts);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +#define tsc2007_iio_device_unregister(ts) /* not needed */
>> That's rather ugly and fragile.  I'd stub it out as an actual function
>> with no content and let the compiler drop it.
> 
> Well, it is a quick and dirty draft.
> Should indeed better be a static (inline) function with empty body.
> 
>>> +
>>> +#endif /* CONFIG_IIO */
>>> +
>>> #ifdef CONFIG_OF
>>> static int tsc2007_get_pendown_state_gpio(struct device *dev)
>>> {
>>> @@ -459,20 +623,15 @@ static int tsc2007_probe(struct i2c_client *client,
>>>                                     I2C_FUNC_SMBUS_READ_WORD_DATA))
>>>                return -EIO;
>>>
>>> -       ts = devm_kzalloc(&client->dev, sizeof(struct tsc2007), GFP_KERNEL);
>>> -       if (!ts)
>>> -               return -ENOMEM;
>>> -
>>> -       input_dev = devm_input_allocate_device(&client->dev);
>>> -       if (!input_dev)
>>> -               return -ENOMEM;
>>> -
>>> -       i2c_set_clientdata(client, ts);
>>> +       err = tsc2007_alloc(client, &ts, &input_dev);
>>> +       if (err < 0)
>>> +               return err;
>>>
>>>        ts->client = client;
>>>        ts->irq = client->irq;
>>>        ts->input = input_dev;
>>>        init_waitqueue_head(&ts->wait);
>>> +       mutex_init(&ts->mlock);
>>>
>>>        snprintf(ts->phys, sizeof(ts->phys),
>>>                 "%s/input0", dev_name(&client->dev));
>>> @@ -543,6 +702,7 @@ static int tsc2007_probe(struct i2c_client *client,
>>>        if (err < 0) {
>>>                dev_err(&client->dev,
>>>                        "Failed to setup chip: %d\n", err);
>>> +               tsc2007_iio_device_unregister(ts);
>>>                return err;     /* usually, chip does not respond */
>>>        }
>>>
>>> @@ -556,6 +716,14 @@ static int tsc2007_probe(struct i2c_client *client,
>>>        return 0;
>>> }
>>>
>>> +static int tsc2007_remove(struct i2c_client *client)
>>> +{
>>> +       struct tsc2007 *ts = i2c_get_clientdata(client);
>>> +       input_unregister_device(ts->input);
>>> +       tsc2007_iio_device_unregister(ts);
>>> +       return 0;
>>> +}
>>> +
>>> static const struct i2c_device_id tsc2007_idtable[] = {
>>>        { "tsc2007", 0 },
>>>        { }
>>> @@ -578,6 +746,7 @@ static struct i2c_driver tsc2007_driver = {
>>>        },
>>>        .id_table       = tsc2007_idtable,
>>>        .probe          = tsc2007_probe,
>>> +       .remove         = tsc2007_remove,
>>> };
>>>
>>> module_i2c_driver(tsc2007_driver);
>>>
>>
> 
> BR and thanks,
> Nikolaus
> 

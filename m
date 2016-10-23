From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 4/8] drivers:input:tsc2007: add iio interface to read
 external ADC input and temperature
Date: Sun, 23 Oct 2016 20:00:13 +0100
Message-ID: <4b6773d9-bc33-7471-ee29-01f51c5cfce2@kernel.org>
References: <cover.1476712675.git.hns@goldelico.com>
 <4d3c600bf0a6b75a74212a103bf31525505290a0.1476712675.git.hns@goldelico.com>
 <07bb4d52-a439-f9a9-8593-ddde8e93e6ee@kernel.org>
 <7A0E332C-4930-4F1A-8320-F87F864B53AE@goldelico.com>
 <1dd251db-7f45-78bf-c9dd-4ae29b0ed757@kernel.org>
 <976C7328-A6AA-4CD5-AAAA-3B14BA3BD793@goldelico.com>
 <F0CB8C7F-29FD-41DF-A652-9D1AF7824D5F@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <F0CB8C7F-29FD-41DF-A652-9D1AF7824D5F-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 23/10/16 19:34, H. Nikolaus Schaller wrote:
> Hi Jonathan,
> 
>> Am 23.10.2016 um 11:57 schrieb H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>:
>>
>> Hi,
>>
>>>> +static int tsc2007_alloc(struct i2c_client *client, struct tsc2007 **ts,
>>>> +                          struct input_dev **input_dev)
>>>> +{
>>>> +       int err;
>>>> +       struct iio_dev *indio_dev;
>>>> +
>>>> +       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*ts));
>>> Instead of doing this to reduce the delta between versions make 
>>> iio_priv a struct tsc2007 **
>>>
>>> That is have a single pointer in there and do your allocation of struct
>>> tsc2007 separately.
>>
>> Sorry, but I think I do not completely understand what you mean here.
>>
>> The problem is that we need to allocate some struct tsc2007 in both cases.
>> But in one case managed directly by &client->dev and in the other managed
>> indirectly. This is why I use the private area of struct iio_dev to store
>> the full struct tsc2007 and not just a pointer.
> 
> Ok, I think I finally did understand how you mean this and have started to
> implement something.
> 
oops. Didn't look on in my emails to get to this one!
> The idea is to have one alloc function to return a struct tsc2007. This
> can be part of the probe function, like it is in the unpatched driver.
> 
> In case of iio this struct tsc2007 is also allocated explicitly so that
> a pointer can be stored in iio_priv.
> 
> This just means an additional iio_priv->ts = devm_kzalloc() in case of iio.
> 
> I have added that approach to my inlined patch and it seems to work (attached).
> 
> Sorry if I do not use the wording you would use and sometimes overlook
> something you have said. I feel here like moving on thin ice and doing
> guesswork about unspoken assumptions...
That's fine.  Stuff that can appear obvious to one person is not
necessarily obvious to another!
> 
>>
>>>
>>> Having doing that, you can have this CONFIG_IIO block as just
>>> doing the iio stuff with the input elements pulled back into the main
>>> probe function.
>>>
>>> Then define something like
>>>
>>> iio_configure (stubbed to nothing if no IIO)
>>> and
>>> iio_unconfigure (also stubbed to nothing if no IIO).
> 
> This seems to work (draft attached).
> 
>>>
>>> A couple of additions in the header
> 
> I think you mean tsc2007.h?
Nope. A local header alongside the driver is what you want for this stuff.
driver/input/tsc2007.h 
> 
> This currently contains only platform data and could IMHO be eliminated
> if everything becomes DT.
> 
>>> to make it all work
>>> (the struct tsc2007 and tsc2007_xfer() + a few of the
>>> register defines..
> 
> Here it appears to me that I have to make a lot of so far private static
> and even static inline functions public so that I can make them stubs and
> call them from tsc2007_iio.c.
There will be a few.
> 
> And for having proper parameter types I have to make most private structs
> also public.
Yes a few of those as well.
> 
> I really like the idea to have the optional iio feature in a separate source
> file, but when really starting to write code, I get the impression that
> it introduces more problems than it solves.
> 
> And I wonder a little why it is not done for #ifdef CONFIG_OF in tsc2007.c
> as well. There are also two static function in some #ifdef #else # endif
> and not going through stubs.
Usually it is only done once a certain volume of code exists.
> 
> So is this intended to give up some static definitions?
Yes, that happens the moment you have multiple source files.

Some losses but generally end up with clean code separation. Always a trade
off unfortunately.  Pity we can't just insist IIO is available! Rather large
to pull in for what is probable a niche use case.

Below is definitely heading in the right direction. I remember vaguely being
convinced of the worth of doing this when optional code is involved!
(was a good while ago now)

Jonathan
> 
> BR and thanks,
> Nikolaus
> 
> diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
> index 5e3c4bf..92da8f6 100644
> --- a/drivers/input/touchscreen/tsc2007.c
> +++ b/drivers/input/touchscreen/tsc2007.c
> @@ -30,6 +30,7 @@
>  #include <linux/of.h>
>  #include <linux/of_gpio.h>
>  #include <linux/input/touchscreen.h>
> +#include <linux/iio/iio.h>
Should not need this after introducing the new file.  Will only be
needed in the iio specific .c file.
>  
>  #define TSC2007_MEASURE_TEMP0          (0x0 << 4)
>  #define TSC2007_MEASURE_AUX            (0x2 << 4)
> @@ -98,6 +99,9 @@ struct tsc2007 {
This will definitely need to go in the header though.
>  
>         int                     (*get_pendown_state)(struct device *);
>         void                    (*clear_penirq)(void);
> +
> +       struct mutex            mlock;
> +       void                    *private;
>  };
>  
>  static inline int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd)
> @@ -192,7 +196,10 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
>         while (!ts->stopped && tsc2007_is_pen_down(ts)) {
>  
>                 /* pen is down, continue with the measurement */
> +
> +               mutex_lock(&ts->mlock);
>                 tsc2007_read_values(ts, &tc);
> +               mutex_unlock(&ts->mlock);
>  
>                 rt = tsc2007_calculate_resistance(ts, &tc);
>  
> @@ -319,6 +326,157 @@ static void tsc2007_close(struct input_dev *input_dev)
>         tsc2007_stop(ts);
>  }
>  
> +#ifdef CONFIG_IIO
> +
> +struct tsc2007_iio {
> +       struct tsc2007 *ts;
Spot on.
> +};
> +
> +#define TSC2007_CHAN_IIO(_chan, _name, _type, _chan_info) \
> +{ \
> +       .datasheet_name = _name, \
> +       .type = _type, \
> +       .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |  \
> +                       BIT(_chan_info), \
> +       .indexed = 1, \
> +       .channel = _chan, \
> +}
> +
> +static const struct iio_chan_spec tsc2007_iio_channel[] = {
> +       TSC2007_CHAN_IIO(0, "x", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
> +       TSC2007_CHAN_IIO(1, "y", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
> +       TSC2007_CHAN_IIO(2, "z1", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
> +       TSC2007_CHAN_IIO(3, "z2", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
> +       TSC2007_CHAN_IIO(4, "adc", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
> +       TSC2007_CHAN_IIO(5, "rt", IIO_VOLTAGE, IIO_CHAN_INFO_RAW), /* Ohms? */
> +       TSC2007_CHAN_IIO(6, "pen", IIO_PRESSURE, IIO_CHAN_INFO_RAW),
> +       TSC2007_CHAN_IIO(7, "temp0", IIO_TEMP, IIO_CHAN_INFO_RAW),
> +       TSC2007_CHAN_IIO(8, "temp1", IIO_TEMP, IIO_CHAN_INFO_RAW),
> +};
> +
> +static int tsc2007_read_raw(struct iio_dev *indio_dev,
> +       struct iio_chan_spec const *chan, int *val, int *val2, long mask)
> +{
> +       struct tsc2007_iio *iio = iio_priv(indio_dev);
> +       struct tsc2007 *tsc = iio->ts;
> +       int adc_chan = chan->channel;
> +       int ret = 0;
> +
> +       if (adc_chan >= ARRAY_SIZE(tsc2007_iio_channel))
> +               return -EINVAL;
> +
> +       if (mask != IIO_CHAN_INFO_RAW)
> +               return -EINVAL;
> +
> +       mutex_lock(&tsc->mlock);
> +
> +       switch (chan->channel) {
> +       case 0:
> +               *val = tsc2007_xfer(tsc, READ_X);
> +               break;
> +       case 1:
> +               *val = tsc2007_xfer(tsc, READ_Y);
> +               break;
> +       case 2:
> +               *val = tsc2007_xfer(tsc, READ_Z1);
> +               break;
> +       case 3:
> +               *val = tsc2007_xfer(tsc, READ_Z2);
> +               break;
> +       case 4:
> +               *val = tsc2007_xfer(tsc, (ADC_ON_12BIT | TSC2007_MEASURE_AUX));
> +               break;
> +       case 5: {
> +               struct ts_event tc;
> +
> +               tc.x = tsc2007_xfer(tsc, READ_X);
> +               tc.z1 = tsc2007_xfer(tsc, READ_Z1);
> +               tc.z2 = tsc2007_xfer(tsc, READ_Z2);
> +               *val = tsc2007_calculate_resistance(tsc, &tc);
> +               break;
> +       }
> +       case 6:
> +               *val = tsc2007_is_pen_down(tsc);
> +               break;
> +       case 7:
> +               *val = tsc2007_xfer(tsc,
> +                                   (ADC_ON_12BIT | TSC2007_MEASURE_TEMP0));
> +               break;
> +       case 8:
> +               *val = tsc2007_xfer(tsc,
> +                                   (ADC_ON_12BIT | TSC2007_MEASURE_TEMP1));
> +               break;
> +       }
> +
> +       /* Prepare for next touch reading - power down ADC, enable PENIRQ */
> +       tsc2007_xfer(tsc, PWRDOWN);
> +
> +       mutex_unlock(&tsc->mlock);
> +
> +       ret = IIO_VAL_INT;
> +
> +       return ret;
> +}
> +
> +static const struct iio_info tsc2007_iio_info = {
> +       .read_raw = tsc2007_read_raw,
> +       .driver_module = THIS_MODULE,
> +};
> +
> +static inline int tsc2007_iio_configure(struct tsc2007 *ts)
> +{
> +       int err;
> +       struct iio_dev *indio_dev;
> +       struct tsc2007_iio *iio;
> +
> +       indio_dev = devm_iio_device_alloc(&ts->client->dev, sizeof(struct tsc2007_iio));
> +       if (!indio_dev) {
> +               dev_err(&ts->client->dev, "iio_device_alloc failed\n");
> +               return -ENOMEM;
> +       }
> +
> +       iio = iio_priv(indio_dev);
> +       iio->ts = ts;
> +       ts->private = (void *) indio_dev;
> +
> +       indio_dev->name = "tsc2007";
> +       indio_dev->dev.parent = &ts->client->dev;
> +       indio_dev->info = &tsc2007_iio_info;
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +       indio_dev->channels = tsc2007_iio_channel;
> +       indio_dev->num_channels = ARRAY_SIZE(tsc2007_iio_channel);
> +
> +       err = iio_device_register(indio_dev);
> +       if (err < 0) {
> +               dev_err(&ts->client->dev, "iio_device_register() failed: %d\n",
> +                       err);
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static inline void tsc2007_iio_unconfigure(struct tsc2007 *ts)
> +{
> +       struct iio_dev *indio_dev = ts->private;
> +
> +       iio_device_unregister(indio_dev);
> +}
> +
> +#else /* CONFIG_IIO */
> +
> +static inline int tsc2007_iio_configure(struct tsc2007 *ts)
> +{
> +       /* not needed */
> +}
> +
> +static inline void tsc2007_iio_unconfigure(struct tsc2007 *ts)
> +{
> +       /* not needed */
> +}
> +
> +#endif /* CONFIG_IIO */
> +
>  #ifdef CONFIG_OF
>  static int tsc2007_get_pendown_state_gpio(struct device *dev)
>  {
> @@ -472,7 +630,13 @@ static int tsc2007_probe(struct i2c_client *client,
>         ts->client = client;
>         ts->irq = client->irq;
>         ts->input = input_dev;
> +
> +       err = tsc2007_iio_configure(ts);
> +       if (err < 0)
> +               return err;
> +
>         init_waitqueue_head(&ts->wait);
> +       mutex_init(&ts->mlock);
>  
>         snprintf(ts->phys, sizeof(ts->phys),
>                  "%s/input0", dev_name(&client->dev));
> @@ -503,8 +667,10 @@ static int tsc2007_probe(struct i2c_client *client,
>                                                           ts->fuzzz, 0);
>         } else {
>                 err = tsc2007_probe_dt(client, ts);
> -               if (err)
> +               if (err) {
> +                       tsc2007_iio_unconfigure(ts);
>                         return err;
> +               }
>         }
>  
>         if (pdata) {
> @@ -516,6 +682,7 @@ static int tsc2007_probe(struct i2c_client *client,
>                                 dev_err(&client->dev,
>                                         "Failed to register exit_platform_hw action, %d\n",
>                                         err);
> +                               tsc2007_iio_unconfigure(ts);
>                                 return err;
>                         }
>                 }
> @@ -533,6 +700,7 @@ static int tsc2007_probe(struct i2c_client *client,
>         if (err) {
>                 dev_err(&client->dev, "Failed to request irq %d: %d\n",
>                         ts->irq, err);
> +               tsc2007_iio_unconfigure(ts);
Maybe need a common unwind and use a goto to get to it.
>                 return err;
>         }
>  
> @@ -543,6 +711,7 @@ static int tsc2007_probe(struct i2c_client *client,
>         if (err < 0) {
>                 dev_err(&client->dev,
>                         "Failed to setup chip: %d\n", err);
> +               tsc2007_iio_unconfigure(ts);
>                 return err;     /* usually, chip does not respond */
>         }
>  
> @@ -550,12 +719,21 @@ static int tsc2007_probe(struct i2c_client *client,
>         if (err) {
>                 dev_err(&client->dev,
>                         "Failed to register input device: %d\n", err);
> +               tsc2007_iio_unconfigure(ts);
>                 return err;
>         }
>  
>         return 0;
>  }
>  
> +static int tsc2007_remove(struct i2c_client *client)
> +{
> +       struct tsc2007 *ts = i2c_get_clientdata(client);
> +       tsc2007_iio_unconfigure(ts);
> +       input_unregister_device(ts->input);
> +       return 0;
> +}
> +
>  static const struct i2c_device_id tsc2007_idtable[] = {
>         { "tsc2007", 0 },
>         { }
> @@ -578,6 +756,7 @@ static struct i2c_driver tsc2007_driver = {
>         },
>         .id_table       = tsc2007_idtable,
>         .probe          = tsc2007_probe,
> +       .remove         = tsc2007_remove,
>  };
>  
>  module_i2c_driver(tsc2007_driver);--
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

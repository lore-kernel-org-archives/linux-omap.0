From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v4 4/8] drivers:input:tsc2007: add iio interface to read external ADC input and temperature
Date: Sun, 23 Oct 2016 20:34:56 +0200
Message-ID: <F0CB8C7F-29FD-41DF-A652-9D1AF7824D5F@goldelico.com>
References: <cover.1476712675.git.hns@goldelico.com> <4d3c600bf0a6b75a74212a103bf31525505290a0.1476712675.git.hns@goldelico.com> <07bb4d52-a439-f9a9-8593-ddde8e93e6ee@kernel.org> <7A0E332C-4930-4F1A-8320-F87F864B53AE@goldelico.com> <1dd251db-7f45-78bf-c9dd-4ae29b0ed757@kernel.org> <976C7328-A6AA-4CD5-AAAA-3B14BA3BD793@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <976C7328-A6AA-4CD5-AAAA-3B14BA3BD793@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, kernel@pyra-handheld.com, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-iio@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Rob Herring <robh+dt@kernel.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, linux-input@vger.kernel.org, Michael Welling <mwelling@ieee.org>, letux-kernel@openphoenux.org, "Andrew F. Davis" <afd@ti.com>, Igor Grinberg <grinberg@compulab.co.il>
List-Id: linux-omap@vger.kernel.org

Hi Jonathan,

> Am 23.10.2016 um 11:57 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> Hi,
>=20
>>> +static int tsc2007_alloc(struct i2c_client *client, struct tsc2007 =
**ts,
>>> +                          struct input_dev **input_dev)
>>> +{
>>> +       int err;
>>> +       struct iio_dev *indio_dev;
>>> +
>>> +       indio_dev =3D devm_iio_device_alloc(&client->dev, =
sizeof(*ts));
>> Instead of doing this to reduce the delta between versions make=20
>> iio_priv a struct tsc2007 **
>>=20
>> That is have a single pointer in there and do your allocation of =
struct
>> tsc2007 separately.
>=20
> Sorry, but I think I do not completely understand what you mean here.
>=20
> The problem is that we need to allocate some struct tsc2007 in both =
cases.
> But in one case managed directly by &client->dev and in the other =
managed
> indirectly. This is why I use the private area of struct iio_dev to =
store
> the full struct tsc2007 and not just a pointer.

Ok, I think I finally did understand how you mean this and have started =
to
implement something.

The idea is to have one alloc function to return a struct tsc2007. This
can be part of the probe function, like it is in the unpatched driver.

In case of iio this struct tsc2007 is also allocated explicitly so that
a pointer can be stored in iio_priv.

This just means an additional iio_priv->ts =3D devm_kzalloc() in case of =
iio.

I have added that approach to my inlined patch and it seems to work =
(attached).

Sorry if I do not use the wording you would use and sometimes overlook
something you have said. I feel here like moving on thin ice and doing
guesswork about unspoken assumptions...

>=20
>>=20
>> Having doing that, you can have this CONFIG_IIO block as just
>> doing the iio stuff with the input elements pulled back into the main
>> probe function.
>>=20
>> Then define something like
>>=20
>> iio_configure (stubbed to nothing if no IIO)
>> and
>> iio_unconfigure (also stubbed to nothing if no IIO).

This seems to work (draft attached).

>>=20
>> A couple of additions in the header

I think you mean tsc2007.h?

This currently contains only platform data and could IMHO be eliminated
if everything becomes DT.

>> to make it all work
>> (the struct tsc2007 and tsc2007_xfer() + a few of the
>> register defines..

Here it appears to me that I have to make a lot of so far private static
and even static inline functions public so that I can make them stubs =
and
call them from tsc2007_iio.c.

And for having proper parameter types I have to make most private =
structs
also public.

I really like the idea to have the optional iio feature in a separate =
source
file, but when really starting to write code, I get the impression that
it introduces more problems than it solves.

And I wonder a little why it is not done for #ifdef CONFIG_OF in =
tsc2007.c
as well. There are also two static function in some #ifdef #else # endif
and not going through stubs.

So is this intended to give up some static definitions?

BR and thanks,
Nikolaus

diff --git a/drivers/input/touchscreen/tsc2007.c =
b/drivers/input/touchscreen/tsc2007.c
index 5e3c4bf..92da8f6 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -30,6 +30,7 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/input/touchscreen.h>
+#include <linux/iio/iio.h>
=20
 #define TSC2007_MEASURE_TEMP0          (0x0 << 4)
 #define TSC2007_MEASURE_AUX            (0x2 << 4)
@@ -98,6 +99,9 @@ struct tsc2007 {
=20
        int                     (*get_pendown_state)(struct device *);
        void                    (*clear_penirq)(void);
+
+       struct mutex            mlock;
+       void                    *private;
 };
=20
 static inline int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd)
@@ -192,7 +196,10 @@ static irqreturn_t tsc2007_soft_irq(int irq, void =
*handle)
        while (!ts->stopped && tsc2007_is_pen_down(ts)) {
=20
                /* pen is down, continue with the measurement */
+
+               mutex_lock(&ts->mlock);
                tsc2007_read_values(ts, &tc);
+               mutex_unlock(&ts->mlock);
=20
                rt =3D tsc2007_calculate_resistance(ts, &tc);
=20
@@ -319,6 +326,157 @@ static void tsc2007_close(struct input_dev =
*input_dev)
        tsc2007_stop(ts);
 }
=20
+#ifdef CONFIG_IIO
+
+struct tsc2007_iio {
+       struct tsc2007 *ts;
+};
+
+#define TSC2007_CHAN_IIO(_chan, _name, _type, _chan_info) \
+{ \
+       .datasheet_name =3D _name, \
+       .type =3D _type, \
+       .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |  \
+                       BIT(_chan_info), \
+       .indexed =3D 1, \
+       .channel =3D _chan, \
+}
+
+static const struct iio_chan_spec tsc2007_iio_channel[] =3D {
+       TSC2007_CHAN_IIO(0, "x", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
+       TSC2007_CHAN_IIO(1, "y", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
+       TSC2007_CHAN_IIO(2, "z1", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
+       TSC2007_CHAN_IIO(3, "z2", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
+       TSC2007_CHAN_IIO(4, "adc", IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
+       TSC2007_CHAN_IIO(5, "rt", IIO_VOLTAGE, IIO_CHAN_INFO_RAW), /* =
Ohms? */
+       TSC2007_CHAN_IIO(6, "pen", IIO_PRESSURE, IIO_CHAN_INFO_RAW),
+       TSC2007_CHAN_IIO(7, "temp0", IIO_TEMP, IIO_CHAN_INFO_RAW),
+       TSC2007_CHAN_IIO(8, "temp1", IIO_TEMP, IIO_CHAN_INFO_RAW),
+};
+
+static int tsc2007_read_raw(struct iio_dev *indio_dev,
+       struct iio_chan_spec const *chan, int *val, int *val2, long =
mask)
+{
+       struct tsc2007_iio *iio =3D iio_priv(indio_dev);
+       struct tsc2007 *tsc =3D iio->ts;
+       int adc_chan =3D chan->channel;
+       int ret =3D 0;
+
+       if (adc_chan >=3D ARRAY_SIZE(tsc2007_iio_channel))
+               return -EINVAL;
+
+       if (mask !=3D IIO_CHAN_INFO_RAW)
+               return -EINVAL;
+
+       mutex_lock(&tsc->mlock);
+
+       switch (chan->channel) {
+       case 0:
+               *val =3D tsc2007_xfer(tsc, READ_X);
+               break;
+       case 1:
+               *val =3D tsc2007_xfer(tsc, READ_Y);
+               break;
+       case 2:
+               *val =3D tsc2007_xfer(tsc, READ_Z1);
+               break;
+       case 3:
+               *val =3D tsc2007_xfer(tsc, READ_Z2);
+               break;
+       case 4:
+               *val =3D tsc2007_xfer(tsc, (ADC_ON_12BIT | =
TSC2007_MEASURE_AUX));
+               break;
+       case 5: {
+               struct ts_event tc;
+
+               tc.x =3D tsc2007_xfer(tsc, READ_X);
+               tc.z1 =3D tsc2007_xfer(tsc, READ_Z1);
+               tc.z2 =3D tsc2007_xfer(tsc, READ_Z2);
+               *val =3D tsc2007_calculate_resistance(tsc, &tc);
+               break;
+       }
+       case 6:
+               *val =3D tsc2007_is_pen_down(tsc);
+               break;
+       case 7:
+               *val =3D tsc2007_xfer(tsc,
+                                   (ADC_ON_12BIT | =
TSC2007_MEASURE_TEMP0));
+               break;
+       case 8:
+               *val =3D tsc2007_xfer(tsc,
+                                   (ADC_ON_12BIT | =
TSC2007_MEASURE_TEMP1));
+               break;
+       }
+
+       /* Prepare for next touch reading - power down ADC, enable =
PENIRQ */
+       tsc2007_xfer(tsc, PWRDOWN);
+
+       mutex_unlock(&tsc->mlock);
+
+       ret =3D IIO_VAL_INT;
+
+       return ret;
+}
+
+static const struct iio_info tsc2007_iio_info =3D {
+       .read_raw =3D tsc2007_read_raw,
+       .driver_module =3D THIS_MODULE,
+};
+
+static inline int tsc2007_iio_configure(struct tsc2007 *ts)
+{
+       int err;
+       struct iio_dev *indio_dev;
+       struct tsc2007_iio *iio;
+
+       indio_dev =3D devm_iio_device_alloc(&ts->client->dev, =
sizeof(struct tsc2007_iio));
+       if (!indio_dev) {
+               dev_err(&ts->client->dev, "iio_device_alloc failed\n");
+               return -ENOMEM;
+       }
+
+       iio =3D iio_priv(indio_dev);
+       iio->ts =3D ts;
+       ts->private =3D (void *) indio_dev;
+
+       indio_dev->name =3D "tsc2007";
+       indio_dev->dev.parent =3D &ts->client->dev;
+       indio_dev->info =3D &tsc2007_iio_info;
+       indio_dev->modes =3D INDIO_DIRECT_MODE;
+       indio_dev->channels =3D tsc2007_iio_channel;
+       indio_dev->num_channels =3D ARRAY_SIZE(tsc2007_iio_channel);
+
+       err =3D iio_device_register(indio_dev);
+       if (err < 0) {
+               dev_err(&ts->client->dev, "iio_device_register() failed: =
%d\n",
+                       err);
+               return err;
+       }
+
+       return 0;
+}
+
+static inline void tsc2007_iio_unconfigure(struct tsc2007 *ts)
+{
+       struct iio_dev *indio_dev =3D ts->private;
+
+       iio_device_unregister(indio_dev);
+}
+
+#else /* CONFIG_IIO */
+
+static inline int tsc2007_iio_configure(struct tsc2007 *ts)
+{
+       /* not needed */
+}
+
+static inline void tsc2007_iio_unconfigure(struct tsc2007 *ts)
+{
+       /* not needed */
+}
+
+#endif /* CONFIG_IIO */
+
 #ifdef CONFIG_OF
 static int tsc2007_get_pendown_state_gpio(struct device *dev)
 {
@@ -472,7 +630,13 @@ static int tsc2007_probe(struct i2c_client *client,
        ts->client =3D client;
        ts->irq =3D client->irq;
        ts->input =3D input_dev;
+
+       err =3D tsc2007_iio_configure(ts);
+       if (err < 0)
+               return err;
+
        init_waitqueue_head(&ts->wait);
+       mutex_init(&ts->mlock);
=20
        snprintf(ts->phys, sizeof(ts->phys),
                 "%s/input0", dev_name(&client->dev));
@@ -503,8 +667,10 @@ static int tsc2007_probe(struct i2c_client *client,
                                                          ts->fuzzz, 0);
        } else {
                err =3D tsc2007_probe_dt(client, ts);
-               if (err)
+               if (err) {
+                       tsc2007_iio_unconfigure(ts);
                        return err;
+               }
        }
=20
        if (pdata) {
@@ -516,6 +682,7 @@ static int tsc2007_probe(struct i2c_client *client,
                                dev_err(&client->dev,
                                        "Failed to register =
exit_platform_hw action, %d\n",
                                        err);
+                               tsc2007_iio_unconfigure(ts);
                                return err;
                        }
                }
@@ -533,6 +700,7 @@ static int tsc2007_probe(struct i2c_client *client,
        if (err) {
                dev_err(&client->dev, "Failed to request irq %d: %d\n",
                        ts->irq, err);
+               tsc2007_iio_unconfigure(ts);
                return err;
        }
=20
@@ -543,6 +711,7 @@ static int tsc2007_probe(struct i2c_client *client,
        if (err < 0) {
                dev_err(&client->dev,
                        "Failed to setup chip: %d\n", err);
+               tsc2007_iio_unconfigure(ts);
                return err;     /* usually, chip does not respond */
        }
=20
@@ -550,12 +719,21 @@ static int tsc2007_probe(struct i2c_client =
*client,
        if (err) {
                dev_err(&client->dev,
                        "Failed to register input device: %d\n", err);
+               tsc2007_iio_unconfigure(ts);
                return err;
        }
=20
        return 0;
 }
=20
+static int tsc2007_remove(struct i2c_client *client)
+{
+       struct tsc2007 *ts =3D i2c_get_clientdata(client);
+       tsc2007_iio_unconfigure(ts);
+       input_unregister_device(ts->input);
+       return 0;
+}
+
 static const struct i2c_device_id tsc2007_idtable[] =3D {
        { "tsc2007", 0 },
        { }
@@ -578,6 +756,7 @@ static struct i2c_driver tsc2007_driver =3D {
        },
        .id_table       =3D tsc2007_idtable,
        .probe          =3D tsc2007_probe,
+       .remove         =3D tsc2007_remove,
 };
=20
 module_i2c_driver(tsc2007_driver);=

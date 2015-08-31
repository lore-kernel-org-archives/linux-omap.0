From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [V4] [TWL4030 MADC] Fix ADC[3:6] readings
Date: Mon, 31 Aug 2015 18:06:07 +0100
Message-ID: <55E4897F.8060809@kernel.org>
References: <1438712148-27004-1-git-send-email-adam.yh.lee@gmail.com>
 <1438712148-27004-2-git-send-email-adam.yh.lee@gmail.com>
 <55C61D22.7080604@kernel.org>
 <CAFeBWL5JT=+X9SCwRefn8L9Epx_c0yaizS5=1W4eq_O3Fpg7Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFeBWL5JT=+X9SCwRefn8L9Epx_c0yaizS5=1W4eq_O3Fpg7Lg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adam Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, j-keerthy-l0cyMroinI0@public.gmane.org, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 10/08/15 17:56, Adam Lee wrote:
> Yes I will do a better job in following the patch submission conventions.
> Thanks for your comment Jonathan.
> 
> @Sebastian, let me know if you have any concerns with the patch.
This has been sat around for long enough that I suspect Sebastian isn't
going to reply.  As such I've just applied it as is to the fixes-togreg
branch of iio.git (with some editing of the patch description!)

Thanks,

Jonathan
> 
> 
> 
> On Sat, Aug 8, 2015 at 8:15 AM Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org <mailto:jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>> wrote:
> 
>     On 04/08/15 19:15, Adam YH Lee wrote:
>     > MADC[3:6] reads incorrect values without these two following changes:
>     >
>     > - enable the 3v1 bias regulator for ADC[3:6]
>     > - configure ADC[3:6] lines as input, not as USB
>     >
>     > Signed-off-by: Adam YH Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
>     I'd ideally like an ack from the driver author or Sebastian as this isn't
>     a driver I'm particular familiar with.
> 
>     Also, for future reference, patches should be titled something like
>     [Patch v4] iio: twl4030 madc: Fix ADC[3:6] readings.
>     (the patch bit is standard, the rest is iio convention)
> 
>     Jonathan
> 
>     > ---
>     >  drivers/iio/adc/twl4030-madc.c | 34 ++++++++++++++++++++++++++++++++++
>     >  1 file changed, 34 insertions(+)
>     >
>     > diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
>     > index 94c5f05..8c58498 100644
>     > --- a/drivers/iio/adc/twl4030-madc.c
>     > +++ b/drivers/iio/adc/twl4030-madc.c
>     > @@ -45,13 +45,18 @@
>     >  #include <linux/types.h>
>     >  #include <linux/gfp.h>
>     >  #include <linux/err.h>
>     > +#include <linux/regulator/consumer.h>
>     >
>     >  #include <linux/iio/iio.h>
>     >
>     > +#define TWL4030_USB_SEL_MADC_MCPC    (1<<3)
>     > +#define TWL4030_USB_CARKIT_ANA_CTRL  0xBB
>     > +
>     >  /**
>     >   * struct twl4030_madc_data - a container for madc info
>     >   * @dev:             Pointer to device structure for madc
>     >   * @lock:            Mutex protecting this data structure
>     > + * @regulator:               Pointer to bias regulator for madc
>     >   * @requests:                Array of request struct corresponding to SW1, SW2 and RT
>     >   * @use_second_irq:  IRQ selection (main or co-processor)
>     >   * @imr:             Interrupt mask register of MADC
>     > @@ -60,6 +65,7 @@
>     >  struct twl4030_madc_data {
>     >       struct device *dev;
>     >       struct mutex lock;      /* mutex protecting this data structure */
>     > +     struct regulator *usb3v1;
>     >       struct twl4030_madc_request requests[TWL4030_MADC_NUM_METHODS];
>     >       bool use_second_irq;
>     >       u8 imr;
>     > @@ -842,6 +848,32 @@ static int twl4030_madc_probe(struct platform_device *pdev)
>     >       }
>     >       twl4030_madc = madc;
>     >
>     > +     /* Configure MADC[3:6] */
>     > +     ret = twl_i2c_read_u8(TWL_MODULE_USB, &regval,
>     > +                     TWL4030_USB_CARKIT_ANA_CTRL);
>     > +     if (ret) {
>     > +             dev_err(&pdev->dev, "unable to read reg CARKIT_ANA_CTRL  0x%X\n",
>     > +                             TWL4030_USB_CARKIT_ANA_CTRL);
>     > +             goto err_i2c;
>     > +     }
>     > +     regval |= TWL4030_USB_SEL_MADC_MCPC;
>     > +     ret = twl_i2c_write_u8(TWL_MODULE_USB, regval,
>     > +                              TWL4030_USB_CARKIT_ANA_CTRL);
>     > +     if (ret) {
>     > +             dev_err(&pdev->dev, "unable to write reg CARKIT_ANA_CTRL 0x%X\n",
>     > +                             TWL4030_USB_CARKIT_ANA_CTRL);
>     > +             goto err_i2c;
>     > +     }
>     > +
>     > +     /* Enable 3v1 bias regulator for MADC[3:6] */
>     > +     madc->usb3v1 = devm_regulator_get(madc->dev, "vusb3v1");
>     > +     if (IS_ERR(madc->usb3v1))
>     > +             return -ENODEV;
>     > +
>     > +     ret = regulator_enable(madc->usb3v1);
>     > +     if (ret)
>     > +             dev_err(madc->dev, "could not enable 3v1 bias regulator\n");
>     > +
>     >       ret = iio_device_register(iio_dev);
>     >       if (ret) {
>     >               dev_err(&pdev->dev, "could not register iio device\n");
>     > @@ -867,6 +899,8 @@ static int twl4030_madc_remove(struct platform_device *pdev)
>     >       twl4030_madc_set_current_generator(madc, 0, 0);
>     >       twl4030_madc_set_power(madc, 0);
>     >
>     > +     regulator_disable(madc->usb3v1);
>     > +
>     >       return 0;
>     >  }
>     >
>     >
> 

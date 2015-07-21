From: Adam Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [V3] [TWL4030 MADC] Fix ADC[3:6] readings
Date: Mon, 20 Jul 2015 17:53:14 -0700
Message-ID: <CAFeBWL6NgLqWu5-oge0qWjSVkgQ+DH1fD4RexNy9zuMEsg1jXg@mail.gmail.com>
References: <1437439755-30618-1-git-send-email-adam.yh.lee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437439755-30618-1-git-send-email-adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Adam YH Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello Peter,
Just sent up the V3 of my patch. Register configuration is now done in
madc driver code.

Another difference from V2 and V1 is that I am using
`devm_regulator_put` instead of
`regulator_put` to match the `devm_regulator_get` call.

I've tested it on Gumstix Overo (OMAP3 + TPS65950).

Let me know,

Adam

On Mon, Jul 20, 2015 at 5:49 PM, Adam YH Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> MADC[3:6] reads incorrect values without these two following changes:
>
> - enable the 3v1 bias regulator for ADC[3:6]
> - configure ADC[3:6] lines as input, not as USB
>
> Signed-off-by: Adam YH Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iio/adc/twl4030-madc.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
> index 94c5f05..ae33eba 100644
> --- a/drivers/iio/adc/twl4030-madc.c
> +++ b/drivers/iio/adc/twl4030-madc.c
> @@ -45,13 +45,18 @@
>  #include <linux/types.h>
>  #include <linux/gfp.h>
>  #include <linux/err.h>
> +#include <linux/regulator/consumer.h>
>
>  #include <linux/iio/iio.h>
>
> +#define TWL4030_USB_SEL_MADC_MCPC      (1<<3)
> +#define TWL4030_USB_CARKIT_ANA_CTRL    0xBB
> +
>  /**
>   * struct twl4030_madc_data - a container for madc info
>   * @dev:               Pointer to device structure for madc
>   * @lock:              Mutex protecting this data structure
> + * @regulator:         Pointer to bias regulator for madc
>   * @requests:          Array of request struct corresponding to SW1, SW2 and RT
>   * @use_second_irq:    IRQ selection (main or co-processor)
>   * @imr:               Interrupt mask register of MADC
> @@ -60,6 +65,7 @@
>  struct twl4030_madc_data {
>         struct device *dev;
>         struct mutex lock;      /* mutex protecting this data structure */
> +       struct regulator *usb3v1;
>         struct twl4030_madc_request requests[TWL4030_MADC_NUM_METHODS];
>         bool use_second_irq;
>         u8 imr;
> @@ -848,6 +854,33 @@ static int twl4030_madc_probe(struct platform_device *pdev)
>                 goto err_i2c;
>         }
>
> +       /* Configure MADC[3:6] */
> +       ret = twl_i2c_read_u8(TWL_MODULE_USB, &regval,
> +                       TWL4030_USB_CARKIT_ANA_CTRL);
> +       if (ret) {
> +               dev_err(&pdev->dev, "unable to read reg CARKIT_ANA_CTRL  0x%X\n",
> +                               TWL4030_USB_CARKIT_ANA_CTRL);
> +               goto err_i2c;
> +       }
> +       regval |= TWL4030_USB_SEL_MADC_MCPC;
> +       ret = twl_i2c_write_u8(TWL_MODULE_USB, regval,
> +                                TWL4030_USB_CARKIT_ANA_CTRL);
> +       if (ret) {
> +               dev_err(&pdev->dev, "unable to write reg CARKIT_ANA_CTRL 0x%X\n",
> +                               TWL4030_USB_CARKIT_ANA_CTRL);
> +               goto err_i2c;
> +       }
> +
> +
> +       /* Enable 3v1 bias regulator for MADC[3:6] */
> +       madc->usb3v1 = devm_regulator_get(madc->dev, "vusb3v1");
> +       if (IS_ERR(madc->usb3v1))
> +               return -ENODEV;
> +
> +       ret = regulator_enable(madc->usb3v1);
> +       if (ret)
> +               dev_err(madc->dev, "could not enable 3v1 bias regulator\n");
> +
>         return 0;
>
>  err_i2c:
> @@ -867,6 +900,9 @@ static int twl4030_madc_remove(struct platform_device *pdev)
>         twl4030_madc_set_current_generator(madc, 0, 0);
>         twl4030_madc_set_power(madc, 0);
>
> +       regulator_disable(madc->usb3v1);
> +       devm_regulator_put(madc->usb3v1);
> +
>         return 0;
>  }
>
> --
> 2.1.4
>

From: Matt Ranostay <matt.ranostay-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/3] iio: adc: cpcap: Fix default register values and
 battery temperature
Date: Fri, 19 May 2017 22:52:23 -0700
Message-ID: <CAJCx=gm7t=2nuHiLCXUohLXR62gZ-ux62tWyEQXyNXMrhTutKg@mail.gmail.com>
References: <20170519034035.16795-1-tony@atomide.com> <20170519034035.16795-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170519034035.16795-2-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, "open list:IIO SUBSYSTEM AND..." <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 18, 2017 at 8:40 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> Looking at the register dumps from Android kernel on droid 4, I noticed
> the values with the mainline kernel don't match. Let's fix this by
> initializing the ADC registers to what Android does.
>
> For getting correct values from the battery thermistor, we need to
> toggle the CPCAP_BIT_THERMBIAS_EN when measuring battery temperature
> to get correct battery temperatures. And looks like we also need to
> wait a little bit before reading the battery temperature as otherwise
> the results are inaccurate.
>
> Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
> Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/iio/adc/cpcap-adc.c | 50 +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 46 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
> --- a/drivers/iio/adc/cpcap-adc.c
> +++ b/drivers/iio/adc/cpcap-adc.c
> @@ -52,6 +52,10 @@
>  #define CPCAP_BIT_RAND0                        BIT(1)  /* Set with CAL_MODE */
>  #define CPCAP_BIT_ADEN                 BIT(0)  /* Currently unused */
>
> +#define CPCAP_REG_ADCC1_DEFAULTS       (CPCAP_BIT_ADEN_AUTO_CLR | \
> +                                        CPCAP_BIT_ADC_CLK_SEL0 |  \
> +                                        CPCAP_BIT_RAND1)
> +
>  /* Register CPCAP_REG_ADCC2 bits */
>  #define CPCAP_BIT_CAL_FACTOR_ENABLE    BIT(15) /* Currently unused */
>  #define CPCAP_BIT_BATDETB_EN           BIT(14) /* Currently unused */
> @@ -62,7 +66,7 @@
>  #define CPCAP_BIT_ADC_PS_FACTOR0       BIT(9)
>  #define CPCAP_BIT_AD4_SELECT           BIT(8)  /* Currently unused */
>  #define CPCAP_BIT_ADC_BUSY             BIT(7)  /* Currently unused */
> -#define CPCAP_BIT_THERMBIAS_EN         BIT(6)  /* Currently unused */
> +#define CPCAP_BIT_THERMBIAS_EN         BIT(6)  /* Bias for AD0_BATTDETB */
>  #define CPCAP_BIT_ADTRIG_DIS           BIT(5)  /* Disable interrupt */
>  #define CPCAP_BIT_LIADC                        BIT(4)  /* Currently unused */
>  #define CPCAP_BIT_TS_REFEN             BIT(3)  /* Currently unused */
> @@ -70,6 +74,13 @@
>  #define CPCAP_BIT_TS_M1                        BIT(1)  /* Currently unused */
>  #define CPCAP_BIT_TS_M0                        BIT(0)  /* Currently unused */
>
> +#define CPCAP_REG_ADCC2_DEFAULTS       (CPCAP_BIT_AD4_SELECT | \
> +                                        CPCAP_BIT_ADTRIG_DIS | \
> +                                        CPCAP_BIT_ADTRIG_DIS | \
> +                                        CPCAP_BIT_LIADC | \
> +                                        CPCAP_BIT_TS_M2 | \
> +                                        CPCAP_BIT_TS_M1)
> +
>  #define CPCAP_MAX_TEMP_LVL             27
>  #define CPCAP_FOUR_POINT_TWO_ADC       801
>  #define ST_ADC_CAL_CHRGI_HIGH_THRESHOLD        530
> @@ -124,10 +135,10 @@ struct cpcap_adc {
>   */
>  enum cpcap_adc_channel {
>         /* Bank0 channels */
> -       CPCAP_ADC_AD0_BATTDETB, /* Battery detection */
> +       CPCAP_ADC_AD0_BATTDETB, /* Battery temperature */

Since this doesn't mean battery detection anymore I'd recommend
renaming to CPCAP_ADC_AD0_BATTEMP or similar.

>         CPCAP_ADC_BATTP,        /* Battery voltage */
>         CPCAP_ADC_VBUS,         /* USB VBUS voltage */
> -       CPCAP_ADC_AD3,          /* Battery temperature when charging */
> +       CPCAP_ADC_AD3,          /* Die temperature when charging */
>         CPCAP_ADC_BPLUS_AD4,    /* Another battery or system voltage */
>         CPCAP_ADC_CHG_ISENSE,   /* Calibrated charge current */
>         CPCAP_ADC_BATTI,        /* Calibrated system current */
> @@ -541,6 +552,15 @@ static void cpcap_adc_setup_bank(struct cpcap_adc *ddata,
>                 return;
>
>         switch (req->channel) {
> +       case CPCAP_ADC_AD0_BATTDETB:
> +               value2 |= CPCAP_BIT_THERMBIAS_EN;
> +               error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
> +                                          CPCAP_BIT_THERMBIAS_EN,
> +                                          value2);
> +               if (error)
> +                       return;
> +               usleep_range(800, 1000);
> +               break;
>         case CPCAP_ADC_AD8 ... CPCAP_ADC_TSY2_AD15:
>                 value1 |= CPCAP_BIT_AD_SEL1;
>                 break;
> @@ -583,7 +603,8 @@ static void cpcap_adc_setup_bank(struct cpcap_adc *ddata,
>         error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
>                                    CPCAP_BIT_ATOX_PS_FACTOR |
>                                    CPCAP_BIT_ADC_PS_FACTOR1 |
> -                                  CPCAP_BIT_ADC_PS_FACTOR0,
> +                                  CPCAP_BIT_ADC_PS_FACTOR0 |
> +                                  CPCAP_BIT_THERMBIAS_EN,
>                                    value2);
>         if (error)
>                 return;
> @@ -664,6 +685,21 @@ static int cpcap_adc_start_bank(struct cpcap_adc *ddata,
>         return error;
>  }
>
> +static int cpcap_adc_stop_bank(struct cpcap_adc *ddata)
> +{
> +       int error;
> +
> +       error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC1,
> +                                  0xffff,
> +                                  CPCAP_REG_ADCC1_DEFAULTS);
> +       if (error)
> +               return error;
> +
> +       return regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
> +                                 0xffff,
> +                                 CPCAP_REG_ADCC2_DEFAULTS);
> +}
> +
>  static void cpcap_adc_phase(struct cpcap_adc_request *req)
>  {
>         const struct cpcap_adc_conversion_tbl *conv_tbl = req->conv_tbl;
> @@ -860,6 +896,9 @@ static int cpcap_adc_read(struct iio_dev *indio_dev,
>                 error = regmap_read(ddata->reg, chan->address, val);
>                 if (error)
>                         goto err_unlock;
> +               error = cpcap_adc_stop_bank(ddata);
> +               if (error)
> +                       goto err_unlock;
>                 mutex_unlock(&ddata->lock);
>                 break;
>         case IIO_CHAN_INFO_PROCESSED:
> @@ -870,6 +909,9 @@ static int cpcap_adc_read(struct iio_dev *indio_dev,
>                 error = cpcap_adc_read_bank_scaled(ddata, &req);
>                 if (error)
>                         goto err_unlock;
> +               error = cpcap_adc_stop_bank(ddata);
> +               if (error)
> +                       goto err_unlock;
>                 mutex_unlock(&ddata->lock);
>                 *val = req.result;
>                 break;
> --
> 2.13.0
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

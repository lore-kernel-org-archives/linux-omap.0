From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] ti_tscadc: Match mfd sub devices to regmap interface
Date: Fri, 02 Nov 2012 09:36:46 +0000
Message-ID: <5093942E.5010403@kernel.org>
References: <1351783496-11557-1-git-send-email-panto@antoniou-consulting.com> <1351783496-11557-2-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1351783496-11557-2-git-send-email-panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/01/2012 03:24 PM, Pantelis Antoniou wrote:
> The MFD parent device now uses a regmap, instead of direct
> memory access. Use the same method in the sub devices to avoid
> nasty surprises.
> 
> Please not that this driver can't really deal with the case of the regmap
> call failing in anyway. So that's why there's no error handling.
> 
> I think it's best to patch this up, until the driver maintainers deal
> with this properly.
This should be split in two as it's touching two different drivers in
different subsystems and may merge through them.

> 
> Signed-off-by: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
> ---
>  drivers/iio/adc/ti_am335x_adc.c           | 10 ++++++++--
>  drivers/input/touchscreen/ti_am335x_tsc.c |  9 +++++++--
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 8595a90..44806f9 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -23,7 +23,9 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/machine.h>
>  #include <linux/iio/driver.h>
> +#include <linux/regmap.h>
>  
> +#include <linux/io.h>
>  #include <linux/mfd/ti_am335x_tscadc.h>
>  #include <linux/platform_data/ti_am335x_adc.h>
>  
> @@ -36,13 +38,17 @@ struct tiadc_device {
>  
>  static unsigned int tiadc_readl(struct tiadc_device *adc, unsigned int reg)
>  {
> -	return readl(adc->mfd_tscadc->tscadc_base + reg);
> +	unsigned int val;
> +
> +	val = (unsigned int)-1;
> +	regmap_read(adc->mfd_tscadc->regmap_tscadc, reg, &val);
> +	return val;
>  }
>  
>  static void tiadc_writel(struct tiadc_device *adc, unsigned int reg,
>  					unsigned int val)
>  {
> -	writel(val, adc->mfd_tscadc->tscadc_base + reg);
> +	regmap_write(adc->mfd_tscadc->regmap_tscadc, reg, val);
>  }
>  
>  static void tiadc_step_config(struct tiadc_device *adc_dev)
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> index 7a26810..5723957 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -26,6 +26,7 @@
>  #include <linux/io.h>
>  #include <linux/input/ti_am335x_tsc.h>
>  #include <linux/delay.h>
> +#include <linux/regmap.h>
>  
>  #include <linux/mfd/ti_am335x_tscadc.h>
>  
> @@ -64,13 +65,17 @@ struct titsc {
>  
>  static unsigned int titsc_readl(struct titsc *ts, unsigned int reg)
>  {
> -	return readl(ts->mfd_tscadc->tscadc_base + reg);
> +	unsigned int val;
> +
> +	val = (unsigned int)-1;
> +	regmap_read(ts->mfd_tscadc->regmap_tscadc, reg, &val);
> +	return val;
>  }
>  
>  static void titsc_writel(struct titsc *tsc, unsigned int reg,
>  					unsigned int val)
>  {
> -	writel(val, tsc->mfd_tscadc->tscadc_base + reg);
> +	regmap_write(tsc->mfd_tscadc->regmap_tscadc, reg, val);
>  }
>  
>  /*
> 

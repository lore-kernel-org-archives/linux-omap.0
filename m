From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] iio: adc: ti_am335x_adc: Increase timeout value
 waiting for ADC sample
Date: Tue, 9 Aug 2016 10:35:02 +0100
Message-ID: <20160809093502.GV5243@dell>
References: <20160808110501.29586-1-vigneshr@ti.com>
 <20160808110501.29586-3-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160808110501.29586-3-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, 08 Aug 2016, Vignesh R wrote:

> Now that open delay and sample delay for each channel is configurable
> via DT, the default IDLE_TIMEOUT value is not enough as this is
> calculated based on hardcoded macros. This results in driver returning
> EBUSY sometimes. Fix this by increasing the timeout
> value based on maximum value possible to open delay and sample delays
> for each channel.
> 
> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/iio/adc/ti_am335x_adc.c      | 2 +-
>  include/linux/mfd/ti_am335x_tscadc.h | 8 ++++----

Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index bed9977a1863..c3cfacca2541 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -381,7 +381,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
>  
>  	am335x_tsc_se_set_once(adc_dev->mfd_tscadc, step_en);
>  
> -	timeout = jiffies + usecs_to_jiffies
> +	timeout = jiffies + msecs_to_jiffies
>  				(IDLE_TIMEOUT * adc_dev->channels);
>  	/* Wait for Fifo threshold interrupt */
>  	while (1) {
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> index 2567a87872b0..7f55b8b41032 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -138,16 +138,16 @@
>  /*
>   * time in us for processing a single channel, calculated as follows:
>   *
> - * num cycles = open delay + (sample delay + conv time) * averaging
> + * max num cycles = open delay + (sample delay + conv time) * averaging
>   *
> - * num cycles: 152 + (1 + 13) * 16 = 376
> + * max num cycles: 262143 + (255 + 13) * 16 = 266431
>   *
>   * clock frequency: 26MHz / 8 = 3.25MHz
>   * clock period: 1 / 3.25MHz = 308ns
>   *
> - * processing time: 376 * 308ns = 116us
> + * max processing time: 266431 * 308ns = 83ms(approx)
>   */
> -#define IDLE_TIMEOUT 116 /* microsec */
> +#define IDLE_TIMEOUT 83 /* milliseconds */
>  
>  #define TSCADC_CELLS		2
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

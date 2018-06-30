From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 4/5] iio: adc: ti_am335x_adc: Disable ADC during suspend
 unconditionally
Date: Sat, 30 Jun 2018 16:18:48 +0100
Message-ID: <20180630161848.1e72deea@archlinux>
References: <20180630103318.25355-1-vigneshr@ti.com>
        <20180630103318.25355-5-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180630103318.25355-5-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, 30 Jun 2018 16:03:17 +0530
Vignesh R <vigneshr@ti.com> wrote:

> Parent MFD device takes care of enabling ADC interface whenever
> touchscreen is marked wakeup capable. Therefore, unconditionally disable
> ADC interface during system suspend to save power in case of system with
> just ADC and no TSC.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>

This sounds like a sensible change to me.   Is it applicable without the
rest of the series?  If so I'll take it through IIO.  If the answer
is that it needs to go with the rest then

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ti_am335x_adc.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 80df5a377d30..cafb1dcadc48 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -693,16 +693,12 @@ static int __maybe_unused tiadc_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct tiadc_device *adc_dev = iio_priv(indio_dev);
> -	struct ti_tscadc_dev *tscadc_dev;
>  	unsigned int idle;
>  
> -	tscadc_dev = ti_tscadc_dev_get(to_platform_device(dev));
> -	if (!device_may_wakeup(tscadc_dev->dev)) {
> -		idle = tiadc_readl(adc_dev, REG_CTRL);
> -		idle &= ~(CNTRLREG_TSCSSENB);
> -		tiadc_writel(adc_dev, REG_CTRL, (idle |
> -				CNTRLREG_POWERDOWN));
> -	}
> +	idle = tiadc_readl(adc_dev, REG_CTRL);
> +	idle &= ~(CNTRLREG_TSCSSENB);
> +	tiadc_writel(adc_dev, REG_CTRL, (idle |
> +			CNTRLREG_POWERDOWN));
>  
>  	return 0;
>  }

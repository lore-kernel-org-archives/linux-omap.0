From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 1/2] iio: adc: ti_am335x_adc: Protect FIFO1 from
 concurrent access
Date: Sun, 21 Aug 2016 19:49:21 +0100
Message-ID: <639a3736-9e43-e4cc-faa8-d8871d29e2db@kernel.org>
References: <20160817121301.21785-1-vigneshr@ti.com>
 <20160817121301.21785-2-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160817121301.21785-2-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lee Jones <lee.jones@linaro.org>, "Andrew F . Davis" <afd@ti.com>, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 17/08/16 13:13, Vignesh R wrote:
> It is possible that two or more ADC channels can be simultaneously
> requested for raw samples, in which case there can be race in access to
> FIFO data resulting in loss of samples.
> If am335x_tsc_se_set_once() is called again from tiadc_read_raw(), when
> ADC is still acquired to sample one of the channels, the second process
> might be put into uninterruptible sleep state. Fix these issues, by
> protecting FIFO access and channel configurations with a mutex. Since
> tiadc_read_raw() might take anywhere between few microseconds to few
> milliseconds to finish execution (depending on averaging and delay
> values supplied via DT), its better to use mutex instead of spinlock.
> 
> Fixes: 7ca6740cd1cd4 ("mfd: input: iio: ti_amm335x: Rework TSC/ADC synchronization")
> Signed-off-by: Vignesh R <vigneshr@ti.com>
Thanks for tracking this down and for the patch in the
first place!

Applied to the fixes-togreg branch of iio.git and marked for
stable.  Should head upstream sometime this week.

Jonathan
> ---
> 
> v2: Add fixes tag.
> 
>  drivers/iio/adc/ti_am335x_adc.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 8a368756881b..bed9977a1863 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -32,6 +32,7 @@
>  
>  struct tiadc_device {
>  	struct ti_tscadc_dev *mfd_tscadc;
> +	struct mutex fifo1_lock; /* to protect fifo access */
>  	int channels;
>  	u8 channel_line[8];
>  	u8 channel_step[8];
> @@ -359,6 +360,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
>  		int *val, int *val2, long mask)
>  {
>  	struct tiadc_device *adc_dev = iio_priv(indio_dev);
> +	int ret = IIO_VAL_INT;
>  	int i, map_val;
>  	unsigned int fifo1count, read, stepid;
>  	bool found = false;
> @@ -372,6 +374,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
>  	if (!step_en)
>  		return -EINVAL;
>  
> +	mutex_lock(&adc_dev->fifo1_lock);
>  	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
>  	while (fifo1count--)
>  		tiadc_readl(adc_dev, REG_FIFO1);
> @@ -388,7 +391,8 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
>  
>  		if (time_after(jiffies, timeout)) {
>  			am335x_tsc_se_adc_done(adc_dev->mfd_tscadc);
> -			return -EAGAIN;
> +			ret = -EAGAIN;
> +			goto err_unlock;
>  		}
>  	}
>  	map_val = adc_dev->channel_step[chan->scan_index];
> @@ -414,8 +418,11 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
>  	am335x_tsc_se_adc_done(adc_dev->mfd_tscadc);
>  
>  	if (found == false)
> -		return -EBUSY;
> -	return IIO_VAL_INT;
> +		ret =  -EBUSY;
> +
> +err_unlock:
> +	mutex_unlock(&adc_dev->fifo1_lock);
> +	return ret;
>  }
>  
>  static const struct iio_info tiadc_info = {
> @@ -483,6 +490,7 @@ static int tiadc_probe(struct platform_device *pdev)
>  
>  	tiadc_step_config(indio_dev);
>  	tiadc_writel(adc_dev, REG_FIFO1THR, FIFO1_THRESHOLD);
> +	mutex_init(&adc_dev->fifo1_lock);
>  
>  	err = tiadc_channel_init(indio_dev, adc_dev->channels);
>  	if (err < 0)
> 

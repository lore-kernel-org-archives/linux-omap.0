From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/5] Input: ti_am335x_tsc: Mark IRQ as wakeup capable
Date: Wed, 18 Jul 2018 17:06:22 +0000
Message-ID: <20180718170622.qms254nlvnavfk7q@penguin>
References: <20180630103318.25355-1-vigneshr@ti.com>
 <20180630103318.25355-6-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180630103318.25355-6-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Jun 30, 2018 at 04:03:18PM +0530, Vignesh R wrote:
> On AM335x, ti_am335x_tsc can wake up the system from suspend, mark the
> IRQ as wakeup capable, so that device irq is not disabled during system
> suspend.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/input/touchscreen/ti_am335x_tsc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> index a4f25a915ffc..9e8684ab48f4 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -27,6 +27,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/sort.h>
> +#include <linux/pm_wakeirq.h>
>  
>  #include <linux/mfd/ti_am335x_tscadc.h>
>  
> @@ -439,6 +440,9 @@ static int titsc_probe(struct platform_device *pdev)
>  	}
>  
>  	device_init_wakeup(&pdev->dev, true);
> +	err = dev_pm_set_wake_irq(&pdev->dev, ts_dev->irq);
> +	if (err)
> +		dev_err(&pdev->dev, "irq wake enable failed.\n");
>  
>  	titsc_writel(ts_dev, REG_IRQSTATUS, TSC_IRQENB_MASK);
>  	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_FIFO0THRES);
> @@ -471,6 +475,7 @@ static int titsc_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_free_irq:
> +	dev_pm_clear_wake_irq(&pdev->dev);
>  	device_init_wakeup(&pdev->dev, false);
>  	free_irq(ts_dev->irq, ts_dev);
>  err_free_mem:
> @@ -484,6 +489,7 @@ static int titsc_remove(struct platform_device *pdev)
>  	struct titsc *ts_dev = platform_get_drvdata(pdev);
>  	u32 steps;
>  
> +	dev_pm_clear_wake_irq(&pdev->dev);
>  	device_init_wakeup(&pdev->dev, false);
>  	free_irq(ts_dev->irq, ts_dev);
>  
> -- 
> 2.18.0
> 

-- 
Dmitry

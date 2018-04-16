From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/3] Input: ti_am335x_tsc - Mark IRQ as wakeup capable
Date: Mon, 16 Apr 2018 10:45:42 -0700
Message-ID: <20180416174542.GB77055@dtor-ws>
References: <20180414095153.32060-1-vigneshr@ti.com>
 <20180414095153.32060-2-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180414095153.32060-2-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Sat, Apr 14, 2018 at 03:21:51PM +0530, Vignesh R wrote:
> On AM335x, ti_am335x_tsc can wake up the system from suspend, mark the
> IRQ as wakeup capable, so that device irq is not disabled during system
> suspend.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
> 
> v2: No changes
> 
>  drivers/input/touchscreen/ti_am335x_tsc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> index f1043ae71dcc..810e05c9c4f5 100644
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
> @@ -432,6 +433,12 @@ static int titsc_probe(struct platform_device *pdev)
>  		goto err_free_mem;
>  	}
>  
> +	if (device_may_wakeup(tscadc_dev->dev)) {
> +		err = dev_pm_set_wake_irq(tscadc_dev->dev, ts_dev->irq);

Hmm, most of the drivers simply use enable_irq_wake()/disable_irq_wake()
in suspend/resume paths and use dev_pm_set_wake_irq() only for dedicated
and distinct wake interrupts. Why do we not follow the same pattern
here?

Thanks.

> +		if (err)
> +			dev_err(&pdev->dev, "irq wake enable failed.\n");
> +	}
> +
>  	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_FIFO0THRES);
>  	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_EOS);
>  	err = titsc_config_wires(ts_dev);
> @@ -462,6 +469,7 @@ static int titsc_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_free_irq:
> +	dev_pm_clear_wake_irq(tscadc_dev->dev);
>  	free_irq(ts_dev->irq, ts_dev);
>  err_free_mem:
>  	input_free_device(input_dev);
> @@ -474,6 +482,7 @@ static int titsc_remove(struct platform_device *pdev)
>  	struct titsc *ts_dev = platform_get_drvdata(pdev);
>  	u32 steps;
>  
> +	dev_pm_clear_wake_irq(ts_dev->mfd_tscadc->dev);
>  	free_irq(ts_dev->irq, ts_dev);
>  
>  	/* total steps followed by the enable mask */
> -- 
> 2.17.0
> 

-- 
Dmitry

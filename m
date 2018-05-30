From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 1/3] Input: ti_am335x_tsc - Mark IRQ as wakeup capable
Date: Wed, 30 May 2018 14:47:50 -0700
Message-ID: <20180530214750.GD203327@dtor-ws>
References: <20180424062741.7891-1-vigneshr@ti.com>
 <20180424062741.7891-2-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180424062741.7891-2-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi Vignesh,

On Tue, Apr 24, 2018 at 11:57:39AM +0530, Vignesh R wrote:
> On AM335x, ti_am335x_tsc can wake up the system from suspend, mark the
> IRQ as wakeup capable, so that device irq is not disabled during system
> suspend.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
> v3: Drop unneeded device_may_wakeup() check
> 
>  drivers/input/touchscreen/ti_am335x_tsc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> index f1043ae71dcc..3908c21862c7 100644
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
> @@ -432,6 +433,10 @@ static int titsc_probe(struct platform_device *pdev)
>  		goto err_free_mem;
>  	}
>  
> +	err = dev_pm_set_wake_irq(tscadc_dev->dev, ts_dev->irq);
> +	if (err)
> +		dev_err(&pdev->dev, "irq wake enable failed.\n");
> +

Looking at this driver some more: why do we have the parent MFD device
as wakeup source? It seems we have 2 independent interrupt lines, one in
IIO and one in input and we could actually have the touchscreen itself
to be one of the wakeup devices? I.e. i'd expect

	err = dev_pm_set_wake_irq(&pdev->dev, ts_dev->irq);

here and we should be checking the touchscreen pdev in suspend/resume
when checking whether to program the controller for wakeups.


>  	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_FIFO0THRES);
>  	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_EOS);
>  	err = titsc_config_wires(ts_dev);
> @@ -462,6 +467,7 @@ static int titsc_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_free_irq:
> +	dev_pm_clear_wake_irq(tscadc_dev->dev);
>  	free_irq(ts_dev->irq, ts_dev);
>  err_free_mem:
>  	input_free_device(input_dev);
> @@ -474,6 +480,7 @@ static int titsc_remove(struct platform_device *pdev)
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

Thanks.

-- 
Dmitry

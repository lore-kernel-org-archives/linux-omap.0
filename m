From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/3] Input: ti_am335x_tsc - Ack pending IRQs at probe
 and before suspend
Date: Mon, 16 Apr 2018 10:59:09 -0700
Message-ID: <20180416175909.GC77055@dtor-ws>
References: <20180414095153.32060-1-vigneshr@ti.com>
 <20180414095153.32060-3-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180414095153.32060-3-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Sat, Apr 14, 2018 at 03:21:52PM +0530, Vignesh R wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> It is seen that just enabling the TSC module triggers a HW_PEN IRQ
> without any interaction with touchscreen by user. This results in first
> suspend/resume sequence to fail as system immediately wakes up from
> suspend as soon as HW_PEN IRQ is enabled in suspend handler due to the
> pending IRQ. Therefore clear all IRQs at probe and also in suspend

Are the interrupts configured as edge?

> callback for sanity.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> v2: Add Acks from v1.
> 
>  drivers/input/touchscreen/ti_am335x_tsc.c | 2 ++
>  include/linux/mfd/ti_am335x_tscadc.h      | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> index 810e05c9c4f5..dcd9db768169 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -439,6 +439,7 @@ static int titsc_probe(struct platform_device *pdev)
>  			dev_err(&pdev->dev, "irq wake enable failed.\n");
>  	}
>  
> +	titsc_writel(ts_dev, REG_IRQSTATUS, IRQENB_MASK);
>  	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_FIFO0THRES);
>  	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_EOS);

Out of curiosity, should this be:

	titsc_writel(ts_dev, REG_IRQENABLE,
			IRQENB_FIFO0THRES | IRQENB_EOS);

?

Because 2nd titsc_writel() overwrites the first? Or separate writes to
the same register are distinct?

>  	err = titsc_config_wires(ts_dev);
> @@ -504,6 +505,7 @@ static int __maybe_unused titsc_suspend(struct device *dev)
>  
>  	tscadc_dev = ti_tscadc_dev_get(to_platform_device(dev));
>  	if (device_may_wakeup(tscadc_dev->dev)) {
> +		titsc_writel(ts_dev, REG_IRQSTATUS, IRQENB_MASK);

The comment in titsc_irq() says that we should not be touching
IRQENB_FIFO0THRES as it is used by another driver, but here we are
whacking it. Can you elaborate why this is safe?

You might need to rework the interrupt handling since you have several
drivers...

>  		idle = titsc_readl(ts_dev, REG_IRQENABLE);
>  		titsc_writel(ts_dev, REG_IRQENABLE,
>  				(idle | IRQENB_HW_PEN));
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> index b9a53e013bff..1a6a34f726cc 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -63,6 +63,7 @@
>  #define IRQENB_FIFO1OVRRUN	BIT(6)
>  #define IRQENB_FIFO1UNDRFLW	BIT(7)
>  #define IRQENB_PENUP		BIT(9)
> +#define IRQENB_MASK		(0x7FF)
>  
>  /* Step Configuration */
>  #define STEPCONFIG_MODE_MASK	(3 << 0)
> -- 
> 2.17.0
> 

Thanks.

-- 
Dmitry

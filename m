From: "R, Vignesh" <vigneshr@ti.com>
Subject: Re: [PATCH] Input: ti_am335x_tsc - Mark IRQ as wakeup capable
Date: Fri, 6 May 2016 21:20:23 +0530
Message-ID: <572CBD3F.9010204@ti.com>
References: <1462529801-8986-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462529801-8986-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 5/6/2016 3:46 PM, Vignesh R wrote:
> On AM335x, ti_am335x_tsc can wake up the system from suspend, mark the
> IRQ as wakeup capable, so that device irq is not disabled during system
> suspend.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/input/touchscreen/ti_am335x_tsc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> index 8b3f15ca7725..423f275ffab8 100644
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
> +		if (err)
> +			dev_err(&pdev->dev, "irq wake enable failed.\n");
> +	}
> +

I forgot dev_pm_clear_wake_irq() here. Will repost, sorry for the noise.

Regards
Vignesh

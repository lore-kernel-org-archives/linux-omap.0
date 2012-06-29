From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] I2C: OMAP: fix runtime PM get/put balance on error
Date: Fri, 29 Jun 2012 07:02:21 -0500
Message-ID: <874npunx6a.fsf@ti.com>
References: <1340960868-7371-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340960868-7371-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
	(Shubhrajyoti D.'s message of "Fri, 29 Jun 2012 14:37:48 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:

>     ensure pm_runtime_put() is called, on pm_runtime_get_sync()
>     failure.
>
>     Without this, after a failed call, the runtime PM usecount will have
>     been incremented, but not decremented causing the usecount to never
>     reach zero after a failure. Thanks to Kevin for educating about it. 
>     While at it also fix a missing pm_runtime_disable in the probe error
>     path.

This is the same subject and changelog as the patch I sent, but is a
different patch.  

Please write a new subject and a changelog specific to your patch.

As this changes the error/failure path, please be specific about how
the failure modes were tested, and on which platforms.

> Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 2500f19..c8e5c76 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1113,10 +1113,10 @@ err_free_irq:
>  	free_irq(dev->irq, dev);
>  err_unuse_clocks:
>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> +err_free_mem:
>  	pm_runtime_put(dev->dev);
>  	iounmap(dev->base);

This doesn't look right.  At least one of the gotos for this label, the
ioremap has failed.

>  	pm_runtime_disable(&pdev->dev);
> -err_free_mem:
>  	platform_set_drvdata(pdev, NULL);
>  	kfree(dev);
>  err_release_region:
> @@ -1136,10 +1136,9 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
>  	free_irq(dev->irq, dev);
>  	i2c_del_adapter(&dev->adapter);
>  	ret = pm_runtime_get_sync(&pdev->dev);
> -	if (IS_ERR_VALUE(ret))
> -		return ret;
> +	if (!IS_ERR_VALUE(ret))
> +		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);

this change isn't described in changelog

> -	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>  	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  	iounmap(dev->base);

Kevin

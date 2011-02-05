From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c: OMAP: fix static suspend vs. runtime suspend
Date: Sat, 5 Feb 2011 16:08:43 +0000
Message-ID: <20110205160843.GD15795@trinity.fluff.org>
References: <1296173921-4832-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1296173921-4832-1-git-send-email-khilman-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 27, 2011 at 04:18:41PM -0800, Kevin Hilman wrote:
> When runtime PM is enabled, each OMAP i2c device is suspended after
> each i2c xfer.  However, there are two cases when the static suspend
> methods must be used to ensure the devices are suspended:
> 
> 1) runtime PM is disabled, either at compile time or dynamically
>     via /sys/devices/.../power/control.
> 2) an i2c client driver uses i2c during it's suspend callback, thus
>    leaving the i2c driver active (NOTE: runtime suspend transitions are
>    disabled during system suspend, so i2c activity during system
>    suspend will runtime resume the device, but not runtime (re)suspend it.)
> 
> Since the actual work to suspend the device is handled by the
> subsytem, call the bus methods to take care of it.
> 
> NOTE: This takes care of a known suspend problem on OMAP3 where the
> TWL RTC driver does i2c xfers during its suspend path leaving the i2c
> driver in an active state (since runtime suspend transistions are
> disabled.)
> 
> Signed-off-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
> ---
> Ben, this is a regression in 2.6.38 so hopefully this can be queued
> in the 2.6.38-rc cycle.  Thanks.

Ok, after all the discussions should I keep it in my -rc queue?
 
>  drivers/i2c/busses/i2c-omap.c |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index b605ff3..0541df9 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1137,12 +1137,40 @@ omap_i2c_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_SUSPEND
> +static int omap_i2c_suspend(struct device *dev)
> +{
> +	if (!pm_runtime_suspended(dev))
> +		if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend)
> +			dev->bus->pm->runtime_suspend(dev);
> +
> +	return 0;
> +}
> +
> +static int omap_i2c_resume(struct device *dev)
> +{
> +	if (!pm_runtime_suspended(dev))
> +		if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume)
> +			dev->bus->pm->runtime_resume(dev);
> +
> +	return 0;
> +}
> +
> +static struct dev_pm_ops omap_i2c_pm_ops = {
> +	.suspend = omap_i2c_suspend,
> +	.resume = omap_i2c_resume,
> +};
> +#else
> +#define omap_i2c_pm_ops NULL
> +#endif
> +
>  static struct platform_driver omap_i2c_driver = {
>  	.probe		= omap_i2c_probe,
>  	.remove		= omap_i2c_remove,
>  	.driver		= {
>  		.name	= "omap_i2c",
>  		.owner	= THIS_MODULE,
> +		.pm     = &omap_i2c_pm_ops,
>  	},
>  };
>  
> -- 
> 1.7.3.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.

From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH] I2C: Fix for suspend/resume issue in i2c-core
Date: Mon, 30 Aug 2010 11:43:23 -0700
Message-ID: <87wrr83pro.fsf@deeprootsystems.com>
References: <1283219414-8798-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1283219414-8798-1-git-send-email-vishwanath.bs-l0cyMroinI0@public.gmane.org>
	(Vishwanath BS's message of "Tue, 31 Aug 2010 07:20:14 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vishwanath BS <vishwanath.bs-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Partha Basak <p-basak2-l0cyMroinI0@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Vishwanath BS <vishwanath.bs-l0cyMroinI0@public.gmane.org> writes:

> In current i2c core driver, pm_runtime_set_active call from i2c_device_pm_resume
> is not balanced by pm_runtime_set_suspended call from i2c_device_pm_suspend.
> pm_runtime_set_active called from resume path will increase the child_count of
> the device's parent. However, matching pm_runtime_set_suspended is not called
> in suspend routine because of which child_count of the device's parent
> is not balanced, preventing the parent device to idle.
> Issue has been fixed by adding pm_runtime_set_suspended call inside suspend
> reoutine which will make sure that child_counts are balanced.
> This fix has been tested on OMAP4430.
>
> Signed-off-by: Partha Basak <p-basak2-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Vishwanath BS <vishwanath.bs-l0cyMroinI0@public.gmane.org>
>
> Cc: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>
> Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Also Cc'ing Mark Brown as original author of runtime PM for i2-core.

Kevin

> ---
>  drivers/i2c/i2c-core.c |   12 ++++++++++--
>  1 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 6649176..3146bff
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -196,14 +196,22 @@ static int i2c_legacy_resume(struct device *dev)
>  static int i2c_device_pm_suspend(struct device *dev)
>  {
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +	int ret;
>  
>  	if (pm_runtime_suspended(dev))
>  		return 0;
>  
>  	if (pm)
> -		return pm->suspend ? pm->suspend(dev) : 0;
> +		ret = pm->suspend ? pm->suspend(dev) : 0;
> +	else
> +		ret = i2c_legacy_suspend(dev, PMSG_SUSPEND);
>  
> -	return i2c_legacy_suspend(dev, PMSG_SUSPEND);
> +	if (!ret) {
> +		pm_runtime_disable(dev);
> +		pm_runtime_set_suspended(dev);
> +		pm_runtime_enable(dev);
> +	}
> +	return ret;
>  }
>  
>  static int i2c_device_pm_resume(struct device *dev)

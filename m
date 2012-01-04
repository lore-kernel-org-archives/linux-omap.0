From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH RFC] MFD: OMAP: USB: Make the runtime functions depend on CONFIG_PM_RUNTIME
Date: Tue, 03 Jan 2012 16:14:07 -0800
Message-ID: <874nwc8gts.fsf@ti.com>
References: <1325572979-6090-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1325572979-6090-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
	(Shubhrajyoti D.'s message of "Tue, 3 Jan 2012 12:12:59 +0530")
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:

> Currently the runtime functions are compiled regardless
> of CONFIG_PM_RUNTIME flag. This patch intends to fix the same by
> using SET_RUNTIME_PM_OPS.
>
> Cc : Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
> applies on Tony's ehci branch.
> Compile tested only.

You also should compile test this with runtime PM disabled.  I believe
the current patch will lead to 'function defined but not used' warnings.

Kevin

>  drivers/mfd/omap-usb-host.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 3f565ef..ef72ebe 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -887,8 +887,8 @@ static int __devexit usbhs_omap_remove(struct platform_device *pdev)
>  }
>  
>  static const struct dev_pm_ops usbhsomap_dev_pm_ops = {
> -	.runtime_suspend	= usbhs_runtime_suspend,
> -	.runtime_resume		= usbhs_runtime_resume,
> +	SET_RUNTIME_PM_OPS(usbhs_runtime_suspend,
> +				usbhs_runtime_resume, NULL)
>  };
>  
>  static struct platform_driver usbhs_omap_driver = {
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

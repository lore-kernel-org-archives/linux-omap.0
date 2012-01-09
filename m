From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH RFCv2] MFD: OMAP: USB: Make the runtime functions depend on CONFIG_PM_RUNTIME
Date: Mon, 09 Jan 2012 15:52:15 -0800
Message-ID: <87hb04xwls.fsf@ti.com>
References: <1326108657-23595-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:43005 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932158Ab2AIXwS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jan 2012 18:52:18 -0500
In-Reply-To: <1326108657-23595-1-git-send-email-shubhrajyoti@ti.com>
	(Shubhrajyoti D.'s message of "Mon, 9 Jan 2012 17:00:57 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> Currently the runtime functions are compiled regardless
> of CONFIG_PM_RUNTIME flag. This patch intends to fix the same by
> using SET_RUNTIME_PM_OPS.
>
> Cc : Keshava Munegowda <keshava_mgowda@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> applies on Tony's ehci branch.
> Compile tested only.

Lookd right to me:

Reviewed-by: Kevin Hilman <khilman@ti.com>

>  drivers/mfd/omap-usb-host.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 3f565ef..2896d6b 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -422,6 +422,7 @@ static void usbhs_omap_tll_init(struct device *dev, u8 tll_channel_count)
>  	}
>  }
>  
> +#ifdef CONFIG_PM_RUNTIME
>  static int usbhs_runtime_resume(struct device *dev)
>  {
>  	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
> @@ -489,6 +490,7 @@ static int usbhs_runtime_suspend(struct device *dev)
>  
>  	return 0;
>  }
> +#endif
>  
>  static void omap_usbhs_init(struct device *dev)
>  {
> @@ -887,8 +889,8 @@ static int __devexit usbhs_omap_remove(struct platform_device *pdev)
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

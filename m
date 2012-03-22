From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH RFC v2] usb: musb: omap: fix the error check for pm_runtime_get_sync
Date: Thu, 22 Mar 2012 10:36:19 -0700
Message-ID: <87k42ca67g.fsf@ti.com>
References: <1332422925-3212-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:33546 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754504Ab2CVRgV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Mar 2012 13:36:21 -0400
Received: by ghrr11 with SMTP id r11so1986121ghr.19
        for <linux-omap@vger.kernel.org>; Thu, 22 Mar 2012 10:36:19 -0700 (PDT)
In-Reply-To: <1332422925-3212-1-git-send-email-shubhrajyoti@ti.com>
	(Shubhrajyoti D.'s message of "Thu, 22 Mar 2012 18:58:45 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> pm_runtime_get_sync returns a signed integer.In case of errors
> it returns a negative value.This patch fixes the error check
> by making it signed instead of unsigned thus preventing register
> access if get_sync_fails. Also passes the error cause to the
> debug message.
>
> Cc :  Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> Compile tested only
>
>  drivers/usb/musb/omap2430.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 2ae0bb3..e5dd18f 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -282,7 +282,8 @@ static void musb_otg_notifier_work(struct work_struct *data_notifier_work)
>  
>  static int omap2430_musb_init(struct musb *musb)
>  {
> -	u32 l, status = 0;
> +	u32 l;
> +	int status = 0;

nit: you might as well drop the '= 0' assignment since it's not needed.

Otherwise, looks right to me.

Acked-by: Kevin Hilman <khilman@ti.com>

Kevin

>  	struct device *dev = musb->controller;
>  	struct musb_hdrc_platform_data *plat = dev->platform_data;
>  	struct omap_musb_board_data *data = plat->board_data;
> @@ -301,7 +302,7 @@ static int omap2430_musb_init(struct musb *musb)
>  
>  	status = pm_runtime_get_sync(dev);
>  	if (status < 0) {
> -		dev_err(dev, "pm_runtime_get_sync FAILED");
> +		dev_err(dev, "pm_runtime_get_sync FAILED %d\n", status);
>  		goto err1;
>  	}

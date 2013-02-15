From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [RFC/NOT FOR MERGING 1/3] arm: omap: use generic implementation if !od
Date: Fri, 15 Feb 2013 07:28:22 -0800
Message-ID: <871uch7g15.fsf@linaro.org>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33348 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755948Ab3BOP20 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Feb 2013 10:28:26 -0500
Received: by mail-pb0-f46.google.com with SMTP id uo15so646432pbc.5
        for <linux-omap@vger.kernel.org>; Fri, 15 Feb 2013 07:28:25 -0800 (PST)
In-Reply-To: <1360840554-26901-1-git-send-email-balbi@ti.com> (Felipe Balbi's
	message of "Thu, 14 Feb 2013 13:15:52 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hi Felipe,

Felipe Balbi <balbi@ti.com> writes:

> Eventually, we need to be able to remove
> ti,hwmods DT attribute (or at a minimum
> ignore it).
>
> For new platforms, this patch could enable
> the transition by not relying on ti,hwmods
> to have functioning PM and Idle implementation.
>
> Notice that this poses no differences for
> platforms which are already supported, it
> just gives us means of dropping the relyance
> on hwmod for new platforms.
>
> NYET-Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/mach-omap2/omap_device.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
> index e065daa..305eeb4 100644
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -796,13 +796,18 @@ static int __init omap_early_device_register(struct platform_device *pdev)
>  static int _od_runtime_suspend(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> +	struct omap_device *od = to_omap_device(pdev);
>  	int ret;
>  
>  	ret = pm_generic_runtime_suspend(dev);
>  
> +	if (!od)
> +		goto out;
> +

Rather than adding a check for every function, I think you will get the
effect by simply not hooking up the PM domain.

IOW, in omap_device_build_from_dt(), conditionalize:

	pdev->dev.pm_domain = &omap_device_pm_domain;

then none of the callbacks will be called in the first place, so they
won't need to be conditionalized.

Without a PM domain, they will fallback to the bus level hooks, which in
this case will be the platform_bus hooks, which will just call the
pm_generic functions.

Kevin

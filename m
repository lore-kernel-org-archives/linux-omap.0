From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP3: don't init PM on AM35{05,17}
Date: Tue, 03 Jan 2012 15:37:55 -0800
Message-ID: <87lipo8ii4.fsf@ti.com>
References: <4EEE80DE.8040001@emcraft.com>
	<1324339251-10764-1-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:47747 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752312Ab2ACXiA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jan 2012 18:38:00 -0500
Received: by mail-iy0-f181.google.com with SMTP id k12so34671224iak.40
        for <linux-omap@vger.kernel.org>; Tue, 03 Jan 2012 15:37:59 -0800 (PST)
In-Reply-To: <1324339251-10764-1-git-send-email-yanok@emcraft.com> (Ilya
	Yanok's message of "Tue, 20 Dec 2011 01:00:51 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-omap@vger.kernel.org

Ilya Yanok <yanok@emcraft.com> writes:

> Current OMAP3 PM code seems to be incompatible with AM35{05,17} and
> leads to system hang during boot.
> Disable PM init on AM35{05,17} until working implementation will be
> merged.

Were you able to find out where exactly things got hung up?

We're trying hard to avoid adding more cpu_is_* checks so would like to
better understand the problem before merging such a fix.

Thanks,

Kevin

> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> ---
> This patch solves the problem for me but I'm curious why simple
> CONFIG_PM disabling doesn't work? I'm getting
> Unhandled fault: external abort on non-linefetch
> while trying to access absolutely valid register from omapdss/venc
> driver. I've tried to disable VENC but then I got the same error
> from omap_wdt driver. Is it supposed to be so? Are !CONFIG_PM
> configurations supported? How comes that disabling CONFIG_PM
> makes some registers inaccessible?
>
> Regards, Ilya.
>
>  arch/arm/mach-omap2/pm34xx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index fc69875..0f30742 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -790,7 +790,7 @@ static int __init omap3_pm_init(void)
>  	struct clockdomain *neon_clkdm, *per_clkdm, *mpu_clkdm, *core_clkdm;
>  	int ret;
>  
> -	if (!cpu_is_omap34xx())
> +	if (!cpu_is_omap34xx() || cpu_is_omap3505() || cpu_is_omap3517())
>  		return -ENODEV;
>  
>  	if (!omap3_has_io_chain_ctrl())

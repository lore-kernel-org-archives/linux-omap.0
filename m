From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 12/19] omap3+: sr: disable interrupt by default
Date: Wed, 02 Mar 2011 16:15:15 -0800
Message-ID: <8739n5vz3g.fsf@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>
	<1298116918-30744-13-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:37098 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754487Ab1CCAPU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 19:15:20 -0500
Received: by yia13 with SMTP id 13so187059yia.30
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 16:15:18 -0800 (PST)
In-Reply-To: <1298116918-30744-13-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sat, 19 Feb 2011 17:31:51 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Nishanth Menon <nm@ti.com> writes:

> We will enable and disable interrupt on a need basis in the class
> driver. we need to keep the irq disabled by default else the
> forceupdate or vcbypass events could trigger events that we dont
> need/expect to handle.

It's not clear from the patch where the IRQ is re-enabled.  For example,
without knowing better, I would expect a corresponding change to the
Class 3 driver to enable/disable the IRQ as needed.

Kevin


> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/smartreflex.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 7931fcd..9c61ab0 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -281,6 +281,7 @@ static int sr_late_init(struct omap_sr *sr_info)
>  				IRQF_DISABLED, name, (void *)sr_info);
>  		if (ret)
>  			goto error;
> +		disable_irq(sr_info->irq);
>  	}
>  
>  	if (pdata && pdata->enable_on_init)

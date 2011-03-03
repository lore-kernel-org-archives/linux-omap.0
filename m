From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 11/19] omap3+: sr: call handler with interrupt disabled
Date: Wed, 02 Mar 2011 16:11:00 -0800
Message-ID: <87fwr5vzaj.fsf@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>
	<1298116918-30744-12-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:59978 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752118Ab1CCALF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 19:11:05 -0500
Received: by gwj23 with SMTP id 23so245793gwj.15
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 16:11:03 -0800 (PST)
In-Reply-To: <1298116918-30744-12-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sat, 19 Feb 2011 17:31:50 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Nishanth Menon <nm@ti.com> writes:

> Request the handler irq such that there is no nesting for calls.
> the notifiers are not expected to be nested, further the interrupt
> events for status change should be handled prior to the next event
> else there is a risk of loosing events.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

IRQs disabled interrupt handlers are soon to disappear in the kernel.

This kind of thing should be handled using locking, most likely IRQs
disabled spinlocks.

Kevin

> ---
>  arch/arm/mach-omap2/smartreflex.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 1fe8b95..7931fcd 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -278,7 +278,7 @@ static int sr_late_init(struct omap_sr *sr_info)
>  			goto error;
>  		}
>  		ret = request_irq(sr_info->irq, sr_interrupt,
> -				0, name, (void *)sr_info);
> +				IRQF_DISABLED, name, (void *)sr_info);
>  		if (ret)
>  			goto error;
>  	}

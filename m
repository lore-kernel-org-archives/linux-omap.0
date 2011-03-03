From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 16/19] omap3+: sr: disable spamming interrupts
Date: Wed, 02 Mar 2011 16:21:51 -0800
Message-ID: <87pqq9uk80.fsf@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>
	<1298116918-30744-17-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:52865 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752608Ab1CCAVy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 19:21:54 -0500
Received: by mail-iw0-f172.google.com with SMTP id 42so436024iwl.3
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 16:21:53 -0800 (PST)
In-Reply-To: <1298116918-30744-17-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sat, 19 Feb 2011 17:31:55 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Nishanth Menon <nm@ti.com> writes:

> At times with bad SR configurations especially during silicon bringups,
> we could get continuous spurious interrupts which end up hanging the
> platform in the form of an ISR call for status bits that are
> automatically enabled by the h/w without any s/w clearing option.
>
> If we detect scenarios where isr was called without the corresponding

minor: please capitalize ISR consistently throughout.

> notification bit being set, instead of hanging up the system,
> we will disable interrupt after noting the event in the system log
> to try and keep system sanity and allow developer to debug and fix
> the condition.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

otherwise, patch looks fine.

Kevin

> ---
>  arch/arm/mach-omap2/smartreflex.c |   12 ++++++++++--
>  1 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index ad23b8d..0301186 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -209,8 +209,16 @@ static irqreturn_t sr_interrupt(int irq, void *data)
>  		value = irqstat_to_notifier_v2(status);
>  	}
>  
> -	if (sr_class->notify)
> -		sr_class->notify(sr_info->voltdm, value);
> +	/* Attempt some resemblence of recovery! */
> +	if (!value) {
> +		dev_err(&sr_info->pdev->dev, "%s: Spurious interrupt!"
> +			"status = 0x%08x. Disabling to prevent spamming!!\n",
> +			__func__, status);
> +		disable_irq_nosync(sr_info->irq);
> +	} else {
> +		if (sr_class->notify)
> +			sr_class->notify(sr_info->voltdm, value);
> +	}
>  
>  	return IRQ_HANDLED;
>  }

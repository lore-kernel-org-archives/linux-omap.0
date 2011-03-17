From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V3 08/19] OMAP3+: SR: make notify independent of class
Date: Thu, 17 Mar 2011 10:18:14 -0700
Message-ID: <87mxkt8y3t.fsf@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
	<1299338962-5602-9-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:55826 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751846Ab1CQRS0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 13:18:26 -0400
Received: by mail-yx0-f173.google.com with SMTP id 8so1285248yxk.32
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 10:18:22 -0700 (PDT)
In-Reply-To: <1299338962-5602-9-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sat, 5 Mar 2011 20:59:11 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>

Nishanth Menon <nm@ti.com> writes:

> Interrupt notification mechanism of SmartReflex can be used by the
> choice of implementation of the class driver. For example, Class 2 and
> Class 1.5 of SmartReflex can both use the interrupt notification to
> identify the transition of voltage or other events.
>
> Hence, the actual class does not matter for notifier. Let the class
> driver's handling decide how it should be used. SmartReflex driver
> should provide just the primitives.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks, queuing for 2.6.40 (branch: for_2.6.40/pm-misc)

Kevin

> ---
>  arch/arm/mach-omap2/smartreflex.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 2566552..7096300 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -142,7 +142,7 @@ static irqreturn_t sr_interrupt(int irq, void *data)
>  		sr_write_reg(sr_info, IRQSTATUS, status);
>  	}
>  
> -	if (sr_class->class_type == SR_CLASS2 && sr_class->notify)
> +	if (sr_class->notify)
>  		sr_class->notify(sr_info->voltdm, status);
>  
>  	return IRQ_HANDLED;
> @@ -257,9 +257,7 @@ static int sr_late_init(struct omap_sr *sr_info)
>  	struct resource *mem;
>  	int ret = 0;
>  
> -	if (sr_class->class_type == SR_CLASS2 &&
> -		sr_class->notify_flags && sr_info->irq) {
> -
> +	if (sr_class->notify && sr_class->notify_flags && sr_info->irq) {
>  		name = kasprintf(GFP_KERNEL, "sr_%s", sr_info->voltdm->name);
>  		if (name == NULL) {
>  			ret = -ENOMEM;

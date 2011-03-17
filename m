From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V3 09/19] OMAP3+: SR: disable interrupt by default
Date: Thu, 17 Mar 2011 10:19:31 -0700
Message-ID: <87hbb18y1o.fsf@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
	<1299338962-5602-10-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:54421 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754850Ab1CQRTe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 13:19:34 -0400
Received: by mail-iy0-f170.google.com with SMTP id 12so3688912iyb.15
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 10:19:33 -0700 (PDT)
In-Reply-To: <1299338962-5602-10-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sat, 5 Mar 2011 20:59:12 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>

Nishanth Menon <nm@ti.com> writes:

> We will enable and disable interrupt on a need basis in the class
> driver. We need to keep the IRQ disabled by default else the
> forceupdate or vcbypass events could trigger events that we don't
> need/expect to handle.
>
> This is a preparation for SmartReflex AVS class drivers such as
> class 2 and class 1.5 which would need to use interrupts. Existing
> SmartReflex AVS class 3 driver does not require to use interrupts
> and is not impacted by this change.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks, queueing for 2.6.40

Kevin

> ---
>  arch/arm/mach-omap2/smartreflex.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 7096300..f9057ad 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -267,6 +267,7 @@ static int sr_late_init(struct omap_sr *sr_info)
>  				0, name, (void *)sr_info);
>  		if (ret)
>  			goto error;
> +		disable_irq(sr_info->irq);
>  	}
>  
>  	if (pdata && pdata->enable_on_init)

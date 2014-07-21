From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 3/7] ARM: OMAP4+: PRM: remove "wkup" event
Date: Mon, 21 Jul 2014 03:44:14 -0700
Message-ID: <20140721104413.GT18374@atomide.com>
References: <1402025761-16831-1-git-send-email-nm@ti.com>
 <1402025761-16831-4-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:59727 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754324AbaGUKpl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jul 2014 06:45:41 -0400
Content-Disposition: inline
In-Reply-To: <1402025761-16831-4-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [140605 20:37]:
> "wkup" event at bit offset 0 exists only on OMAP3.
> OMAP4430/60 PRM_IRQSTATUS_A9, OMAP5/DRA7 PRM_IRQSTATUS_MPU
> 
> register bit 0 is DPLL_CORE_RECAL_ST not wakeup event like OMAP3.

Hmm so why was it added originally then?

Do the PRM_IRQSTATUS line and the following line belong together
or is it missing something?

Regards,

Tony
 
> The same applies to AM437x as well.
> 
> Remove the wrong definition.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/prm44xx.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
> index d4d745e..1ecf244 100644
> --- a/arch/arm/mach-omap2/prm44xx.c
> +++ b/arch/arm/mach-omap2/prm44xx.c
> @@ -32,7 +32,6 @@
>  /* Static data */
>  
>  static const struct omap_prcm_irq omap4_prcm_irqs[] = {
> -	OMAP_PRCM_IRQ("wkup",   0,      0),
>  	OMAP_PRCM_IRQ("io",     9,      1),
>  };
>  
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

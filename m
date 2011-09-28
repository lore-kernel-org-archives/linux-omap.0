From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: irq: loop counter fix in omap_init_irq()
Date: Wed, 28 Sep 2011 11:20:36 -0700
Message-ID: <20110928182035.GZ6324@atomide.com>
References: <20110722115810.34f963ad@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26168 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab1I1SUi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Sep 2011 14:20:38 -0400
Content-Disposition: inline
In-Reply-To: <20110722115810.34f963ad@myhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tapani Utriainen <tapani@technexion.com>
Cc: linux-omap@vger.kernel.org

* Tapani Utriainen <tapani@technexion.com> [110721 20:58]:
> From: Tapani Utriainen <tapani@technexion.com>
> 
> Fixes bug where variable i was redundantly used for counting two nested loops.

Thanks & sorry for the delay. Adding this into fixes.

Tony
 
> Signed-off-by: Tapani Utriainen <tapani@technexion.com>
> --- 
>  irq.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -165,8 +165,8 @@ static void __init omap_init_irq(u32 base, int nr_irqs)
>  
>  		omap_irq_bank_init_one(bank);
>  
> -		for (i = 0, j = 0; i < bank->nr_irqs; i += 32, j += 0x20)
> -			omap_alloc_gc(bank->base_reg + j, i, 32);
> +		for (j = 0; j < bank->nr_irqs; j += 32)
> +			omap_alloc_gc(bank->base_reg + j, j, 32);
>  
>  		nr_of_irqs += bank->nr_irqs;
>  		nr_banks++;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

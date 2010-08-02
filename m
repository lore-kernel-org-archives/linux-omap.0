From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] omap4: l2x0: Override the default l2x0_disable
Date: Mon, 2 Aug 2010 16:12:49 +0300
Message-ID: <20100802131246.GM12293@atomide.com>
References: <1280598348-4721-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54549 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab0HBNMu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Aug 2010 09:12:50 -0400
Content-Disposition: inline
In-Reply-To: <1280598348-4721-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [100731 20:38]:
> The machine_kexec() calls outer_disable which can crash on OMAP4
> becasue of trustzone restrictions.
> 
> This patch overrides the default l2x0_disable with a OMAP4
> specific implementation taking care of trustzone

Do you need different handling on GP omaps compared to HS omaps?

Tony
 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/omap4-common.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> index 13dc979..b557cc2 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -44,6 +44,13 @@ void __init gic_init_irq(void)
>  }
>  
>  #ifdef CONFIG_CACHE_L2X0
> +
> +static void omap4_l2x0_disable(void)
> +{
> +	/* Disable PL310 L2 Cache controller */
> +	omap_smc1(0x102, 0x0);
> +}
> +
>  static int __init omap_l2_cache_init(void)
>  {
>  	/*
> @@ -66,6 +73,12 @@ static int __init omap_l2_cache_init(void)
>  	 */
>  	l2x0_init(l2cache_base, 0x0e050000, 0xc0000fff);
>  
> +	/*
> +	 * Override default outer_cache.disable with a OMAP4
> +	 * specific one
> +	*/
> +	outer_cache.disable = omap4_l2x0_disable;
> +
>  	return 0;
>  }
>  early_initcall(omap_l2_cache_init);
> -- 
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

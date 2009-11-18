From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/8] OMAP3: clock: add clockdomains for UART1 & 2
Date: Wed, 18 Nov 2009 03:58:20 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0911180357440.25515@utopia.booyaka.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46672 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835AbZKRK6P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 05:58:15 -0500
In-Reply-To: <1258506313-17115-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin,

On Tue, 17 Nov 2009, Kevin Hilman wrote:

> UART1 & 2 were missing clockdomains resulting in broken omap_hwmod
> init for these devices.

also looks good, will add this to the fixes series.

- Paul

> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/clock34xx.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
> index a1b3de7..cbc3d8a 100644
> --- a/arch/arm/mach-omap2/clock34xx.h
> +++ b/arch/arm/mach-omap2/clock34xx.h
> @@ -1507,6 +1507,7 @@ static struct clk uart2_fck = {
>  	.parent		= &core_48m_fck,
>  	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
>  	.enable_bit	= OMAP3430_EN_UART2_SHIFT,
> +	.clkdm_name	= "core_l4_clkdm",
>  	.recalc		= &followparent_recalc,
>  };
>  
> @@ -1516,6 +1517,7 @@ static struct clk uart1_fck = {
>  	.parent		= &core_48m_fck,
>  	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
>  	.enable_bit	= OMAP3430_EN_UART1_SHIFT,
> +	.clkdm_name	= "core_l4_clkdm",
>  	.recalc		= &followparent_recalc,
>  };
>  
> -- 
> 1.6.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 



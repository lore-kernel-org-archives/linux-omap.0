From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: allow DEBUG_UNCOMPRESS for OMAP2+
Date: Fri, 19 Feb 2016 10:02:38 -0800
Message-ID: <20160219180237.GI21202@atomide.com>
References: <1451362159-27910-1-git-send-email-sdliyong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1451362159-27910-1-git-send-email-sdliyong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Li <sdliyong@gmail.com>
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Yong Li <sdliyong@gmail.com> [151228 20:12]:
> Based on the below
> commit ae3c99a26c60 ("ARM: 7806/1: allow DEBUG_UNCOMPRESS for Tegra"),
> change the .data section to .text section,
> to enable DEBUG_UNCOMPRESS for OMAP2+ platforms
> Tested okay using BeagleBone Black

Sorry for the delay, I just noticed this one while looking
through my inbox for pending patches.

I think we should first simplify things by moving things over
to use the generic DEBUG_UART_8250 code where the addresses
need to be specified in the .config. It's been on my list of
things to do for quite a while but I keep getting interrupted.

My guess is that if we do that, this patch is no longer
needed :) Yong, care to take a look at that?

Regards,

Tony

> Signed-off-by: Yong Li <sdliyong@gmail.com>
> ---
>  arch/arm/Kconfig.debug             |  2 +-
>  arch/arm/include/debug/omap2plus.S | 13 ++++++++++---
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 259c0ca..e5ae36a 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1596,7 +1596,7 @@ config DEBUG_UART_8250_FLOW_CONTROL
>  config DEBUG_UNCOMPRESS
>  	bool
>  	depends on ARCH_MULTIPLATFORM || PLAT_SAMSUNG || ARM_SINGLE_ARMV7M
> -	default y if DEBUG_LL && !DEBUG_OMAP2PLUS_UART && \
> +	default y if DEBUG_LL && (!DEBUG_OMAP2PLUS_UART || !ZBOOT_ROM) && \
>  		     (!DEBUG_TEGRA_UART || !ZBOOT_ROM)
>  	help
>  	  This option influences the normal decompressor output for
> diff --git a/arch/arm/include/debug/omap2plus.S b/arch/arm/include/debug/omap2plus.S
> index 6d867ae..12421f9 100644
> --- a/arch/arm/include/debug/omap2plus.S
> +++ b/arch/arm/include/debug/omap2plus.S
> @@ -58,11 +58,18 @@
>  
>  #define UART_OFFSET(addr)	((addr) & 0x00ffffff)
>  
> +#if defined(ZIMAGE)
> +	omap_uart_phys:	.word	0
> +	omap_uart_virt:	.word	0
> +	omap_uart_lsr:	.word	0
> +#else
> +
>  		.pushsection .data
> -omap_uart_phys:	.word	0
> -omap_uart_virt:	.word	0
> -omap_uart_lsr:	.word	0
> +	omap_uart_phys:	.word	0
> +	omap_uart_virt:	.word	0
> +	omap_uart_lsr:	.word	0
>  		.popsection
> +#endif
>  
>  		.macro	addruart, rp, rv, tmp
>  
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

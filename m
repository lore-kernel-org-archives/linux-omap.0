From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] ARM: OMAP2+: Remove MACH_NOKIA_N800
Date: Sun, 9 Feb 2014 21:50:21 +0200
Message-ID: <20140209195021.GE573@drone.musicnaut.iki.fi>
References: <1391958088.25424.17.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1391958088.25424.17.camel@x220>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Sun, Feb 09, 2014 at 04:01:28PM +0100, Paul Bolle wrote:
> The last caller of machine_is_nokia_n800() was removed in commit
> 5a87cde490e1 ("ARM: OMAP2+: Remove legacy booting support for n8x0").
> That means that the Kconfig symbol MACH_NOKIA_N800 is now unused. It can
> safely be removed.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> ---
> Untested.
> 
>  arch/arm/mach-omap2/Kconfig | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 653b489..66da3f5 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -268,9 +268,6 @@ config MACH_OMAP_3430SDP
>  	default y
>  	select OMAP_PACKAGE_CBB
>  
> -config MACH_NOKIA_N800
> -       bool
> -
>  config MACH_NOKIA_N810
>         bool
>  
> @@ -281,7 +278,6 @@ config MACH_NOKIA_N8X0
>  	bool "Nokia N800/N810"
>  	depends on SOC_OMAP2420
>  	default y
> -	select MACH_NOKIA_N800
>  	select MACH_NOKIA_N810
>  	select MACH_NOKIA_N810_WIMAX
>  	select OMAP_PACKAGE_ZAC
> -- 
> 1.8.5.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

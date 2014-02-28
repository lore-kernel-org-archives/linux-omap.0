From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap: remove OMAP_PACKAGE_ZAC and OMAP_PACKAGE_ZAF
Date: Fri, 28 Feb 2014 15:38:17 -0800
Message-ID: <20140228233817.GZ13624@atomide.com>
References: <1392576697.28866.27.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392576697.28866.27.camel@x220>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Russell King <linux@arm.linux.org.uk>, Richard Weinberger <richard@nod.at>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Paul Bolle <pebolle@tiscali.nl> [140216 10:54]:
> The Kconfig symbols OMAP_PACKAGE_ZAC and OMAP_PACKAGE_ZAF were added in
> v2.6.36. They have never been used. Setting them has no effect. These
> symbols can safely be removed.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Tested with "git grep".

Thanks applying into omap-for-v3.15/soc with the related entries also
removed from arch/arm/mach-omap2/mux.h.

Regards,

Tony
 
> A sort of related cleanup would be removing the preprocessoer defines of
> OMAP_PACKAGE_ZAC and OMAP_PACKAGE_ZAF that are unused since v3.14-rc1.
> 
>  arch/arm/mach-omap2/Kconfig | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 7d4934e..bb51eeb 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -165,12 +165,6 @@ config SOC_TI81XX
>  	depends on ARCH_OMAP3
>  	default y
>  
> -config OMAP_PACKAGE_ZAF
> -       bool
> -
> -config OMAP_PACKAGE_ZAC
> -       bool
> -
>  config OMAP_PACKAGE_CBC
>         bool
>  
> @@ -280,7 +274,6 @@ config MACH_NOKIA_N8X0
>  	default y
>  	select MACH_NOKIA_N810
>  	select MACH_NOKIA_N810_WIMAX
> -	select OMAP_PACKAGE_ZAC
>  
>  config MACH_NOKIA_RX51
>  	bool "Nokia N900 (RX-51) phone"
> -- 
> 1.8.5.3
> 

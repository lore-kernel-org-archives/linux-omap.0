From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RFC 4/6] ARM: OMAP2+: AM43x/AM335x: have reset
 controller
Date: Tue, 8 Oct 2013 11:17:24 -0700
Message-ID: <20131008181723.GG8313@atomide.com>
References: <cover.1378129416.git.afzal@ti.com>
 <54ef6f33272dfe2bbf3596da05579a7305fb0cff.1378129416.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:55308 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752957Ab3JHSR0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Oct 2013 14:17:26 -0400
Content-Disposition: inline
In-Reply-To: <54ef6f33272dfe2bbf3596da05579a7305fb0cff.1378129416.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>

* Afzal Mohammed <afzal@ti.com> [130902 07:27]:
> AM43x, AM335x have reset block as part of prcm, let reset driver be
> usable with these SoC's.

Once the driver is ready, this can be merged along with the 
reset driver:

Acked-by: Tony Lindgren <tony@atomide.com>
 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 3eed000..fa28d1d 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -72,6 +72,7 @@ config SOC_AM33XX
>  	select CPU_V7
>  	select MULTI_IRQ_HANDLER
>  	select COMMON_CLK
> +	select ARCH_HAS_RESET_CONTROLLER
>  
>  config SOC_AM43XX
>  	bool "TI AM43x"
> @@ -82,6 +83,7 @@ config SOC_AM43XX
>  	select ARM_GIC
>  	select COMMON_CLK
>  	select MACH_OMAP_GENERIC
> +	select ARCH_HAS_RESET_CONTROLLER
>  
>  config ARCH_OMAP2PLUS
>  	bool
> -- 
> 1.8.3.4
> 

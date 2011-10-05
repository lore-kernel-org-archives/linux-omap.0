From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 5/4] ARM: OMAP: Move set_globals initialization to happen
 in init_early
Date: Tue, 04 Oct 2011 21:51:07 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1110042150190.9106@xanadu.home>
References: <20111005004339.26980.31149.stgit@kaulin.local>
 <20111005014044.GZ6324@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:62150 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757658Ab1JEBvI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 21:51:08 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR002.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LSK001ETKVCVD40@VL-VM-MR002.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Tue, 04 Oct 2011 21:45:12 -0400 (EDT)
In-reply-to: <20111005014044.GZ6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, 4 Oct 2011, Tony Lindgren wrote:

> Otherwise we can't do generic map_io as we currently rely on
> static mappings that work only because of arch_ioremap.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

That's great.

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

> diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
> index e26c79c..e6ee884 100644
> --- a/arch/arm/mach-omap2/board-ti8168evm.c
> +++ b/arch/arm/mach-omap2/board-ti8168evm.c
> @@ -37,7 +37,6 @@ static void __init ti8168_evm_init(void)
>  
>  static void __init ti8168_evm_map_io(void)
>  {
> -	omap2_set_globals_ti816x();
>  	omapti816x_map_common_io();
>  }
>  
> diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
> index de61f15..f19a332 100644
> --- a/arch/arm/mach-omap2/common.c
> +++ b/arch/arm/mach-omap2/common.c
> @@ -59,7 +59,6 @@ void __init omap2_set_globals_242x(void)
>  
>  void __init omap242x_map_io(void)
>  {
> -	omap2_set_globals_242x();
>  	omap242x_map_common_io();
>  }
>  #endif
> @@ -83,7 +82,6 @@ void __init omap2_set_globals_243x(void)
>  
>  void __init omap243x_map_io(void)
>  {
> -	omap2_set_globals_243x();
>  	omap243x_map_common_io();
>  }
>  #endif
> @@ -107,7 +105,6 @@ void __init omap2_set_globals_3xxx(void)
>  
>  void __init omap3_map_io(void)
>  {
> -	omap2_set_globals_3xxx();
>  	omap34xx_map_common_io();
>  }
>  
> @@ -153,7 +150,6 @@ void __init omap2_set_globals_443x(void)
>  
>  void __init omap4_map_io(void)
>  {
> -	omap2_set_globals_443x();
>  	omap44xx_map_common_io();
>  }
>  #endif
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 4957554..527abdd 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -44,6 +44,7 @@
>  #include "clockdomain.h"
>  #include <plat/omap_hwmod.h>
>  #include <plat/multi.h>
> +#include <plat/common.h>
>  
>  /*
>   * The machine specific code may provide the extra mapping besides the
> @@ -363,6 +364,7 @@ static void __init omap_hwmod_init_postsetup(void)
>  
>  void __init omap2420_init_early(void)
>  {
> +	omap2_set_globals_242x();
>  	omap_common_init_early();
>  	omap2xxx_voltagedomains_init();
>  	omap242x_powerdomains_init();
> @@ -374,6 +376,7 @@ void __init omap2420_init_early(void)
>  
>  void __init omap2430_init_early(void)
>  {
> +	omap2_set_globals_243x();
>  	omap_common_init_early();
>  	omap2xxx_voltagedomains_init();
>  	omap243x_powerdomains_init();
> @@ -389,6 +392,7 @@ void __init omap2430_init_early(void)
>   */
>  void __init omap3_init_early(void)
>  {
> +	omap2_set_globals_3xxx();
>  	omap_common_init_early();
>  	omap3xxx_voltagedomains_init();
>  	omap3xxx_powerdomains_init();
> @@ -420,11 +424,19 @@ void __init am35xx_init_early(void)
>  
>  void __init ti816x_init_early(void)
>  {
> -	omap3_init_early();
> +	omap2_set_globals_ti816x();
> +	omap_common_init_early();
> +	omap3xxx_voltagedomains_init();
> +	omap3xxx_powerdomains_init();
> +	omap3xxx_clockdomains_init();
> +	omap3xxx_hwmod_init();
> +	omap_hwmod_init_postsetup();
> +	omap3xxx_clk_init();
>  }
>  
>  void __init omap4430_init_early(void)
>  {
> +	omap2_set_globals_443x();
>  	omap_common_init_early();
>  	omap44xx_voltagedomains_init();
>  	omap44xx_powerdomains_init();
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

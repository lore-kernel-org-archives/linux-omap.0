From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Added support for OMAP35x processor series
Date: Tue, 5 Aug 2008 12:25:25 +0300
Message-ID: <20080805092523.GK7193@atomide.com>
References: <premi@ti.com> <1217591379-1515-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51878 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896AbYHEJZ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 05:25:28 -0400
Content-Disposition: inline
In-Reply-To: <1217591379-1515-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

* Sanjeev Premi <premi@ti.com> [080801 14:50]:
> This patch adds basic support for the OMAP35x Applications Processors.
> (See: http://focus.ti.com/general/docs/gencontent.tsp?contentId=46725)
> 
> As you will notice, NEON SIMD coprocessor is enabled by default for
> these processors.

Do we really need this? To me it seems like our CPU detection should
figure out the processor is 34xx and specifically 35xx something.

Are there Cortex A8 processors with no Neon hardware?

Tony


> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig |   50 ++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 49 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index bb6d695..63d7cdd 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -25,6 +25,54 @@ config ARCH_OMAP3430
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
>  	select ARCH_OMAP_OTG
>  
> +config ARCH_OMAP35XX
> +	bool "OMAP35x Family"
> +	select ARCH_OMAP3
> +	select ARCH_OMAP34XX
> +	select ARCH_OMAP3430
> +	select OMAP3430_ES2
> +	select NEON
> +	help
> +	  OMAP35x family of processors based on ARM Cortex-A8
> +	  in combination with IVA2.2 core and OpenGL ES2.0
> +	  compatible graphics engine.
> +
> +	  ARM Cortex-A8 contains NEON SIMD coprocessor.
> +
> +choice
> +	prompt "Current choice"
> +	default ARCH_OMAP3503
> +
> +config ARCH_OMAP3503
> +	bool "OMAP3503"
> +	depends on ARCH_OMAP35XX
> +	help
> +	  Contains ARM Cortex-A8 processor.
> +
> +config ARCH_OMAP3515
> +	bool "OMAP3515"
> +	depends on ARCH_OMAP35XX
> +	help
> +	   Contains ARM Cortex-A8 processor and SGX530 subsystem
> +	   for 2D and 3D graphics acceleration.
> +
> +config ARCH_OMAP3525
> +	bool "OMAP3525"
> +	depends on ARCH_OMAP35XX
> +	help
> +	  Contains ARM Cortex-A8 processor and IVA2.2 subsystem
> +	  with a C64x+ DSP core.
> +
> +config ARCH_OMAP3530
> +	bool "OMAP3530"
> +	depends on ARCH_OMAP35XX
> +	help
> +	   Contains ARM Cortex-A8 processor, IVA2.2 subsystem
> +	   with a C64x+ DSP Core and SGX530 subsystem for 2D
> +	   and 3D graphics acceleration.
> +
> +endchoice
> +
>  comment "OMAP Board Type"
>  	depends on ARCH_OMAP2 || ARCH_OMAP3
>  
> @@ -117,7 +165,7 @@ config MACH_OMAP_3430SDP
>  
>  config MACH_OMAP3EVM
>  	bool "OMAP 3530 EVM board"
> -	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> +	depends on ARCH_OMAP35XX
>  
>  config MACH_OMAP3_BEAGLE
>  	bool "OMAP3 BEAGLE board"
> -- 
> 1.5.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

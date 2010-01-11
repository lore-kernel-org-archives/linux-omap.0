From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/6] Regulator: Kconfig modified to select TWL4030 for
 OMAP3 based platforms
Date: Mon, 11 Jan 2010 14:39:38 -0800
Message-ID: <20100111223938.GC5055@atomide.com>
References: <1262973491-32648-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56070 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab0AKWjd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 17:39:33 -0500
Content-Disposition: inline
In-Reply-To: <1262973491-32648-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk

* Anuj Aggarwal <anuj.aggarwal@ti.com> [100108 09:57]:
> Kconfig is modified so that PMIC TWL4030 is automatically selected for
> platforms using it. It is required to compile board-omap35x-twl4030-pmic.c
> in the build.

Please group the patches in a way that compile works for each patch
in the series.  Otherwise git bisect will break.

Regards,

Tony

 
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 95b8eb2..ab3abc9 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -66,16 +66,19 @@ config MACH_OMAP3_BEAGLE
>  	bool "OMAP3 BEAGLE board"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
>  	select OMAP_PACKAGE_CBB
> +	select PMIC_TWL4030
>  
>  config MACH_OMAP_LDP
>  	bool "OMAP3 LDP board"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
>  	select OMAP_PACKAGE_CBB
> +	select PMIC_TWL4030
>  
>  config MACH_OVERO
>  	bool "Gumstix Overo board"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
>  	select OMAP_PACKAGE_CBB
> +	select PMIC_TWL4030
>  
>  config MACH_OMAP3EVM
>  	bool "OMAP 3530 EVM board"
> @@ -100,16 +103,19 @@ config MACH_OMAP3_PANDORA
>  	bool "OMAP3 Pandora"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
>  	select OMAP_PACKAGE_CBB
> +	select PMIC_TWL4030
>  
>  config MACH_OMAP3_TOUCHBOOK
>  	bool "OMAP3 Touch Book"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
>  	select BACKLIGHT_CLASS_DEVICE
> +	select PMIC_TWL4030
>  
>  config MACH_OMAP_3430SDP
>  	bool "OMAP 3430 SDP board"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
>  	select OMAP_PACKAGE_CBB
> +	select PMIC_TWL4030
>  
>  config MACH_NOKIA_N800
>         bool
> @@ -136,27 +142,32 @@ config MACH_OMAP_ZOOM2
>  	bool "OMAP3 Zoom2 board"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
>  	select OMAP_PACKAGE_CBB
> +	select PMIC_TWL4030
>  
>  config MACH_OMAP_ZOOM3
>  	bool "OMAP3630 Zoom3 board"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
>  	select OMAP_PACKAGE_CBP
> +	select PMIC_TWL4030
>  
>  config MACH_CM_T35
>  	bool "CompuLab CM-T35 module"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
>  	select OMAP_PACKAGE_CUS
>  	select OMAP_MUX
> +	select PMIC_TWL4030
>  
>  config MACH_IGEP0020
>  	bool "IGEP0020"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
>  	select OMAP_PACKAGE_CBB
> +	select PMIC_TWL4030
>  
>  config MACH_OMAP_3630SDP
>  	bool "OMAP3630 SDP board"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
>  	select OMAP_PACKAGE_CBP
> +	select PMIC_TWL4030
>  
>  config MACH_OMAP_4430SDP
>  	bool "OMAP 4430 SDP board"
> -- 
> 1.6.2.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

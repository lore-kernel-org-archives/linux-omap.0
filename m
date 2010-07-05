From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH resend 1/3] AM35x: Add musb support
Date: Mon, 5 Jul 2010 12:50:19 +0300
Message-ID: <20100705095015.GP15951@atomide.com>
References: <1278053879-6850-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55585 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081Ab0GEJub (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jul 2010 05:50:31 -0400
Content-Disposition: inline
In-Reply-To: <1278053879-6850-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, felipe.balbi@nokia.com

* Ajay Kumar Gupta <ajay.gupta@ti.com> [100702 09:52]:
> AM35x has musb interface (version 1.8) and uses CPPI41 DMA engine.
> It has USB phy built inside the IP itself.
> 
> Also added ARCH_AM35x which is required to differentiate musb ips
> between OMAP3x and AM35x. This config would be used for below purposes,
>         - Select am35x.c instead of omap2430.c for compilation
>           at drivers/usb/musb directory. Please note there are
>           significant differneces in these two files as musb ip
>           in quite different on AM35x.
>         - Select workaround codes applicable for AM35x musb issues.
>           one such workaround is for bytewise read issue on AM35x.
> 

<snip>

> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index b31b6f1..52a6752 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -84,6 +84,7 @@ config MACH_OMAP3517EVM
>  	bool "OMAP3517/ AM3517 EVM board"
>  	depends on ARCH_OMAP3
>  	select OMAP_PACKAGE_CBB
> +	select ARCH_AM35x
>  
>  config MACH_OMAP3_PANDORA
>  	bool "OMAP3 Pandora"

No thanks..

> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -5,6 +5,14 @@ menu "TI OMAP Implementations"
>  config ARCH_OMAP_OTG
>  	bool
>  
> +config ARCH_AM35x
> +	bool
> +	help
> +	  Select this option if your platform is based on AM35x. As
> +	  AM35x has an updated MUSB with CPPI4.1 DMA so this config
> +	  is introduced to differentiate musb ip between OMAP3x and
> +	  AM35x platforms.
> +
>  choice
>  	prompt "OMAP System Type"
>  	default ARCH_OMAP2PLUS

..this should not be needed.

Regards,

Tony

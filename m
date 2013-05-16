From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2: remove CONFIG_ARCH_OMAP2PLUS_TYPICAL
Date: Thu, 16 May 2013 08:11:27 -0700
Message-ID: <20130516151126.GP5600@atomide.com>
References: <1368710950-2306-1-git-send-email-robherring2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50645 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681Ab3EPPLe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 May 2013 11:11:34 -0400
Content-Disposition: inline
In-Reply-To: <1368710950-2306-1-git-send-email-robherring2@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org

* Rob Herring <robherring2@gmail.com> [130516 06:34]:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> CONFIG_ARCH_OMAP2PLUS_TYPICAL is selecting user defined features, not h/w
> required options. This does not play well with multi-platform kernels and
> belongs in a defconfig.

Yes we can remove this. But let's update omap2plus_defconfig with these
options where needed. I can update this patch for that and queue it
if that works for you.

Regards,

Tony


> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> ---
>  arch/arm/mach-omap2/Kconfig | 17 -----------------
>  1 file changed, 17 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index f49cd51..9d4b5f7 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -26,23 +26,6 @@ if ARCH_OMAP2PLUS
>  
>  menu "TI OMAP2/3/4 Specific Features"
>  
> -config ARCH_OMAP2PLUS_TYPICAL
> -	bool "Typical OMAP configuration"
> -	default y
> -	select AEABI
> -	select HIGHMEM
> -	select I2C
> -	select I2C_OMAP
> -	select MENELAUS if ARCH_OMAP2
> -	select NEON if ARCH_OMAP3 || ARCH_OMAP4 || SOC_OMAP5
> -	select PM_RUNTIME
> -	select REGULATOR
> -	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
> -	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
> -	select VFP
> -	help
> -	  Compile a kernel suitable for booting most boards
> -
>  config SOC_HAS_OMAP2_SDRC
>  	bool "OMAP2 SDRAM Controller support"
>  
> -- 
> 1.8.1.2
> 

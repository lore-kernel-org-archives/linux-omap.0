From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP5+: Reuse OMAP4 PM code for OMAP5 and DRA7
Date: Wed, 10 Sep 2014 02:14:58 +0000
Message-ID: <20140910021458.GA1058@atomide.com>
References: <1410282933-30131-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:30996 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751156AbaIJCPG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2014 22:15:06 -0400
Content-Disposition: inline
In-Reply-To: <1410282933-30131-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Nishanth Menon <nm@ti.com> [140909 17:16]:
> OMAP4, OMAP5 and DRA7 share a lot of common logic and data structures.
> These have been enabled in the previous patches, however, this also
> means that OMAP5 or DRA7 only builds also need to build OMAP4 logic.
> Update to reuse OMAP4 logic.
> 
> This fixes the 'undefined reference to 'omap4_pm_init_early'' in
> OMAP5 or DRA7 only builds.
> 
> Fixes: 6af16a1dac5465c ("ARM: DRA7: Add hook in SoC initcalls to enable pm initialization")
> Fixes: 628ed4717000789 ("ARM: OMAP5: Add hook in SoC initcalls to enable pm initialization")
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> This fixes the regression with randconfig that Tony reported with
> omap-for-v3.18/soc branch.
> 
> Tested with CONFIG_ARCH_OMAP2, CONFIG_ARCH_OMAP3, CONFIG_ARCH_OMAP4,
> CONFIG_SOC_OMAP5, CONFIG_SOC_AM33XX, CONFIG_SOC_AM43XX, CONFIG_SOC_DRA7XX
> only builds.

Thanks applying into omap-for-v3.18/soc.

Tony 
 
>  arch/arm/mach-omap2/Makefile |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 69bbcba..d9dd99c 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -87,9 +87,10 @@ ifeq ($(CONFIG_PM),y)
>  obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
>  obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
> -obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o
> -obj-$(CONFIG_SOC_OMAP5)			+= omap-mpuss-lowpower.o
> -obj-$(CONFIG_SOC_DRA7XX)		+= omap-mpuss-lowpower.o
> +omap-4-5-pm-common			=  pm44xx.o omap-mpuss-lowpower.o
> +obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-pm-common)
> +obj-$(CONFIG_SOC_OMAP5)			+= $(omap-4-5-pm-common)
> +obj-$(CONFIG_SOC_DRA7XX)		+= $(omap-4-5-pm-common)
>  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
>  
>  obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
> @@ -102,7 +103,10 @@ endif
>  
>  ifeq ($(CONFIG_CPU_IDLE),y)
>  obj-$(CONFIG_ARCH_OMAP3)                += cpuidle34xx.o
> -obj-$(CONFIG_ARCH_OMAP4)                += cpuidle44xx.o
> +omap-4-5-idle-common			=  cpuidle44xx.o
> +obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-idle-common)
> +obj-$(CONFIG_SOC_OMAP5)			+= $(omap-4-5-idle-common)
> +obj-$(CONFIG_SOC_DRA7XX)		+= $(omap-4-5-idle-common)
>  endif
>  
>  # PRCM
> -- 
> 1.7.9.5
> 

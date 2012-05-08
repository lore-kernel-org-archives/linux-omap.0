From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: am33xx: Make am33xx as a separate class
Date: Tue, 8 May 2012 13:08:34 -0700
Message-ID: <20120508200833.GD5088@atomide.com>
References: <1336490630-7272-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:45015 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756443Ab2EHUIg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 16:08:36 -0400
Content-Disposition: inline
In-Reply-To: <1336490630-7272-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

* Vaibhav Hiremath <hvaibhav@ti.com> [120508 08:32]:
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -123,8 +123,11 @@ config SOC_OMAPTI81XX
>  
>  config SOC_OMAPAM33XX
>  	bool "AM33XX support"
> -	depends on ARCH_OMAP3
> +	depends on ARCH_OMAP2PLUS

This is not needed, it's inside if ARCH_OMAP2PLUS block.

> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -16,6 +16,7 @@ secure-common				= omap-smc.o omap-secure.o
>  obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common)
>  obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(hwmod-common) $(secure-common)
>  obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(hwmod-common) $(secure-common)
> +obj-$(CONFIG_SOC_OMAPAM33XX) += irq.o $(hwmod-common)
>  
>  ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
>  obj-y += mcbsp.o
> @@ -93,6 +94,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cm2xxx_3xxx.o cminst44xx.o \
>  					   cm44xx.o prcm_mpu44xx.o \
>  					   prminst44xx.o vc44xx_data.o \
>  					   vp44xx_data.o prm44xx.o
> +obj-$(CONFIG_SOC_OMAPAM33XX)		+= prcm.o
>  
>  # OMAP voltage domains
>  voltagedomain-common			:= voltage.o vc.o vp.o
> @@ -102,6 +104,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(voltagedomain-common) \
>  					   voltagedomains3xxx_data.o
>  obj-$(CONFIG_ARCH_OMAP4)		+= $(voltagedomain-common) \
>  					   voltagedomains44xx_data.o
> +obj-$(CONFIG_SOC_OMAPAM33XX)		+= $(voltagedomain-common)
>  
>  # OMAP powerdomain framework
>  powerdomain-common			+= powerdomain.o powerdomain-common.o
> @@ -116,6 +119,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(powerdomain-common) \
>  obj-$(CONFIG_ARCH_OMAP4)		+= $(powerdomain-common) \
>  					   powerdomain44xx.o \
>  					   powerdomains44xx_data.o
> +obj-$(CONFIG_SOC_OMAPAM33XX)		+= $(powerdomain-common)
>  
>  # PRCM clockdomain control
>  clockdomain-common			+= clockdomain.o \
> @@ -132,6 +136,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(clockdomain-common) \
>  obj-$(CONFIG_ARCH_OMAP4)		+= $(clockdomain-common) \
>  					   clockdomain44xx.o \
>  					   clockdomains44xx_data.o
> +obj-$(CONFIG_SOC_OMAPAM33XX)		+= $(clockdomain-common)
>  
>  # Clock framework
>  obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common) clock2xxx.o \
> @@ -149,6 +154,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common) clock3xxx.o \
>  					   clkt_iclk.o
>  obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) clock44xx_data.o \
>  					   dpll3xxx.o dpll44xx.o
> +obj-$(CONFIG_SOC_OMAPAM33XX)		+= $(clock-common) dpll3xxx.o
>  
>  # OMAP2 clock rate set data (old "OPP" data)
>  obj-$(CONFIG_SOC_OMAP2420)		+= opp2420_data.o

Can you please rebase this on what's now in the cleanup branch at commit
382ae00105d9989a821f458084e0428bce10b969? That should simplify the Makefile
changes a bit.

Other than that looks good to me.

Tony

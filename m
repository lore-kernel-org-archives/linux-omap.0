From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: omap5: build opp4xxx_data.c
Date: Fri, 21 Jun 2013 15:42:50 -0500
Message-ID: <20130621204250.GA16139@kahuna>
References: <201306212229.54238.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36224 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946024Ab3FUUnT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jun 2013 16:43:19 -0400
Content-Disposition: inline
In-Reply-To: <201306212229.54238.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

On 22:29-20130621, Arnd Bergmann wrote:
> Building OMAP5 support without this file currently results in this link error:
> 
> arch/arm/mach-omap2/built-in.o: In function `omap54xx_voltagedomains_init':
> :(.init.text+0x6b80): undefined reference to `omap446x_vdd_core_volt_data'
> :(.init.text+0x6b84): undefined reference to `omap446x_vdd_mpu_volt_data'
> :(.init.text+0x6b88): undefined reference to `omap446x_vdd_iva_volt_data'
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 0520dc4..f5038f5 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -77,6 +77,7 @@ ifeq ($(CONFIG_PM_OPP),y)
>  obj-y					+= opp.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= opp3xxx_data.o
>  obj-$(CONFIG_ARCH_OMAP4)		+= opp4xxx_data.o
> +obj-$(CONFIG_SOC_OMAP5)			+= opp4xxx_data.o
>  endif
>  

	/*
	 * XXX Will depend on the process, validation, and binning
	 * for the currently-running IC. Use OMAP4 data for time being.
	 */
#ifdef CONFIG_PM_OPP
	omap5_voltdm_mpu.volt_data = omap446x_vdd_mpu_volt_data;
	omap5_voltdm_mm.volt_data = omap446x_vdd_iva_volt_data;
	omap5_voltdm_core.volt_data = omap446x_vdd_core_volt_data;
#endif

Should we just remove this instead? these are obviously wrong.

-- 
Regards,
Nishanth Menon

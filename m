From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/13] ARM: OMAP5: Add the build support
Date: Fri, 4 May 2012 15:58:58 -0700
Message-ID: <20120504225857.GB5613@atomide.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-13-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34762 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606Ab2EDW7A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 18:59:00 -0400
Content-Disposition: inline
In-Reply-To: <1336029982-31898-13-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: R Sricharan <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, b-cousson@ti.com

* R Sricharan <r.sricharan@ti.com> [120503 00:30]:
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -9,7 +9,7 @@ config ARCH_OMAP2PLUS_TYPICAL
>  	select REGULATOR
>  	select PM_RUNTIME
>  	select VFP
> -	select NEON if ARCH_OMAP3 || ARCH_OMAP4
> +	select NEON if ARCH_OMAP3 || ARCH_OMAP4 || ARCH_OMAP5
>  	select SERIAL_OMAP
>  	select SERIAL_OMAP_CONSOLE
>  	select I2C

If we add CONFIG_SOC_OMAP3PLUS and CONFIG_SOC_OMAP4PLUS, then
this becomes more future proof with select NEON if SOC_OMAP3PLUS.

> @@ -55,6 +55,13 @@ config ARCH_OMAP4
>  	select USB_ARCH_HAS_EHCI if USB_SUPPORT
>  	select ARM_CPU_SUSPEND if PM
>  
> +config ARCH_OMAP5
> +	bool "TI OMAP5"
> +	depends on ARCH_OMAP2PLUS
> +	select CPU_V7
> +	select ARM_GIC
> +	select HAVE_SMP

No need to have depends on ARCH_OMAP2PLUS, it's all inside
if ARCH_OMAP2PLUS anyways. I removed those already once, but that
had to be reverted because the patch was doing other things too
that did not work out too well..

> @@ -343,6 +350,10 @@ config MACH_OMAP4_PANDA
>  	select OMAP_PACKAGE_CBS
>  	select REGULATOR_FIXED_VOLTAGE if REGULATOR
>  
> +config MACH_OMAP5_SEVM
> +	bool "OMAP5 sevm Board"
> +	depends on ARCH_OMAP5
> +
>  config OMAP3_EMU
>  	bool "OMAP3 debugging peripherals"
>  	depends on ARCH_OMAP3

No need for it here either. Actually, I think this whole chunk
can be now left out since it's DT based?

Regards,

Tony

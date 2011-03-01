From: Felipe Balbi <balbi@ti.com>
Subject: Re: [patch v1 3/3] arm: omap4: support pmu
Date: Tue, 1 Mar 2011 19:12:00 +0200
Message-ID: <20110301171200.GC2488@legolas.emea.dhcp.ti.com>
References: <1298998711-8165-1-git-send-email-tom.leiming@gmail.com>
 <1298998711-8165-4-git-send-email-tom.leiming@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:60838 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756857Ab1CARNG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 12:13:06 -0500
Received: by mail-bw0-f41.google.com with SMTP id 17so6437542bwz.14
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 09:13:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298998711-8165-4-git-send-email-tom.leiming@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tom.leiming@gmail.com
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, will.deacon@arm.com, Woodruff Richard <r-woodruff2@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Wed, Mar 02, 2011 at 12:58:31AM +0800, tom.leiming@gmail.com wrote:
> From: Ming Lei <tom.leiming@gmail.com>
> 
> This patch supports pmu irq routed from CTI, so
> make pmu/perf working on OMAP4.
> 
> The idea is from Woodruff Richard in the disscussion
> "Oprofile on Pandaboard / Omap4" of pandaboard@googlegroups.com.
> 
> Cc: Woodruff Richard <r-woodruff2@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
>  arch/arm/mach-omap2/dbg44xx.h |   18 +++++++++++++
>  arch/arm/mach-omap2/devices.c |   55 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 72 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/dbg44xx.h
> 
> diff --git a/arch/arm/mach-omap2/dbg44xx.h b/arch/arm/mach-omap2/dbg44xx.h
> new file mode 100644
> index 0000000..e447ad5
> --- /dev/null
> +++ b/arch/arm/mach-omap2/dbg44xx.h
> @@ -0,0 +1,18 @@
> +/*
> + * OMAP44xx on-chip debug support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * XXX This file needs to be updated to align on one of "OMAP4", "OMAP44XX",
> + *     or "OMAP4430".
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_DBG44XX_H
> +#define __ARCH_ARM_MACH_OMAP2_DBG44XX_H
> +
> +#define OMAP44XX_CTI0_BASE		0x54148000
> +#define OMAP44XX_CTI1_BASE		0x54149000
> +
> +#endif
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index d216976..0420a58 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -35,6 +35,7 @@
>  
>  #include "mux.h"
>  #include "control.h"
> +#include "dbg44xx.h"
>  
>  #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
>  
> @@ -322,19 +323,71 @@ static struct resource omap3_pmu_resource = {
>  	.flags	= IORESOURCE_IRQ,
>  };
>  
> +static struct resource omap4_pmu_resource[] = {
> +	{
> +	.start	= OMAP44XX_IRQ_CTI0,
> +	.end	= OMAP44XX_IRQ_CTI0,
> +	.flags	= IORESOURCE_IRQ,
> +	},
> +	{
> +	.start	= OMAP44XX_IRQ_CTI1,
> +	.end	= OMAP44XX_IRQ_CTI1,
> +	.flags	= IORESOURCE_IRQ,
> +	}
> +};

indentation is wrong.

>  static void omap_init_pmu(void)
>  {
>  	if (cpu_is_omap24xx())
>  		omap_pmu_device.resource = &omap2_pmu_resource;
>  	else if (cpu_is_omap34xx())
>  		omap_pmu_device.resource = &omap3_pmu_resource;

missing add braces to these two.

-- 
balbi

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RESUBMIT][PATCH 5/7] OMAP4: Update common omap machine
	specific sources.
Date: Sat, 16 May 2009 11:07:32 +0100
Message-ID: <20090516100732.GK15328@n2100.arm.linux.org.uk>
References: <1241677756-28756-1-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-2-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-3-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-4-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-5-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33210 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786AbZEPKHk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 06:07:40 -0400
Content-Disposition: inline
In-Reply-To: <1241677756-28756-5-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

I think this is going to take several separate reviews to group stuff
together.

On Thu, May 07, 2009 at 11:59:14AM +0530, Santosh Shilimkar wrote:
> This patch updates the common machine spcific source files for OMAP4430.

Spelling - "specific".

> diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
> index 0e7d501..1497d18 100644
> --- a/arch/arm/mach-omap2/clockdomain.c
> +++ b/arch/arm/mach-omap2/clockdomain.c
> @@ -177,6 +177,8 @@ void clkdm_init(struct clockdomain **clkdms,
>  	struct clockdomain **c = NULL;
>  	struct clkdm_pwrdm_autodep *autodep = NULL;
>  
> +	if (cpu_is_omap44xx())
> +		return ; /* FIXME: Not yet support */
>  	if (clkdms)
>  		for (c = clkdms; *c; c++)
>  			clkdm_register(*c);
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 73e2971..7fc03b8 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -117,6 +117,8 @@ void pwrdm_init(struct powerdomain **pwrdm_list)
>  {
>  	struct powerdomain **p = NULL;
>  
> +	if (cpu_is_omap44xx())
> +		return ; /* FIXME: Not supported yet */
>  	if (pwrdm_list)
>  		for (p = pwrdm_list; *p; p++)
>  			pwrdm_register(*p);
> diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
> index 2a30060..944da57 100644
> --- a/arch/arm/mach-omap2/sdrc.c
> +++ b/arch/arm/mach-omap2/sdrc.c
> @@ -79,6 +79,8 @@ void __init omap2_sdrc_init(struct omap_sdrc_params *sp)
>  {
>  	u32 l;
>  
> +	if (cpu_is_omap44xx())
> +		return; /* SDRC not supported */
>  	l = sms_read_reg(SMS_SYSCONFIG);
>  	l &= ~(0x3 << 3);
>  	l |= (0x2 << 3);
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 916fcd3..6db7791 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -200,7 +247,9 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sp)
>  	omap2_mux_init();
>  	pwrdm_init(powerdomains_omap);
>  	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
> +#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is ready */
>  	omap2_clk_init();
> +#endif
>  	omap2_sdrc_init(sp);
>  	gpmc_init();
>  }

I'm not sure why:

1. you're using a (possible) run time check in sdrc.c, clockdomain.c and
   powerdomain.c, but a compile time check in io.c
2. you don't leave sdrc.c, clockdomain.c and powerdomain.c alone and just
   disable the three initialisation calls inside omap2_init_common_hw().

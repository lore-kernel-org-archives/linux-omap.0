From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2 06/18] ARM: OMAP5: PM: Enable Mercury retention mode on CPUx powerdomains
Date: Wed, 03 Apr 2013 13:31:37 -0700
Message-ID: <87k3ojuziu.fsf@linaro.org>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
	<1364205910-32392-7-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:35375 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761353Ab3DCUbl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Apr 2013 16:31:41 -0400
Received: by mail-pd0-f176.google.com with SMTP id r11so1038774pdi.21
        for <linux-omap@vger.kernel.org>; Wed, 03 Apr 2013 13:31:40 -0700 (PDT)
In-Reply-To: <1364205910-32392-7-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Mon, 25 Mar 2013 15:34:58 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> In addition to the standard power-management technique, the OMAP5
> MPU subsystem also employs an SR3-APG (mercury) power management
> technology to reduce leakage.
>
> It allows for full logic and memories retention on MPU_C0 and MPU_C1 and
> is controlled by the PRCM_MPU.
>
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/omap-mpuss-lowpower.c |   27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> index b1441b1..d390d18 100644
> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> @@ -62,6 +62,10 @@
>  #include "prm44xx.h"
>  #include "prm-regbits-44xx.h"
>  
> +/* Add defines needed for mercury mode. Refer MPU's PRM_PSCON_COUNT */
> +#define PRM_PSCON_HG_EN		(1 << 24)
> +#define PRM_PSCON_HG_RAMPUP	(1 << 25)

nit: use BIT()

>  #ifdef CONFIG_SMP
>  
>  struct omap4_cpu_pm_info {
> @@ -337,6 +341,28 @@ int __cpuinit omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
>  	return 0;
>  }
>  
> +/**
> + * enable_mercury_retention_mode: Enable OMAP5 mercury retention feature
> + *
> + * OMAP5 devices supports  SR3-APG (mercury) power management technology to
> + * reduce leakage. It allows for full logic and memories retention on
> + * MPU_C0 and MPU_C1 and is controlled by the PRCM_MPU. The function enable
> + * the mercury retention feature.
> + */
> +static void enable_mercury_retention_mode(void)

__init ?

This is very OMAP5 specific (unless you generalize the offsets used) so
should this have omap5_ prefix?

Kevin

> +{
> +	u32 reg;
> +
> +	/*
> +	 * To enable mercury mode, both HG_EN and HG_RAMPUP needs to be
> +	 * enabled from PRM_PSCON_COUNT register.
> +	 */
> +	reg = omap4_prcm_mpu_read_inst_reg(OMAP54XX_PRCM_MPU_DEVICE_INST,
> +			OMAP54XX_PRCM_MPU_PRM_PSCON_COUNT_OFFSET);
> +	reg |= PRM_PSCON_HG_EN | PRM_PSCON_HG_RAMPUP;
> +	omap4_prcm_mpu_write_inst_reg(reg, OMAP54XX_PRCM_MPU_DEVICE_INST,
> +			OMAP54XX_PRCM_MPU_PRM_PSCON_COUNT_OFFSET);

nit: when I see 'reg', I expect it to be a register/offset.  But this is
a register value.  Maybe use 'val' instead as you've done elsewhere in
this series.

Kevin

> +}
>  
>  /*
>   * Initialise OMAP4 MPUSS
> @@ -415,6 +441,7 @@ int __init omap4_mpuss_init(void)
>  		cpu_context_offset = OMAP4_RM_CPU0_CPU0_CONTEXT_OFFSET;
>  	} else if (soc_is_omap54xx()) {
>  		cpu_context_offset = OMAP54XX_RM_CPU0_CPU0_CONTEXT_OFFSET;
> +		enable_mercury_retention_mode();
>  	}
>  
>  	return 0;

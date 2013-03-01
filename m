From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 06/15] ARM: OMAP5: PM: Enable Mercury retention mode on
 CPUx powerdomains
Date: Fri, 1 Mar 2013 13:42:16 -0600
Message-ID: <20130301194216.GB22626@kahuna>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
 <1362139864-9233-7-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37446 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308Ab3CATmU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Mar 2013 14:42:20 -0500
Content-Disposition: inline
In-Reply-To: <1362139864-9233-7-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

On 17:40-20130301, Santosh Shilimkar wrote:
> In addition to the standard power-management technique, the OMAP5
> MPU subsystem also employs an SR3-APG (mercury) power management
> technology to reduce leakage.
Mercury fast is employed here - might be good to note that.
> 
> It allows for full logic and memories retention on MPU_C0 and MPU_C1 and
> is controlled by the PRCM_MPU.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/omap-mpuss-lowpower.c |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> index bcd2efb..9fda96b 100644
> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> @@ -360,6 +360,20 @@ int __cpuinit omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
>  
>  
>  /*
> + * Enable Mercury Fast HG retention mode by default.
> + */
> +static void enable_mercury_retention_mode(void)
> +{
> +	u32 reg;
> +
> +	reg = omap4_prcm_mpu_read_inst_reg(OMAP54XX_PRCM_MPU_DEVICE_INST,
> +			OMAP54XX_PRCM_MPU_PRM_PSCON_COUNT_OFFSET);
> +	reg |= BIT(24) | BIT(25);
Can we please use macros here?
we are setting BIT(25) - fast ramp-up (Mercury fast) Vs 0 (which would
have been mercury slow)
BIT(24) is mercury enable basically. OMAP4 prm-regbits-44xx.h did not
have these ofcourse, so might be a different bit file or so?
> +	omap4_prcm_mpu_write_inst_reg(reg, OMAP54XX_PRCM_MPU_DEVICE_INST,
> +			OMAP54XX_PRCM_MPU_PRM_PSCON_COUNT_OFFSET);
> +}
> +
> +/*
>   * Initialise OMAP4 MPUSS
>   */
>  int __init omap4_mpuss_init(void)
> @@ -438,6 +452,9 @@ int __init omap4_mpuss_init(void)
>  		cpu_context_offset = OMAP54XX_RM_CPU0_CPU0_CONTEXT_OFFSET;
>  	}
>  
> +	if (soc_is_omap54xx())
> +		enable_mercury_retention_mode();
> +
>  	return 0;
>  }
>  
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Regards,
Nishanth Menon

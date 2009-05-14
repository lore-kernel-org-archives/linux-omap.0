From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH omap3-upstream] OMAP: PM: add PRCM register offsets
Date: Thu, 14 May 2009 16:17:52 -0700
Message-ID: <20090514231751.GX5593@atomide.com>
References: <1242340569-16302-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54791 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753688AbZENXRy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 19:17:54 -0400
Content-Disposition: inline
In-Reply-To: <1242340569-16302-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [090514 15:36]:
> Add _OFFSET #defines for the PRCM registers to be used with the
> prm_[read|write]_* macros.  These are used extensively in the
> forthcoming OMAP PM support.

Thanks, I've merged this into "Remove OMAP_PRM_REGADDR and OMAP2_PRM_BASE",
will post the series with LAKML Cc'd for review.

Tony
 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/clock.c    |    4 +-
>  arch/arm/mach-omap2/cm.h       |    1 +
>  arch/arm/mach-omap2/prm.h      |   69 ++++++++++++++++++++++++++++++---------
>  arch/arm/mach-omap2/sram242x.S |    6 ++--
>  arch/arm/mach-omap2/sram243x.S |    6 ++--
>  5 files changed, 62 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> index 4247a15..dd37483 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -91,9 +91,9 @@ static void _omap2xxx_clk_commit(struct clk *clk)
>  		return;
>  
>  	prm_write_mod_reg(OMAP24XX_VALID_CONFIG, OMAP24XX_GR_MOD,
> -		OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET);
> +		OMAP2_PRCM_CLKCFG_CTRL_OFFSET);
>  	/* OCP barrier */
> -	prm_read_mod_reg(OMAP24XX_GR_MOD, OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET);
> +	prm_read_mod_reg(OMAP24XX_GR_MOD, OMAP2_PRCM_CLKCFG_CTRL_OFFSET);
>  }
>  
>  /*
> diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
> index 04c5fc5..1d3c93b 100644
> --- a/arch/arm/mach-omap2/cm.h
> +++ b/arch/arm/mach-omap2/cm.h
> @@ -33,6 +33,7 @@
>  #define OMAP3430_CM_SYSCONFIG		OMAP_CM_REGADDR(OCP_MOD, 0x0010)
>  #define OMAP3430_CM_POLCTRL		OMAP_CM_REGADDR(OCP_MOD, 0x009c)
>  
> +#define OMAP3_CM_CLKOUT_CTRL_OFFSET	0x0070
>  #define OMAP3430_CM_CLKOUT_CTRL		OMAP_CM_REGADDR(OMAP3430_CCR_MOD, 0x0070)
>  
>  /*
> diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
> index 2eb8399..7c8e0c4 100644
> --- a/arch/arm/mach-omap2/prm.h
> +++ b/arch/arm/mach-omap2/prm.h
> @@ -33,36 +33,35 @@
>   *
>   */
>  
> -/* Global 24xx registers in GR_MOD (Same as OCP_MOD for 24xx) */
> -#define OMAP24XX_PRCM_VOLTCTRL_OFFSET		0x0050
> -#define OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET	0x0080
> -
> -/* 242x GR_MOD registers, use these only for assembly code */
> -#define OMAP242X_PRCM_VOLTCTRL		OMAP2420_PRM_REGADDR(OMAP24XX_GR_MOD,	\
> -						OMAP24XX_PRCM_VOLTCTRL_OFFSET)
> -#define OMAP242X_PRCM_CLKCFG_CTRL	OMAP2420_PRM_REGADDR(OMAP24XX_GR_MOD,	\
> -						OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET)
> -
> -/* 243x GR_MOD registers, use these only for assembly code */
> -#define OMAP243X_PRCM_VOLTCTRL		OMAP2430_PRM_REGADDR(OMAP24XX_GR_MOD,	\
> -						OMAP24XX_PRCM_VOLTCTRL_OFFSET)
> -#define OMAP243X_PRCM_CLKCFG_CTRL	OMAP2430_PRM_REGADDR(OMAP24XX_GR_MOD,	\
> -						OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET)
> -
> +#define OMAP2_PRCM_REVISION_OFFSET	0x0000
>  #define OMAP2420_PRCM_REVISION		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0000)
> +#define OMAP2_PRCM_SYSCONFIG_OFFSET	0x0010
>  #define OMAP2420_PRCM_SYSCONFIG		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0010)
>  
> +#define OMAP2_PRCM_IRQSTATUS_MPU_OFFSET	0x0018
>  #define OMAP2420_PRCM_IRQSTATUS_MPU	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0018)
> +#define OMAP2_PRCM_IRQENABLE_MPU_OFFSET	0x001c
>  #define OMAP2420_PRCM_IRQENABLE_MPU	OMAP2420_PRM_REGADDR(OCP_MOD, 0x001c)
>  
> +#define OMAP2_PRCM_VOLTCTRL_OFFSET	0x0050
> +#define OMAP2420_PRCM_VOLTCTRL		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0050)
> +#define OMAP2_PRCM_VOLTST_OFFSET	0x0054
>  #define OMAP2420_PRCM_VOLTST		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0054)
> +#define OMAP2_PRCM_CLKSRC_CTRL_OFFSET	0x0060
>  #define OMAP2420_PRCM_CLKSRC_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0060)
> +#define OMAP2_PRCM_CLKOUT_CTRL_OFFSET	0x0070
>  #define OMAP2420_PRCM_CLKOUT_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0070)
> +#define OMAP2_PRCM_CLKEMUL_CTRL_OFFSET	0x0078
>  #define OMAP2420_PRCM_CLKEMUL_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0078)
> +#define OMAP2_PRCM_CLKCFG_CTRL_OFFSET	0x0080
>  #define OMAP2420_PRCM_CLKCFG_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0080)
> +#define OMAP2_PRCM_CLKCFG_STATUS_OFFSET	0x0084
>  #define OMAP2420_PRCM_CLKCFG_STATUS	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0084)
> +#define OMAP2_PRCM_VOLTSETUP_OFFSET	0x0090
>  #define OMAP2420_PRCM_VOLTSETUP		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0090)
> +#define OMAP2_PRCM_CLKSSETUP_OFFSET	0x0094
>  #define OMAP2420_PRCM_CLKSSETUP		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0094)
> +#define OMAP2_PRCM_POLCTRL_OFFSET	0x0098
>  #define OMAP2420_PRCM_POLCTRL		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0098)
>  
>  #define OMAP2430_PRCM_REVISION		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0000)
> @@ -71,6 +70,7 @@
>  #define OMAP2430_PRCM_IRQSTATUS_MPU	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0018)
>  #define OMAP2430_PRCM_IRQENABLE_MPU	OMAP2430_PRM_REGADDR(OCP_MOD, 0x001c)
>  
> +#define OMAP2430_PRCM_VOLTCTRL		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0050)
>  #define OMAP2430_PRCM_VOLTST		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0054)
>  #define OMAP2430_PRCM_CLKSRC_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0060)
>  #define OMAP2430_PRCM_CLKOUT_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0070)
> @@ -81,46 +81,83 @@
>  #define OMAP2430_PRCM_CLKSSETUP		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0094)
>  #define OMAP2430_PRCM_POLCTRL		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0098)
>  
> +#define OMAP3_PRM_REVISION_OFFSET	0x0004
>  #define OMAP3430_PRM_REVISION		OMAP34XX_PRM_REGADDR(OCP_MOD, 0x0004)
> +#define OMAP3_PRM_SYSCONFIG_OFFSET	0x0014
>  #define OMAP3430_PRM_SYSCONFIG		OMAP34XX_PRM_REGADDR(OCP_MOD, 0x0014)
>  
> +#define OMAP3_PRM_IRQSTATUS_MPU_OFFSET	0x0018
>  #define OMAP3430_PRM_IRQSTATUS_MPU	OMAP34XX_PRM_REGADDR(OCP_MOD, 0x0018)
> +#define OMAP3_PRM_IRQENABLE_MPU_OFFSET	0x001c
>  #define OMAP3430_PRM_IRQENABLE_MPU	OMAP34XX_PRM_REGADDR(OCP_MOD, 0x001c)
>  
>  
> +#define OMAP3_PRM_VC_SMPS_SA_OFFSET	0x0020
>  #define OMAP3430_PRM_VC_SMPS_SA		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0020)
> +#define OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET	0x0024
>  #define OMAP3430_PRM_VC_SMPS_VOL_RA	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0024)
> +#define OMAP3_PRM_VC_SMPS_CMD_RA_OFFSET	0x0028
>  #define OMAP3430_PRM_VC_SMPS_CMD_RA	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0028)
> +#define OMAP3_PRM_VC_CMD_VAL_0_OFFSET	0x002c
>  #define OMAP3430_PRM_VC_CMD_VAL_0	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x002c)
> +#define OMAP3_PRM_VC_CMD_VAL_1_OFFSET	0x0030
>  #define OMAP3430_PRM_VC_CMD_VAL_1	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0030)
> +#define OMAP3_PRM_VC_CH_CONF_OFFSET	0x0034
>  #define OMAP3430_PRM_VC_CH_CONF		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0034)
> +#define OMAP3_PRM_VC_I2C_CFG_OFFSET	0x0038
>  #define OMAP3430_PRM_VC_I2C_CFG		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0038)
> +#define OMAP3_PRM_VC_BYPASS_VAL_OFFSET	0x003c
>  #define OMAP3430_PRM_VC_BYPASS_VAL	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x003c)
> +#define OMAP3_PRM_RSTCTRL_OFFSET	0x0050
>  #define OMAP3430_PRM_RSTCTRL		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0050)
> +#define OMAP3_PRM_RSTTIME_OFFSET	0x0054
>  #define OMAP3430_PRM_RSTTIME		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0054)
> +#define OMAP3_PRM_RSTST_OFFSET	0x0058
>  #define OMAP3430_PRM_RSTST		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0058)
> +#define OMAP3_PRM_VOLTCTRL_OFFSET	0x0060
>  #define OMAP3430_PRM_VOLTCTRL		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0060)
> +#define OMAP3_PRM_SRAM_PCHARGE_OFFSET	0x0064
>  #define OMAP3430_PRM_SRAM_PCHARGE	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0064)
> +#define OMAP3_PRM_CLKSRC_CTRL_OFFSET	0x0070
>  #define OMAP3430_PRM_CLKSRC_CTRL	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0070)
> +#define OMAP3_PRM_VOLTSETUP1_OFFSET	0x0090
>  #define OMAP3430_PRM_VOLTSETUP1		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0090)
> +#define OMAP3_PRM_VOLTOFFSET_OFFSET	0x0094
>  #define OMAP3430_PRM_VOLTOFFSET		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0094)
> +#define OMAP3_PRM_CLKSETUP_OFFSET	0x0098
>  #define OMAP3430_PRM_CLKSETUP		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0098)
> +#define OMAP3_PRM_POLCTRL_OFFSET	0x009c
>  #define OMAP3430_PRM_POLCTRL		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x009c)
> +#define OMAP3_PRM_VOLTSETUP2_OFFSET	0x00a0
>  #define OMAP3430_PRM_VOLTSETUP2		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00a0)
> +#define OMAP3_PRM_VP1_CONFIG_OFFSET	0x00b0
>  #define OMAP3430_PRM_VP1_CONFIG		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00b0)
> +#define OMAP3_PRM_VP1_VSTEPMIN_OFFSET	0x00b4
>  #define OMAP3430_PRM_VP1_VSTEPMIN	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00b4)
> +#define OMAP3_PRM_VP1_VSTEPMAX_OFFSET	0x00b8
>  #define OMAP3430_PRM_VP1_VSTEPMAX	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00b8)
> +#define OMAP3_PRM_VP1_VLIMITTO_OFFSET	0x00bc
>  #define OMAP3430_PRM_VP1_VLIMITTO	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00bc)
> +#define OMAP3_PRM_VP1_VOLTAGE_OFFSET	0x00c0
>  #define OMAP3430_PRM_VP1_VOLTAGE	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00c0)
> +#define OMAP3_PRM_VP1_STATUS_OFFSET	0x00c4
>  #define OMAP3430_PRM_VP1_STATUS		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00c4)
> +#define OMAP3_PRM_VP2_CONFIG_OFFSET	0x00d0
>  #define OMAP3430_PRM_VP2_CONFIG		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00d0)
> +#define OMAP3_PRM_VP2_VSTEPMIN_OFFSET	0x00d4
>  #define OMAP3430_PRM_VP2_VSTEPMIN	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00d4)
> +#define OMAP3_PRM_VP2_VSTEPMAX_OFFSET	0x00d8
>  #define OMAP3430_PRM_VP2_VSTEPMAX	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00d8)
> +#define OMAP3_PRM_VP2_VLIMITTO_OFFSET	0x00dc
>  #define OMAP3430_PRM_VP2_VLIMITTO	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00dc)
> +#define OMAP3_PRM_VP2_VOLTAGE_OFFSET	0x00e0
>  #define OMAP3430_PRM_VP2_VOLTAGE	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00e0)
> +#define OMAP3_PRM_VP2_STATUS_OFFSET	0x00e4
>  #define OMAP3430_PRM_VP2_STATUS		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00e4)
>  
> +#define OMAP3_PRM_CLKSEL_OFFSET	0x0040
>  #define OMAP3430_PRM_CLKSEL		OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD, 0x0040)
> +#define OMAP3_PRM_CLKOUT_CTRL_OFFSET	0x0070
>  #define OMAP3430_PRM_CLKOUT_CTRL	OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD, 0x0070)
>  
>  /*
> diff --git a/arch/arm/mach-omap2/sram242x.S b/arch/arm/mach-omap2/sram242x.S
> index cbb8930..bb29985 100644
> --- a/arch/arm/mach-omap2/sram242x.S
> +++ b/arch/arm/mach-omap2/sram242x.S
> @@ -124,7 +124,7 @@ omap242x_sdi_cm_clksel2_pll:
>  omap242x_sdi_sdrc_dlla_ctrl:
>  	.word OMAP242X_SDRC_REGADDR(SDRC_DLLA_CTRL)
>  omap242x_sdi_prcm_voltctrl:
> -	.word OMAP242X_PRCM_VOLTCTRL
> +	.word OMAP2420_PRCM_VOLTCTRL
>  prcm_mask_val:
>  	.word 0xFFFF3FFC
>  omap242x_sdi_timer_32ksynct_cr:
> @@ -220,7 +220,7 @@ omap242x_srs_sdrc_dlla_ctrl:
>  omap242x_srs_sdrc_rfr_ctrl:
>  	.word OMAP242X_SDRC_REGADDR(SDRC_RFR_CTRL_0)
>  omap242x_srs_prcm_voltctrl:
> -	.word OMAP242X_PRCM_VOLTCTRL
> +	.word OMAP2420_PRCM_VOLTCTRL
>  ddr_prcm_mask_val:
>  	.word 0xFFFF3FFC
>  omap242x_srs_timer_32ksynct:
> @@ -305,7 +305,7 @@ wait_dll_lock:
>  	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
>  
>  omap242x_ssp_set_config:
> -	.word OMAP242X_PRCM_CLKCFG_CTRL
> +	.word OMAP2420_PRCM_CLKCFG_CTRL
>  omap242x_ssp_pll_ctl:
>  	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_CLKEN)
>  omap242x_ssp_pll_stat:
> diff --git a/arch/arm/mach-omap2/sram243x.S b/arch/arm/mach-omap2/sram243x.S
> index 054b0f3..9955abc 100644
> --- a/arch/arm/mach-omap2/sram243x.S
> +++ b/arch/arm/mach-omap2/sram243x.S
> @@ -124,7 +124,7 @@ omap243x_sdi_cm_clksel2_pll:
>  omap243x_sdi_sdrc_dlla_ctrl:
>  	.word OMAP243X_SDRC_REGADDR(SDRC_DLLA_CTRL)
>  omap243x_sdi_prcm_voltctrl:
> -	.word OMAP243X_PRCM_VOLTCTRL
> +	.word OMAP2430_PRCM_VOLTCTRL
>  prcm_mask_val:
>  	.word 0xFFFF3FFC
>  omap243x_sdi_timer_32ksynct_cr:
> @@ -220,7 +220,7 @@ omap243x_srs_sdrc_dlla_ctrl:
>  omap243x_srs_sdrc_rfr_ctrl:
>  	.word OMAP243X_SDRC_REGADDR(SDRC_RFR_CTRL_0)
>  omap243x_srs_prcm_voltctrl:
> -	.word OMAP243X_PRCM_VOLTCTRL
> +	.word OMAP2430_PRCM_VOLTCTRL
>  ddr_prcm_mask_val:
>  	.word 0xFFFF3FFC
>  omap243x_srs_timer_32ksynct:
> @@ -305,7 +305,7 @@ wait_dll_lock:
>  	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
>  
>  omap243x_ssp_set_config:
> -	.word OMAP243X_PRCM_CLKCFG_CTRL
> +	.word OMAP2430_PRCM_CLKCFG_CTRL
>  omap243x_ssp_pll_ctl:
>  	.word OMAP2430_CM_REGADDR(PLL_MOD, CM_CLKEN)
>  omap243x_ssp_pll_stat:
> -- 
> 1.6.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

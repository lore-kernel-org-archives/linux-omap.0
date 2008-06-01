From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 3/3] ARM: OMAP: SmartReflex driver: integration to linux-omap
Date: Sun, 1 Jun 2008 11:17:01 +0200
Message-ID: <FA2F38A0-A9CB-4990-BA61-E56FC0B889C9@student.utwente.nl>
References: <> <1212156747-26652-1-git-send-email-ext-kalle.jokiniemi@nokia.com> <1212156747-26652-2-git-send-email-ext-kalle.jokiniemi@nokia.com> <1212156747-26652-3-git-send-email-ext-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:51707 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751602AbYFAJRm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 1 Jun 2008 05:17:42 -0400
In-Reply-To: <1212156747-26652-3-git-send-email-ext-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Cc: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 30 mei 2008, om 16:12 heeft Kalle Jokiniemi het volgende geschreven:

> - Changed register accesses to use __raw_readl(), __raw_writel() and
>  prm_rmw_reg_bits() functions instread of "REG_X = REG_Y" type  
> accesses.

   CC      arch/arm/mach-omap2/smartreflex.o
arch/arm/mach-omap2/smartreflex.c: In function 'sr_configure_vp':
arch/arm/mach-omap2/smartreflex.c:351: error: implicit declaration of  
function 'prm_rmw_reg_bits'

That function got replaced by prm_rmw_mod_reg_bits by:
[PATCH 11/14] ARM: OMAP: Remove OMAP_PRM_REGADDR

http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=158e5d7128ed806b5b4eec0839e73727fa7a1f8a



> - Added smartreflex.o into compilation, depends on  
> CONFIG_ARCH_OMAP34XX and
>  CONFIG_TWL4030_CORE

This part doesn't apply anymore, but that's easily fixed


regards,

Koen


> Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
> ---
> arch/arm/mach-omap2/Makefile      |    4 +
> arch/arm/mach-omap2/pm34xx.c      |    9 +
> arch/arm/mach-omap2/smartreflex.c |  406 ++++++++++++++++++++ 
> +----------------
> 3 files changed, 247 insertions(+), 172 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/ 
> Makefile
> index b617b66..6a4c7e7 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -21,6 +21,10 @@ endif
> ifeq ($(CONFIG_ARCH_OMAP3),y)
> obj-$(CONFIG_PM) += pm34xx.o sleep34xx.o
> endif
> +
> +ifeq ($(CONFIG_ARCH_OMAP34XX),y)
> +obj-$(CONFIG_TWL4030_CORE) += smartreflex.o
> +endif
> obj-$(CONFIG_PM_DEBUG) += pm-debug.o
>
> # Clock framework
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/ 
> pm34xx.c
> index a1bfb30..fbba2f3 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -36,6 +36,7 @@
>
> #include "prm.h"
> #include "pm.h"
> +#include "smartreflex.h"
>
> struct power_state {
> 	struct powerdomain *pwrdm;
> @@ -243,6 +244,10 @@ static int omap3_pm_suspend(void)
> 	struct power_state *pwrst;
> 	int state, ret = 0;
>
> +	/* XXX Disable smartreflex before entering suspend */
> +	disable_smartreflex(SR1);
> +	disable_smartreflex(SR2);
> +
> 	/* Read current next_pwrsts */
> 	list_for_each_entry(pwrst, &pwrst_list, node)
> 		pwrst->saved_state = pwrdm_read_next_pwrst(pwrst->pwrdm);
> @@ -274,6 +279,10 @@ restore:
> 		printk(KERN_INFO "Successfully put all powerdomains "
> 		       "to target state\n");
>
> +	/* XXX Enable smartreflex after suspend */
> +	enable_smartreflex(SR1);
> +	enable_smartreflex(SR2);
> +
> 	return ret;
> }
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/ 
> smartreflex.c
> index dae7460..068944c 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -3,6 +3,9 @@
>  *
>  * OMAP34XX SmartReflex Voltage Control
>  *
> + * Copyright (C) 2008 Nokia Corporation
> + * Kalle Jokiniemi
> + *
>  * Copyright (C) 2007 Texas Instruments, Inc.
>  * Lesly A M <x0080970@ti.com>
>  *
> @@ -20,13 +23,14 @@
> #include <linux/err.h>
> #include <linux/clk.h>
> #include <linux/sysfs.h>
> -
> -#include <asm/arch/prcm.h>
> -#include <asm/arch/power_companion.h>
> +#include <linux/kobject.h>
> +#include <linux/i2c/twl4030.h>
> #include <linux/io.h>
>
> -#include "prcm-regs.h"
> +#include <asm/arch/omap34xx.h>
> +
> #include "smartreflex.h"
> +#include "prm-regbits-34xx.h"
>
>
> /* #define DEBUG_SR 1 */
> @@ -37,11 +41,16 @@
> #  define DPRINTK(fmt, args...)
> #endif
>
> +/* XXX: These should be relocated where-ever the OPP implementation  
> will be */
> +u32 current_vdd1_opp;
> +u32 current_vdd2_opp;
> +
> struct omap_sr{
> 	int srid;
> 	int is_sr_reset;
> 	int is_autocomp_active;
> 	struct clk *fck;
> +	u32 clk_length;
> 	u32 req_opp_no;
> 	u32 opp1_nvalue, opp2_nvalue, opp3_nvalue, opp4_nvalue, opp5_nvalue;
> 	u32 senp_mod, senn_mod;
> @@ -53,6 +62,7 @@ static struct omap_sr sr1 = {
> 	.srid = SR1,
> 	.is_sr_reset = 1,
> 	.is_autocomp_active = 0,
> +	.clk_length = 0,
> 	.srbase_addr = OMAP34XX_SR1_BASE,
> };
>
> @@ -60,6 +70,7 @@ static struct omap_sr sr2 = {
> 	.srid = SR2,
> 	.is_sr_reset = 1,
> 	.is_autocomp_active = 0,
> +	.clk_length = 0,
> 	.srbase_addr = OMAP34XX_SR2_BASE,
> };
>
> @@ -85,8 +96,6 @@ static inline u32 sr_read_reg(struct omap_sr *sr,  
> int offset)
> 	return omap_readl(sr->srbase_addr + offset);
> }
>
> -
> -#ifndef USE_EFUSE_VALUES
> static void cal_reciprocal(u32 sensor, u32 *sengain, u32 *rnsen)
> {
> 	u32 gn, rn, mul;
> @@ -100,7 +109,21 @@ static void cal_reciprocal(u32 sensor, u32  
> *sengain, u32 *rnsen)
> 		}
> 	}
> }
> -#endif
> +
> +static void sr_clk_get(struct omap_sr *sr)
> +{
> +	if (sr->srid == SR1) {
> +		sr->fck = clk_get(NULL, "sr1_fck");
> +		if (IS_ERR(sr->fck))
> +			printk(KERN_ERR "Could not get sr1_fck\n");
> +
> +	} else if (sr->srid == SR2) {
> +		sr->fck = clk_get(NULL, "sr2_fck");
> +		if (IS_ERR(sr->fck))
> +			printk(KERN_ERR "Could not get sr2_fck\n");
> +
> +	}
> +}
>
> static int sr_clk_enable(struct omap_sr *sr)
> {
> @@ -131,20 +154,48 @@ static int sr_clk_disable(struct omap_sr *sr)
> 	return 0;
> }
>
> +static void sr_set_clk_length(struct omap_sr *sr)
> +{
> +	struct clk *osc_sys_ck;
> +	u32 sys_clk = 0;
> +
> +	osc_sys_ck = clk_get(NULL, "osc_sys_ck");
> +	sys_clk = clk_get_rate(osc_sys_ck);
> +	clk_put(osc_sys_ck);
> +
> +	switch (sys_clk) {
> +	case 12000000:
> +		sr->clk_length = SRCLKLENGTH_12MHZ_SYSCLK;
> +		break;
> +	case 13000000:
> +		sr->clk_length = SRCLKLENGTH_13MHZ_SYSCLK;
> +		break;
> +	case 19200000:
> +		sr->clk_length = SRCLKLENGTH_19MHZ_SYSCLK;
> +		break;
> +	case 26000000:
> +		sr->clk_length = SRCLKLENGTH_26MHZ_SYSCLK;
> +		break;
> +	case 38400000:
> +		sr->clk_length = SRCLKLENGTH_38MHZ_SYSCLK;
> +		break;
> +	default :
> +		printk(KERN_ERR "Invalid sysclk value: %d\n", sys_clk);
> +		break;
> +	}
> +}
> +
> +/*
> + * TODO: once EFUSE is available, it should be used instead of these
> + * pre-calculated values.
> + */
> static void sr_set_nvalues(struct omap_sr *sr)
> {
> -#ifdef USE_EFUSE_VALUES
> -	u32 n1, n2;
> -#else
> 	u32 senpval, sennval;
> 	u32 senpgain, senngain;
> 	u32 rnsenp, rnsenn;
> -#endif
>
> 	if (sr->srid == SR1) {
> -#ifdef USE_EFUSE_VALUES
> -		/* Read values for VDD1 from EFUSE */
> -#else
> 		/* since E-Fuse Values are not available, calculating the
> 		 * reciprocal of the SenN and SenP values for SR1
> 		 */
> @@ -216,15 +267,16 @@ static void sr_set_nvalues(struct omap_sr *sr)
> 				(rnsenp << NVALUERECIPROCAL_RNSENP_SHIFT) |
> 				(rnsenn << NVALUERECIPROCAL_RNSENN_SHIFT));
>
> +		/* XXX The clocks are enabled in the startup and NVALUE is
> +		 * set also there. Disabling this for now, but this could
> +		 * be related to dynamic sleep during boot */
> +#if 0
> 		sr_clk_enable(sr);
> 		sr_write_reg(sr, NVALUERECIPROCAL, sr->opp3_nvalue);
> 		sr_clk_disable(sr);
> -
> #endif
> +
> 	} else if (sr->srid == SR2) {
> -#ifdef USE_EFUSE_VALUES
> -		/* Read values for VDD2 from EFUSE */
> -#else
> 		/* since E-Fuse Values are not available, calculating the
> 		 * reciprocal of the SenN and SenP values for SR2
> 		 */
> @@ -269,8 +321,6 @@ static void sr_set_nvalues(struct omap_sr *sr)
> 				(senngain << NVALUERECIPROCAL_SENNGAIN_SHIFT) |
> 				(rnsenp << NVALUERECIPROCAL_RNSENP_SHIFT) |
> 				(rnsenn << NVALUERECIPROCAL_RNSENN_SHIFT));
> -
> -#endif
> 	}
>
> }
> @@ -281,122 +331,126 @@ static void sr_configure_vp(int srid)
>
> 	if (srid == SR1) {
> 		vpconfig = PRM_VP1_CONFIG_ERROROFFSET | PRM_VP1_CONFIG_ERRORGAIN
> -			| PRM_VP1_CONFIG_INITVOLTAGE | PRM_VP1_CONFIG_TIMEOUTEN;
> +					| PRM_VP1_CONFIG_INITVOLTAGE
> +					| PRM_VP1_CONFIG_TIMEOUTEN;
>
> -		PRM_VP1_CONFIG = vpconfig;
> -		PRM_VP1_VSTEPMIN = PRM_VP1_VSTEPMIN_SMPSWAITTIMEMIN |
> -						PRM_VP1_VSTEPMIN_VSTEPMIN;
> +		__raw_writel(vpconfig, OMAP3430_PRM_VP1_CONFIG);
> +		__raw_writel(PRM_VP1_VSTEPMIN_SMPSWAITTIMEMIN |
> +					PRM_VP1_VSTEPMIN_VSTEPMIN,
> +					OMAP3430_PRM_VP1_VSTEPMIN);
>
> -		PRM_VP1_VSTEPMAX = PRM_VP1_VSTEPMAX_SMPSWAITTIMEMAX |
> -						PRM_VP1_VSTEPMAX_VSTEPMAX;
> +		__raw_writel(PRM_VP1_VSTEPMAX_SMPSWAITTIMEMAX |
> +					PRM_VP1_VSTEPMAX_VSTEPMAX,
> +					OMAP3430_PRM_VP1_VSTEPMAX);
>
> -		PRM_VP1_VLIMITTO = PRM_VP1_VLIMITTO_VDDMAX |
> -			PRM_VP1_VLIMITTO_VDDMIN | PRM_VP1_VLIMITTO_TIMEOUT;
> +		__raw_writel(PRM_VP1_VLIMITTO_VDDMAX | PRM_VP1_VLIMITTO_VDDMIN |
> +					PRM_VP1_VLIMITTO_TIMEOUT,
> +					OMAP3430_PRM_VP1_VLIMITTO);
>
> -		PRM_VP1_CONFIG |= PRM_VP1_CONFIG_INITVDD;
> -		PRM_VP1_CONFIG &= ~PRM_VP1_CONFIG_INITVDD;
> +		/* Trigger initVDD value copy to voltage processor */
> +		prm_rmw_reg_bits(PRM_VP1_CONFIG_INITVDD, PRM_VP1_CONFIG_INITVDD,
> +					OMAP3430_PRM_VP1_CONFIG);
> +		/* Reset initVDD copy trigger bit */
> +		prm_rmw_reg_bits(PRM_VP1_CONFIG_INITVDD, 0,
> +					OMAP3430_PRM_VP1_CONFIG);
>
> 	} else if (srid == SR2) {
> 		vpconfig = PRM_VP2_CONFIG_ERROROFFSET | PRM_VP2_CONFIG_ERRORGAIN
> -			| PRM_VP2_CONFIG_INITVOLTAGE | PRM_VP2_CONFIG_TIMEOUTEN;
> +					| PRM_VP2_CONFIG_INITVOLTAGE
> +					| PRM_VP2_CONFIG_TIMEOUTEN;
>
> -		PRM_VP2_CONFIG = vpconfig;
> -		PRM_VP2_VSTEPMIN = PRM_VP2_VSTEPMIN_SMPSWAITTIMEMIN |
> -						PRM_VP2_VSTEPMIN_VSTEPMIN;
> +		__raw_writel(vpconfig, OMAP3430_PRM_VP2_CONFIG);
> +		__raw_writel(PRM_VP2_VSTEPMIN_SMPSWAITTIMEMIN |
> +					PRM_VP2_VSTEPMIN_VSTEPMIN,
> +					OMAP3430_PRM_VP2_VSTEPMIN);
>
> -		PRM_VP2_VSTEPMAX = PRM_VP2_VSTEPMAX_SMPSWAITTIMEMAX |
> -						PRM_VP2_VSTEPMAX_VSTEPMAX;
> +		__raw_writel(PRM_VP2_VSTEPMAX_SMPSWAITTIMEMAX |
> +					PRM_VP2_VSTEPMAX_VSTEPMAX,
> +					OMAP3430_PRM_VP2_VSTEPMAX);
>
> -		PRM_VP2_VLIMITTO = PRM_VP2_VLIMITTO_VDDMAX |
> -			PRM_VP2_VLIMITTO_VDDMIN | PRM_VP2_VLIMITTO_TIMEOUT;
> +		__raw_writel(PRM_VP2_VLIMITTO_VDDMAX | PRM_VP2_VLIMITTO_VDDMIN |
> +					PRM_VP2_VLIMITTO_TIMEOUT,
> +					OMAP3430_PRM_VP2_VLIMITTO);
>
> -		PRM_VP2_CONFIG |= PRM_VP2_CONFIG_INITVDD;
> -		PRM_VP2_CONFIG &= ~PRM_VP2_CONFIG_INITVDD;
> +		/* Trigger initVDD value copy to voltage processor */
> +		prm_rmw_reg_bits(PRM_VP2_CONFIG_INITVDD, PRM_VP2_CONFIG_INITVDD,
> +					OMAP3430_PRM_VP2_CONFIG);
> +		/* Reset initVDD copy trigger bit */
> +		prm_rmw_reg_bits(PRM_VP2_CONFIG_INITVDD, 0,
> +					OMAP3430_PRM_VP2_CONFIG);
>
> 	}
> }
>
> static void sr_configure_vc(void)
> {
> -	PRM_VC_SMPS_SA =
> -		(R_SRI2C_SLAVE_ADDR << PRM_VC_SMPS_SA1_SHIFT) |
> -		(R_SRI2C_SLAVE_ADDR << PRM_VC_SMPS_SA0_SHIFT);
> +	__raw_writel((R_SRI2C_SLAVE_ADDR << OMAP3430_SMPS_SA1_SHIFT) |
> +			(R_SRI2C_SLAVE_ADDR << OMAP3430_SMPS_SA0_SHIFT),
> +			OMAP3430_PRM_VC_SMPS_SA);
>
> -	PRM_VC_SMPS_VOL_RA = (R_VDD2_SR_CONTROL <<  
> PRM_VC_SMPS_VOLRA1_SHIFT) |
> -				(R_VDD1_SR_CONTROL << PRM_VC_SMPS_VOLRA0_SHIFT);
> +	__raw_writel((R_VDD2_SR_CONTROL << OMAP3430_VOLRA1_SHIFT) |
> +			(R_VDD1_SR_CONTROL << OMAP3430_VOLRA0_SHIFT),
> +			OMAP3430_PRM_VC_SMPS_VOL_RA);
>
> -	PRM_VC_CMD_VAL_0 = (PRM_VC_CMD_VAL0_ON << PRM_VC_CMD_ON_SHIFT) |
> -			(PRM_VC_CMD_VAL0_ONLP << PRM_VC_CMD_ONLP_SHIFT) |
> -			(PRM_VC_CMD_VAL0_RET << PRM_VC_CMD_RET_SHIFT) |
> -			(PRM_VC_CMD_VAL0_OFF << PRM_VC_CMD_OFF_SHIFT);
> +	__raw_writel((OMAP3430_VC_CMD_VAL0_ON << OMAP3430_VC_CMD_ON_SHIFT) |
> +		(OMAP3430_VC_CMD_VAL0_ONLP << OMAP3430_VC_CMD_ONLP_SHIFT) |
> +		(OMAP3430_VC_CMD_VAL0_RET << OMAP3430_VC_CMD_RET_SHIFT) |
> +		(OMAP3430_VC_CMD_VAL0_OFF << OMAP3430_VC_CMD_OFF_SHIFT),
> +		OMAP3430_PRM_VC_CMD_VAL_0);
>
> -	PRM_VC_CMD_VAL_1 = (PRM_VC_CMD_VAL1_ON << PRM_VC_CMD_ON_SHIFT) |
> -			(PRM_VC_CMD_VAL1_ONLP << PRM_VC_CMD_ONLP_SHIFT) |
> -			(PRM_VC_CMD_VAL1_RET << PRM_VC_CMD_RET_SHIFT) |
> -			(PRM_VC_CMD_VAL1_OFF << PRM_VC_CMD_OFF_SHIFT);
> +	__raw_writel((OMAP3430_VC_CMD_VAL1_ON << OMAP3430_VC_CMD_ON_SHIFT) |
> +		(OMAP3430_VC_CMD_VAL1_ONLP << OMAP3430_VC_CMD_ONLP_SHIFT) |
> +		(OMAP3430_VC_CMD_VAL1_RET << OMAP3430_VC_CMD_RET_SHIFT) |
> +		(OMAP3430_VC_CMD_VAL1_OFF << OMAP3430_VC_CMD_OFF_SHIFT),
> +		OMAP3430_PRM_VC_CMD_VAL_1);
>
> -	PRM_VC_CH_CONF = PRM_VC_CH_CONF_CMD1 | PRM_VC_CH_CONF_RAV1;
> +	__raw_writel(OMAP3430_CMD1 | OMAP3430_RAV1,  
> OMAP3430_PRM_VC_CH_CONF);
>
> -	PRM_VC_I2C_CFG = PRM_VC_I2C_CFG_MCODE | PRM_VC_I2C_CFG_HSEN
> -							| PRM_VC_I2C_CFG_SREN;
> +	__raw_writel(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN | OMAP3430_SREN,
> +				OMAP3430_PRM_VC_I2C_CFG);
>
> 	/* Setup voltctrl and other setup times */
> +	/* XXX CONFIG_SYSOFFMODE has not been implemented yet */
> #ifdef CONFIG_SYSOFFMODE
> -	PRM_VOLTCTRL = PRM_VOLTCTRL_AUTO_OFF | PRM_VOLTCTRL_AUTO_RET;
> -	PRM_CLKSETUP = PRM_CLKSETUP_DURATION;
> -	PRM_VOLTSETUP1 = (PRM_VOLTSETUP_TIME2 <<  
> PRM_VOLTSETUP_TIME2_OFFSET) |
> -			(PRM_VOLTSETUP_TIME1 << PRM_VOLTSETUP_TIME1_OFFSET);
> -	PRM_VOLTOFFSET = PRM_VOLTOFFSET_DURATION;
> -	PRM_VOLTSETUP2 = PRM_VOLTSETUP2_DURATION;
> +	__raw_writel(OMAP3430_AUTO_OFF | OMAP3430_AUTO_RET,
> +			OMAP3430_PRM_VOLTCTRL);
> +
> +	__raw_writel(OMAP3430_CLKSETUP_DURATION, OMAP3430_PRM_CLKSETUP);
> +	__raw_writel((OMAP3430_VOLTSETUP_TIME2 <<
> +			OMAP3430_VOLTSETUP_TIME2_OFFSET) |
> +			(OMAP3430_VOLTSETUP_TIME1 <<
> +			OMAP3430_VOLTSETUP_TIME1_OFFSET),
> +			OMAP3430_PRM_VOLTSETUP1);
> +
> +	__raw_writel(OMAP3430_VOLTOFFSET_DURATION, OMAP3430_PRM_VOLTOFFSET);
> +	__raw_writel(OMAP3430_VOLTSETUP2_DURATION, OMAP3430_PRM_VOLTSETUP2);
> #else
> -	PRM_VOLTCTRL |= PRM_VOLTCTRL_AUTO_RET;
> +	prm_rmw_reg_bits(OMAP3430_AUTO_RET, OMAP3430_AUTO_RET,
> +				OMAP3430_PRM_VOLTCTRL);
> #endif
>
> }
>
> -
> static void sr_configure(struct omap_sr *sr)
> {
> -	u32 sys_clk, sr_clk_length = 0;
> 	u32 sr_config;
> 	u32 senp_en , senn_en;
>
> +	if (sr->clk_length == 0)
> +		sr_set_clk_length(sr);
> +
> 	senp_en = sr->senp_mod;
> 	senn_en = sr->senn_mod;
> -
> -	sys_clk = prcm_get_system_clock_speed();
> -
> -	switch (sys_clk) {
> -	case 12000:
> -		sr_clk_length = SRCLKLENGTH_12MHZ_SYSCLK;
> -		break;
> -	case 13000:
> -		sr_clk_length = SRCLKLENGTH_13MHZ_SYSCLK;
> -		break;
> -	case 19200:
> -		sr_clk_length = SRCLKLENGTH_19MHZ_SYSCLK;
> -		break;
> -	case 26000:
> -		sr_clk_length = SRCLKLENGTH_26MHZ_SYSCLK;
> -		break;
> -	case 38400:
> -		sr_clk_length = SRCLKLENGTH_38MHZ_SYSCLK;
> -		break;
> -	default :
> -		printk(KERN_ERR "Invalid sysclk value\n");
> -		break;
> -	}
> -
> -	DPRINTK(KERN_DEBUG "SR : sys clk %lu\n", sys_clk);
> 	if (sr->srid == SR1) {
> 		sr_config = SR1_SRCONFIG_ACCUMDATA |
> -			(sr_clk_length << SRCONFIG_SRCLKLENGTH_SHIFT) |
> +			(sr->clk_length << SRCONFIG_SRCLKLENGTH_SHIFT) |
> 			SRCONFIG_SENENABLE | SRCONFIG_ERRGEN_EN |
> 			SRCONFIG_MINMAXAVG_EN |
> 			(senn_en << SRCONFIG_SENNENABLE_SHIFT) |
> 			(senp_en << SRCONFIG_SENPENABLE_SHIFT) |
> 			SRCONFIG_DELAYCTRL;
> -
> +		DPRINTK(KERN_DEBUG "setting SRCONFIG1 to 0x%08lx\n",
> +						(unsigned long int) sr_config);
> 		sr_write_reg(sr, SRCONFIG, sr_config);
>
> 		sr_write_reg(sr, AVGWEIGHT, SR1_AVGWEIGHT_SENPAVGWEIGHT |
> @@ -408,18 +462,18 @@ static void sr_configure(struct omap_sr *sr)
>
> 	} else if (sr->srid == SR2) {
> 		sr_config = SR2_SRCONFIG_ACCUMDATA |
> -			(sr_clk_length << SRCONFIG_SRCLKLENGTH_SHIFT) |
> +			(sr->clk_length << SRCONFIG_SRCLKLENGTH_SHIFT) |
> 			SRCONFIG_SENENABLE | SRCONFIG_ERRGEN_EN |
> 			SRCONFIG_MINMAXAVG_EN |
> 			(senn_en << SRCONFIG_SENNENABLE_SHIFT) |
> 			(senp_en << SRCONFIG_SENPENABLE_SHIFT) |
> 			SRCONFIG_DELAYCTRL;
>
> +		DPRINTK(KERN_DEBUG "setting SRCONFIG2 to 0x%08lx\n",
> +						(unsigned long int) sr_config);
> 		sr_write_reg(sr, SRCONFIG, sr_config);
> -
> 		sr_write_reg(sr, AVGWEIGHT, SR2_AVGWEIGHT_SENPAVGWEIGHT |
> 					SR2_AVGWEIGHT_SENNAVGWEIGHT);
> -
> 		sr_modify_reg(sr, ERRCONFIG, (SR_ERRWEIGHT_MASK |
> 			SR_ERRMAXLIMIT_MASK | SR_ERRMINLIMIT_MASK),
> 			(SR2_ERRWEIGHT | SR2_ERRMAXLIMIT | SR2_ERRMINLIMIT));
> @@ -476,7 +530,6 @@ static void sr_enable(struct omap_sr *sr, u32  
> target_opp_no)
>
> 	if (current_nvalue == nvalue_reciprocal) {
> 		DPRINTK("System is already at the desired voltage level\n");
> -		return;
> 	}
>
> 	sr_write_reg(sr, NVALUERECIPROCAL, nvalue_reciprocal);
> @@ -485,18 +538,20 @@ static void sr_enable(struct omap_sr *sr, u32  
> target_opp_no)
> 	sr_modify_reg(sr, ERRCONFIG,
> 			(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST),
> 			(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST));
> -
> 	if (sr->srid == SR1) {
> 		/* Enable VP1 */
> -		PRM_VP1_CONFIG |= PRM_VP1_CONFIG_VPENABLE;
> +		prm_rmw_reg_bits(PRM_VP1_CONFIG_VPENABLE,
> +				PRM_VP1_CONFIG_VPENABLE,
> +				OMAP3430_PRM_VP1_CONFIG);
> 	} else if (sr->srid == SR2) {
> 		/* Enable VP2 */
> -		PRM_VP2_CONFIG |= PRM_VP2_CONFIG_VPENABLE;
> +		prm_rmw_reg_bits(PRM_VP2_CONFIG_VPENABLE,
> +				PRM_VP2_CONFIG_VPENABLE,
> +				OMAP3430_PRM_VP2_CONFIG);
> 	}
>
> 	/* SRCONFIG - enable SR */
> 	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, SRCONFIG_SRENABLE);
> -
> }
>
> static void sr_disable(struct omap_sr *sr)
> @@ -507,11 +562,13 @@ static void sr_disable(struct omap_sr *sr)
> 	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, ~SRCONFIG_SRENABLE);
>
> 	if (sr->srid == SR1) {
> -		/* Enable VP1 */
> -		PRM_VP1_CONFIG &= ~PRM_VP1_CONFIG_VPENABLE;
> +		/* Disable VP1 */
> +		prm_rmw_reg_bits(PRM_VP1_CONFIG_VPENABLE, 0,
> +					OMAP3430_PRM_VP1_CONFIG);
> 	} else if (sr->srid == SR2) {
> -		/* Enable VP2 */
> -		PRM_VP2_CONFIG &= ~PRM_VP2_CONFIG_VPENABLE;
> +		/* Disable VP2 */
> +		prm_rmw_reg_bits(PRM_VP2_CONFIG_VPENABLE, 0,
> +					OMAP3430_PRM_VP2_CONFIG);
> 	}
> }
>
> @@ -574,16 +631,13 @@ void enable_smartreflex(int srid)
>
> 	if (sr->is_autocomp_active == 1) {
> 		if (sr->is_sr_reset == 1) {
> -			if (srid == SR1) {
> -				/* Enable SR clks */
> -				CM_FCLKEN_WKUP |= SR1_CLK_ENABLE;
> -				target_opp_no = get_opp_no(current_vdd1_opp);
> +			/* Enable SR clks */
> +			sr_clk_enable(sr);
>
> -			} else if (srid == SR2) {
> -				/* Enable SR clks */
> -				CM_FCLKEN_WKUP |= SR2_CLK_ENABLE;
> +			if (srid == SR1)
> +				target_opp_no = get_opp_no(current_vdd1_opp);
> +			else if (srid == SR2)
> 				target_opp_no = get_opp_no(current_vdd2_opp);
> -			}
>
> 			sr_configure(sr);
>
> @@ -602,15 +656,6 @@ void disable_smartreflex(int srid)
> 		sr = &sr2;
>
> 	if (sr->is_autocomp_active == 1) {
> -		if (srid == SR1) {
> -			/* Enable SR clk */
> -			CM_FCLKEN_WKUP |= SR1_CLK_ENABLE;
> -
> -		} else if (srid == SR2) {
> -			/* Enable SR clk */
> -			CM_FCLKEN_WKUP |= SR2_CLK_ENABLE;
> -		}
> -
> 		if (sr->is_sr_reset == 0) {
>
> 			sr->is_sr_reset = 1;
> @@ -618,17 +663,16 @@ void disable_smartreflex(int srid)
> 			sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE,
> 							~SRCONFIG_SRENABLE);
>
> +			/* Disable SR clk */
> +			sr_clk_disable(sr);
> 			if (sr->srid == SR1) {
> -				/* Disable SR clk */
> -				CM_FCLKEN_WKUP &= ~SR1_CLK_ENABLE;
> -				/* Enable VP1 */
> -				PRM_VP1_CONFIG &= ~PRM_VP1_CONFIG_VPENABLE;
> -
> +				/* Disable VP1 */
> +				prm_rmw_reg_bits(PRM_VP1_CONFIG_VPENABLE, 0,
> +						OMAP3430_PRM_VP1_CONFIG);
> 			} else if (sr->srid == SR2) {
> -				/* Disable SR clk */
> -				CM_FCLKEN_WKUP &= ~SR2_CLK_ENABLE;
> -				/* Enable VP2 */
> -				PRM_VP2_CONFIG &= ~PRM_VP2_CONFIG_VPENABLE;
> +				/* Disable VP2 */
> +				prm_rmw_reg_bits(PRM_VP2_CONFIG_VPENABLE, 0,
> +						OMAP3430_PRM_VP2_CONFIG);
> 			}
> 		}
> 	}
> @@ -638,7 +682,6 @@ void disable_smartreflex(int srid)
> /* Voltage Scaling using SR VCBYPASS */
> int sr_voltagescale_vcbypass(u32 target_opp, u8 vsel)
> {
> -	int ret;
> 	int sr_status = 0;
> 	u32 vdd, target_opp_no;
> 	u32 vc_bypass_value;
> @@ -651,39 +694,48 @@ int sr_voltagescale_vcbypass(u32 target_opp,  
> u8 vsel)
> 	if (vdd == PRCM_VDD1) {
> 		sr_status = sr_stop_vddautocomap(SR1);
>
> -		PRM_VC_CMD_VAL_0 = (PRM_VC_CMD_VAL_0 & ~PRM_VC_CMD_ON_MASK) |
> -						(vsel << PRM_VC_CMD_ON_SHIFT);
> +		prm_rmw_reg_bits(OMAP3430_VC_CMD_ON_MASK,
> +					(vsel << OMAP3430_VC_CMD_ON_SHIFT),
> +					OMAP3430_PRM_VC_CMD_VAL_0);
> 		reg_addr = R_VDD1_SR_CONTROL;
>
> 	} else if (vdd == PRCM_VDD2) {
> 		sr_status = sr_stop_vddautocomap(SR2);
>
> -		PRM_VC_CMD_VAL_1 = (PRM_VC_CMD_VAL_1 & ~PRM_VC_CMD_ON_MASK) |
> -						(vsel << PRM_VC_CMD_ON_SHIFT);
> +		prm_rmw_reg_bits(OMAP3430_VC_CMD_ON_MASK,
> +					(vsel << OMAP3430_VC_CMD_ON_SHIFT),
> +					OMAP3430_PRM_VC_CMD_VAL_1);
> 		reg_addr = R_VDD2_SR_CONTROL;
> 	}
>
> -	vc_bypass_value = (vsel << PRM_VC_BYPASS_DATA_SHIFT) |
> -			(reg_addr << PRM_VC_BYPASS_REGADDR_SHIFT) |
> -			(R_SRI2C_SLAVE_ADDR << PRM_VC_BYPASS_SLAVEADDR_SHIFT);
> +	vc_bypass_value = (vsel << OMAP3430_DATA_SHIFT) |
> +			(reg_addr << OMAP3430_REGADDR_SHIFT) |
> +			(R_SRI2C_SLAVE_ADDR << OMAP3430_SLAVEADDR_SHIFT);
>
> -	PRM_VC_BYPASS_VAL = vc_bypass_value;
> +	__raw_writel(vc_bypass_value, OMAP3430_PRM_VC_BYPASS_VAL);
>
> -	PRM_VC_BYPASS_VAL |= PRM_VC_BYPASS_VALID;
> +	vc_bypass_value = prm_rmw_reg_bits(OMAP3430_VALID, OMAP3430_VALID,
> +						OMAP3430_PRM_VC_BYPASS_VAL);
>
> -	DPRINTK("%s : PRM_VC_BYPASS_VAL %X\n", __func__, PRM_VC_BYPASS_VAL);
> -	DPRINTK("PRM_IRQST_MPU %X\n", PRM_IRQSTATUS_MPU);
> +	DPRINTK("%s : PRM_VC_BYPASS_VAL %X\n", __func__, vc_bypass_value);
> +	DPRINTK("PRM_IRQST_MPU %X\n",  
> __raw_readl(OMAP3430_PRM_IRQSTATUS_MPU));
>
> -	while ((PRM_VC_BYPASS_VAL & PRM_VC_BYPASS_VALID) != 0x0) {
> -		ret = loop_wait(&loop_cnt, &retries_cnt, 10);
> -		if (ret != PRCM_PASS) {
> +	while ((vc_bypass_value & OMAP3430_VALID) != 0x0) {
> +		loop_cnt++;
> +		if (retries_cnt > 10) {
> 			printk(KERN_INFO "Loop count exceeded in check SR I2C"
> 								"write\n");
> -			return ret;
> +			return SR_FAIL;
> +		}
> +		if (loop_cnt > 50) {
> +			retries_cnt++;
> +			loop_cnt = 0;
> +			udelay(10);
> 		}
> +		vc_bypass_value = __raw_readl(OMAP3430_PRM_VC_BYPASS_VAL);
> 	}
>
> -	omap_udelay(T2_SMPS_UPDATE_DELAY);
> +	udelay(T2_SMPS_UPDATE_DELAY);
>
> 	if (sr_status) {
> 		if (vdd == PRCM_VDD1)
> @@ -696,13 +748,15 @@ int sr_voltagescale_vcbypass(u32 target_opp,  
> u8 vsel)
> }
>
> /* Sysfs interface to select SR VDD1 auto compensation */
> -static ssize_t omap_sr_vdd1_autocomp_show(struct kset *subsys, char  
> *buf)
> +static ssize_t omap_sr_vdd1_autocomp_show(struct kobject *kobj,
> +					struct kobj_attribute *attr, char *buf)
> {
> 	return sprintf(buf, "%d\n", sr1.is_autocomp_active);
> }
>
> -static ssize_t omap_sr_vdd1_autocomp_store(struct kset *subsys,
> -				const char *buf, size_t n)
> +static ssize_t omap_sr_vdd1_autocomp_store(struct kobject *kobj,
> +					struct kobj_attribute *attr,
> +					const char *buf, size_t n)
> {
> 	u32 current_vdd1opp_no;
> 	unsigned short value;
> @@ -722,7 +776,7 @@ static ssize_t  
> omap_sr_vdd1_autocomp_store(struct kset *subsys,
> 	return n;
> }
>
> -static struct subsys_attribute sr_vdd1_autocomp = {
> +static struct kobj_attribute sr_vdd1_autocomp = {
> 	.attr = {
> 	.name = __stringify(sr_vdd1_autocomp),
> 	.mode = 0644,
> @@ -732,13 +786,15 @@ static struct subsys_attribute  
> sr_vdd1_autocomp = {
> };
>
> /* Sysfs interface to select SR VDD2 auto compensation */
> -static ssize_t omap_sr_vdd2_autocomp_show(struct kset *subsys, char  
> *buf)
> +static ssize_t omap_sr_vdd2_autocomp_show(struct kobject *kobj,
> +					struct kobj_attribute *attr, char *buf)
> {
> 	return sprintf(buf, "%d\n", sr2.is_autocomp_active);
> }
>
> -static ssize_t omap_sr_vdd2_autocomp_store(struct kset *subsys,
> -				const char *buf, size_t n)
> +static ssize_t omap_sr_vdd2_autocomp_store(struct kobject *kobj,
> +					struct kobj_attribute *attr,
> +					const char *buf, size_t n)
> {
> 	u32 current_vdd2opp_no;
> 	unsigned short value;
> @@ -758,7 +814,7 @@ static ssize_t  
> omap_sr_vdd2_autocomp_store(struct kset *subsys,
> 	return n;
> }
>
> -static struct subsys_attribute sr_vdd2_autocomp = {
> +static struct kobj_attribute sr_vdd2_autocomp = {
> 	.attr = {
> 	.name = __stringify(sr_vdd2_autocomp),
> 	.mode = 0644,
> @@ -774,15 +830,19 @@ static int __init omap3_sr_init(void)
> 	int ret = 0;
> 	u8 RdReg;
>
> -#ifdef CONFIG_ARCH_OMAP34XX
> -	sr1.fck = clk_get(NULL, "sr1_fck");
> -	if (IS_ERR(sr1.fck))
> -		printk(KERN_ERR "Could not get sr1_fck\n");
> -
> -	sr2.fck = clk_get(NULL, "sr2_fck");
> -	if (IS_ERR(sr2.fck))
> -		printk(KERN_ERR "Could not get sr2_fck\n");
> -#endif /* #ifdef CONFIG_ARCH_OMAP34XX */
> +	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
> +		current_vdd1_opp = PRCM_VDD1_OPP3;
> +		current_vdd2_opp = PRCM_VDD2_OPP3;
> +	} else {
> +		current_vdd1_opp = PRCM_VDD1_OPP1;
> +		current_vdd2_opp = PRCM_VDD1_OPP1;
> +	}
> +	if (cpu_is_omap34xx()) {
> +		sr_clk_get(&sr1);
> +		sr_clk_get(&sr2);
> +	}
> +	sr_set_clk_length(&sr1);
> +	sr_set_clk_length(&sr2);
>
> 	/* Call the VPConfig, VCConfig, set N Values. */
> 	sr_set_nvalues(&sr1);
> @@ -794,22 +854,24 @@ static int __init omap3_sr_init(void)
> 	sr_configure_vc();
>
> 	/* Enable SR on T2 */
> -	ret = t2_in(PM_RECEIVER, &RdReg, R_DCDC_GLOBAL_CFG);
> -	RdReg |= DCDC_GLOBAL_CFG_ENABLE_SRFLX;
> -	ret |= t2_out(PM_RECEIVER, RdReg, R_DCDC_GLOBAL_CFG);
> +	ret = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &RdReg,
> +					R_DCDC_GLOBAL_CFG);
>
> +	RdReg |= DCDC_GLOBAL_CFG_ENABLE_SRFLX;
> +	ret |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, RdReg,
> +					R_DCDC_GLOBAL_CFG);
>
> 	printk(KERN_INFO "SmartReflex driver initialized\n");
>
> -	ret = subsys_create_file(&power_subsys, &sr_vdd1_autocomp);
> +	ret = sysfs_create_file(power_kobj, &sr_vdd1_autocomp.attr);
> 	if (ret)
> -		printk(KERN_ERR "subsys_create_file failed: %d\n", ret);
> +		printk(KERN_ERR "sysfs_create_file failed: %d\n", ret);
>
> -	ret = subsys_create_file(&power_subsys, &sr_vdd2_autocomp);
> +	ret = sysfs_create_file(power_kobj, &sr_vdd2_autocomp.attr);
> 	if (ret)
> -		printk(KERN_ERR "subsys_create_file failed: %d\n", ret);
> +		printk(KERN_ERR "sysfs_create_file failed: %d\n", ret);
>
> 	return 0;
> }
>
> -arch_initcall(omap3_sr_init);
> +late_initcall(omap3_sr_init);
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIQmkPMkyGM64RGpERAjI+AJ4wONfJ6jT0eCXtBRnV0L6oniu9LACgjZBp
k4rTRzmCLqSuzIjjCZkzQog=
=IQ5m
-----END PGP SIGNATURE-----

From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: SmartReflex driver: added required
	register and bit definitions.
Date: Thu, 19 Jun 2008 13:41:06 +0300
Message-ID: <1213872066.7667.16.camel@kj-ubuntu>
References: <>
	 <1213687386-15053-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:56346 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755602AbYFSKjn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jun 2008 06:39:43 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5JAdZ8Z027477
	for <linux-omap@vger.kernel.org>; Thu, 19 Jun 2008 05:39:41 -0500
In-Reply-To: <1213687386-15053-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch does not seem to apply cleanly with the latest tree changes,
so I'm resending a refreshed version.

--
Kalle

On ti, 2008-06-17 at 10:23 +0300, Kalle Jokiniemi wrote:
> Added new register and bit definitions to enable Smartreflex driver
> integration. Also PRM_VC_SMPS_SA bit definitions' naming was changed to match
> the naming of other similar bit definitions.
> 
> Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
> ---
>  arch/arm/mach-omap2/prm-regbits-34xx.h |   27 +++-
>  arch/arm/mach-omap2/smartreflex.h      |  235 ++++++++++++++++++++++++++++++++
>  include/asm-arm/arch-omap/control.h    |   19 +++
>  include/asm-arm/arch-omap/omap34xx.h   |    2 +
>  4 files changed, 278 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/smartreflex.h
> 
> diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
> index c6a7940..f82b5a7 100644
> --- a/arch/arm/mach-omap2/prm-regbits-34xx.h
> +++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
> @@ -435,10 +435,10 @@
>  /* PM_PWSTST_EMU specific bits */
>  
>  /* PRM_VC_SMPS_SA */
> -#define OMAP3430_PRM_VC_SMPS_SA_SA1_SHIFT		16
> -#define OMAP3430_PRM_VC_SMPS_SA_SA1_MASK		(0x7f << 16)
> -#define OMAP3430_PRM_VC_SMPS_SA_SA0_SHIFT		0
> -#define OMAP3430_PRM_VC_SMPS_SA_SA0_MASK		(0x7f << 0)
> +#define OMAP3430_SMPS_SA1_SHIFT				16
> +#define OMAP3430_SMPS_SA1_MASK				(0x7f << 16)
> +#define OMAP3430_SMPS_SA0_SHIFT				0
> +#define OMAP3430_SMPS_SA0_MASK				(0x7f << 0)
>  
>  /* PRM_VC_SMPS_VOL_RA */
>  #define OMAP3430_VOLRA1_SHIFT				16
> @@ -452,7 +452,7 @@
>  #define OMAP3430_CMDRA0_SHIFT				0
>  #define OMAP3430_CMDRA0_MASK				(0xff << 0)
>  
> -/* PRM_VC_CMD_VAL_0 specific bits */
> +/* PRM_VC_CMD_VAL */
>  #define OMAP3430_VC_CMD_ON_SHIFT			24
>  #define OMAP3430_VC_CMD_ON_MASK				(0xFF << 24)
>  #define OMAP3430_VC_CMD_ONLP_SHIFT			16
> @@ -462,7 +462,17 @@
>  #define OMAP3430_VC_CMD_OFF_SHIFT			0
>  #define OMAP3430_VC_CMD_OFF_MASK			(0xFF << 0)
>  
> +/* PRM_VC_CMD_VAL_0 specific bits */
> +#define OMAP3430_VC_CMD_VAL0_ON				(0x3 << 4)
> +#define OMAP3430_VC_CMD_VAL0_ONLP			(0x3 << 3)
> +#define OMAP3430_VC_CMD_VAL0_RET			(0x3 << 3)
> +#define OMAP3430_VC_CMD_VAL0_OFF			(0x3 << 3)
> +
>  /* PRM_VC_CMD_VAL_1 specific bits */
> +#define OMAP3430_VC_CMD_VAL1_ON				(0xB << 2)
> +#define OMAP3430_VC_CMD_VAL1_ONLP			(0x3 << 3)
> +#define OMAP3430_VC_CMD_VAL1_RET			(0x3 << 3)
> +#define OMAP3430_VC_CMD_VAL1_OFF			(0x3 << 3)
>  
>  /* PRM_VC_CH_CONF */
>  #define OMAP3430_CMD1					(1 << 20)
> @@ -521,6 +531,13 @@
>  #define OMAP3430_AUTO_RET				(1 << 1)
>  #define OMAP3430_AUTO_SLEEP				(1 << 0)
>  
> +/* Constants to define setup durations */
> +#define OMAP3430_CLKSETUP_DURATION			0xff
> +#define OMAP3430_VOLTSETUP_TIME2			0xfff
> +#define OMAP3430_VOLTSETUP_TIME1			0xfff
> +#define OMAP3430_VOLTOFFSET_DURATION			0xff
> +#define OMAP3430_VOLTSETUP2_DURATION			0xff
> +
>  /* PRM_SRAM_PCHARGE */
>  #define OMAP3430_PCHARGE_TIME_SHIFT			0
>  #define OMAP3430_PCHARGE_TIME_MASK			(0xff << 0)
> diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
> new file mode 100644
> index 0000000..574329f
> --- /dev/null
> +++ b/arch/arm/mach-omap2/smartreflex.h
> @@ -0,0 +1,235 @@
> +#ifndef __ARCH_ARM_MACH_OMAP3_SMARTREFLEX_H
> +#define __ARCH_ARM_MACH_OMAP3_SMARTREFLEX_H
> +/*
> + * linux/arch/arm/mach-omap2/smartreflex.h
> + *
> + * Copyright (C) 2008 Nokia Corporation
> + * Kalle Jokiniemi
> + *
> + * Copyright (C) 2007 Texas Instruments, Inc.
> + * Lesly A M <x0080970@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#define PHY_TO_OFF_PM_MASTER(p)		(p - 0x36)
> +#define PHY_TO_OFF_PM_RECIEVER(p)	(p - 0x5b)
> +#define PHY_TO_OFF_PM_INT(p)		(p - 0x2e)
> +
> +/* SMART REFLEX REG ADDRESS OFFSET */
> +#define SRCONFIG	0x00
> +#define SRSTATUS	0x04
> +#define SENVAL		0x08
> +#define SENMIN		0x0C
> +#define SENMAX		0x10
> +#define SENAVG		0x14
> +#define AVGWEIGHT	0x18
> +#define NVALUERECIPROCAL	0x1C
> +#define SENERROR	0x20
> +#define ERRCONFIG	0x24
> +
> +/* SR Modules */
> +#define SR1		1
> +#define SR2		2
> +
> +#define SR_FAIL		1
> +#define SR_PASS		0
> +
> +#define SR_TRUE		1
> +#define SR_FALSE	0
> +
> +#define GAIN_MAXLIMIT	16
> +#define R_MAXLIMIT	256
> +
> +#define SR1_CLK_ENABLE	(0x1 << 6)
> +#define SR2_CLK_ENABLE	(0x1 << 7)
> +
> +/* PRM_VP1_CONFIG */
> +#define PRM_VP1_CONFIG_ERROROFFSET	(0x00 << 24)
> +#define PRM_VP1_CONFIG_ERRORGAIN	(0x20 << 16)
> +
> +#define PRM_VP1_CONFIG_INITVOLTAGE	(0x30 << 8) /* 1.2 volt */
> +#define PRM_VP1_CONFIG_TIMEOUTEN	(0x1 << 3)
> +#define PRM_VP1_CONFIG_INITVDD		(0x1 << 2)
> +#define PRM_VP1_CONFIG_FORCEUPDATE	(0x1 << 1)
> +#define PRM_VP1_CONFIG_VPENABLE		(0x1 << 0)
> +
> +/* PRM_VP1_VSTEPMIN */
> +#define PRM_VP1_VSTEPMIN_SMPSWAITTIMEMIN	(0x01F4 << 8)
> +#define PRM_VP1_VSTEPMIN_VSTEPMIN		(0x01 << 0)
> +
> +/* PRM_VP1_VSTEPMAX */
> +#define PRM_VP1_VSTEPMAX_SMPSWAITTIMEMAX	(0x01F4 << 8)
> +#define PRM_VP1_VSTEPMAX_VSTEPMAX		(0x04 << 0)
> +
> +/* PRM_VP1_VLIMITTO */
> +#define PRM_VP1_VLIMITTO_VDDMAX		(0x3C << 24)
> +#define PRM_VP1_VLIMITTO_VDDMIN		(0x0 << 16)
> +#define PRM_VP1_VLIMITTO_TIMEOUT	(0xFFFF << 0)
> +
> +/* PRM_VP2_CONFIG */
> +#define PRM_VP2_CONFIG_ERROROFFSET	(0x00 << 24)
> +#define PRM_VP2_CONFIG_ERRORGAIN	(0x20 << 16)
> +
> +#define PRM_VP2_CONFIG_INITVOLTAGE	(0x30 << 8) /* 1.2 volt */
> +#define PRM_VP2_CONFIG_TIMEOUTEN	(0x1 << 3)
> +#define PRM_VP2_CONFIG_INITVDD		(0x1 << 2)
> +#define PRM_VP2_CONFIG_FORCEUPDATE	(0x1 << 1)
> +#define PRM_VP2_CONFIG_VPENABLE		(0x1 << 0)
> +
> +/* PRM_VP2_VSTEPMIN */
> +#define PRM_VP2_VSTEPMIN_SMPSWAITTIMEMIN	(0x01F4 << 8)
> +#define PRM_VP2_VSTEPMIN_VSTEPMIN		(0x01 << 0)
> +
> +/* PRM_VP2_VSTEPMAX */
> +#define PRM_VP2_VSTEPMAX_SMPSWAITTIMEMAX	(0x01F4 << 8)
> +#define PRM_VP2_VSTEPMAX_VSTEPMAX		(0x04 << 0)
> +
> +/* PRM_VP2_VLIMITTO */
> +#define PRM_VP2_VLIMITTO_VDDMAX		(0x2C << 24)
> +#define PRM_VP2_VLIMITTO_VDDMIN		(0x0 << 16)
> +#define PRM_VP2_VLIMITTO_TIMEOUT	(0xFFFF << 0)
> +
> +/* SRCONFIG */
> +#define SR1_SRCONFIG_ACCUMDATA		(0x1F4 << 22)
> +#define SR2_SRCONFIG_ACCUMDATA		(0x1F4 << 22)
> +
> +#define SRCLKLENGTH_12MHZ_SYSCLK	0x3C
> +#define SRCLKLENGTH_13MHZ_SYSCLK	0x41
> +#define SRCLKLENGTH_19MHZ_SYSCLK	0x60
> +#define SRCLKLENGTH_26MHZ_SYSCLK	0x82
> +#define SRCLKLENGTH_38MHZ_SYSCLK	0xC0
> +
> +#define SRCONFIG_SRCLKLENGTH_SHIFT	12
> +#define SRCONFIG_SENNENABLE_SHIFT	5
> +#define SRCONFIG_SENPENABLE_SHIFT	3
> +
> +#define SRCONFIG_SRENABLE		(0x01 << 11)
> +#define SRCONFIG_SENENABLE		(0x01 << 10)
> +#define SRCONFIG_ERRGEN_EN		(0x01 << 9)
> +#define SRCONFIG_MINMAXAVG_EN		(0x01 << 8)
> +
> +#define SRCONFIG_DELAYCTRL		(0x01 << 2)
> +#define SRCONFIG_CLKCTRL		(0x00 << 0)
> +
> +/* AVGWEIGHT */
> +#define SR1_AVGWEIGHT_SENPAVGWEIGHT	(0x03 << 2)
> +#define SR1_AVGWEIGHT_SENNAVGWEIGHT	(0x03 << 0)
> +
> +#define SR2_AVGWEIGHT_SENPAVGWEIGHT	(0x01 << 2)
> +#define SR2_AVGWEIGHT_SENNAVGWEIGHT	(0x01 << 0)
> +
> +/* NVALUERECIPROCAL */
> +#define NVALUERECIPROCAL_SENPGAIN_SHIFT	20
> +#define NVALUERECIPROCAL_SENNGAIN_SHIFT	16
> +#define NVALUERECIPROCAL_RNSENP_SHIFT	8
> +#define NVALUERECIPROCAL_RNSENN_SHIFT	0
> +
> +/* ERRCONFIG */
> +#define SR_CLKACTIVITY_MASK		(0x03 << 20)
> +#define SR_ERRWEIGHT_MASK		(0x07 << 16)
> +#define SR_ERRMAXLIMIT_MASK		(0xFF << 8)
> +#define SR_ERRMINLIMIT_MASK		(0xFF << 0)
> +
> +#define SR_CLKACTIVITY_IOFF_FOFF	(0x00 << 20)
> +#define SR_CLKACTIVITY_IOFF_FON		(0x02 << 20)
> +
> +#define ERRCONFIG_VPBOUNDINTEN		(0x1 << 31)
> +#define ERRCONFIG_VPBOUNDINTST		(0x1 << 30)
> +
> +#define SR1_ERRWEIGHT			(0x07 << 16)
> +#define SR1_ERRMAXLIMIT			(0x02 << 8)
> +#define SR1_ERRMINLIMIT			(0xFA << 0)
> +
> +#define SR2_ERRWEIGHT			(0x07 << 16)
> +#define SR2_ERRMAXLIMIT			(0x02 << 8)
> +#define SR2_ERRMINLIMIT			(0xF9 << 0)
> +
> +/* T2 SMART REFLEX */
> +#define R_SRI2C_SLAVE_ADDR		0x12
> +#define R_VDD1_SR_CONTROL		0x00
> +#define R_VDD2_SR_CONTROL		0x01
> +#define T2_SMPS_UPDATE_DELAY		360	/* In uSec */
> +
> +/* Vmode control */
> +#define R_DCDC_GLOBAL_CFG	PHY_TO_OFF_PM_RECIEVER(0x61)
> +
> +#define R_VDD1_VSEL		PHY_TO_OFF_PM_RECIEVER(0xb9)
> +#define R_VDD1_VMODE_CFG	PHY_TO_OFF_PM_RECIEVER(0xba)
> +#define R_VDD1_VFLOOR		PHY_TO_OFF_PM_RECIEVER(0xbb)
> +#define R_VDD1_VROOF		PHY_TO_OFF_PM_RECIEVER(0xbc)
> +#define R_VDD1_STEP		PHY_TO_OFF_PM_RECIEVER(0xbd)
> +
> +#define R_VDD2_VSEL		PHY_TO_OFF_PM_RECIEVER(0xc7)
> +#define R_VDD2_VMODE_CFG	PHY_TO_OFF_PM_RECIEVER(0xc8)
> +#define R_VDD2_VFLOOR		PHY_TO_OFF_PM_RECIEVER(0xc9)
> +#define R_VDD2_VROOF		PHY_TO_OFF_PM_RECIEVER(0xca)
> +#define R_VDD2_STEP		PHY_TO_OFF_PM_RECIEVER(0xcb)
> +
> +/* R_DCDC_GLOBAL_CFG register, SMARTREFLEX_ENABLE values */
> +#define DCDC_GLOBAL_CFG_ENABLE_SRFLX	0x08
> +
> +/* VDDs*/
> +#define PRCM_VDD1	1
> +#define PRCM_VDD2	2
> +#define PRCM_MAX_SYSC_REGS 30
> +
> +/*
> + * XXX: These should be removed/moved from here once we have a working DVFS
> + * implementation in place
> + */
> +#define AT_3430		1	/*3430 ES 1.0 */
> +#define AT_3430_ES2	2	/*3430 ES 2.0 */
> +
> +#define ID_OPP			0xE2 	/*OPP*/
> +
> +/* DEVICE ID/DPLL ID/CLOCK ID: bits 28-31 for OMAP type */
> +#define OMAP_TYPE_SHIFT		28
> +#define OMAP_TYPE_MASK		0xF
> +/* OPP ID: bits: 0-4 for OPP number */
> +#define OPP_NO_POS		0
> +#define OPP_NO_MASK		0x1F
> +/* OPP ID: bits: 5-6 for VDD */
> +#define VDD_NO_POS		5
> +#define VDD_NO_MASK		0x3
> +/* Other IDs: bits 20-27 for ID type */
> +/* These IDs have bits 25,26,27 as 1 */
> +#define OTHER_ID_TYPE_SHIFT		20
> +#define OTHER_ID_TYPE_MASK		0xFF
> +
> +#define OTHER_ID_TYPE(X) ((X & OTHER_ID_TYPE_MASK) << OTHER_ID_TYPE_SHIFT)
> +#define ID_OPP_NO(X)	 ((X & OPP_NO_MASK) << OPP_NO_POS)
> +#define ID_VDD(X)	 ((X & VDD_NO_MASK) << VDD_NO_POS)
> +#define OMAP(X)		 ((X >> OMAP_TYPE_SHIFT) & OMAP_TYPE_MASK)
> +#define get_opp_no(X)	 ((X >> OPP_NO_POS) & OPP_NO_MASK)
> +#define get_vdd(X)	 ((X >> VDD_NO_POS) & VDD_NO_MASK)
> +
> +/* VDD1 OPPs */
> +#define PRCM_VDD1_OPP1		(OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
> +					ID_VDD(PRCM_VDD1) | ID_OPP_NO(0x1))
> +#define PRCM_VDD1_OPP2		(OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
> +					ID_VDD(PRCM_VDD1) | ID_OPP_NO(0x2))
> +#define PRCM_VDD1_OPP3		(OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
> +					ID_VDD(PRCM_VDD1) | ID_OPP_NO(0x3))
> +#define PRCM_VDD1_OPP4		(OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
> +					ID_VDD(PRCM_VDD1) | ID_OPP_NO(0x4))
> +#define PRCM_VDD1_OPP5		(OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
> +					ID_VDD(PRCM_VDD1) | ID_OPP_NO(0x5))
> +#define PRCM_NO_VDD1_OPPS	5
> +
> +
> +/* VDD2 OPPs */
> +#define PRCM_VDD2_OPP1		(OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
> +					ID_VDD(PRCM_VDD2) | ID_OPP_NO(0x1))
> +#define PRCM_VDD2_OPP2		(OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
> +					ID_VDD(PRCM_VDD2) | ID_OPP_NO(0x2))
> +#define PRCM_VDD2_OPP3		(OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
> +					ID_VDD(PRCM_VDD2) | ID_OPP_NO(0x3))
> +#define PRCM_NO_VDD2_OPPS	3
> +/* XXX: end remove/move */
> +
> +#endif
> +
> +
> diff --git a/include/asm-arm/arch-omap/control.h b/include/asm-arm/arch-omap/control.h
> index 12bc22a..6e64fe7 100644
> --- a/include/asm-arm/arch-omap/control.h
> +++ b/include/asm-arm/arch-omap/control.h
> @@ -138,6 +138,15 @@
>  #define OMAP343X_CONTROL_TEST_KEY_11	(OMAP2_CONTROL_GENERAL + 0x00f4)
>  #define OMAP343X_CONTROL_TEST_KEY_12	(OMAP2_CONTROL_GENERAL + 0x00f8)
>  #define OMAP343X_CONTROL_TEST_KEY_13	(OMAP2_CONTROL_GENERAL + 0x00fc)
> +#define OMAP343X_CONTROL_FUSE_OPP1_VDD1	(OMAP2_CONTROL_GENERAL + 0x0110)
> +#define OMAP343X_CONTROL_FUSE_OPP2_VDD1	(OMAP2_CONTROL_GENERAL + 0x0114)
> +#define OMAP343X_CONTROL_FUSE_OPP3_VDD1	(OMAP2_CONTROL_GENERAL + 0x0118)
> +#define OMAP343X_CONTROL_FUSE_OPP4_VDD1	(OMAP2_CONTROL_GENERAL + 0x011c)
> +#define OMAP343X_CONTROL_FUSE_OPP5_VDD1	(OMAP2_CONTROL_GENERAL + 0x0120)
> +#define OMAP343X_CONTROL_FUSE_OPP1_VDD2	(OMAP2_CONTROL_GENERAL + 0x0124)
> +#define OMAP343X_CONTROL_FUSE_OPP2_VDD2	(OMAP2_CONTROL_GENERAL + 0x0128)
> +#define OMAP343X_CONTROL_FUSE_OPP3_VDD2	(OMAP2_CONTROL_GENERAL + 0x012c)
> +#define OMAP343X_CONTROL_FUSE_SR	(OMAP2_CONTROL_GENERAL + 0x0130)
>  #define OMAP343X_CONTROL_IVA2_BOOTADDR	(OMAP2_CONTROL_GENERAL + 0x0190)
>  #define OMAP343X_CONTROL_IVA2_BOOTMOD	(OMAP2_CONTROL_GENERAL + 0x0194)
>  #define OMAP343X_CONTROL_TEMP_SENSOR	(OMAP2_CONTROL_GENERAL + 0x02b4)
> @@ -172,6 +181,16 @@
>  #define OMAP2_SYSBOOT_1_MASK		(1 << 1)
>  #define OMAP2_SYSBOOT_0_MASK		(1 << 0)
>  
> +/* CONTROL_FUSE_SR bits */
> +#define OMAP343X_SR2_SENNENABLE_MASK	(0x3 << 10)
> +#define OMAP343X_SR2_SENNENABLE_SHIFT	10
> +#define OMAP343X_SR2_SENPENABLE_MASK	(0x3 << 8)
> +#define OMAP343X_SR2_SENPENABLE_SHIFT	8
> +#define OMAP343X_SR1_SENNENABLE_MASK	(0x3 << 2)
> +#define OMAP343X_SR1_SENNENABLE_SHIFT	2
> +#define OMAP343X_SR1_SENPENABLE_MASK	(0x3 << 0)
> +#define OMAP343X_SR1_SENPENABLE_SHIFT	0
> +
>  #ifndef __ASSEMBLY__
>  #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
>  extern void __iomem *omap_ctrl_base_get(void);
> diff --git a/include/asm-arm/arch-omap/omap34xx.h b/include/asm-arm/arch-omap/omap34xx.h
> index 6a0459a..3667fd6 100644
> --- a/include/asm-arm/arch-omap/omap34xx.h
> +++ b/include/asm-arm/arch-omap/omap34xx.h
> @@ -54,6 +54,8 @@
>  #define OMAP34XX_HSUSB_HOST_BASE	(L4_34XX_BASE + 0x64000)
>  #define OMAP34XX_USBTLL_BASE	(L4_34XX_BASE + 0x62000)
>  #define IRQ_SIR_IRQ		0x0040
> +#define OMAP34XX_SR1_BASE	0x480C9000
> +#define OMAP34XX_SR2_BASE	0x480CB000
>  
> 
>  #if defined(CONFIG_ARCH_OMAP3430)

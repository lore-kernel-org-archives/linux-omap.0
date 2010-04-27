From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 03/22] OMAP3: PM: Convert smartreflex driver into a platform driver using hwmods and omap-device layer
Date: Tue, 27 Apr 2010 10:47:20 -0700
Message-ID: <87d3xkokif.fsf@deeprootsystems.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
	<1271408597-3066-2-git-send-email-thara@ti.com>
	<1271408597-3066-3-git-send-email-thara@ti.com>
	<1271408597-3066-4-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:51453 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754255Ab0D0Rra (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 13:47:30 -0400
Received: by pxi17 with SMTP id 17so2318373pxi.19
        for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 10:47:30 -0700 (PDT)
In-Reply-To: <1271408597-3066-4-git-send-email-thara@ti.com> (Thara Gopinath's message of "Fri\, 16 Apr 2010 14\:32\:58 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch converts the exisitng smartreflex library into a
> platform driver with device , driver registrations using hardware mods.
> As part of this Ntarget values are passed as platform data.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
>
> ---
>  arch/arm/mach-omap2/Makefile      |    2 +-
>  arch/arm/mach-omap2/smartreflex.c |  325 +++++++++++++------------------------
>  arch/arm/mach-omap2/smartreflex.h |   26 +++
>  arch/arm/mach-omap2/sr_device.c   |  139 ++++++++++++++++
>  4 files changed, 278 insertions(+), 214 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/sr_device.c
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index ab47043..62accd2 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -48,7 +48,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
>  obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o
>  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
> -obj-$(CONFIG_OMAP_SMARTREFLEX)	+= smartreflex.o
> +obj-$(CONFIG_OMAP_SMARTREFLEX)		+= sr_device.o smartreflex.o
>  
>  AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
>  AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index dc8d6e1..b4e98e5 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -3,6 +3,9 @@
>   *
>   * OMAP34XX SmartReflex Voltage Control
>   *
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + * Thara Gopinath <thara@ti.com>
> + *
>   * Copyright (C) 2008 Nokia Corporation
>   * Kalle Jokiniemi
>   *
> @@ -14,7 +17,6 @@
>   * published by the Free Software Foundation.
>   */
>  
> -
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> @@ -29,10 +31,11 @@
>  #include <linux/list.h>
>  
>  #include <plat/omap34xx.h>
> -#include <plat/control.h>
>  #include <plat/clock.h>
>  #include <plat/opp.h>
>  #include <plat/opp_twl_tps.h>
> +#include <plat/omap_hwmod.h>
> +#include <plat/omap_device.h>
>  
>  #include "prm.h"
>  #include "smartreflex.h"
> @@ -41,45 +44,44 @@
>  #define MAX_TRIES 100
>  
>  struct omap_sr {
> -	int		srid;
> -	int		is_sr_reset;
> -	int		is_autocomp_active;
> -	struct clk	*clk;
> -	struct clk	*vdd_opp_clk;
> -	u32		clk_length;
> -	u32		req_opp_no;
> -	u32		opp1_nvalue, opp2_nvalue, opp3_nvalue, opp4_nvalue;
> -	u32		opp5_nvalue;
> -	u32		senp_mod, senn_mod;
> -	void __iomem	*srbase_addr;

I think you should leave the srbase_addr here and keep the register
access the way it is (using __raw_[read|write]*) My preference for
general drivers is to keep the omap_hwmod/omap_device usage in the
driver to a minimum.  More on this below in comments on the _probe
function. 

I would just rename it from 'srbase_addr' to 'base'.

> +	int			srid;
> +	int			is_sr_reset;
> +	int			is_autocomp_active;
> +	struct clk		*vdd_opp_clk;
> +	u32			clk_length;
> +	unsigned int		irq;
> +	struct platform_device	*pdev;
>  	struct list_head	node;
>  };
>  
>  /* sr_list contains all the instances of smartreflex module */
>  static LIST_HEAD(sr_list);
>  
> -#define SR_REGADDR(offs)	(sr->srbase_addr + offset)
> -
>  static inline void sr_write_reg(struct omap_sr *sr, unsigned offset, u32 value)
>  {
> -	__raw_writel(value, SR_REGADDR(offset));
> +	struct omap_device *odev = to_omap_device(sr->pdev);
> +
> +	omap_hwmod_writel(value, odev->hwmods[0], offset);
>  }
>  
>  static inline void sr_modify_reg(struct omap_sr *sr, unsigned offset, u32 mask,
>  					u32 value)
>  {
> +	struct omap_device *odev = to_omap_device(sr->pdev);
>  	u32 reg_val;
>  
> -	reg_val = __raw_readl(SR_REGADDR(offset));
> +	reg_val = omap_hwmod_readl(odev->hwmods[0], offset);
>  	reg_val &= ~mask;
>  	reg_val |= value;
>  
> -	__raw_writel(reg_val, SR_REGADDR(offset));
> +	omap_hwmod_writel(reg_val, odev->hwmods[0], offset);
>  }
>  
>  static inline u32 sr_read_reg(struct omap_sr *sr, unsigned offset)
>  {
> -	return __raw_readl(SR_REGADDR(offset));
> +	struct omap_device *odev = to_omap_device(sr->pdev);
> +
> +	return omap_hwmod_readl(odev->hwmods[0], offset);
>  }
>  
>  static struct omap_sr *_sr_lookup(int srid)
> @@ -98,71 +100,22 @@ static struct omap_sr *_sr_lookup(int srid)
>  
>  static int sr_clk_enable(struct omap_sr *sr)
>  {
> -	if (clk_enable(sr->clk) != 0) {
> -		pr_err("Could not enable %s\n", sr->clk->name);
> -		return -1;
> -	}
> +	struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
>  
> -	/* set fclk- active , iclk- idle */
> -	sr_modify_reg(sr, ERRCONFIG, SR_CLKACTIVITY_MASK,
> -		      SR_CLKACTIVITY_IOFF_FON);
> +	if (pdata->device_enable)
> +		pdata->device_enable(sr->pdev);
>  
>  	return 0;
>  }
>  
>  static void sr_clk_disable(struct omap_sr *sr)
>  {
> -	/* set fclk, iclk- idle */
> -	sr_modify_reg(sr, ERRCONFIG, SR_CLKACTIVITY_MASK,
> -		      SR_CLKACTIVITY_IOFF_FOFF);
> -
> -	clk_disable(sr->clk);
> -	sr->is_sr_reset = 1;
> -}
> -
> -static struct omap_sr sr1 = {
> -	.srid			= SR1,
> -	.is_sr_reset		= 1,
> -	.is_autocomp_active	= 0,
> -	.clk_length		= 0,
> -	.srbase_addr		= OMAP2_L4_IO_ADDRESS(OMAP34XX_SR1_BASE),
> -};
> -
> -static struct omap_sr sr2 = {
> -	.srid			= SR2,
> -	.is_sr_reset		= 1,
> -	.is_autocomp_active	= 0,
> -	.clk_length		= 0,
> -	.srbase_addr		= OMAP2_L4_IO_ADDRESS(OMAP34XX_SR2_BASE),
> -};
> -
> -static void cal_reciprocal(u32 sensor, u32 *sengain, u32 *rnsen)
> -{
> -	u32 gn, rn, mul;
> -
> -	for (gn = 0; gn < GAIN_MAXLIMIT; gn++) {
> -		mul = 1 << (gn + 8);
> -		rn = mul / sensor;
> -		if (rn < R_MAXLIMIT) {
> -			*sengain = gn;
> -			*rnsen = rn;
> -		}
> -	}
> -}
> -
> -static u32 cal_test_nvalue(u32 sennval, u32 senpval)
> -{
> -	u32 senpgain, senngain;
> -	u32 rnsenp, rnsenn;
> +	struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
>  
> -	/* Calculating the gain and reciprocal of the SenN and SenP values */
> -	cal_reciprocal(senpval, &senpgain, &rnsenp);
> -	cal_reciprocal(sennval, &senngain, &rnsenn);
> +	if (pdata->device_idle)
> +		pdata->device_idle(sr->pdev);
>  
> -	return (senpgain << NVALUERECIPROCAL_SENPGAIN_SHIFT) |
> -		(senngain << NVALUERECIPROCAL_SENNGAIN_SHIFT) |
> -		(rnsenp << NVALUERECIPROCAL_RNSENP_SHIFT) |
> -		(rnsenn << NVALUERECIPROCAL_RNSENN_SHIFT);
> +	sr->is_sr_reset = 1;
>  }
>  
>  static u8 get_vdd1_opp(void)
> @@ -255,76 +208,6 @@ static void sr_set_clk_length(struct omap_sr *sr)
>  	}
>  }
>  
> -static void sr_set_efuse_nvalues(struct omap_sr *sr)
> -{
> -	if (sr->srid == SR1) {
> -		sr->senn_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
> -					OMAP343X_SR1_SENNENABLE_MASK) >>
> -					OMAP343X_SR1_SENNENABLE_SHIFT;
> -		sr->senp_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
> -					OMAP343X_SR1_SENPENABLE_MASK) >>
> -					OMAP343X_SR1_SENPENABLE_SHIFT;
> -
> -		sr->opp5_nvalue = omap_ctrl_readl(
> -					OMAP343X_CONTROL_FUSE_OPP5_VDD1);
> -		sr->opp4_nvalue = omap_ctrl_readl(
> -					OMAP343X_CONTROL_FUSE_OPP4_VDD1);
> -		sr->opp3_nvalue = omap_ctrl_readl(
> -					OMAP343X_CONTROL_FUSE_OPP3_VDD1);
> -		sr->opp2_nvalue = omap_ctrl_readl(
> -					OMAP343X_CONTROL_FUSE_OPP2_VDD1);
> -		sr->opp1_nvalue = omap_ctrl_readl(
> -					OMAP343X_CONTROL_FUSE_OPP1_VDD1);
> -	} else if (sr->srid == SR2) {
> -		sr->senn_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
> -					OMAP343X_SR2_SENNENABLE_MASK) >>
> -					OMAP343X_SR2_SENNENABLE_SHIFT;
> -
> -		sr->senp_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
> -					OMAP343X_SR2_SENPENABLE_MASK) >>
> -					OMAP343X_SR2_SENPENABLE_SHIFT;
> -
> -		sr->opp3_nvalue = omap_ctrl_readl(
> -					OMAP343X_CONTROL_FUSE_OPP3_VDD2);
> -		sr->opp2_nvalue = omap_ctrl_readl(
> -					OMAP343X_CONTROL_FUSE_OPP2_VDD2);
> -		sr->opp1_nvalue = omap_ctrl_readl(
> -					OMAP343X_CONTROL_FUSE_OPP1_VDD2);
> -	}
> -}
> -
> -/* Hard coded nvalues for testing purposes, may cause device to hang! */
> -static void sr_set_testing_nvalues(struct omap_sr *sr)
> -{
> -	if (sr->srid == SR1) {
> -		sr->senp_mod = 0x03;	/* SenN-M5 enabled */
> -		sr->senn_mod = 0x03;
> -
> -		/* calculate nvalues for each opp */
> -		sr->opp5_nvalue = cal_test_nvalue(0xacd + 0x330, 0x848 + 0x330);
> -		sr->opp4_nvalue = cal_test_nvalue(0x964 + 0x2a0, 0x727 + 0x2a0);
> -		sr->opp3_nvalue = cal_test_nvalue(0x85b + 0x200, 0x655 + 0x200);
> -		sr->opp2_nvalue = cal_test_nvalue(0x506 + 0x1a0, 0x3be + 0x1a0);
> -		sr->opp1_nvalue = cal_test_nvalue(0x373 + 0x100, 0x28c + 0x100);
> -	} else if (sr->srid == SR2) {
> -		sr->senp_mod = 0x03;
> -		sr->senn_mod = 0x03;
> -
> -		sr->opp3_nvalue = cal_test_nvalue(0x76f + 0x200, 0x579 + 0x200);
> -		sr->opp2_nvalue = cal_test_nvalue(0x4f5 + 0x1c0, 0x390 + 0x1c0);
> -		sr->opp1_nvalue = cal_test_nvalue(0x359, 0x25d);
> -	}
> -
> -}
> -
> -static void sr_set_nvalues(struct omap_sr *sr)
> -{
> -	if (SR_TESTING_NVALUES)
> -		sr_set_testing_nvalues(sr);
> -	else
> -		sr_set_efuse_nvalues(sr);
> -}
> -
>  static void sr_configure_vp(int srid)
>  {
>  	u32 vpconfig;
> @@ -438,12 +321,13 @@ static void sr_configure(struct omap_sr *sr)
>  {
>  	u32 sr_config;
>  	u32 senp_en , senn_en;
> +	struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
>  
>  	if (sr->clk_length == 0)
>  		sr_set_clk_length(sr);
>  
> -	senp_en = sr->senp_mod;
> -	senn_en = sr->senn_mod;
> +	senp_en = pdata->senp_mod;
> +	senn_en = pdata->senn_mod;
>  	if (sr->srid == SR1) {
>  		sr_config = SR1_SRCONFIG_ACCUMDATA |
>  			(sr->clk_length << SRCONFIG_SRCLKLENGTH_SHIFT) |
> @@ -571,57 +455,28 @@ static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
>  {
>  	u32 nvalue_reciprocal, v;
>  	struct omap_opp *opp;
> +	struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
>  	int uvdc;
>  	char vsel;
>  
> -	sr->req_opp_no = target_opp_no;
> -
>  	if (sr->srid == SR1) {
> -		switch (target_opp_no) {
> -		case 5:
> -			nvalue_reciprocal = sr->opp5_nvalue;
> -			break;
> -		case 4:
> -			nvalue_reciprocal = sr->opp4_nvalue;
> -			break;
> -		case 3:
> -			nvalue_reciprocal = sr->opp3_nvalue;
> -			break;
> -		case 2:
> -			nvalue_reciprocal = sr->opp2_nvalue;
> -			break;
> -		case 1:
> -			nvalue_reciprocal = sr->opp1_nvalue;
> -			break;
> -		default:
> -			nvalue_reciprocal = sr->opp3_nvalue;
> -			break;
> -		}
> -
>  		opp = opp_find_by_opp_id(OPP_MPU, target_opp_no);
>  		if (!opp)
>  			return false;
>  	} else {
> -		switch (target_opp_no) {
> -		case 3:
> -			nvalue_reciprocal = sr->opp3_nvalue;
> -			break;
> -		case 2:
> -			nvalue_reciprocal = sr->opp2_nvalue;
> -			break;
> -		case 1:
> -			nvalue_reciprocal = sr->opp1_nvalue;
> -			break;
> -		default:
> -			nvalue_reciprocal = sr->opp3_nvalue;
> -			break;
> -		}
> -
>  		opp = opp_find_by_opp_id(OPP_L3, target_opp_no);
>  		if (!opp)
>  			return false;
>  	}
>  
> +	if (!pdata->sr_nvalue) {
> +		pr_notice("N target values does not exist for SR%d\n",
> +								sr->srid);
> +		return false;
> +	}
> +
> +	nvalue_reciprocal = pdata->sr_nvalue[target_opp_no - 1];
> +
>  	if (nvalue_reciprocal == 0) {
>  		pr_notice("OPP%d doesn't support SmartReflex\n",
>  								target_opp_no);
> @@ -1033,49 +888,93 @@ static struct kobj_attribute sr_vdd2_autocomp = {
>  	.store = omap_sr_vdd2_autocomp_store,
>  };
>  
> +static int __devinit omap_smartreflex_probe(struct platform_device *pdev)
> +{
> +	struct omap_sr *sr_info = kzalloc(sizeof(struct omap_sr), GFP_KERNEL);
> +	struct omap_device *odev = to_omap_device(pdev);
> +	int ret = 0;
> +
> +	if (WARN_ON(!sr_info))
> +		return -ENOMEM;
> +	sr_info->pdev = pdev;
> +	sr_info->srid = pdev->id + 1;
> +	sr_info->is_sr_reset = 1,
> +	sr_info->is_autocomp_active = 0;
> +	sr_info->clk_length = 0;
> +	if (odev->hwmods[0]->mpu_irqs)
> +		sr_info->irq = odev->hwmods[0]->mpu_irqs[0].irq;

You should use platform_get_resource(..., IORESOURCE_IRQ) here instead
of accessing the hwmod. (or better, platform_get_irq().)

Remember that omap_device_build() builds a platform_device as well
with all the resources (base addresses, IRQs, DMA channels) so the
standard platform_get_resource() calls should be used to get all
those.

And, for the base address, use 

  sr_info->base = platform_get_resource(pdev, IORESOURCE_MEM);

Ideally, as generic driver here should have no (or minimal) knowledge of 
omap_device/omap_hwmod internals.

> +	sr_set_clk_length(sr_info);
> +
> +	if (sr_info->srid == SR1) {
> +		sr_info->vdd_opp_clk = clk_get(NULL, "dpll1_ck");
> +		ret = sysfs_create_file(power_kobj, &sr_vdd1_autocomp.attr);
> +		if (ret)
> +			pr_err("sysfs_create_file failed: %d\n", ret);
> +	} else {
> +		sr_info->vdd_opp_clk = clk_get(NULL, "l3_ick");
> +		ret = sysfs_create_file(power_kobj, &sr_vdd2_autocomp.attr);
> +		if (ret)
> +			pr_err("sysfs_create_file failed: %d\n", ret);
> +	}
> +
> +	/* Call the VPConfig */
> +	sr_configure_vp(sr_info->srid);
> +	list_add(&sr_info->node, &sr_list);
> +	pr_info("SmartReflex driver initialized\n");
> +
> +	return ret;
> +}
> +
> +static int __devexit omap_smartreflex_remove(struct platform_device *pdev)
> +{
> +	struct omap_sr *sr_info = _sr_lookup(pdev->id + 1);
>  
> +	/* Disable Autocompensation if enabled before removing the module */
> +	if (sr_info->is_autocomp_active == 1)
> +		sr_stop_vddautocomap(sr_info->srid);
> +	list_del(&sr_info->node);
> +	kfree(sr_info);
>  
> -static int __init omap3_sr_init(void)
> +	return 0;
> +}
> +
> +static struct platform_driver smartreflex_driver = {
> +	.probe          = omap_smartreflex_probe,

minor nit... since you're using platform_device_probe(), you don't
need a .probe function here, and you can make omap_smartreflex_probe()
__init.

> +	.remove         = omap_smartreflex_remove,
> +	.driver		= {
> +		.name	= "smartreflex",
> +	},
> +};
> +
> +static int __init sr_init(void)
>  {
>  	int ret = 0;
>  	u8 RdReg;
>  
> +	/* TODO: Find an appropriate place for this */
>  	/* Enable SR on T2 */
>  	ret = twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &RdReg,
>  			      R_DCDC_GLOBAL_CFG);
> -
>  	RdReg |= DCDC_GLOBAL_CFG_ENABLE_SRFLX;
>  	ret |= twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, RdReg,
>  				R_DCDC_GLOBAL_CFG);
> -	if (cpu_is_omap34xx()) {
> -		sr1.clk = clk_get(NULL, "sr1_fck");
> -		sr2.clk = clk_get(NULL, "sr2_fck");
> -	}
> -	sr1.vdd_opp_clk = clk_get(NULL, "dpll1_ck");
> -	sr2.vdd_opp_clk = clk_get(NULL, "l3_ick");
> -	sr_set_clk_length(&sr1);
> -	sr_set_clk_length(&sr2);
> -
> -	/* Call the VPConfig, VCConfig, set N Values. */
> -	sr_set_nvalues(&sr1);
> -	sr_configure_vp(SR1);
> -
> -	sr_set_nvalues(&sr2);
> -	sr_configure_vp(SR2);
> -
> -	pr_info("SmartReflex driver initialized\n");
>  
> -	ret = sysfs_create_file(power_kobj, &sr_vdd1_autocomp.attr);
> -	if (ret)
> -		pr_err("sysfs_create_file failed: %d\n", ret);
> +	ret = platform_driver_probe(&smartreflex_driver,
> +				omap_smartreflex_probe);
>  
> -	ret = sysfs_create_file(power_kobj, &sr_vdd2_autocomp.attr);
>  	if (ret)
> -		pr_err("sysfs_create_file failed: %d\n", ret);
> -	list_add(&sr1.node, &sr_list);
> -	list_add(&sr2.node, &sr_list);
> -
> +		pr_err("platform driver register failed for smartreflex");
>  	return 0;
>  }
>  
> -late_initcall(omap3_sr_init);
> +void __exit sr_exit(void)
> +{
> +	platform_driver_unregister(&smartreflex_driver);
> +}
> +late_initcall(sr_init);
> +module_exit(sr_exit);
> +
> +MODULE_DESCRIPTION("OMAP SMARTREFLEX DRIVER");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:" DRIVER_NAME);
> +MODULE_AUTHOR("Texas Instruments Inc");
> diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
> index d239eb2..5eb8846 100644
> --- a/arch/arm/mach-omap2/smartreflex.h
> +++ b/arch/arm/mach-omap2/smartreflex.h
> @@ -14,6 +14,8 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <linux/platform_device.h>
> +
>  #define PHY_TO_OFF_PM_MASTER(p)		(p - 0x36)
>  #define PHY_TO_OFF_PM_RECIEVER(p)	(p - 0x5b)
>  #define PHY_TO_OFF_PM_INT(p)		(p - 0x2e)
> @@ -276,6 +278,30 @@ struct omap_smartreflex_dev_data {
>   * do anything.
>   */
>  #ifdef CONFIG_OMAP_SMARTREFLEX
> +/**
> + * omap_smartreflex_data - Smartreflex platform data
> + *
> + * @senp_mod		: SENPENABLE value for the sr
> + * @senn_mod		: SENNENABLE value for sr
> + * @sr_nvalue		: array of n target values for sr
> + * @enable_on_init	: whether this sr module needs to enabled at
> + *			  boot up or not
> + * @device_enable	: fn pointer to be populated with omap_device
> + *			enable API
> + * @device_shutdown	: fn pointer to be populated with omap_device
> + *			shutdown API
> + * @device_idle		: fn pointer to be pouplated with omap_device idle API

You can drop the comments about omap_device API.  These are intended to
be generic pointers.  The device part is free to fill those out

> + */
> +struct omap_smartreflex_data {

Also, how about a rename to omap_sr_data;

> +	u32		senp_mod;
> +	u32		senn_mod;
> +	u32		*sr_nvalue;
> +	bool		enable_on_init;
> +	int (*device_enable)(struct platform_device *pdev);
> +	int (*device_shutdown)(struct platform_device *pdev);
> +	int (*device_idle)(struct platform_device *pdev);
> +};
> +
>  void enable_smartreflex(int srid);
>  void disable_smartreflex(int srid);
>  int sr_voltagescale_vcbypass(u32 t_opp, u32 c_opp, u8 t_vsel, u8 c_vsel);
> diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
> new file mode 100644
> index 0000000..a9c1ef0
> --- /dev/null
> +++ b/arch/arm/mach-omap2/sr_device.c
> @@ -0,0 +1,139 @@
> +/*
> + * linux/arch/arm/mach-omap2/sr_device.c

Please drop the filename from the header.

> + * OMAP3/OMAP4 smartreflex device file
> + *
> + * Author: Thara Gopinath	<thara@ti.com>
> + *
> + * Based originally on code from smartreflex.c
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + * Thara Gopinath <thara@ti.com>
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
> +#include <linux/err.h>
> +
> +#include <plat/control.h>
> +#include <plat/omap_hwmod.h>
> +#include <plat/omap_device.h>
> +#include <plat/opp.h>
> +
> +#include "smartreflex.h"
> +
> +#define MAX_HWMOD_NAME_LEN	16
> +
> +struct omap_device_pm_latency omap_sr_latency[] = {
> +	{
> +		.deactivate_func = omap_device_idle_hwmods,
> +		.activate_func	 = omap_device_enable_hwmods,
> +		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST
> +	},
> +};
> +
> +/* Read EFUSE values from control registers for OMAP3430 */
> +static void __init sr_read_efuse(
> +				struct omap_smartreflex_dev_data *dev_data,
> +				struct omap_smartreflex_data *sr_data)
> +{
> +	int i;
> +
> +	if (WARN_ON(!dev_data || !dev_data->volts_supported ||
> +			!dev_data->efuse_sr_control ||
> +			!dev_data->efuse_nvalues_offs))
> +		return;
> +
> +	sr_data->sr_nvalue = kzalloc(sizeof(sr_data->sr_nvalue) *
> +			dev_data->volts_supported , GFP_KERNEL);
> +	sr_data->senn_mod = (omap_ctrl_readl(dev_data->efuse_sr_control) &
> +				(0x3 << dev_data->sennenable_shift) >>
> +				dev_data->sennenable_shift);
> +	sr_data->senp_mod = (omap_ctrl_readl(dev_data->efuse_sr_control) &
> +				(0x3 << dev_data->senpenable_shift) >>
> +				dev_data->senpenable_shift);
> +	for (i = 0; i < dev_data->volts_supported; i++)
> +		sr_data->sr_nvalue[i] = omap_ctrl_readl(
> +				dev_data->efuse_nvalues_offs[i]);
> +}
> +
> +/*
> + * Hard coded nvalues for testing purposes for OMAP3430,
> + * may cause device to hang!
> + */
> +static void __init sr_set_testing_nvalues(
> +				struct omap_smartreflex_dev_data *dev_data,
> +				struct omap_smartreflex_data *sr_data)
> +{
> +	int i;
> +
> +	if (WARN_ON(!dev_data || !dev_data->volts_supported ||
> +			!dev_data->test_nvalues))
> +		return;
> +
> +	sr_data->sr_nvalue = kzalloc(sizeof(sr_data->sr_nvalue) *
> +			dev_data->volts_supported , GFP_KERNEL);
> +	sr_data->senn_mod = dev_data->test_sennenable;
> +	sr_data->senp_mod = dev_data->test_senpenable;
> +	for (i = 0; i < dev_data->volts_supported; i++)
> +		sr_data->sr_nvalue[i] = dev_data->test_nvalues[i];
> +}
> +
> +static void __init sr_set_nvalues(struct omap_smartreflex_dev_data *dev_data,
> +		struct omap_smartreflex_data *sr_data)
> +{
> +	if (cpu_is_omap34xx()) {

Why this check?  Looks like the called functions already check for
valid data.  Also, I don't see this changed/updated in the 3630 patches.

> +		if (SR_TESTING_NVALUES)
> +			sr_set_testing_nvalues(dev_data, sr_data);
> +		else
> +			sr_read_efuse(dev_data, sr_data);
> +	}
> +}
> +
> +static int __init omap_devinit_smartreflex(void)
> +{
> +	int i = 0;
> +	char *name = "smartreflex";
> +
> +	do {
> +		struct omap_smartreflex_data *sr_data;
> +		struct omap_smartreflex_dev_data *sr_dev_data;
> +		struct omap_device *od;
> +		struct omap_hwmod *oh;
> +		char oh_name[MAX_HWMOD_NAME_LEN + 1];
> +
> +		snprintf(oh_name, MAX_HWMOD_NAME_LEN, "sr%d_hwmod", i + 1);
> +		oh = omap_hwmod_lookup(oh_name);

Should be using the hwmod_class to iterate: omap_hwmod_for_each_by_class()

> +		if (!oh)
> +			break;
> +
> +		sr_data = kzalloc(sizeof(struct omap_smartreflex_data),
> +								GFP_KERNEL);
> +		sr_dev_data = (struct omap_smartreflex_dev_data *)oh->dev_attr;
> +		if (WARN_ON(!sr_data))
> +			return -ENOMEM;
> +
> +		sr_data->enable_on_init = false;
> +		sr_data->device_enable = omap_device_enable;
> +		sr_data->device_shutdown = omap_device_shutdown;
> +		sr_data->device_idle = omap_device_idle;
> +		sr_set_nvalues(sr_dev_data, sr_data);
> +
> +		od = omap_device_build(name, i, oh, sr_data, sizeof(*sr_data),
> +				       omap_sr_latency,
> +				       ARRAY_SIZE(omap_sr_latency), 0);
> +		WARN(IS_ERR(od), "Could not build omap_device for %s: %s.\n",
> +		     name, oh->name);
> +		i++;
> +	} while (1);
> +
> +	return 0;
> +}
> +arch_initcall(omap_devinit_smartreflex);

Kevin

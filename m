From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 05/10] OMAP4: Adding voltage driver support
Date: Wed, 25 Aug 2010 16:08:26 -0700
Message-ID: <87eidm9tp1.fsf@deeprootsystems.com>
References: <1282130191-9062-1-git-send-email-thara@ti.com>
	<1282130191-9062-6-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36289 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907Ab0HYXI3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 19:08:29 -0400
Received: by pzk9 with SMTP id 9so386668pzk.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Aug 2010 16:08:29 -0700 (PDT)
In-Reply-To: <1282130191-9062-6-git-send-email-thara@ti.com> (Thara Gopinath's
	message of "Wed, 18 Aug 2010 16:46:26 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch adds voltage driver support for OMAP4.

Need a better changelog here... different registers definitions, more
VDDs, etc. etc.

> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile              |    2 +-
>  arch/arm/mach-omap2/voltage.c             |  246 ++++++++++++++++++++++++++++-
>  arch/arm/plat-omap/include/plat/voltage.h |   20 +++-
>  3 files changed, 264 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 03e494e..d46fbec 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -51,7 +51,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
>  obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o voltage.o \
>  					   cpuidle34xx.o
> -obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o
> +obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o voltage.o
>  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
>  obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
>  obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index d15c5cb..6a07fe9 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -34,6 +34,8 @@
>  #include <plat/voltage.h>
>  
>  #include "prm-regbits-34xx.h"
> +#include "prm44xx.h"
> +#include "prm-regbits-44xx.h"
>  
>  #define VP_IDLE_TIMEOUT		200
>  #define VP_TRANXDONE_TIMEOUT	300
> @@ -158,7 +160,49 @@ static struct omap_vdd_info omap3_vdd_info[] = {
>  
>  #define OMAP3_NO_SCALABLE_VDD ARRAY_SIZE(omap3_vdd_info)
>  
> -/* TODO: OMAP4 register offsets */
> +/* OMAP4 VDD sturctures */
> +static struct omap_vdd_info omap4_vdd_info[] = {
> +	{
> +		.vp_offs = {
> +			.vpconfig = OMAP4_PRM_VP_MPU_CONFIG_OFFSET,
> +			.vstepmin = OMAP4_PRM_VP_MPU_VSTEPMIN_OFFSET,
> +			.vstepmax = OMAP4_PRM_VP_MPU_VSTEPMAX_OFFSET,
> +			.vlimitto = OMAP4_PRM_VP_MPU_VLIMITTO_OFFSET,
> +			.vstatus = OMAP4_PRM_VP_MPU_STATUS_OFFSET,
> +			.voltage = OMAP4_PRM_VP_MPU_VOLTAGE_OFFSET,
> +		},
> +		.voltdm = {
> +			.name = "mpu",
> +		},
> +	},
> +	{
> +		.vp_offs = {
> +			.vpconfig = OMAP4_PRM_VP_IVA_CONFIG_OFFSET,
> +			.vstepmin = OMAP4_PRM_VP_IVA_VSTEPMIN_OFFSET,
> +			.vstepmax = OMAP4_PRM_VP_IVA_VSTEPMAX_OFFSET,
> +			.vlimitto = OMAP4_PRM_VP_IVA_VLIMITTO_OFFSET,
> +			.vstatus = OMAP4_PRM_VP_IVA_STATUS_OFFSET,
> +			.voltage = OMAP4_PRM_VP_IVA_VOLTAGE_OFFSET,
> +		},
> +		.voltdm = {
> +			.name = "iva",
> +		},
> +	},
> +	{
> +		.vp_offs = {
> +			.vpconfig = OMAP4_PRM_VP_CORE_CONFIG_OFFSET,
> +			.vstepmin = OMAP4_PRM_VP_CORE_VSTEPMIN_OFFSET,
> +			.vstepmax = OMAP4_PRM_VP_CORE_VSTEPMAX_OFFSET,
> +			.vlimitto = OMAP4_PRM_VP_CORE_VLIMITTO_OFFSET,
> +			.vstatus = OMAP4_PRM_VP_CORE_STATUS_OFFSET,
> +			.voltage = OMAP4_PRM_VP_CORE_VOLTAGE_OFFSET,
> +		},
> +		.voltdm = {
> +			.name = "core",
> +		},
> +	},
> +};
> +#define OMAP4_NO_SCALABLE_VDD ARRAY_SIZE(omap4_vdd_info)

same comment as with OMAP3 version: drop the 'NO' part in favor of _NUM,
or _NR.

>  /*
>   * Default voltage controller settings.
> @@ -222,6 +266,29 @@ static struct omap_volt_data omap36xx_vdd2_volt_data[] = {
>  	{.volt_nominal = 1137500, .sr_errminlimit = 0xF9, .vp_errgain = 0x16},
>  };
>  
> +/*
> + * Structures containing OMAP4430 voltage supported and various
> + * data associated with it per voltage domain basis. Smartreflex Ntarget
> + * values are left as 0 as they have to be populated by smartreflex
> + * driver after reading the efuse.
> + */
> +static struct omap_volt_data omap44xx_vdd_mpu_volt_data[] = {
> +	{.volt_nominal = 930000, .sr_errminlimit = 0xF4, .vp_errgain = 0x0C},
> +	{.volt_nominal = 1100000, .sr_errminlimit = 0xF9, .vp_errgain = 0x16},
> +	{.volt_nominal = 1260000, .sr_errminlimit = 0xFA, .vp_errgain = 0x23},
> +	{.volt_nominal = 1350000, .sr_errminlimit = 0xFA, .vp_errgain = 0x27},
> +};
> +
> +static struct omap_volt_data omap44xx_vdd_iva_volt_data[] = {
> +	{.volt_nominal = 930000, .sr_errminlimit = 0xF4, .vp_errgain = 0x0C},
> +	{.volt_nominal = 1100000, .sr_errminlimit = 0xF9, .vp_errgain = 0x16},
> +	{.volt_nominal = 1260000, .sr_errminlimit = 0xFA, .vp_errgain = 0x23},
> +};
> +
> +static struct omap_volt_data omap44xx_vdd_core_volt_data[] = {
> +	{.volt_nominal = 930000, .sr_errminlimit = 0xF4, .vp_errgain = 0x0C},
> +	{.volt_nominal = 1100000, .sr_errminlimit = 0xF9, .vp_errgain = 0x16},
> +};
>  
>  /* By default VPFORCEUPDATE is the chosen method of voltage scaling */
>  static bool voltscale_vpforceupdate = true;
> @@ -510,6 +577,165 @@ static void __init omap3_vdd_data_configure(struct omap_vdd_info *vdd)
>  	vdd->vp_reg.vlimitto_timeout_shift = OMAP3430_TIMEOUT_SHIFT;
>  }
>  
> +/* OMAP4 specific voltage init functions */
> +static void __init omap4_init_voltagecontroller(void)
> +{
> +	voltage_write_reg(OMAP4_PRM_VC_SMPS_SA_OFFSET,
> +			(OMAP4_SRI2C_SLAVE_ADDR <<
> +			 OMAP4430_SA_VDD_CORE_L_0_6_SHIFT) |
> +			(OMAP4_SRI2C_SLAVE_ADDR <<
> +			 OMAP4430_SA_VDD_IVA_L_PRM_VC_SMPS_SA_SHIFT) |
> +			(OMAP4_SRI2C_SLAVE_ADDR <<
> +			 OMAP4430_SA_VDD_MPU_L_PRM_VC_SMPS_SA_SHIFT));
> +	voltage_write_reg(OMAP4_PRM_VC_VAL_SMPS_RA_VOL_OFFSET,
> +			(OMAP4_VDD_MPU_SR_VOLT_REG <<
> +			 OMAP4430_VOLRA_VDD_MPU_L_SHIFT) |
> +			(OMAP4_VDD_IVA_SR_VOLT_REG <<
> +			 OMAP4430_VOLRA_VDD_IVA_L_SHIFT) |
> +			(OMAP4_VDD_CORE_SR_VOLT_REG <<
> +			 OMAP4430_VOLRA_VDD_CORE_L_SHIFT));
> +	voltage_write_reg(OMAP4_PRM_VC_CFG_CHANNEL_OFFSET,
> +			OMAP4430_RAV_VDD_MPU_L_MASK |
> +			OMAP4430_CMD_VDD_MPU_L_MASK |
> +			OMAP4430_RAV_VDD_IVA_L_MASK |
> +			OMAP4430_CMD_VDD_IVA_L_MASK |
> +			OMAP4430_RAV_VDD_CORE_L_MASK |
> +			OMAP4430_CMD_VDD_CORE_L_MASK);

insert blank line 

> +	/*
> +	 * Configure SR I2C in HS Mode. Is there really a need to configure
> +	 * i2c in the normal mode??
> +	 */
> +/*	voltage_write_reg(OMAP4_PRM_VC_CFG_I2C_MODE_OFFSET,
> +			0x0 << OMAP4430_HSMCODE_SHIFT);
> +	voltage_write_reg(OMAP4_PRM_VC_CFG_I2C_CLK_OFFSET,
> +			(0x0A << OMAP4430_HSSCLL_SHIFT |
> +			0x05 << OMAP4430_HSSCLH_SHIFT));*/

this is commented out.  Either remove it, or make it conditional on
something meaningful.

> +	voltage_write_reg(OMAP4_PRM_VC_CFG_I2C_CLK_OFFSET,
> +			(0x60 << OMAP4430_SCLL_SHIFT |
> +			0x26 << OMAP4430_SCLH_SHIFT));
> +	/* TODO: Configure setup times and CMD_VAL values*/
> +}
> +
> +/* Sets up all the VDD related info for OMAP4 */
> +static void __init omap4_vdd_data_configure(struct omap_vdd_info *vdd)
> +{
> +	unsigned long curr_volt;
> +	struct omap_volt_data *volt_data;
> +	struct clk *sys_ck;
> +	u32 sys_clk_speed, timeout_val, waittime;
> +
> +	if (!strcmp(vdd->voltdm.name, "mpu")) {
> +		vdd->vp_reg.vlimitto_vddmin = OMAP4_VP_MPU_VLIMITTO_VDDMIN;
> +		vdd->vp_reg.vlimitto_vddmax = OMAP4_VP_MPU_VLIMITTO_VDDMAX;
> +		vdd->volt_data = omap44xx_vdd_mpu_volt_data;
> +		vdd->volt_data_count = ARRAY_SIZE(omap44xx_vdd_mpu_volt_data);
> +		vdd->volt_clk = clk_get(NULL, "dpll_mpu_ck");
> +		WARN(IS_ERR(vdd->volt_clk), "unable to get clock for vdd_%s\n",
> +				vdd->voltdm.name);
> +		vdd->opp_dev = omap2_get_mpuss_device();
> +		vdd->vp_reg.tranxdone_status =
> +				OMAP4430_VP_MPU_TRANXDONE_ST_MASK;
> +		vdd->cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_MPU_L_OFFSET;
> +		vdd->vdd_sr_reg = OMAP4_VDD_MPU_SR_VOLT_REG;
> +	} else if (!strcmp(vdd->voltdm.name, "core")) {
> +		vdd->vp_reg.vlimitto_vddmin = OMAP4_VP_CORE_VLIMITTO_VDDMIN;
> +		vdd->vp_reg.vlimitto_vddmax = OMAP4_VP_CORE_VLIMITTO_VDDMAX;
> +		vdd->volt_data = omap44xx_vdd_core_volt_data;
> +		vdd->volt_data_count = ARRAY_SIZE(omap44xx_vdd_core_volt_data);
> +		vdd->volt_clk = clk_get(NULL, "l3_div_ck");
> +		WARN(IS_ERR(vdd->volt_clk), "unable to get clock for vdd_%s\n",
> +				vdd->voltdm.name);
> +		vdd->opp_dev = omap2_get_l3_device();
> +		vdd->vp_reg.tranxdone_status =
> +				OMAP4430_VP_CORE_TRANXDONE_ST_MASK;
> +		vdd->cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_CORE_L_OFFSET;
> +		vdd->vdd_sr_reg = OMAP4_VDD_CORE_SR_VOLT_REG;
> +	} else if (!strcmp(vdd->voltdm.name, "iva")) {
> +		vdd->vp_reg.vlimitto_vddmin = OMAP4_VP_IVA_VLIMITTO_VDDMIN;
> +		vdd->vp_reg.vlimitto_vddmax = OMAP4_VP_IVA_VLIMITTO_VDDMAX;
> +		vdd->volt_data = omap44xx_vdd_iva_volt_data;
> +		vdd->volt_data_count = ARRAY_SIZE(omap44xx_vdd_iva_volt_data);
> +		vdd->volt_clk = clk_get(NULL, "dpll_iva_m5x2_ck");
> +		WARN(IS_ERR(vdd->volt_clk), "unable to get clock for vdd_%s\n",
> +				vdd->voltdm.name);
> +		vdd->opp_dev = omap2_get_iva_device();
> +		vdd->vp_reg.tranxdone_status =
> +			OMAP4430_VP_IVA_TRANXDONE_ST_MASK;
> +		vdd->cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_IVA_L_OFFSET;
> +		vdd->vdd_sr_reg = OMAP4_VDD_IVA_SR_VOLT_REG;
> +	} else {
> +		pr_warning("%s: vdd_%s does not exisit in OMAP4\n",
> +			__func__, vdd->voltdm.name);
> +		return;
> +	}
> +
> +	curr_volt = omap_voltage_get_nom_volt(&vdd->voltdm);
> +	if (!curr_volt) {
> +		pr_warning("%s: unable to find current voltage for vdd_%s\n",
> +			__func__, vdd->voltdm.name);
> +		return;
> +	}
> +
> +	volt_data = omap_voltage_get_voltdata(&vdd->voltdm, curr_volt);
> +	if (IS_ERR(volt_data)) {
> +		pr_warning("%s: Unable to get volt table for vdd_%s at init",
> +			__func__, vdd->voltdm.name);
> +		return;
> +	}
> +	/*
> +	 * Sys clk rate is require to calculate vp timeout value and
> +	 * smpswaittimemin and smpswaittimemax.
> +	 */
> +	sys_ck = clk_get(NULL, "sys_clkin_ck");
> +	if (IS_ERR(sys_ck)) {
> +		pr_warning("%s: Could not get the sys clk to calculate"
> +			"various vdd_%s params\n", __func__, vdd->voltdm.name);
> +		return;
> +	}
> +	sys_clk_speed = clk_get_rate(sys_ck);
> +	clk_put(sys_ck);

insert blank line

[...]

Kevin

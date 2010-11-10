From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 2/6] OMAP4: Adding voltage driver support
Date: Wed, 10 Nov 2010 11:22:19 -0800
Message-ID: <87eiat56hg.fsf@deeprootsystems.com>
References: <1288196196-15469-1-git-send-email-thara@ti.com>
	<1288196196-15469-3-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50502 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756519Ab0KJTWZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 14:22:25 -0500
Received: by gwb11 with SMTP id 11so165124gwb.19
        for <linux-omap@vger.kernel.org>; Wed, 10 Nov 2010 11:22:24 -0800 (PST)
In-Reply-To: <1288196196-15469-3-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Wed, 27 Oct 2010 21:46:32 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> OMAP4 has three scalable voltage domains vdd_mpu, vdd_iva
> and vdd_core. This patch adds the voltage tables and other
> configurable voltage processor and voltage controller
> settings to control these three scalable domains in OMAP4.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

[...]

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

As mentioned in previous reviews, the standard is to write hex value
using lower case letters.   Please fix this up in the both OMAP3 & 4 series.

[...]

> +/* Sets up all the VDD related info for OMAP4 */
> +static void __init omap4_vdd_data_configure(struct omap_vdd_info *vdd)
> +{
> +	struct clk *sys_ck;
> +	u32 sys_clk_speed, timeout_val, waittime;
> +
> +	if (!strcmp(vdd->voltdm.name, "mpu")) {
> +		vdd->vp_reg.vlimitto_vddmin = OMAP4_VP_MPU_VLIMITTO_VDDMIN;
> +		vdd->vp_reg.vlimitto_vddmax = OMAP4_VP_MPU_VLIMITTO_VDDMAX;
> +		vdd->volt_data = omap44xx_vdd_mpu_volt_data;
> +		vdd->volt_data_count = ARRAY_SIZE(omap44xx_vdd_mpu_volt_data);
> +		vdd->vp_reg.tranxdone_status =
> +				OMAP4430_VP_MPU_TRANXDONE_ST_MASK;
> +		vdd->cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_MPU_L_OFFSET;
> +		vdd->vdd_sr_reg = OMAP4_VDD_MPU_SR_VOLT_REG;
> +	} else if (!strcmp(vdd->voltdm.name, "core")) {
> +		vdd->vp_reg.vlimitto_vddmin = OMAP4_VP_CORE_VLIMITTO_VDDMIN;
> +		vdd->vp_reg.vlimitto_vddmax = OMAP4_VP_CORE_VLIMITTO_VDDMAX;
> +		vdd->volt_data = omap44xx_vdd_core_volt_data;
> +		vdd->volt_data_count = ARRAY_SIZE(omap44xx_vdd_core_volt_data);
> +		vdd->vp_reg.tranxdone_status =
> +				OMAP4430_VP_CORE_TRANXDONE_ST_MASK;
> +		vdd->cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_CORE_L_OFFSET;
> +		vdd->vdd_sr_reg = OMAP4_VDD_CORE_SR_VOLT_REG;
> +	} else if (!strcmp(vdd->voltdm.name, "iva")) {
> +		vdd->vp_reg.vlimitto_vddmin = OMAP4_VP_IVA_VLIMITTO_VDDMIN;
> +		vdd->vp_reg.vlimitto_vddmax = OMAP4_VP_IVA_VLIMITTO_VDDMAX;
> +		vdd->volt_data = omap44xx_vdd_iva_volt_data;
> +		vdd->volt_data_count = ARRAY_SIZE(omap44xx_vdd_iva_volt_data);
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
> +
> +	/* Divide to avoid overflow */
> +	sys_clk_speed /= 1000;
> +
> +	/* Nominal/Reset voltage of the VDD */
> +	vdd->nominal_volt = vdd->curr_volt = 1200000;

same comment as from  OMAP3 series.

[...]

>  /* Generic voltage init functions */
>  static void __init init_voltageprocessor(struct omap_vdd_info *vdd)
>  {
> @@ -753,6 +945,14 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
>  		vc_cmd_on_mask = OMAP3430_VC_CMD_ON_MASK;
>  		prm_irqst_reg_offs = OMAP3_PRM_IRQSTATUS_MPU_OFFSET;
>  		ocp_mod = OCP_MOD;
> +	} else if (cpu_is_omap44xx()) {
> +		vc_cmd_on_shift = OMAP4430_ON_SHIFT;
> +		vc_cmd_on_mask = OMAP4430_ON_MASK;
> +		if (!strcmp(vdd->voltdm.name, "mpu"))
> +			prm_irqst_reg_offs = OMAP4_PRM_IRQSTATUS_MPU_2_OFFSET;
> +		else
> +			prm_irqst_reg_offs = OMAP4_PRM_IRQSTATUS_MPU_OFFSET;
> +		ocp_mod = OMAP4430_PRM_OCP_SOCKET_MOD;

again, please no cpu_is_* outside of init functions.

>  	} else {
>  		pr_warning("%s: Voltage scaling not yet enabled for"
>  			"this chip\n", __func__);
> @@ -1348,6 +1548,12 @@ static int __init omap_voltage_init(void)
>  		nr_scalable_vdd = OMAP3_NR_SCALABLE_VDD;
>  		init_voltagecontroller = omap3_init_voltagecontroller;
>  		vdd_data_configure = omap3_vdd_data_configure;
> +	} else if (cpu_is_omap44xx()) {
> +		volt_mod = OMAP4430_PRM_DEVICE_MOD;
> +		vdd_info = omap4_vdd_info;
> +		nr_scalable_vdd = OMAP4_NR_SCALABLE_VDD;
> +		init_voltagecontroller = omap4_init_voltagecontroller;
> +		vdd_data_configure = omap4_vdd_data_configure;
>  	} else {
>  		pr_warning("%s: voltage driver support not added\n", __func__);
>  		return 0;

Kevin

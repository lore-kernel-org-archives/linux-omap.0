From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2 2/8] OMAP3: PM: Adding voltage driver support for OMAP3
Date: Mon, 30 Aug 2010 16:21:44 -0700
Message-ID: <87sk1vwut3.fsf@deeprootsystems.com>
References: <1281707231-3026-1-git-send-email-thara@ti.com>
	<1281707231-3026-3-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56810 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346Ab0H3XVr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Aug 2010 19:21:47 -0400
Received: by pvg2 with SMTP id 2so2270705pvg.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Aug 2010 16:21:47 -0700 (PDT)
In-Reply-To: <1281707231-3026-3-git-send-email-thara@ti.com> (Thara Gopinath's
	message of "Fri, 13 Aug 2010 19:17:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, dderrick@ti.com

Thara Gopinath <thara@ti.com> writes:

> +/*
> + * vc_bypass_scale_voltage - VC bypass method of voltage scaling
> + */
> +static int vc_bypass_scale_voltage(struct omap_vdd_info *vdd,
> +		unsigned long target_volt)
> +{
> +	struct omap_volt_data *volt_data;
> +	u32 vc_bypass_value, vc_cmdval, vc_valid, vc_bypass_val_reg_offs;
> +	u32 vp_errgain_val, vc_cmd_on_mask;
> +	u32 loop_cnt = 0, retries_cnt = 0;
> +	u32 smps_steps = 0, smps_delay = 0;
> +	u8 vc_data_shift, vc_slaveaddr_shift, vc_regaddr_shift;
> +	u8 vc_cmd_on_shift;
> +	u8 target_vsel, current_vsel, sr_i2c_slave_addr;
> +
> +	if (cpu_is_omap34xx()) {
> +		vc_cmd_on_shift = OMAP3430_VC_CMD_ON_SHIFT;
> +		vc_cmd_on_mask = OMAP3430_VC_CMD_ON_MASK;
> +		vc_data_shift = OMAP3430_DATA_SHIFT;
> +		vc_slaveaddr_shift = OMAP3430_SLAVEADDR_SHIFT;
> +		vc_regaddr_shift = OMAP3430_REGADDR_SHIFT;
> +		vc_valid = OMAP3430_VALID_MASK;
> +		vc_bypass_val_reg_offs = OMAP3_PRM_VC_BYPASS_VAL_OFFSET;
> +		sr_i2c_slave_addr = OMAP3_SRI2C_SLAVE_ADDR;
> +	}

cpu_is_* should not be used every time this path is taken.  Rather, all
the SoC conditional values should be initialized once at init time.

[...]

> +/* VP force update method of voltage scaling */
> +static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
> +		unsigned long target_volt)
> +{
> +	struct omap_volt_data *volt_data;
> +	u32 vc_cmd_on_mask, vc_cmdval, vpconfig;
> +	u32 smps_steps = 0, smps_delay = 0;
> +	int timeout = 0;
> +	u8 target_vsel, current_vsel;
> +	u8 vc_cmd_on_shift;
> +	u8 prm_irqst_reg_offs, ocp_mod;
> +
> +	if (cpu_is_omap34xx()) {
> +		vc_cmd_on_shift = OMAP3430_VC_CMD_ON_SHIFT;
> +		vc_cmd_on_mask = OMAP3430_VC_CMD_ON_MASK;
> +		prm_irqst_reg_offs = OMAP3_PRM_IRQSTATUS_MPU_OFFSET;
> +		ocp_mod = OCP_MOD;
> +	}

ditto.

Same goes for the OMAP4 patches which add to this.

Kevin

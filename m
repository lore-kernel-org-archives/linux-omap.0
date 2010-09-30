From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 02/11] OMAP3: PM: Adding voltage driver support for OMAP3
Date: Wed, 29 Sep 2010 17:27:02 -0700
Message-ID: <87iq1ooz3d.fsf@deeprootsystems.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	<1285166719-19352-3-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52099 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab0I3A1E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 20:27:04 -0400
Received: by pvg2 with SMTP id 2so331458pvg.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Sep 2010 17:27:04 -0700 (PDT)
In-Reply-To: <1285166719-19352-3-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Wed, 22 Sep 2010 20:15:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch adds voltage driver support for OMAP3. The driver
> allows  configuring the voltage controller and voltage
> processors during init and exports APIs to enable/disable
> voltage processors, scale voltage and reset voltage.
> The driver also maintains the global voltage table on a per
> VDD basis which contains the various voltages supported by the
> VDD along with per voltage dependent data like smartreflex
> n-target value, errminlimit and voltage processor errorgain.
> The driver allows scaling of VDD voltages either through
> "vc bypass method" or through "vp forceupdate method" the
> choice being configurable through the board file.
>
> This patch contains code originally in linux omap pm branch
> smartreflex driver.  Major contributors to this driver are
> Lesly A M, Rajendra Nayak, Kalle Jokiniemi, Paul Walmsley,
> Nishant Menon, Kevin Hilman.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

[...]

> +static void vp_latch_vsel(struct omap_vdd_info *vdd)
> +{
> +	u32 vpconfig;
> +	unsigned long uvdc;
> +	char vsel;
> +
> +	uvdc = omap_voltage_get_nom_volt(&vdd->voltdm);
> +	if (!uvdc) {
> +		pr_warning("%s: unable to find current voltage for vdd_%s\n",
> +			__func__, vdd->voltdm.name);
> +		return;
> +	}
> +
> +	if (!volt_pmic_info.uv_to_vsel) {
> +		pr_warning("%s: PMIC function to convert voltage in uV to"
> +			" vsel not registered\n", __func__);
> +		return;
> +	}

Should return an error condition to the caller here...

> +	vsel = volt_pmic_info.uv_to_vsel(uvdc);
> +
> +	vpconfig = voltage_read_reg(vdd->vp_offs.vpconfig);
> +	vpconfig &= ~(vdd->vp_reg.vpconfig_initvoltage_mask |
> +			vdd->vp_reg.vpconfig_initvdd);
> +	vpconfig |= vsel << vdd->vp_reg.vpconfig_initvoltage_shift;
> +
> +	voltage_write_reg(vdd->vp_offs.vpconfig, vpconfig);
> +
> +	/* Trigger initVDD value copy to voltage processor */
> +	voltage_write_reg(vdd->vp_offs.vpconfig,
> +			(vpconfig | vdd->vp_reg.vpconfig_initvdd));
> +
> +	/* Clear initVDD copy trigger bit */
> +	voltage_write_reg(vdd->vp_offs.vpconfig, vpconfig);
> +}

[...]

> +static void __init init_voltageprocessor(struct omap_vdd_info *vdd)
> +{
> +	u32 vpconfig;
> +
> +	vpconfig = vdd->vp_reg.vpconfig_erroroffset |
> +			(vdd->vp_reg.vpconfig_errorgain <<
> +			vdd->vp_reg.vpconfig_errorgain_shift) |
> +			vdd->vp_reg.vpconfig_timeouten;
> +
> +	voltage_write_reg(vdd->vp_offs.vpconfig, vpconfig);
> +
> +	voltage_write_reg(vdd->vp_offs.vstepmin,
> +			(vdd->vp_reg.vstepmin_smpswaittimemin <<
> +			vdd->vp_reg.vstepmin_smpswaittimemin_shift) |
> +			(vdd->vp_reg.vstepmin_stepmin <<
> +			vdd->vp_reg.vstepmin_stepmin_shift));
> +
> +	voltage_write_reg(vdd->vp_offs.vstepmax,
> +			(vdd->vp_reg.vstepmax_smpswaittimemax <<
> +			vdd->vp_reg.vstepmax_smpswaittimemax_shift) |
> +			(vdd->vp_reg.vstepmax_stepmax <<
> +			vdd->vp_reg.vstepmax_stepmax_shift));
> +
> +	voltage_write_reg(vdd->vp_offs.vlimitto,
> +			(vdd->vp_reg.vlimitto_vddmax <<
> +			vdd->vp_reg.vlimitto_vddmax_shift) |
> +			(vdd->vp_reg.vlimitto_vddmin <<
> +			vdd->vp_reg.vlimitto_vddmin_shift) |
> +			(vdd->vp_reg.vlimitto_timeout <<
> +			vdd->vp_reg.vlimitto_timeout_shift));
> +
> +	/* Set the init voltage */
> +	vp_latch_vsel(vdd);

On OMAP4/panda, the boot hangs after this.

Since there is no PMIC registered, this call returns early but there is
no error checking done.  I think the init needs a little more error
checking and graceful failure, especially when there is no PMIC present.

Kevin

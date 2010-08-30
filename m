From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2 2/8] OMAP3: PM: Adding voltage driver support for OMAP3
Date: Mon, 30 Aug 2010 16:06:11 -0700
Message-ID: <8739tvya3g.fsf@deeprootsystems.com>
References: <1281707231-3026-1-git-send-email-thara@ti.com>
	<1281707231-3026-3-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58743 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754028Ab0H3XGO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Aug 2010 19:06:14 -0400
Received: by pzk9 with SMTP id 9so2245205pzk.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Aug 2010 16:06:14 -0700 (PDT)
In-Reply-To: <1281707231-3026-3-git-send-email-thara@ti.com> (Thara Gopinath's
	message of "Fri, 13 Aug 2010 19:17:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, dderrick@ti.com

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

> +unsigned long omap_voltage_get_nom_volt(struct voltagedomain *voltdm)
> +{
> +	struct omap_opp *opp;
> +	struct omap_vdd_info *vdd;
> +	unsigned long freq;
> +
> +	if (!voltdm || IS_ERR(voltdm)) {
> +		pr_warning("%s: VDD specified does not exist!\n", __func__);
> +		return 0;
> +	}
> +
> +	vdd = container_of(voltdm, struct omap_vdd_info, voltdm);
> +
> +	freq = vdd->volt_clk->rate;
> +	opp = opp_find_freq_ceil(vdd->opp_dev, &freq);
> +	if (IS_ERR(opp)) {
> +		pr_warning("%s: Unable to find OPP for vdd_%s freq%ld\n",
> +			__func__, voltdm->name, freq);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Use higher freq voltage even if an exact match is not available
> +	 * we are probably masking a clock framework bug, so warn
> +	 */
> +	if (unlikely(freq != vdd->volt_clk->rate))
> +		pr_warning("%s: Available freq %ld != dpll freq %ld.\n",
> +			__func__, freq, vdd->volt_clk->rate);
> +
> +	return opp_get_voltage(opp);
> +}

Minor nit...

Rather than having to look this up in the OPP table every time, couldn't
this be initialized and stored in struct voltagedomain? 

Whenever the voltage is changed, it's updated in struct voltagedomain
and doesn't have to be continually looked up in the OPP layer.

> +/**
> + * omap_vp_get_curr_volt : API to get the current vp voltage.
> + * @voltdm: pointer to the VDD.
> + *
> + * This API returns the current voltage for the specified voltage processor
> + */
> +unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm)
> +{
> +	struct omap_vdd_info *vdd;
> +	u8 curr_vsel;
> +
> +	if (!voltdm || IS_ERR(voltdm)) {
> +		pr_warning("%s: VDD specified does not exist!\n", __func__);
> +		return 0;
> +	}
> +
> +	vdd = container_of(voltdm, struct omap_vdd_info, voltdm);
> +
> +	curr_vsel = voltage_read_reg(vdd->vp_offs.voltage);
> +	return omap_twl_vsel_to_uv(curr_vsel);
> +}

This too.  No need to read from the HW, if we just keep track of all
the changes in 'struct voltagedomain'.

Kevin

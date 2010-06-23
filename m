From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/8] OMAP3: PM: Adding voltage driver support for OMAP3
Date: Wed, 23 Jun 2010 11:57:50 -0700
Message-ID: <87sk4dshjl.fsf@deeprootsystems.com>
References: <1275150748-15386-1-git-send-email-thara@ti.com>
	<1275150748-15386-2-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42118 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab0FWS5y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 14:57:54 -0400
Received: by pvg2 with SMTP id 2so41559pvg.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Jun 2010 11:57:53 -0700 (PDT)
In-Reply-To: <1275150748-15386-2-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Sat, 29 May 2010 22:02:21 +0530")
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

> +/**
> + * get_curr_vdd_voltage : Gets the current non-auto-compensated voltage
> + * @vdd	: the VDD for which current voltage info is needed
> + *
> + * API to get the current non-auto-compensated voltage for a VDD.
> + * Returns 0 in case of error else returns the current voltage for the VDD.
> + */
> +unsigned long get_curr_voltage(int vdd)
> +{
> +	struct omap_opp *opp;
> +	unsigned long freq;
> +
> +	if (check_voltage_domain(vdd)) {
> +		pr_warning("%s: VDD %d does not exist!\n", __func__, vdd);
> +		return 0;
> +	}
> +
> +	freq = vdd_info[vdd].volt_clk->rate;
> +	opp = opp_find_freq_ceil(vdd_info[vdd].opp_type, &freq);
> +	if (IS_ERR(opp)) {
> +		pr_warning("%s: Unable to find OPP for VDD%d freq%ld\n",
> +			__func__, vdd + 1, freq);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Use higher freq voltage even if an exact match is not available
> +	 * we are probably masking a clock framework bug, so warn
> +	 */
> +	if (unlikely(freq != vdd_info[vdd].volt_clk->rate))
> +		pr_warning("%s: Available freq %ld != dpll freq %ld.\n",
> +			__func__, freq, vdd_info[vdd].volt_clk->rate);
> +
> +	return opp_get_voltage(opp);
> +}

Rather than having to do an OPP lookup each time based on current clock
rate, why not just store the current voltage into vdd_info and
update it whenever it changes.  This function could then just return
that value.

Kevin

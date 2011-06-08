From: Colin Cross <ccross@google.com>
Subject: Re: [pm-wip/voltdm_nm][PATCH 10/10] OMAP2+: PM: init_voltages: handle
 non compliant bootloaders
Date: Tue, 7 Jun 2011 18:12:06 -0700
Message-ID: <BANLkTimDen6QWhmxkQ9WhCRoLoNGyeYNH7iyoCpJG-cQHSa3Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:15142 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224Ab1FHBMJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jun 2011 21:12:09 -0400
Received: from kpbe20.cbf.corp.google.com (kpbe20.cbf.corp.google.com [172.25.105.84])
	by smtp-out.google.com with ESMTP id p581C7b4014316
	for <linux-omap@vger.kernel.org>; Tue, 7 Jun 2011 18:12:08 -0700
Received: from yib12 (yib12.prod.google.com [10.243.65.76])
	by kpbe20.cbf.corp.google.com with ESMTP id p581AhnO031640
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Tue, 7 Jun 2011 18:12:06 -0700
Received: by yib12 with SMTP id 12so10515yib.35
        for <linux-omap@vger.kernel.org>; Tue, 07 Jun 2011 18:12:06 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: l-o <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@ti.com>

> Bootloaders should in theory setup a frequency which is enabled in
> OPP table. However, there can be mismatches, and we should try
> both going lower in addition to the going higher to find
> a match if bootloader boots up at a OPP than the kernel thinks it
> should be allowed. We also sequence the frequency and voltage settings
> properly.
>
> Reported-by: Colin Cross <ccross@google.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> PS: Apologies on the spam.. for some reason 10/10 never appeared in
> http://marc.info/?l=linux-omap&r=2&b=201106&w=2 - grumble grumble :(
>
>  arch/arm/mach-omap2/pm.c |   55 ++++++++++++++++++++++++++++++++++++---------
>  1 files changed, 44 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 7355347..ce7554b 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -174,7 +174,9 @@ static int __init omap2_set_init_voltage(char *vdd_name, ch ar *clk_name,
>  	struct voltagedomain *voltdm;
>  	struct clk *clk;
>  	struct opp *opp;
> -	unsigned long freq, bootup_volt;
> +	unsigned long freq_cur, freq_valid, bootup_volt;
> +	int raise_freq_idx, i;
> +	int ret = -EINVAL;
>
>  	if (!vdd_name || !clk_name || !dev) {
>  		printk(KERN_ERR "%s: Invalid parameters!\n", __func__);
> @@ -195,16 +197,20 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
>  		goto exit;
>  	}
>
> -	freq = clk->rate;
> -	clk_put(clk);
> +	freq_cur = clk->rate;
> +	freq_valid = freq_cur;
>
>  	rcu_read_lock();
> -	opp = opp_find_freq_ceil(dev, &freq);
> +	opp = opp_find_freq_ceil(dev, &freq_valid);
>  	if (IS_ERR(opp)) {
> -		rcu_read_unlock();
> -		printk(KERN_ERR "%s: unable to find boot up OPP for vdd_%s\n",
> -			__func__, vdd_name);
> -		goto exit;
> +		opp = opp_find_freq_floor(dev, &freq_valid);
> +		if (IS_ERR(opp)) {
> +			rcu_read_unlock();
> +			pr_err("%s: no boot OPP match for %ld on vdd_%s\n",
> +				__func__, freq_cur, vdd_name);
> +			ret = -ENOENT;
> +			goto exit_ck;
> +		}
>  	}
>
>  	bootup_volt = opp_get_voltage(opp);
> @@ -212,11 +218,38 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
>  	if (!bootup_volt) {
>  		printk(KERN_ERR "%s: unable to find voltage corresponding"
>  			"to the bootup OPP for vdd_%s\n", __func__, vdd_name);
> -		goto exit;
> +		ret = -ENOENT;
> +		goto exit_ck;
>  	}
>
> -	voltdm_scale(voltdm, bootup_volt);
> -	return 0;
> +	/*
> +	 * Frequency and Voltage have to be sequenced: if we move from
> +	 * a lower frequency to higher frequency, raise voltage, followed by
> +	 * frequency, and vice versa. we assume that the voltage at boot
> +	 * is the required voltage for the frequency it was set for.
> +	 */
> +	raise_freq_idx = freq_cur < freq_valid;
> +	for (i = 0; i < 2; i++) {
> +		if (i == raise_freq_idx)
> +			ret = clk_set_rate(clk, freq_valid);
> +		else
> +			ret = voltdm_scale(voltdm, bootup_volt);
> +		if (ret < 0) {
> +			pr_err("%s: unable to set %s-%s(f=%ld v=%ld)on vdd%s\n",
> +				__func__,
> +				(i == raise_freq_idx) ? "clk" : "voltage",
> +				(i == raise_freq_idx) ? clk_name : vdd_name,
> +				freq_valid, bootup_volt, vdd_name);
> +			goto exit_ck;
> +		}
> +	}

This is way too complicated.  Writing out what you mean is much more
readable, and not many more LOC:

if (freq_cur < freq_valid) {
	ret = voltdm_scale(voltdm, bootup_volt);
	if (ret) {
		pr_err("%s: unable to set voltage-%s(f=%ld v=%ld)on vdd%s\n",
			vdd_name, freq_valid, bootup_volt, vdd_name);
		goto exit_ck;
	}
}

ret = clk_set_rate(clk, freq_valid);
if (ret) {
	pr_err("%s: unable to set clk-%s(f=%ld v=%ld)on vdd%s\n",
		clk_name, freq_valid, bootup_volt, vdd_name);
	goto exit_ck;
}

if (freq_cur > freq_valid) {
	ret = voltdm_scale(voltdm, bootup_volt);
	if (ret) {
		pr_err("%s: unable to set voltage-%s(f=%ld v=%ld)on vdd%s\n",
			vdd_name, freq_valid, bootup_volt, vdd_name);
		goto exit_ck;
	}
}

> +
> +	ret = 0;
> +exit_ck:
> +	clk_put(clk);
> +
> +	if (!ret)
> +		return 0;
>
>  exit:
>  	printk(KERN_ERR "%s: Unable to put vdd_%s to its init voltage\n\n",
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

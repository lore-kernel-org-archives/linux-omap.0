From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 5/9] omap3: pm: sr: replace get_opp with freq_to_opp
Date: Fri, 18 Dec 2009 15:12:49 -0800
Message-ID: <87eimrx4em.fsf@deeprootsystems.com>
References: <1258004721-7315-1-git-send-email-nm@ti.com>
	<1258004721-7315-2-git-send-email-nm@ti.com>
	<1258004721-7315-3-git-send-email-nm@ti.com>
	<1258004721-7315-4-git-send-email-nm@ti.com>
	<1258004721-7315-5-git-send-email-nm@ti.com>
	<1258004721-7315-6-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:45235 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932801AbZLRXMw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 18:12:52 -0500
Received: by pwj9 with SMTP id 9so2190276pwj.21
        for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 15:12:51 -0800 (PST)
In-Reply-To: <1258004721-7315-6-git-send-email-nm@ti.com> (Nishanth Menon's message of "Wed\, 11 Nov 2009 23\:45\:17 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Benoit Cousson <b-cousson@ti.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

Nishanth Menon <nm@ti.com> writes:

> SmartReflex implements a get_opp to search through the opp table,
> replace it with the accessor function as it is a duplicate of
> freq_to_opp

SmartReflex is not quite working with this version which is in
pm-wip-opp.  My (untested) theory below...

[...]

> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -146,49 +146,29 @@ static u32 cal_test_nvalue(u32 sennval, u32 senpval)
>  		(rnsenn << NVALUERECIPROCAL_RNSENN_SHIFT);
>  }
>  
> -/* determine the current OPP from the frequency
> - * we need to give this function last element of OPP rate table
> - * and the frequency
> - */
> -static u16 get_opp(struct omap_opp *opp_freq_table,
> -					unsigned long freq)
> -{
> -	struct omap_opp *prcm_config;
> -
> -	prcm_config = opp_freq_table;
> -
> -	if (prcm_config->rate <= freq)
> -		return prcm_config->opp_id; /* Return the Highest OPP */
> -	for (; prcm_config->rate; prcm_config--)
> -		if (prcm_config->rate < freq)
> -			return (prcm_config+1)->opp_id;
> -		else if (prcm_config->rate == freq)
> -			return prcm_config->opp_id;
> -	/* Return the least OPP */
> -	return (prcm_config+1)->opp_id;
> -}

The function you removed here is doing the equivalent of
opp_find_freq_ceil()


> -static u16 get_vdd1_opp(void)
> +static u8 get_vdd1_opp(void)
>  {
> -	u16 opp;
> +	u8 opp;
>  
>  	if (sr1.vdd_opp_clk == NULL || IS_ERR(sr1.vdd_opp_clk) ||
>  							mpu_opps == NULL)
>  		return 0;
>  
> -	opp = get_opp(mpu_opps + MAX_VDD1_OPP, sr1.vdd_opp_clk->rate);
> +	/* Not expected to fail.. */
> +	BUG_ON(freq_to_opp(&opp, mpu_opps, sr1.vdd_opp_clk->rate));
>  	return opp;
>  }

Ih this version you use freq_to_opp(), but in the V5 tarball you sent,
you replace get_opp with:

	opp = opp_find_freq_exact(mpu_opps, sr1.vdd_opp_clk->rate, true);

This results in never finding an OPP, and SR never scaling.

This should probably be opp_find_freq_ceil(), right?

Kevin

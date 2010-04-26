From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH V2] OMAP3630:DSS2: Updating MAX divider value
Date: Mon, 26 Apr 2010 20:11:15 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E1EBEE7@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026F6E308A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51259 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab0DZOl2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 10:41:28 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026F6E308A@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Y, Kishore" <kishore.y@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Y, Kishore
> Sent: Monday, April 26, 2010 7:14 PM
> To: Tomi Valkeinen; Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org
> Subject: [PATCH V2] OMAP3630:DSS2: Updating MAX divider value
> 
> From 5f2a14ec8dd5ddb80532f898be3575379008ea56 Mon Sep 17 00:00:00 2001
> From: Kishore Y <kishore.y@ti.com>
> Date: Sun, 25 Apr 2010 16:27:19 +0530
> Subject: [PATCH] OMAP3630:DSS2: Updating MAX divider value
> 
> In DPLL4 M3, M4, M5 and M6 field width has been increased by 1 bit in 3630.
> So the max divider value that can be achived will be 32 and not 16.
> In 3630 the functional clock is x1 of DPLL4 and not x2 .Hence multiplier 2
> is removed.
> 
> Signed-off-by: Sudeep Basavaraj <sudeep.basavaraj@ti.com>
> Signed-off-by: Mukund Mittal <mmittal@ti.com>
> Signed-off-by: Kishore Y <kishore.y@ti.com>
> ---
> Changes compared to version 1:
>    -divider check is based on cpu type instead of board type
> 
>  drivers/video/omap2/dss/dss.c |   24 +++++++++++++++++++-----
>  1 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
> index 5434418..24b1825 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
> @@ -223,7 +223,13 @@ void dss_dump_clocks(struct seq_file *s)
> 
>  	seq_printf(s, "dpll4_ck %lu\n", dpll4_ck_rate);
> 
> -	seq_printf(s, "dss1_alwon_fclk = %lu / %lu * 2 = %lu\n",
> +	if (cpu_is_omap3630())
> +		seq_printf(s, "dss1_alwon_fclk = %lu / %lu  = %lu\n",
> +			dpll4_ck_rate,
> +			dpll4_ck_rate / dpll4_m4_ck_rate,
> +			dss_clk_get_rate(DSS_CLK_FCK1));
> +	else
> +		seq_printf(s, "dss1_alwon_fclk = %lu / %lu * 2 = %lu\n",
>  			dpll4_ck_rate,
>  			dpll4_ck_rate / dpll4_m4_ck_rate,
>  			dss_clk_get_rate(DSS_CLK_FCK1));
> @@ -293,7 +299,8 @@ int dss_calc_clock_rates(struct dss_clock_info *cinfo)
>  {
>  	unsigned long prate;
> 
> -	if (cinfo->fck_div > 16 || cinfo->fck_div == 0)
> +	if (cinfo->fck_div > (cpu_is_omap3630() ? 32 : 16) ||
> +						cinfo->fck_div == 0)
>  		return -EINVAL;
> 
>  	prate = clk_get_rate(clk_get_parent(dss.dpll4_m4_ck));
> @@ -329,7 +336,10 @@ int dss_get_clock_div(struct dss_clock_info *cinfo)
>  	if (cpu_is_omap34xx()) {
>  		unsigned long prate;
>  		prate = clk_get_rate(clk_get_parent(dss.dpll4_m4_ck));
> -		cinfo->fck_div = prate / (cinfo->fck / 2);
> +		if (cpu_is_omap3630())
> +			cinfo->fck_div = prate / (cinfo->fck);
> +		else
> +			cinfo->fck_div = prate / (cinfo->fck / 2);
>  	} else {
>  		cinfo->fck_div = 0;
>  	}
> @@ -402,10 +412,14 @@ retry:
> 
>  		goto found;
>  	} else if (cpu_is_omap34xx()) {
> -		for (fck_div = 16; fck_div > 0; --fck_div) {
> +		for (fck_div = (cpu_is_omap3630() ? 32 : 16);
> +					fck_div > 0; --fck_div) {
>  			struct dispc_clock_info cur_dispc;
> 
> -			fck = prate / fck_div * 2;
> +			if (cpu_is_omap3630())
> +				fck = prate / fck_div;
> +			else
> +				fck = prate / fck_div * 2;
> 
>  			if (fck > DISPC_MAX_FCK)
>  				continue;
[Hiremath, Vaibhav] Looks ok to me.

Acked/Reviewed by: Vaibhav Hiremath <hvaibhav@ti.com>

Thanks,
Vaibhav
> --
> 1.5.6.3
> 
> 
> Regards,
> Kishore Y

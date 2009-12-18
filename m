From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 10/12] OMAP OPP: remove "initial terminators" from OPP lists
Date: Fri, 18 Dec 2009 11:08:43 -0800
Message-ID: <87zl5gw150.fsf@deeprootsystems.com>
References: <20091218004617.7694.84525.stgit@localhost.localdomain>
	<20091218004739.7694.25893.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:40125 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433AbZLRTIq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 14:08:46 -0500
Received: by pzk1 with SMTP id 1so2421141pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 11:08:46 -0800 (PST)
In-Reply-To: <20091218004739.7694.25893.stgit@localhost.localdomain> (Paul Walmsley's message of "Thu\, 17 Dec 2009 17\:47\:40 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: nm@ti.com, linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> Now that the SRF and Smartreflex code uses accessor functions to interact
> with OPPs, the "initial terminators" can be removed.

Nice.

With the initial terminators gone, some assumptions in SRF have to be
changed too where SRF is directly indexing into the OPP table.

I'll fix that up in an updated version of my 'hide OPP details' series.

Kevin


> ---
>  arch/arm/plat-omap/opp.c |   36 ++++++++----------------------------
>  1 files changed, 8 insertions(+), 28 deletions(-)
>
> diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
> index 596e3ee..f651912 100644
> --- a/arch/arm/plat-omap/opp.c
> +++ b/arch/arm/plat-omap/opp.c
> @@ -53,15 +53,15 @@ unsigned long opp_get_freq(const struct omap_opp *opp)
>  struct omap_opp * __deprecated opp_find_by_opp_id(struct omap_opp *opps,
>  						  u8 opp_id)
>  {
> -	int i = 1;
> +	int i = 0;
>  
>  	if (!opps || !opp_id)
>  		return NULL;
>  
> -	/* The first entry is a dummy one, loop till we hit terminator */
>  	while (!OPP_TERM(&opps[i])) {
>  		if (opps[i].enabled && (opps[i].opp_id == opp_id))
>  			return &opps[i];
> +
>  		i++;
>  	}
>  
> @@ -76,7 +76,6 @@ int opp_get_opp_count(struct omap_opp *oppl)
>  		pr_err("%s: Invalid parameters being passed\n", __func__);
>  		return -EINVAL;
>  	}
> -	oppl++;			/* skip initial terminator */
>  	while (!OPP_TERM(oppl)) {
>  		if (oppl->enabled)
>  			n++;
> @@ -92,9 +91,7 @@ struct omap_opp *opp_find_freq_exact(struct omap_opp *oppl,
>  		pr_err("%s: Invalid parameters being passed\n", __func__);
>  		return ERR_PTR(-EINVAL);
>  	}
> -	/* skip initial terminator */
> -	if (OPP_TERM(oppl))
> -		oppl++;
> +
>  	while (!OPP_TERM(oppl)) {
>  		if ((oppl->rate == freq) && (oppl->enabled == enabled))
>  			break;
> @@ -111,10 +108,6 @@ struct omap_opp *opp_find_freq_ceil(struct omap_opp *oppl, unsigned long *freq)
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	/* skip initial terminator */
> -	if (OPP_TERM(oppl))
> -		oppl++;
> -
>  	while (!OPP_TERM(oppl)) {
>  		if (oppl->enabled && oppl->rate >= *freq)
>  			break;
> @@ -139,10 +132,6 @@ struct omap_opp *opp_find_freq_floor(struct omap_opp *oppl, unsigned long *freq)
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	/* skip initial terminator */
> -	if (OPP_TERM(oppl))
> -		oppl++;
> -
>  	while (!OPP_TERM(oppl)) {
>  		if (oppl->enabled) {
>  			if (oppl->rate > *freq)
> @@ -181,20 +170,16 @@ struct omap_opp *opp_add(struct omap_opp *oppl,
>  		pr_err("%s: Invalid params being passed\n", __func__);
>  		return ERR_PTR(-EINVAL);
>  	}
> -	/* need a start terminator.. */
> -	if (unlikely(!OPP_TERM(oppl))) {
> -		pr_err("%s: Expected a start terminator!!\n", __func__);
> -		return ERR_PTR(-EINVAL);
> -	}
> +
>  	n = 0;
>  	opp = oppl;
> -	opp++;
>  	while (!OPP_TERM(opp)) {
>  		n++;
>  		opp++;
>  	}
> +
>  	/* lets now reallocate memory */
> -	oppr = kmalloc(sizeof(struct omap_opp) * (n + 3), GFP_KERNEL);
> +	oppr = kmalloc(sizeof(struct omap_opp) * (n + 2), GFP_KERNEL);
>  	if (!oppr) {
>  		pr_err("%s: No memory for new opp array\n", __func__);
>  		return ERR_PTR(-ENOMEM);
> @@ -204,7 +189,7 @@ struct omap_opp *opp_add(struct omap_opp *oppl,
>  	opp = oppl;
>  	oppt = oppr;
>  	ins = 0;
> -	i = 0;
> +	i = 1;
>  	do {
>  		if (ins || opp->rate < opp_def->freq) {
>  			memcpy(oppt, opp, sizeof(struct omap_opp));
> @@ -249,17 +234,12 @@ struct omap_opp __init *opp_init_list(const struct omap_opp_def *opp_defs)
>  		t++;
>  	}
>  
> -	oppl = kmalloc(sizeof(struct omap_opp) * (n + 2), GFP_KERNEL);
> +	oppl = kmalloc(sizeof(struct omap_opp) * (n + 1), GFP_KERNEL);
>  	if (!oppl) {
>  		pr_err("%s: No memory for opp array\n", __func__);
>  		return ERR_PTR(-ENOMEM);
>  	}
>  	opp = oppl;
> -	/* Setup start terminator - SRF depends on this for indexing :( */
> -	opp->rate = 0;
> -	opp->enabled = 0;
> -	opp->u_volt = 0;
> -	opp++;
>  	while (n) {
>  		omap_opp_populate(opp, opp_defs);
>  		opp->opp_id = i;
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

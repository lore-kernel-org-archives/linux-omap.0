From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PATCH 2/3] omap3: pm: removes hardcoded VDD1/2 OPP values and
 make threshold generic
Date: Thu, 19 Nov 2009 05:39:40 -0600
Message-ID: <4B052E7C.60104@gmail.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E940254330A64@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:55979 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbZKSLj1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Nov 2009 06:39:27 -0500
Received: by yxe17 with SMTP id 17so1860008yxe.33
        for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2009 03:39:33 -0800 (PST)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940254330A64@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G.N, Vijayakumar" <vijaykumar.gn@ti.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

G.N, Vijayakumar said the following on 11/19/2009 05:25 AM:
> >From 3a4213ec9284c04e1a6a3b14094819e70ac951d9 Mon Sep 17 00:00:00 2001
> From: Vijay Kumar <vijaykumar.gn@ti.com>
> Date: Thu, 19 Nov 2009 15:06:30 +0530
> Subject: [PATCH 2/3] Correct VDD2 DVFS OPP threshold
>
> VDD2 OPP is linked with VDD1 OPP. THis patch removes hardcoded VDD2 OPP
> values and make threshold generic
>
> Signed-off-by: Vishwanath B.S. <vishwanath.bs@ti.com>
> Signed-off-by: Vijay Kumar <vijaykumar.gn@ti.com>
> ---
>  arch/arm/mach-omap2/resource34xx.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
> index cc85601..3bdb1f9 100644
> --- a/arch/arm/mach-omap2/resource34xx.c
> +++ b/arch/arm/mach-omap2/resource34xx.c
> @@ -372,7 +372,7 @@ int set_opp(struct shared_resource *resp, u32 target_level)
>  	int ind;
>  
>  	if (resp == vdd1_resp) {
> -		if (target_level < 3)
> +		if (target_level < MAX_VDD2_OPP)
>  			resource_release("vdd2_opp", &vdd2_dev);
>  
>  		resource_set_opp_level(VDD1_OPP, target_level, 0);
> @@ -381,7 +381,7 @@ int set_opp(struct shared_resource *resp, u32 target_level)
>  		 * is at 100Mhz or above.
>  		 * throughput in KiB/s for 100 Mhz = 100 * 1000 * 4.
>  		 */
> -		if (target_level >= 3)
> +		if (target_level > MIN_VDD2_OPP)
>  			resource_request("vdd2_opp", &vdd2_dev,
>  				(4 * (l3_opps + MAX_VDD2_OPP)->rate / 1000));
>  
> @@ -391,7 +391,7 @@ int set_opp(struct shared_resource *resp, u32 target_level)
>  		/* Convert the tput in KiB/s to Bus frequency in MHz */
>  		req_l3_freq = (tput * 1000)/4;
>  
> -		for (ind = 2; ind <= MAX_VDD2_OPP; ind++)
> +		for (ind = MIN_VDD2_OPP; ind <= MAX_VDD2_OPP; ind++)
>  			if ((l3_opps + ind)->rate >= req_l3_freq) {
>  				target_level = ind;
>  				break;
>   

IMHO, important catch, but as the previous patch was NAKed (for
MAX_VDDn_OPP), NAK to this too.
Regards,
Nishanth Menon

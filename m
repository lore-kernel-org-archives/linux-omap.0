From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 3/3] omap3: pm: removes hardcoded VDD1/2 OPP values and
 make threshold generic
Date: Thu, 19 Nov 2009 05:44:14 -0600
Message-ID: <4B052F8E.4030203@ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E940254330A66@dbde02.ent.ti.com>
Reply-To: nm@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:39480 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbZKSLoE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Nov 2009 06:44:04 -0500
Received: by yxe17 with SMTP id 17so1862386yxe.33
        for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2009 03:44:10 -0800 (PST)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940254330A66@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G.N, Vijayakumar" <vijaykumar.gn@ti.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

G.N, Vijayakumar said the following on 11/19/2009 05:26 AM:
> >From 202416dbdf3fce31bfd76f1e74dda89b382a78c3 Mon Sep 17 00:00:00 2001
> From: Vijay Kumar <vijaykumar.gn@ti.com>
> Date: Thu, 19 Nov 2009 15:07:38 +0530
> Subject: [PATCH 3/3] OMAP 3630: Update VDD2 values
>  The OMAP3630 VDD2 minimum value is 1 and Maximum value is 2. The VDD2
>  API's are updated to return proper VDD2 values.
>
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Manjunath GK <manjugk@ti.com>
> Signed-off-by: Vijay Kumar <vijaykumar.gn@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 1ed7f53..c240804 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -1080,7 +1080,7 @@ EXPORT_SYMBOL(omap3_get_min_vdd1_opp);
>  int omap3_get_max_vdd2_opp(void)
>  {
>  	if (cpu_is_omap3630())
> -		return VDD2_OPP3;
> +		return VDD2_OPP2;
>  	else /* Place holder for other 34xx (3430/3440) */
>  		return VDD2_OPP3;
>  
> @@ -1090,9 +1090,9 @@ EXPORT_SYMBOL(omap3_get_max_vdd2_opp);
>  int omap3_get_min_vdd2_opp(void)
>  {
>  	if (cpu_is_omap3630())
> -		return VDD2_OPP2;
> -	else /* Place holder for other 34xx (3430/3440) */
>  		return VDD2_OPP1;
> +	else /* Place holder for other 34xx (3430/3440) */
>   
this is redundant.
> +		return VDD2_OPP2;
>  
>  }
>  EXPORT_SYMBOL(omap3_get_min_vdd2_opp);
>   
I NAK this patch on the principle that these are redundant unashamedly
copies of each function without handling all scenarios:
e.g.
a) what if board x wants to disable vdd2 opp1? how can he get mainline
support with hacking on this?
b) if you have 3630-1000 device, how do you handle it cleanly?
c) you believe in OPP ID here, I DO NOT - I believe we should do things
based off frequencies.

Regards,
Nishanth Menon

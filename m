From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Smartreflex: Fix VDD2 OPP determining logic
Date: Wed, 20 May 2009 07:09:59 -0700
Message-ID: <8763fvuaq0.fsf@deeprootsystems.com>
References: <1242822417-17829-1-git-send-email-ext-roger.quadros@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:3502 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334AbZETOKA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 10:10:00 -0400
Received: by wf-out-1314.google.com with SMTP id 26so152492wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 07:10:01 -0700 (PDT)
In-Reply-To: <1242822417-17829-1-git-send-email-ext-roger.quadros@nokia.com> (Roger Quadros's message of "Wed\, 20 May 2009 15\:26\:57 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: linux-omap@vger.kernel.org

Roger Quadros <ext-roger.quadros@nokia.com> writes:

> Use l3_ick clock rate to find out current VDD2 OPP since
> VDD2 OPP table uses rates corresponding to L3 clock.
>
> Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>

Thanks, pushed to PM branch.

Kevin

> ---
>  arch/arm/mach-omap2/smartreflex.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 061cd4e..422c917 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -184,7 +184,7 @@ static u16 get_vdd2_opp(void)
>  	u16 opp;
>  	struct clk *clk;
>  
> -	clk = clk_get(NULL, "dpll3_m2_ck");
> +	clk = clk_get(NULL, "l3_ick");
>  
>  	if (clk == NULL || IS_ERR(clk) || l3_opps == NULL)
>  		return 0;
> -- 
> 1.6.0.4

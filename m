From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] OMAP2: Fix a cpu type check problem.
Date: Tue, 10 Aug 2010 17:32:20 +0300
Message-ID: <4C6162F4.7030500@compulab.co.il>
References: <1281443797-7062-1-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:36545 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757717Ab0HJOc2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Aug 2010 10:32:28 -0400
In-Reply-To: <1281443797-7062-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

On 08/10/10 15:36, Stanley.Miao wrote:
> cpu_is_omap3517() and cpu_is_omap3505() are the subgroups of cpu_is_omap34xx(),
> so we should check cpu_is_omap3517() and cpu_is_omap3505() first, then check
> cpu_is_omap34xx().
>
> Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
>   

Tested-by: Igor Grinberg <grinberg@compulab.co.il>

I've just ran into this yesterday evening.
Having a patch for this on the next day made me :)
Tested on AM3517.

> ---
>  arch/arm/mach-omap2/clock3xxx_data.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
> index 138646d..dfdce2d 100644
> --- a/arch/arm/mach-omap2/clock3xxx_data.c
> +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> @@ -3417,7 +3417,13 @@ int __init omap3xxx_clk_init(void)
>  	struct omap_clk *c;
>  	u32 cpu_clkflg = CK_3XXX;
>  
> -	if (cpu_is_omap34xx()) {
> +	if (cpu_is_omap3517()) {
> +		cpu_mask = RATE_IN_3XXX | RATE_IN_3430ES2PLUS;
> +		cpu_clkflg |= CK_3517;
> +	} else if (cpu_is_omap3505()) {
> +		cpu_mask = RATE_IN_3XXX | RATE_IN_3430ES2PLUS;
> +		cpu_clkflg |= CK_3505;
> +	} else if (cpu_is_omap34xx()) {
>  		cpu_mask = RATE_IN_3XXX;
>  		cpu_clkflg |= CK_343X;
>  
> @@ -3432,12 +3438,6 @@ int __init omap3xxx_clk_init(void)
>  			cpu_mask |= RATE_IN_3430ES2PLUS;
>  			cpu_clkflg |= CK_3430ES2;
>  		}
> -	} else if (cpu_is_omap3517()) {
> -		cpu_mask = RATE_IN_3XXX | RATE_IN_3430ES2PLUS;
> -		cpu_clkflg |= CK_3517;
> -	} else if (cpu_is_omap3505()) {
> -		cpu_mask = RATE_IN_3XXX | RATE_IN_3430ES2PLUS;
> -		cpu_clkflg |= CK_3505;
>  	}
>  
>  	if (omap3_has_192mhz_clk())
>   

-- 
Regards,
Igor.


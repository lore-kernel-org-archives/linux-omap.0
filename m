From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/5] ARM: OMAP1: Fix dpll1 reprogramming not actually
 allowed
Date: Mon, 28 Nov 2011 09:46:16 -0800
Message-ID: <20111128174616.GP31337@atomide.com>
References: <1322364751-29980-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <1322364751-29980-4-git-send-email-jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1322364751-29980-4-git-send-email-jkrzyszt@tis.icnet.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [111126 19:06]:
> DPLL1 reprogramming to a different rate is actually blocked inside
> omap1_select_table_rate(), resulting in the defalut rate of 60 MHz
> always used instead of the one selected in .config. Fix it.
> 
> Created against linux-3.2-rc2, tested on Amstrad Delta on top of
> linux-omap/fixes.

This too first requires something for boards to pass the supported
rates.

Tony
 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> ---
>  arch/arm/mach-omap1/clock.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
> index 3899176..962adbc 100644
> --- a/arch/arm/mach-omap1/clock.c
> +++ b/arch/arm/mach-omap1/clock.c
> @@ -200,10 +200,6 @@ int omap1_select_table_rate(struct clk *clk, unsigned long rate)
>  		if (ptr->xtal != ref_rate)
>  			continue;
>  
> -		/* DPLL1 cannot be reprogrammed without risking system crash */
> -		if (likely(dpll1_rate != 0) && ptr->pll_rate != dpll1_rate)
> -			continue;
> -
>  		/* Can check only after xtal frequency check */
>  		if (ptr->rate <= rate)
>  			break;
> -- 
> 1.7.3.4
> 

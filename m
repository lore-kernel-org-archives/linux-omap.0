From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP3+: dpll: optimize noncore dpll locking logic
Date: Thu, 24 May 2012 01:49:21 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205240147510.2572@utopia.booyaka.com>
References: <1337369838-15185-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50059 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841Ab2EXHtV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 May 2012 03:49:21 -0400
In-Reply-To: <1337369838-15185-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Vikram Pandita <vikram.pandita@ti.com>, Tony Lindgren <tony@atomide.com>, Jon Hunter <jon-hunter@ti.com>, Mike Turquette <mturquette@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Nishanth

On Fri, 18 May 2012, Nishanth Menon wrote:

> From: Vikram Pandita <vikram.pandita@ti.com>
> 
> If the dpll is already locked, code can be optimized
> to return much earlier than doing redundent set of lock mode
> and wait on idlest.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Jon Hunter <jon-hunter@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Mike Turquette <mturquette@ti.com>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>

Did you intend to add your Signed-off-by: to this patch?

Also, just FYI, no need to add the Cc: lines for the mailing lists in the 
bottom of the patch description.

- Paul


> ---
>  arch/arm/mach-omap2/dpll3xxx.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
> index fc56745..3cfd7c4 100644
> --- a/arch/arm/mach-omap2/dpll3xxx.c
> +++ b/arch/arm/mach-omap2/dpll3xxx.c
> @@ -135,11 +135,20 @@ static u16 _omap3_dpll_compute_freqsel(struct clk *clk, u8 n)
>   */
>  static int _omap3_noncore_dpll_lock(struct clk *clk)
>  {
> +	const struct dpll_data *dd;
>  	u8 ai;
> -	int r;
> +	u8 state = 1;
> +	int r = 0;
>  
>  	pr_debug("clock: locking DPLL %s\n", clk->name);
>  
> +	dd = clk->dpll_data;
> +	state <<= __ffs(dd->idlest_mask);
> +
> +	/* Check if already locked */
> +	if ((__raw_readl(dd->idlest_reg) & dd->idlest_mask) == state)
> +		goto done;
> +
>  	ai = omap3_dpll_autoidle_read(clk);
>  
>  	omap3_dpll_deny_idle(clk);
> @@ -151,6 +160,7 @@ static int _omap3_noncore_dpll_lock(struct clk *clk)
>  	if (ai)
>  		omap3_dpll_allow_idle(clk);
>  
> +done:
>  	return r;
>  }
>  
> -- 
> 1.7.9.5
> 


- Paul

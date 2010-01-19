From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHV5 2/4] OMAP3: Remove FreqSel for 3630
Date: Mon, 18 Jan 2010 19:30:48 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001181929540.3977@utopia.booyaka.com>
References: <1263803362-7083-1-git-send-email-vishwanath.bs@ti.com> <1263803362-7083-2-git-send-email-vishwanath.bs@ti.com> <1263803362-7083-3-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60112 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123Ab0ASCas (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 21:30:48 -0500
In-Reply-To: <1263803362-7083-3-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org

Vishwanath,

more comments.

On Mon, 18 Jan 2010, Vishwanath BS wrote:

> DPLL_FREQSEL field in CLKEN_PLL register is no longer valid for OMAP3630. So remove
> references to that.
> 
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> ---
>  arch/arm/mach-omap2/dpll.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/dpll.c b/arch/arm/mach-omap2/dpll.c
> index 87a5529..f872d10 100755
> --- a/arch/arm/mach-omap2/dpll.c
> +++ b/arch/arm/mach-omap2/dpll.c
> @@ -346,8 +346,9 @@ int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
>  	/* 3430 ES2 TRM: 4.7.6.9 DPLL Programming Sequence */
>  	_omap3_noncore_dpll_bypass(clk);
>  
> -	/* Set jitter correction */
> -	if (!cpu_is_omap44xx()) {
> +	/* Set jitter correction. No jitter correction for OMAP4 and 3630
> +	     since freqsel is field is no longer present */

Again, please follow Documentation/CodingStyle for your comment format.

> +	if (!cpu_is_omap44xx() && !cpu_is_omap3630()) {
>  		v = __raw_readl(dd->control_reg);
>  		v &= ~dd->freqsel_mask;
>  		v |= freqsel << __ffs(dd->freqsel_mask);
> @@ -430,8 +431,8 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
>  		if (dd->last_rounded_rate == 0)
>  			return -EINVAL;
>  
> -		/* No freqsel on OMAP4 */
> -		if (!cpu_is_omap44xx()) {
> +		/* No freqsel on OMAP4 and OMAP3630 */
> +		if (!cpu_is_omap44xx() && !cpu_is_omap3630()) {
>  			freqsel = _omap3_dpll_compute_freqsel(clk,
>  						dd->last_rounded_n);
>  			if (!freqsel)
> -- 
> 1.5.6.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul

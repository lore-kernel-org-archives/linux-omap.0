From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHV4 2/4] OMAP3: Remove FreqSel for 3630
Date: Thu, 7 Jan 2010 10:58:11 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001071057250.10034@utopia.booyaka.com>
References: <1262849801-9955-1-git-send-email-vishwanath.bs@ti.com> <1262849801-9955-2-git-send-email-vishwanath.bs@ti.com> <1262849801-9955-3-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34321 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435Ab0AGR6M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 12:58:12 -0500
In-Reply-To: <1262849801-9955-3-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org

Hello Vishwanath,

On Thu, 7 Jan 2010, Vishwanath BS wrote:

> Frequency Selection field is no longer valid for OMAP3630. So remove
> references to that.

The code in the patch is fine, but this patch description doesn't seem to 
have anything to do with the code.  Please fix and resend.

> 
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> ---
>  arch/arm/mach-omap2/dpll.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/dpll.c b/arch/arm/mach-omap2/dpll.c
> index 4f5570e..e3c6008 100755
> --- a/arch/arm/mach-omap2/dpll.c
> +++ b/arch/arm/mach-omap2/dpll.c
> @@ -346,8 +346,8 @@ int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
>  	/* 3430 ES2 TRM: 4.7.6.9 DPLL Programming Sequence */
>  	_omap3_noncore_dpll_bypass(clk);
>  
> -	/* Set jitter correction */
> -	if (!cpu_is_omap44xx()) {
> +	/* Set jitter correction. No jitter correction for OMAP4 and 3630 */
> +	if (!cpu_is_omap44xx() && !cpu_is_omap3630()) {
>  		v = __raw_readl(dd->control_reg);
>  		v &= ~dd->freqsel_mask;
>  		v |= freqsel << __ffs(dd->freqsel_mask);
> @@ -429,8 +429,8 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
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

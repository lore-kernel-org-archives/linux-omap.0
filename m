From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [RFC] ARM: OMAP: hwmod: wait for sysreset complete after
 enabling hwmod
Date: Tue, 23 Oct 2012 11:03:39 +0300
Message-ID: <1350979419.2143.71.camel@sokoban>
References: <1350922532-26338-1-git-send-email-t-kristo@ti.com>
	 <alpine.DEB.2.00.1210230745160.32436@utopia.booyaka.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54078 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752930Ab2JWIDq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Oct 2012 04:03:46 -0400
In-Reply-To: <alpine.DEB.2.00.1210230745160.32436@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Venkatraman S <svenkatr@ti.com>, khilman@ti.com

Hi Paul,

On Tue, 2012-10-23 at 07:47 +0000, Paul Walmsley wrote:
> Hi Tero,
> 
> On Mon, 22 Oct 2012, Tero Kristo wrote:
> 
> > When waking up from off-mode, some IP blocks are reset automatically by
> > hardware. For this reason, software must wait until the reset has
> > completed before attempting to access the IP block.
> > 
> > This patch fixes for example the bug introduced by commit
> > 6c31b2150ff96755d24e0ab6d6fea08a7bf5c44c ("mmc: omap_hsmmc: remove access
> > to SYSCONFIG register"), in which the MMC IP block is reset during
> > off-mode entry, but the code expects the module to be already available
> > during the execution of context restore.
> > 
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Venkatraman S <svenkatr@ti.com>
> 
> What do you think about these modifications?  The code is quite similar to 
> what was in the _ocp_softreset() function, so just moved it into a 
> function.  Also moved the callsite from the end of _enable_sysc() to the 
> beginning, which makes more sense to me, but would like to get your 
> opinion.

Looks good to me. Only reason I pushed the reset wait to the end of the
function was a minimal potential timing optimization. As the beginning
of the function will write a register, it will consume a bit of time
(especially if in 32k domain), so it can maybe save a single register
read in the delay loop if ordered that way.

Your way is probably safer, it might cause problems in some cases if the
config is written before reset has completed (can it?)

-Tero

> 
> - Paul
> 
> From: Tero Kristo <t-kristo@ti.com>
> Date: Mon, 22 Oct 2012 19:15:32 +0300
> Subject: [PATCH] [RFC] ARM: OMAP: hwmod: wait for sysreset complete after
>  enabling hwmod
> 
> When waking up from off-mode, some IP blocks are reset automatically by
> hardware. For this reason, software must wait until the reset has
> completed before attempting to access the IP block.
> 
> This patch fixes for example the bug introduced by commit
> 6c31b2150ff96755d24e0ab6d6fea08a7bf5c44c ("mmc: omap_hsmmc: remove access
> to SYSCONFIG register"), in which the MMC IP block is reset during
> off-mode entry, but the code expects the module to be already available
> during the execution of context restore.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Venkatraman S <svenkatr@ti.com>
> [paul@pwsan.com: moved softreset wait code into separate function; call
>  from top of _enable_sysc() rather than the bottom]
> 
> ---
>  arch/arm/mach-omap2/omap_hwmod.c |   56 ++++++++++++++++++++++++++++----------
>  1 file changed, 42 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 504e0e0..0356a09 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -423,6 +423,38 @@ static int _set_softreset(struct omap_hwmod *oh, u32 *v)
>  }
>  
>  /**
> + * _wait_softreset_complete - wait for an OCP softreset to complete
> + * @oh: struct omap_hwmod * to wait on
> + *
> + * Wait until the IP block represented by @oh reports that its OCP
> + * softreset is complete.  This can be triggered by software (see
> + * _ocp_softreset()) or by hardware upon returning from off-mode (one
> + * example is HSMMC).  Waits for up to MAX_MODULE_SOFTRESET_WAIT
> + * microseconds.  Returns the number of microseconds waited.
> + */
> +static int _wait_softreset_complete(struct omap_hwmod *oh)
> +{
> +	struct omap_hwmod_class_sysconfig *sysc;
> +	u32 softrst_mask;
> +	int c = 0;
> +
> +	sysc = oh->class->sysc;
> +
> +	if (sysc->sysc_flags & SYSS_HAS_RESET_STATUS)
> +		omap_test_timeout((omap_hwmod_read(oh, sysc->syss_offs)
> +				   & SYSS_RESETDONE_MASK),
> +				  MAX_MODULE_SOFTRESET_WAIT, c);
> +	else if (sysc->sysc_flags & SYSC_HAS_RESET_STATUS) {
> +		softrst_mask = (0x1 << sysc->sysc_fields->srst_shift);
> +		omap_test_timeout(!(omap_hwmod_read(oh, sysc->sysc_offs)
> +				    & softrst_mask),
> +				  MAX_MODULE_SOFTRESET_WAIT, c);
> +	}
> +
> +	return c;
> +}
> +
> +/**
>   * _set_dmadisable: set OCP_SYSCONFIG.DMADISABLE bit in @v
>   * @oh: struct omap_hwmod *
>   *
> @@ -1283,6 +1315,14 @@ static void _enable_sysc(struct omap_hwmod *oh)
>  	if (!oh->class->sysc)
>  		return;
>  
> +	/*
> +	 * Wait until reset has completed, this is needed as the IP
> +	 * block is reset automatically by hardware in some cases
> +	 * (off-mode for example), and the drivers require the
> +	 * IP to be ready when they access it
> +	 */
> +	_wait_softreset_complete(oh);
> +
>  	v = oh->_sysc_cache;
>  	sf = oh->class->sysc->sysc_flags;
>  
> @@ -1805,7 +1845,7 @@ static int _am33xx_disable_module(struct omap_hwmod *oh)
>   */
>  static int _ocp_softreset(struct omap_hwmod *oh)
>  {
> -	u32 v, softrst_mask;
> +	u32 v;
>  	int c = 0;
>  	int ret = 0;
>  
> @@ -1835,19 +1875,7 @@ static int _ocp_softreset(struct omap_hwmod *oh)
>  	if (oh->class->sysc->srst_udelay)
>  		udelay(oh->class->sysc->srst_udelay);
>  
> -	if (oh->class->sysc->sysc_flags & SYSS_HAS_RESET_STATUS)
> -		omap_test_timeout((omap_hwmod_read(oh,
> -						    oh->class->sysc->syss_offs)
> -				   & SYSS_RESETDONE_MASK),
> -				  MAX_MODULE_SOFTRESET_WAIT, c);
> -	else if (oh->class->sysc->sysc_flags & SYSC_HAS_RESET_STATUS) {
> -		softrst_mask = (0x1 << oh->class->sysc->sysc_fields->srst_shift);
> -		omap_test_timeout(!(omap_hwmod_read(oh,
> -						     oh->class->sysc->sysc_offs)
> -				   & softrst_mask),
> -				  MAX_MODULE_SOFTRESET_WAIT, c);
> -	}
> -
> +	c = _wait_softreset_complete(oh);
>  	if (c == MAX_MODULE_SOFTRESET_WAIT)
>  		pr_warning("omap_hwmod: %s: softreset failed (waited %d usec)\n",
>  			   oh->name, MAX_MODULE_SOFTRESET_WAIT);



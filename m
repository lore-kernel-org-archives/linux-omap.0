From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2] OMAP3: SDRC : Add comments on Errata i520 for Global
 SW reset
Date: Mon, 4 Oct 2010 10:12:05 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010041010490.13816@utopia.booyaka.com>
References: <1286208218-391-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41267 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539Ab0JDQMG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 12:12:06 -0400
In-Reply-To: <1286208218-391-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Vishwa,

On Mon, 4 Oct 2010, Vishwanath BS wrote:

> This patch adds comments on precatution to be taken if Global Warm reset is
> used as the means to trigger sysem reset.

thanks for this but the comment style still needs at least one more fix 
per Documentation/CodingStyle:

----

The preferred style for long (multi-line) comments is:

	/*
	 * This is the preferred style for multi-line
	 * comments in the Linux kernel source code.
	 * Please use it consistently.
	 *
	 * Description:  A column of asterisks on the left side,
	 * with beginning and ending almost-blank lines.
	 */

-----

Please make sure that every line in the comment block has an asterisk on 
the left side.

Once you fix that and repost, I'll queue for 2.6.38.

- Paul

> 
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/prcm.c |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> index c201374..6494a88
> --- a/arch/arm/mach-omap2/prcm.c
> +++ b/arch/arm/mach-omap2/prcm.c
> @@ -157,6 +157,34 @@ void omap_prcm_arch_reset(char mode, const char *cmd)
>  	else
>  		WARN_ON(1);
>  
> +	/*
> +	 * As per Errata i520, In some cases, user will not be able to
> +	 * access DDR memory after warm-reset.
> +	 * This situation occurs while the warm-reset happens during a read
> +	 * access to DDR memory. In that particular condition, DDR memory
> +	 * does not respond to a corrupted read command due to the warm
> +	 * reset occurence but SDRC is waiting for read completion.
> +	 * SDRC is not sensitive to the warm reset, but the interconect is
> +	 * reset on the fly, thus causing a misalignment between SDRC logic,
> +	 * interconect logic and DDR memory state.
> +	 * WORKAROUND:
> +	 * Steps to perform before a Warm reset is trigged:
> +	 * 1. enable self-refresh on idle request
> +	 * 2. put SDRC in idle
> +	 * 3. wait until SDRC goes to idle
> +	 * 4. generate SW reset (Global SW reset)
> +
> +	 * Steps to be performed after warm reset occurs (in bootloader):
> +	 * if HW warm reset is the source, apply below steps before any
> +	 * accesses to SDRAM:
> +	 * 1. Reset SMS and SDRC and wait till reset is complete
> +	 * 2. Re-initialize SMS, SDRC and memory
> +
> +	 * NOTE: Above work around is required only if arch reset is implemented
> +	 * using Global SW reset(GLOBAL_SW_RST). DPLL3 reset does not need
> +	 * the WA since it resets SDRC as well as part of cold reset.
> +	 */
> +
>  	if (cpu_is_omap24xx() || cpu_is_omap34xx())
>  		prm_set_mod_reg_bits(OMAP_RST_DPLL3_MASK, prcm_offs,
>  						 OMAP2_RM_RSTCTRL);
> -- 
> 1.7.0.4
> 


- Paul

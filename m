From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/04] OMAP3: PM: Disable PER DPLL idle before OFF, reduces OFF latency by 20ms
Date: Tue, 16 Jun 2009 07:21:24 -0700
Message-ID: <87k53c5kez.fsf@deeprootsystems.com>
References: <1245153154-1876-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:18333 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbZFPOVY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jun 2009 10:21:24 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1827171wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 16 Jun 2009 07:21:27 -0700 (PDT)
In-Reply-To: <1245153154-1876-1-git-send-email-rnayak@ti.com> (Rajendra Nayak's message of "Tue\, 16 Jun 2009 17\:22\:31 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, dderrick@ti.com, r-woodruff2@ti.com

Rajendra Nayak <rnayak@ti.com> writes:

> If autoidle for DPLL4 is enabled in the stored scratchpad
> value of CM_AUTOIDLE_PLL then there is an added delay by
> the boot ROM when coming out of OFF mode.
> The patch disables this bitfield in the stored scratchpad value.
>
> This should significantly reduce CORE OFF latency and also
> bring down the threshold for CORE OFF, making OFF affordable
> even with smaller sleep times.
> This patch however does not optimize the C state threshold for
> CORE OFF states based on the new latency.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Please forgive the DPLL ignorance here, but I think a little more
verbose description is needed here, especially for those of use who
don't understand all the voodoo involved with DPLLs and ROM code
interaction.

>From this description, it's not clear what the resulting state of
DPLL4 will be and thus what the impact might be on power consumption.

IOW, Does this leave the DPLL in a locked, or is ROM code is doing a
software-programmed transition to low-power stop?  or is there some
other automatic disable when PER goes to OFF?

Can you clarify and update the description.  Thanks.

Kevin

> ---
>  arch/arm/mach-omap2/control.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
> index c9407c0..a7159a9 100644
> --- a/arch/arm/mach-omap2/control.c
> +++ b/arch/arm/mach-omap2/control.c
> @@ -238,6 +238,13 @@ void omap3_save_scratchpad_contents(void)
>  			cm_read_mod_reg(PLL_MOD, CM_CLKEN);
>  	prcm_block_contents.cm_autoidle_pll =
>  			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_AUTOIDLE_PLL);
> +	/*
> +	 * ROM restore takes 20mS longer if PER idle is enabled before OFF.
> +	 * Clear feature before sleep. The origional idle state is
> +	 * restored by software as part of wake procedure.
> +	 */
> +	prcm_block_contents.cm_autoidle_pll &= ~OMAP3430_AUTO_PERIPH_DPLL_MASK;
> +
>  	prcm_block_contents.cm_clksel1_pll =
>  			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL1_PLL);
>  	prcm_block_contents.cm_clksel2_pll =
> -- 
> 1.5.4.7
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

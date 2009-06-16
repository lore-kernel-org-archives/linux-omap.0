From: "Derrick, David" <dderrick@ti.com>
Subject: RE: [PATCH 01/04] OMAP3: PM: Disable PER DPLL idle before OFF,
 reduces OFF latency by 20ms
Date: Tue, 16 Jun 2009 11:09:57 -0500
Message-ID: <92CDD168D1E81F4F9D3839DC45903FC6536982D4@dlee03.ent.ti.com>
References: <1245153154-1876-1-git-send-email-rnayak@ti.com>
 <87k53c5kez.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48378 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753732AbZFPQKD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jun 2009 12:10:03 -0400
In-Reply-To: <87k53c5kez.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>

Kevin,

There is a feature to auto idle DPLLs.
The DPLLs will go into a bypass mode when not needed.

The boot ROM restores some PRCM registers from scratchpad memory when waking up from the OFF power mode.
The procedure in the boot ROM is to restore the DPLL4 settings and then poll until the DPLL4 has locked. There is a timeout on the poll of 20ms.

If you store into scratchpad the register such that the autoidle is enabled, then as soon as the boot ROM locks DPLL4 it will immediately go into bypass. Therefore the poll on the DPLL4 locking will time out (20ms).

If you store into scratchpad the register such that the autoidle is not enabled, then the boot ROM will lock DPLL4 and poll until the DPLL4 is locked - which happens in the usec range.

You need to ensure that you re-enable the autoidle of DPLL4 after you get back to user code - which is already done in our base port so you shouldn't have to worry with it unless you have removed this code.

This change allows the wake up latency from OFF mode to be reduced by 20msec.

Note that we have seen some instability with this change so use with caution.

Regards,
David

-----Original Message-----
From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
Sent: Tuesday, June 16, 2009 9:21 AM
To: Nayak, Rajendra
Cc: linux-omap@vger.kernel.org; Derrick, David; Woodruff, Richard
Subject: Re: [PATCH 01/04] OMAP3: PM: Disable PER DPLL idle before OFF, reduces OFF latency by 20ms

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


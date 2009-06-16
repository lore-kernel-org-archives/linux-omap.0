From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 01/04] OMAP3: PM: Disable PER DPLL idle before OFF, reduces OFF latency by 20ms
Date: Tue, 16 Jun 2009 15:52:51 +0300
Message-ID: <87fxe0basc.fsf@trdhcp146196.ntc.nokia.com>
References: <1245153154-1876-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:65091 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268AbZFPMys convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jun 2009 08:54:48 -0400
In-Reply-To: <1245153154-1876-1-git-send-email-rnayak@ti.com> (ext Rajendra Nayak's message of "Tue\, 16 Jun 2009 13\:52\:31 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dderrick@ti.com" <dderrick@ti.com>, "r-woodruff2@ti.com" <r-woodruff2@ti.com>

ext Rajendra Nayak <rnayak@ti.com> writes:

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

Do you have any numbers to give on what is the impact to consumption?

>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/control.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/cont=
rol.c
> index c9407c0..a7159a9 100644
> --- a/arch/arm/mach-omap2/control.c
> +++ b/arch/arm/mach-omap2/control.c
> @@ -238,6 +238,13 @@ void omap3_save_scratchpad_contents(void)
>  			cm_read_mod_reg(PLL_MOD, CM_CLKEN);
>  	prcm_block_contents.cm_autoidle_pll =3D
>  			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_AUTOIDLE_PLL);
> +	/*
> +	 * ROM restore takes 20mS longer if PER idle is enabled before OFF.
> +	 * Clear feature before sleep. The origional idle state is
> +	 * restored by software as part of wake procedure.
> +	 */
> +	prcm_block_contents.cm_autoidle_pll &=3D ~OMAP3430_AUTO_PERIPH_DPLL=
_MASK;
> +
>  	prcm_block_contents.cm_clksel1_pll =3D
>  			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL1_PLL);
>  	prcm_block_contents.cm_clksel2_pll =3D
> --=20
> 1.5.4.7
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Jouni H=C3=B6gander
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

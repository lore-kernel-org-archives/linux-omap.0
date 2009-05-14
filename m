From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/1] ARM:OMAP3: Fix PLL_MOD CLKEN offset in scratchpad
Date: Thu, 14 May 2009 10:11:46 -0700
Message-ID: <87vdo3txrh.fsf@deeprootsystems.com>
References: <1242126136-8419-1-git-send-email-kalle.jokiniemi@digia.com>
	<1242126136-8419-2-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f115.google.com ([209.85.222.115]:35033 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbZENRLr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 13:11:47 -0400
Received: by pzk13 with SMTP id 13so694087pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 14 May 2009 10:11:48 -0700 (PDT)
In-Reply-To: <1242126136-8419-2-git-send-email-kalle.jokiniemi@digia.com> (Kalle Jokiniemi's message of "Tue\, 12 May 2009 14\:02\:16 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: linux-omap@vger.kernel.org, jouni.hogander@nokia.com

Kalle Jokiniemi <kalle.jokiniemi@digia.com> writes:

> The CM_CLKEN_PLL register saved in scratchpad memory
> was wrongly using offset of 0x0004 instead of 0x0000.
>
> The effect of this was that boot ROM code would
> restore the wrong value when waking up from off mode.
> This wrong value, however, will be overwritten by
> prcm context restore. Still, a short period of wrong
> clock settings in CM_CLKEN_PLL remained between ROM
> code and prcm context restore. This is fixed by the
> patch.
>
> Problem reported by: Jouni H=F6gander <jouni.hogander@nokia.com>
>
> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>

Thanks, pushed to PM branch.

Kevin

> ---
>  arch/arm/mach-omap2/control.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/cont=
rol.c
> index a0429fe..60de860 100644
> --- a/arch/arm/mach-omap2/control.c
> +++ b/arch/arm/mach-omap2/control.c
> @@ -235,7 +235,7 @@ void omap3_save_scratchpad_contents(void)
>  	prcm_block_contents.cm_clksel_wkup =3D
>  			cm_read_mod_reg(WKUP_MOD, CM_CLKSEL);
>  	prcm_block_contents.cm_clken_pll =3D
> -			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKEN_PLL);
> +			cm_read_mod_reg(PLL_MOD, CM_CLKEN);
>  	prcm_block_contents.cm_autoidle_pll =3D
>  			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_AUTOIDLE_PLL);
>  	prcm_block_contents.cm_clksel1_pll =3D
> --=20
> 1.5.4.3
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

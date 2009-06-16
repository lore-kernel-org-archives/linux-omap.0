From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 02/04] OMAP3: PM: Prevent AUTO_RET and AUTO_OFF being enabled simultaneously
Date: Tue, 16 Jun 2009 15:39:49 +0300
Message-ID: <87ws7cfj3e.fsf@trdhcp146196.ntc.nokia.com>
References: <1245153154-1876-1-git-send-email-rnayak@ti.com>
	<1245153154-1876-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37220 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbZFPMls convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jun 2009 08:41:48 -0400
In-Reply-To: <1245153154-1876-2-git-send-email-rnayak@ti.com> (ext Rajendra Nayak's message of "Tue\, 16 Jun 2009 13\:52\:32 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dderrick@ti.com" <dderrick@ti.com>, "r-woodruff2@ti.com" <r-woodruff2@ti.com>

ext Rajendra Nayak <rnayak@ti.com> writes:

> There is a design requirement in OMAP3 that Auto_RET and AUTO_OFF
> should not be set together. The PRCM FSM  has been coded assuming
> that SW will set either auto_ret or auto_off bit depending on
> whether the core has been programmed to go into open switched
> logic retention state or OFF state. They are mutually exclusive.

So we don't have to do this if closed switch retention is used? (This
is what is currently used in linux-omap:pm)

> A similar issue will exist if SW sets  auto_ret=3D auto_off=3D1 and
> auto_sleep =3D 1 in the PRM voltage CTRL register
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index a9ef670..d4225b4 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -392,6 +392,10 @@ void omap_sram_idle(void)
>  					     OMAP3_PRM_VOLTCTRL_OFFSET);
>  			omap3_core_save_context();
>  			omap3_prcm_save_context();
> +		} else if (core_next_state =3D=3D PWRDM_POWER_RET) {
> +			prm_set_mod_reg_bits(OMAP3430_AUTO_RET,
> +						OMAP3430_GR_MOD,
> +						OMAP3_PRM_VOLTCTRL_OFFSET);
>  		}
>  		/* Enable IO-PAD and IO-CHAIN wakeups */
>  		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
> @@ -446,6 +450,10 @@ void omap_sram_idle(void)
>  			prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF,
>  					       OMAP3430_GR_MOD,
>  					       OMAP3_PRM_VOLTCTRL_OFFSET);
> +		else if (core_next_state =3D=3D PWRDM_POWER_RET)
> +			prm_clear_mod_reg_bits(OMAP3430_AUTO_RET,
> +						OMAP3430_GR_MOD,
> +						OMAP3_PRM_VOLTCTRL_OFFSET);
>  		/* Enable smartreflex after WFI */
>  		enable_smartreflex(SR1);
>  		enable_smartreflex(SR2);
> @@ -1128,10 +1136,6 @@ static void __init configure_vc(void)
>  				OMAP3430_GR_MOD,
>  				OMAP3_PRM_VC_I2C_CFG_OFFSET);
> =20
> -	/* Setup value for voltctrl */
> -	prm_write_mod_reg(OMAP3430_AUTO_RET,
> -			  OMAP3430_GR_MOD, OMAP3_PRM_VOLTCTRL_OFFSET);
> -
>  	/* Write setup times */
>  	prm_write_mod_reg(prm_setup.clksetup, OMAP3430_GR_MOD,
>  			OMAP3_PRM_CLKSETUP_OFFSET);
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

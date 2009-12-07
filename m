From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] OMAP3: PM: Enable wake-up from McBSP2, 3 and 4 modules
Date: Mon, 7 Dec 2009 15:38:06 +0200
Message-ID: <200912071538.06968.peter.ujfalusi@nokia.com>
References: <1259241530-26109-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37513 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934520AbZLGNiH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Dec 2009 08:38:07 -0500
In-Reply-To: <1259241530-26109-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tony@atomide.com" <tony@atomide.com>

Hello Tony, Kevin,

On Thursday 26 November 2009 15:18:50 Ujfalusi Peter (Nokia-D/Tampere) =
wrote:
> Wake-up from McBSP ports are needed, especially when the THRESHOLD
> dma mode is in use for audio playback.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index 81ed252..6b17647 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -878,12 +878,16 @@ static void __init prcm_setup_regs(void)
>  	/* Enable wakeups in PER */
>  	prm_write_mod_reg(OMAP3430_EN_GPIO2 | OMAP3430_EN_GPIO3 |
>  			  OMAP3430_EN_GPIO4 | OMAP3430_EN_GPIO5 |
> -			  OMAP3430_EN_GPIO6 | OMAP3430_EN_UART3,
> +			  OMAP3430_EN_GPIO6 | OMAP3430_EN_UART3 |
> +			  OMAP3430_EN_MCBSP2 | OMAP3430_EN_MCBSP3 |
> +			  OMAP3430_EN_MCBSP4,
>  			  OMAP3430_PER_MOD, PM_WKEN);
>  	/* and allow them to wake up MPU */
>  	prm_write_mod_reg(OMAP3430_GRPSEL_GPIO2 | OMAP3430_EN_GPIO3 |
>  			  OMAP3430_GRPSEL_GPIO4 | OMAP3430_EN_GPIO5 |
> -			  OMAP3430_GRPSEL_GPIO6 | OMAP3430_EN_UART3,
> +			  OMAP3430_GRPSEL_GPIO6 | OMAP3430_EN_UART3 |
> +			  OMAP3430_EN_MCBSP2 | OMAP3430_EN_MCBSP3 |
> +			  OMAP3430_EN_MCBSP4,
>  			  OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
>=20
>  	/* Don't attach IVA interrupts */
>=20

Have you had time to take a look at this patch?

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

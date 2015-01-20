From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2] ASoC: OMAP: mcbsp: ensure that CLKX and CLKR are not
 used as ouput pins when they are used as input clock for the SRG.
Date: Tue, 20 Jan 2015 10:47:55 +0200
Message-ID: <54BE163B.2000208@ti.com>
References: <1421702668-21135-1-git-send-email-niederp@physik.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52236 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248AbbATIsM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Jan 2015 03:48:12 -0500
In-Reply-To: <1421702668-21135-1-git-send-email-niederp@physik.uni-kl.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?B?VGhvbWFzIE5pZWRlcnByw7xt?= <niederp@physik.uni-kl.de>, jarkko.nikula@bitmer.com
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

On 01/19/2015 11:24 PM, Thomas Niederpr=C3=BCm wrote:
> This patch fixes faulty behaviour in a setup where the input clock fo=
r the
> SRG is fed through the CLKR/CLKX pin but the McBSP is configured to b=
e
> master (SND_SOC_DAIFMT_CBS_CFS). In that case of course CLKR/CLKX mus=
t
> not be configured as output pin. Otherwise the input clock is messed =
up
> horribly.
>=20
> This patch makes it possible to use the CLKR/CLKX pin rather than CLK=
S to
> inject a reference clock in setups where McBSP is master and not both
> rx and tx are used. However for this to work it has to be ensured tha=
t
> set_dai_sysclk() is called after set_dai_fmt().
>=20
> This was tested on a beagleboard-xm using McBSP1 to drive a i2s DAC t=
hrough
> the tx lines (CLKX,FSX,DX). Using this patch the CLKR pin is used to =
inject
> an external reference clock.
>=20
> changes since v1:
> - added comments explaining the bit masking to disable output on CLKR=
/CLKX

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

>=20
> Signed-off-by: Thomas Niederpr=C3=BCm <niederp@physik.uni-kl.de>
> ---
>  sound/soc/omap/omap-mcbsp.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.=
c
> index bd3ef2a..c37f606 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -530,8 +530,19 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct =
snd_soc_dai *cpu_dai,
> =20
>  	case OMAP_MCBSP_SYSCLK_CLKX_EXT:
>  		regs->srgr2	|=3D CLKSM;
> +		regs->pcr0	|=3D SCLKME;
> +		/*
> +		 * If McBSP is master but yet the CLKX/CLKR pin drives the SRG,
> +		 * disable output on those pins. This enables to inject the=20
> +		 * reference clock through CLKX/CLKR. For this to work=20
> +		 * set_dai_sysclk() _needs_ to be called after set_dai_fmt().
> +		 */
> +		regs->pcr0	&=3D ~CLKXM;
> +		break;
>  	case OMAP_MCBSP_SYSCLK_CLKR_EXT:
>  		regs->pcr0	|=3D SCLKME;
> +		/* Disable ouput on CLKR pin in master mode */
> +		regs->pcr0	&=3D ~CLKRM;
>  		break;
>  	default:
>  		err =3D -ENODEV;
>=20


--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

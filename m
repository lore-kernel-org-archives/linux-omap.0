From: Thomas =?ISO-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Subject: Re: [PATCH] ASoC: OMAP: mcbsp: ensure that CLKX and CLKR are not
 used as ouput pins when they are used as input clock for the SRG.
Date: Fri, 16 Jan 2015 11:15:35 +0100
Message-ID: <1421403335.2546.14.camel@ag-ott-thomas.physik.uni-kl.de>
References: <1421360901-20671-1-git-send-email-niederp@physik.uni-kl.de>
	 <54B8D6CB.6020801@ti.com>
Reply-To: niederp@physik.uni-kl.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:60709 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbbAPKPq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2015 05:15:46 -0500
In-Reply-To: <54B8D6CB.6020801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: jarkko.nikula@bitmer.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

Am Freitag, den 16.01.2015, 11:15 +0200 schrieb Peter Ujfalusi:
> On 01/16/2015 12:28 AM, Thomas Niederpr=C3=BCm wrote:
> > This patch fixes faulty behaviour in a setup where the input clock =
for
> > the SRG is fed through the CLKR pin but the McBSP is configured to =
be
> > master (SND_SOC_DAIFMT_CBS_CFS). In that case of course CLKR must n=
ot be
> > configured as output pin. Otherwise the input clock is messed up
> > horribly. The same reasoning applies if CLKX is configured as input=
 for
> > the SRG.
>=20
> If CLKX/CLKR is used as input clock for McBSP then the CBS_CFS is not=
 valid.
> In this case you need to use CBM_CFS.
>=20
The setup I am using is the following: McBSP is driving an external i2s
DAC as master by supplying CLKX and FSX and DX. The DAC only supports
i2s slave mode. For synchronization the DAC and the McBSP should share
the same master/reference clock (CLKM). Since I don't need the receive
path of the McBSP anyway for the DAC I can use the CLKR pin to insert
the CLKM as input to the SRG. I think in this scenario CBS_CFS is valid
since the McBSP acts as master (for the transmit path)

It might be more common to use the CKLS pin to inject the reference
clock, but the beagleboard-xm I am using already hard wired this to the
built-in twl4030 codec which makes it unusable.

> >=20
> > Signed-off-by: Thomas Niederpr=C3=BCm <niederp@physik.uni-kl.de>
> > ---
> >  sound/soc/omap/omap-mcbsp.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbs=
p.c
> > index bd3ef2a..c89f562 100644
> > --- a/sound/soc/omap/omap-mcbsp.c
> > +++ b/sound/soc/omap/omap-mcbsp.c
> > @@ -530,8 +530,12 @@ static int omap_mcbsp_dai_set_dai_sysclk(struc=
t snd_soc_dai *cpu_dai,
> > =20
> >  	case OMAP_MCBSP_SYSCLK_CLKX_EXT:
> >  		regs->srgr2	|=3D CLKSM;
> > +		regs->pcr0	|=3D SCLKME;
> > +		regs->pcr0	&=3D ~CLKXM;
> > +		break;
> >  	case OMAP_MCBSP_SYSCLK_CLKR_EXT:
> >  		regs->pcr0	|=3D SCLKME;
> > +		regs->pcr0	&=3D ~CLKRM;
> >  		break;
> >  	default:
> >  		err =3D -ENODEV;
> >=20
>=20
>=20

--=20
Thomas Niederpr=C3=BCm
TU Kaiserslautern
=46B Physik (AG Ott)
Erwin-Schr=C3=B6dinger-Str. 46/431
67663 Kaiserslautern
Tel.: 0631 205 2387
=46ax: 0631 205 3906

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

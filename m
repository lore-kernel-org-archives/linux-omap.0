From: Thomas =?ISO-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Subject: Re: [PATCH] ASoC: OMAP: mcbsp: ensure that CLKX and CLKR are not
 used as ouput pins when they are used as input clock for the SRG.
Date: Fri, 16 Jan 2015 16:06:38 +0100
Message-ID: <1421420798.2546.22.camel@ag-ott-thomas.physik.uni-kl.de>
References: <1421360901-20671-1-git-send-email-niederp@physik.uni-kl.de>
		 <54B8D6CB.6020801@ti.com>
	 <1421403335.2546.14.camel@ag-ott-thomas.physik.uni-kl.de>
	 <54B9074B.5020903@ti.com>
Reply-To: niederp@physik.uni-kl.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:41736 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbbAPPGr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2015 10:06:47 -0500
In-Reply-To: <54B9074B.5020903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: jarkko.nikula@bitmer.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

Am Freitag, den 16.01.2015, 14:42 +0200 schrieb Peter Ujfalusi:
> On 01/16/2015 12:15 PM, Thomas Niederpr=C3=BCm wrote:
> > Am Freitag, den 16.01.2015, 11:15 +0200 schrieb Peter Ujfalusi:
> >> On 01/16/2015 12:28 AM, Thomas Niederpr=C3=BCm wrote:
> >>> This patch fixes faulty behaviour in a setup where the input cloc=
k for
> >>> the SRG is fed through the CLKR pin but the McBSP is configured t=
o be
> >>> master (SND_SOC_DAIFMT_CBS_CFS). In that case of course CLKR must=
 not be
> >>> configured as output pin. Otherwise the input clock is messed up
> >>> horribly. The same reasoning applies if CLKX is configured as inp=
ut for
> >>> the SRG.
> >>
> >> If CLKX/CLKR is used as input clock for McBSP then the CBS_CFS is =
not valid.
> >> In this case you need to use CBM_CFS.
> >>
> > The setup I am using is the following: McBSP is driving an external=
 i2s
> > DAC as master by supplying CLKX and FSX and DX. The DAC only suppor=
ts
> > i2s slave mode. For synchronization the DAC and the McBSP should sh=
are
> > the same master/reference clock (CLKM). Since I don't need the rece=
ive
> > path of the McBSP anyway for the DAC I can use the CLKR pin to inse=
rt
> > the CLKM as input to the SRG. I think in this scenario CBS_CFS is v=
alid
> > since the McBSP acts as master (for the transmit path)
>=20
> Unfortunately the omap-mcbsp driver only supports synchronous configu=
ration
> for tx/rx (since almost all McBSP instance can only be used this way)=
=2E The
> first stream will configure both tx and rx to have the same propertie=
s. Even
> if you are using McBSP1 which has separate FSX and FSR lines, the dri=
ver does
> not have support for this.
> From HW point of view this configuration is valid (not something I wo=
uld
> expect in any product). I don't think there are or will be other desi=
gns than
> your using this mode... But, if you add some comment around the maski=
ng of
> CLKXM and CLKRM bits that would be great.

Do you mean adding it to the commit message or to the code? or both?

> Just shortly why and also note that the set_dai_sysclk() _need_ to be=
 called
> after set_dai_fmt() to get the configuration you expect to see.
>=20
> > It might be more common to use the CKLS pin to inject the reference
> > clock, but the beagleboard-xm I am using already hard wired this to=
 the
> > built-in twl4030 codec which makes it unusable.
>=20
> If you don't use the twl4030 the 256FS line should be floating, we ar=
e using
> CBM_CFM for the twl4030 card which means that the 256FS is not enable=
d -> the
> line is floating.
> It should be safe to use the CLKS, but it is not rooted to any pin :(
> Or remove the resistor form the line and connect your sync clock inst=
ead.

I considered that for a moment as well, but it seemed hack-ish to me. I
have to live with whatever can be muxed to the expansion headers of the
beagle-xm and with that boundary condition using the CLKR seemed to be
the most elegant solution. Also I gain the benefit that the twl4030
remains usable.=20

>=20
> >>>
> >>> Signed-off-by: Thomas Niederpr=C3=BCm <niederp@physik.uni-kl.de>
> >>> ---
> >>>  sound/soc/omap/omap-mcbsp.c | 4 ++++
> >>>  1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mc=
bsp.c
> >>> index bd3ef2a..c89f562 100644
> >>> --- a/sound/soc/omap/omap-mcbsp.c
> >>> +++ b/sound/soc/omap/omap-mcbsp.c
> >>> @@ -530,8 +530,12 @@ static int omap_mcbsp_dai_set_dai_sysclk(str=
uct snd_soc_dai *cpu_dai,
> >>> =20
> >>>  	case OMAP_MCBSP_SYSCLK_CLKX_EXT:
> >>>  		regs->srgr2	|=3D CLKSM;
> >>> +		regs->pcr0	|=3D SCLKME;
> >>> +		regs->pcr0	&=3D ~CLKXM;
> >>> +		break;
> >>>  	case OMAP_MCBSP_SYSCLK_CLKR_EXT:
> >>>  		regs->pcr0	|=3D SCLKME;
> >>> +		regs->pcr0	&=3D ~CLKRM;
> >>>  		break;
> >>>  	default:
> >>>  		err =3D -ENODEV;
> >>>
> >>
> >>
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

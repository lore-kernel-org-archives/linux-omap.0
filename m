From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/5] ASoC: OMAP2+: Update Audio IP with sDMA binding for
 DT boot
Date: Thu, 7 Mar 2013 14:03:31 +0100
Message-ID: <51389023.2000907@ti.com>
References: <1362660204-27074-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60129 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494Ab3CGNDv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Mar 2013 08:03:51 -0500
In-Reply-To: <1362660204-27074-1-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

Hi Sebastien,

On 03/07/2013 01:43 PM, Sebastien Guiriec wrote:
> This patch serie is converting OMAP Audio IPs in order to use OMAP sD=
MA DT
> binding in case of DT boot on OMAP2+ platforms.

The content of the patches looks about right for me, however I would sq=
uash
together the IP and platform driver patches so we avoid breakage within=
 the
series. Also I would put the patch for the .dtsi files as first one.

--=20
P=E9ter

> It is depending on the next patches:
>=20
> [1] http://www.spinics.net/lists/arm-kernel/msg227836.html
> [2] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg84668.h=
tml
>=20
> It has been tested on:
> - OMAP5 (sEVM/panda)in DT boot (McPDM/DMIC).
> - OMAP4 (SDP4430/Panda) in both DT/non DT boot (McPDM/DMIC)
> - OMAP3 (Beagle XM) in both DT/non DT boot (McBSP)
>=20
> Sebastien Guiriec (5):
>   ASoC: omap-pcm: Move to generic DMA for DT binding
>   ASoC: omap-dmic: Update driver for DMA DT binding.
>   ASoC: omap-mcpdm: Update driver for DMA DT binding.
>   ASoC: omap-mcbsp:Update driver for DMA DT binding.
>   ARM: dts: OMAP2+: Add SDMA Audio IPs bindings
>=20
>  arch/arm/boot/dts/omap2420.dtsi |    6 ++++++
>  arch/arm/boot/dts/omap2430.dtsi |   15 +++++++++++++++
>  arch/arm/boot/dts/omap3.dtsi    |   15 +++++++++++++++
>  arch/arm/boot/dts/omap4.dtsi    |   17 +++++++++++++++++
>  arch/arm/boot/dts/omap5.dtsi    |   14 ++++++++++++++
>  sound/soc/omap/mcbsp.c          |   26 ++++++++++++++++----------
>  sound/soc/omap/omap-dmic.c      |   15 +++++++++------
>  sound/soc/omap/omap-mcpdm.c     |   22 ++++++++++++++--------
>  sound/soc/omap/omap-pcm.c       |   12 ++++++++++--
>  sound/soc/omap/omap-pcm.h       |    1 +
>  10 files changed, 117 insertions(+), 26 deletions(-)
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [alsa-devel] [PATCH 0/4] ASoC: OMAP4: McPDM: Fix legacy support
Date: Tue, 9 Aug 2011 10:27:17 +0300
Message-ID: <1454327.U3ERne0amE@barack>
References: <1312284857-1774-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58648 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752506Ab1HIH1W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Aug 2011 03:27:22 -0400
In-Reply-To: <1312284857-1774-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: "Girdwood, Liam" <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>, "Lopez Cruz, Misael" <misael.lopez@ti.com>

Hi Tony,

On Tuesday 02 August 2011 13:34:13 Ujfalusi, Peter wrote:
> Hello,
>=20
> The OMAP4 McPDM driver in upstream has been broken for some time...
> This series fixes that, and enables basic audio playback/capture over=
 the
> mcpdm interface.

Would you have time to look at this series?
Specially patch 1 (maybe 2 as well).
We are planning to send this series through audio for 3.1.

>=20
> Two patch in this series has been taken from the "OMAP4/ASoC: New McP=
DM
> driver" series (patch 1, and 2) [1]. Since I was on holiday, I did no=
t had
> time to rewrite the driver rewrite patch, but I feel that fixing the =
basic
> audio support for OMAP4 is needed.
> The aim here is to have working audio in upstream kernel for 3.1, and=
 have
> the new McPDM driver stack up for the 3.2 release.
>=20
> [1]
> http://mailman.alsa-project.org/pipermail/alsa-devel/2011-July/041687=
=2Ehtml
>=20
> Br,
> Peter
>=20
> ---
> Peter Ujfalusi (4):
>   OMAP: McPDM: Convert McPDM device to omap_device
>   OMAP4: hwmod: enable mcpdm hwmod device.
>   ASoC: omap-mcpdm: Fix threshold and dma configuration
>   ASoC: OMAP4: McPDM: Convert to hwmod/omap_device
>=20
>  arch/arm/mach-omap2/devices.c              |   33 ++++++++++++++++++=
++++++
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
>  arch/arm/plat-omap/devices.c               |   36
> -------------------------- sound/soc/omap/mcpdm.c                    =
 | =20
> 38 +++++++++++++++------------ sound/soc/omap/mcpdm.h                =
     |
>    1 -
>  sound/soc/omap/omap-mcpdm.c                |   19 +++++++++----
>  sound/soc/omap/sdp4430.c                   |    2 +-
>  7 files changed, 69 insertions(+), 62 deletions(-)

Thanks,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

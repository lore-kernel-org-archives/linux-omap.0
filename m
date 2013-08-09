From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/21] ARM: OMAP2+: use new display drivers
Date: Fri, 9 Aug 2013 13:53:06 +0300
Message-ID: <5204CA12.5070203@ti.com>
References: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="bGV3P5ebkbBgPavHsxluBUWLjT1SPxQXV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34226 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967197Ab3HIKxd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Aug 2013 06:53:33 -0400
In-Reply-To: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--bGV3P5ebkbBgPavHsxluBUWLjT1SPxQXV
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tony,

Ping. It'd be nice to get this in for 3.12, so I can remove all the old
drivers and the related legacy code.

Note that the first patch "ARM: OMAP: dss-common: fix Panda's DVI DDC
channel", is a fix for 3.11, and I've sent a fbdev pull request
containing that just now. Merging without that patch will cause a
trivial conflict. If you want, I can also create a branch that has these
on top of the fbdev-fixes branch.

 Tomi

On 26/07/13 10:08, Tomi Valkeinen wrote:
> Hi,
>=20
> The display drivers for new OMAP DSS driver model were merged in v3.11,=
 but the
> board files were not changed to use them. This series changes the board=
 files
> to take those new drivers into use.
>=20
> There's mostly nothing special in the patches. One complication is with=
 Overo
> board file, which adds two panel devices, located in add-on boards, tha=
t use
> the same GPIOs, meaning that the two panel devices cannot be probed at =
the same
> time. The solution used here is to parse the kernel command line, and d=
ecide
> the panel device to be added depending on the given default display.
>=20
> The omap2plus_defconfig is changed to include a few most commonly used =
display
> drivers as modules, and the old drivers are removed.
>=20
> Note: The first patch in this series has been sent separately
> (http://mid.gmane.org/1374570405-8301-2-git-send-email-tomi.valkeinen@t=
i.com),
> and is a fix for v3.11. It's included here as an another patch in the s=
eries
> depends on it.
>=20
> Tested on 4430SDP, Panda, Beagle, Beagle xM, Overo.
>=20
>  Tomi
>=20
> Tomi Valkeinen (21):
>   ARM: OMAP: dss-common: fix Panda's DVI DDC channel
>   ARM: OMAP2+: Remove legacy DSS initialization for omap4
>   ARM: OMAP2+: Add selected display drivers to omap2plus_defconfig
>   ARM: OMAP: dss-common: use new display drivers
>   ARM: OMAP: 4430SDP: remove picodlp device data
>   ARM: OMAP: overo: use new display drivers
>   ARM: OMAP: rx51: use new display drivers
>   ARM: OMAP: beagle: use new display drivers
>   ARM: OMAP: devkit8000: use new display drivers
>   ARM: OMAP: 2430SDP: use new display drivers
>   ARM: OMAP: LDP: use new display drivers
>   ARM: OMAP: omap3stalker: use new display drivers
>   ARM: OMAP: igep0020: use new display drivers
>   ARM: OMAP: cm-t35: use new display drivers
>   ARM: OMAP: H4: use new display drivers
>   ARM: OMAP: 3430SDP: use new display drivers
>   ARM: OMAP: OMAP3EVM: use new display drivers
>   ARM: OMAP: Pandora: use new display drivers
>   ARM: OMAP: Zoom: use new display drivers
>   ARM: OMAP: AM3517EVM: use new display drivers
>   ARM: OMAP2+: Remove old display drivers from omap2plus_defconfig
>=20
>  arch/arm/configs/omap2plus_defconfig         |  12 +-
>  arch/arm/mach-omap2/board-2430sdp.c          |  57 ++++---
>  arch/arm/mach-omap2/board-3430sdp.c          |  83 +++++----
>  arch/arm/mach-omap2/board-am3517evm.c        | 113 +++++++++----
>  arch/arm/mach-omap2/board-cm-t35.c           | 100 +++++++----
>  arch/arm/mach-omap2/board-devkit8000.c       |  96 +++++++----
>  arch/arm/mach-omap2/board-h4.c               |  48 ++++--
>  arch/arm/mach-omap2/board-igep0020.c         |  36 ++--
>  arch/arm/mach-omap2/board-ldp.c              |  68 +++++---
>  arch/arm/mach-omap2/board-omap3beagle.c      |  56 +++---
>  arch/arm/mach-omap2/board-omap3evm.c         |  87 ++++++----
>  arch/arm/mach-omap2/board-omap3pandora.c     |  48 +++---
>  arch/arm/mach-omap2/board-omap3stalker.c     |  61 ++++---
>  arch/arm/mach-omap2/board-overo.c            | 160 +++++++++++-------
>  arch/arm/mach-omap2/board-rx51-peripherals.c |  12 ++
>  arch/arm/mach-omap2/board-rx51-video.c       |  35 ++--
>  arch/arm/mach-omap2/board-zoom-display.c     |  30 ++--
>  arch/arm/mach-omap2/dss-common.c             | 244 ++++++++++++-------=
--------
>  arch/arm/mach-omap2/dss-common.h             |   2 -
>  19 files changed, 787 insertions(+), 561 deletions(-)
>=20



--bGV3P5ebkbBgPavHsxluBUWLjT1SPxQXV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSBMoSAAoJEPo9qoy8lh715iEP/RrVHKsxz02NmWPz01x7OacJ
3ZUFTITcqYIzX8cXcjN+vj2MgPtMFiyydM80+wAND7PYkKS1vuZW/8u3a0Lngxup
qvxVLeJ5s0l+uWAJiY6fF/FjTYOVF/IBHItndrIOppp7TIpfHn1bJbaFqXZoDbzb
LxJB0UDw2WzeRBm8zL2s2GIaRWxzZdcHLfrYQZdTto6jmcgBQCrIiYDFztaoXtv2
5ye/5TogusWK0QgPt49P3o5zp/69jpqA8mPhBWXyEJOQ0H/LIGaqlfMW3/qMeLeH
6LedPNBtL81KXnl6Gs5Z5x0x7hthOEmkeu3Ai9t3XlEviUMqp38+g8FoE47S8mIS
cjP1t201IGL0K5fLawfG7wZk3ADcxFfLlGFw6B+CgSmEeDK9W6obgOTKR9fL0ukx
e8rpVR6qWdugGyioxz7iVER1VQWE+ePXUbkYpNtVSzLo/rfLsvtMs1HzI3xDXkzd
mfxYa1/KYpqXcI6YylX+8Px8XqXwQK3z+AW1sHc0r0WnlGH+uBdFYqaILh4oRzXi
XH5SZ2sOqJk0NZkqCQYq8B3nWSjjfJFjZyuLqMRVo4F9tsCjJQVLrgM0ElezzdyK
7AyolMcnR6x1h27QjIOYCvKDUkEFLBvZIAaANPGJBg0Lb6QfimuBudImSV2fW1Va
53CwjvxFNskCNo4RfM+d
=taNv
-----END PGP SIGNATURE-----

--bGV3P5ebkbBgPavHsxluBUWLjT1SPxQXV--

From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/8] OMAP: OMAP3 DSS related clock patches
Date: Wed, 5 Mar 2014 10:35:02 +0200
Message-ID: <5316E1B6.4060007@ti.com>
References: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="V2N8PiaOdgtsV0WQi41rOfw03FMcSD4Ke"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36870 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975AbaCEIf2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Mar 2014 03:35:28 -0500
In-Reply-To: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--V2N8PiaOdgtsV0WQi41rOfw03FMcSD4Ke
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tero,

What about the dts fixes in this series? DSS DT depends on those fixes.
I'd like the dts fixes to be either merged for v3.14, or I can add them
to my DSS DT series (with acks).

 Tomi

On 13/02/14 12:03, Tomi Valkeinen wrote:
> Hi,
>=20
> I've been debugging OMAP3 related issues with DSS clocks, and I hopeful=
ly have
> them all fixed with this series. This fixes the problems for both non-D=
T boot,
> but also for DT boot with DSS DT support (which is not merged yet).
>=20
> The non-DT boot related fixes should be merged for 3.14, but I'd like t=
he DT
> boot related fixes to be merged for 3.14 also, as that'll make handling=
 the DSS
> DT support easier.
>=20
> This is based on v3.14-rc2.
>=20
>  Tomi
>=20
> Tomi Valkeinen (8):
>   clk: divider: fix rate calculation for fractional rates
>   clk: ti/divider: fix rate calculation for fractional rates
>   ARM: OMAP2+: clock: fix clkoutx2 with CLK_SET_RATE_PARENT
>   ARM: dts: fix omap3 dss clock handle names
>   ARM: dts: fix DPLL4 x2 clkouts on 3630
>   ARM: dts: use ti,fixed-factor-clock for dpll4_m4x2_mul_ck
>   ARM: dts: set 'ti,set-rate-parent' for dpll4_m4 path
>   OMAPDSS: fix rounding when calculating fclk rate
>=20
>  arch/arm/boot/dts/omap3430es1-clocks.dtsi          |  6 +--
>  .../omap36xx-am35xx-omap3430es2plus-clocks.dtsi    |  6 +--
>  arch/arm/boot/dts/omap36xx-clocks.dtsi             | 20 +++++++
>  arch/arm/boot/dts/omap36xx.dtsi                    |  2 +-
>  arch/arm/boot/dts/omap3xxx-clocks.dtsi             |  8 +--
>  arch/arm/mach-omap2/cclock3xxx_data.c              |  2 +
>  arch/arm/mach-omap2/dpll3xxx.c                     | 62 ++++++++++++++=
++++++++
>  drivers/clk/clk-divider.c                          | 10 ++--
>  drivers/clk/ti/divider.c                           |  8 +--
>  drivers/video/omap2/dss/dss.c                      |  4 +-
>  include/linux/clk/ti.h                             |  4 ++
>  11 files changed, 111 insertions(+), 21 deletions(-)
>=20



--V2N8PiaOdgtsV0WQi41rOfw03FMcSD4Ke
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTFuG2AAoJEPo9qoy8lh71N6cP/A01n3kW4LEZFxMBL02GHOxG
IPfKRLl1/ltUDxIoUhPv36eh3RDO5mLG8Pm8j87kpN7pdsL5Yq0yaxDHJVxK2Xnx
qtSD3ZC/leBjI1RqJ15p1vBMmFN/sk+60M4kVSbGnHqskiBeFZNMFO4eZueXUROQ
jLYojJA7CZk3NlfHTVTJy+tl+4Bo8ZlKJbbLZ8+2ST68ZOhXIyKJO98txt21eN0V
zXaVXxR48ydnIh/5ghO+jXtDXuJUVxErp/l5spYyjJ4YTukTWBiZX0eujA5NCrRT
oe5w1FcPVFSsQ35WoW7rTCciV2ImtW2g2SUiSxUQ0xqBHtx1GQb65ZSNuLlwXJ5y
gL4gbCwlpL6QOT8fJ3b9WjuD21cUmVO+k4wD2nTdxaVqHE7roVr/sae32gd+5gFH
yez64+MJp6l061y4tT7WXp7Bo6N5g0YAbxQJoC8jjaojPMF6SeKwBQ7OKywi5n7f
fNWvEqnBInTjp2M+vlX/y9YWmSEWDeBsPTIUvL2P6VwQAPHM1AfSE0YRtqrG85RM
YdBXWvqukqmj0Ecv+RBsCIhdMEJ+yJRze/32iZw04NVNB2QSNzy4DjBDq1PgcY92
FkmxtVwCWEO/r4owJZd5Qk8lH+AHLopRKxDH9YkQ1t2cyQPG70PxfPPorp5KwvyS
fKpypvpT8C0Mn08rWJ5v
=Xu1n
-----END PGP SIGNATURE-----

--V2N8PiaOdgtsV0WQi41rOfw03FMcSD4Ke--

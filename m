From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] ARM: OMAP1: usb: fix sparse warnings
Date: Mon, 29 Oct 2012 18:21:17 +0200
Message-ID: <20121029162117.GL27566@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1210262051290.11258@utopia.booyaka.com>
 <20121026212059.GV11908@atomide.com>
 <alpine.DEB.2.00.1210262128050.11258@utopia.booyaka.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kunpHVz1op/+13PW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46054 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932716Ab2J2Q1O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Oct 2012 12:27:14 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210262128050.11258@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com

--kunpHVz1op/+13PW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 26, 2012 at 09:28:58PM +0000, Paul Walmsley wrote:
>=20
> Resolve the following sparse warnings:
>=20
> arch/arm/mach-omap1/usb.c:304:12: warning: symbol 'omap1_usb0_init' was n=
ot declared. Should it be static?
> arch/arm/mach-omap1/usb.c:412:12: warning: symbol 'omap1_usb1_init' was n=
ot declared. Should it be static?
> arch/arm/mach-omap1/usb.c:478:12: warning: symbol 'omap1_usb2_init' was n=
ot declared. Should it be static?
>=20
> by declaring those functions as static.
>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Felipe Balbi <balbi@ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>=20
> Applies on linux-omap/omap-for-v3.8/cleanup-headers.
>=20
>  arch/arm/mach-omap1/usb.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
> index 84267ed..104fed3 100644
> --- a/arch/arm/mach-omap1/usb.c
> +++ b/arch/arm/mach-omap1/usb.c
> @@ -301,7 +301,7 @@ static inline void otg_device_init(struct omap_usb_co=
nfig *pdata)
> =20
>  #endif
> =20
> -u32 __init omap1_usb0_init(unsigned nwires, unsigned is_device)
> +static u32 __init omap1_usb0_init(unsigned nwires, unsigned is_device)
>  {
>  	u32	syscon1 =3D 0;
> =20
> @@ -409,7 +409,7 @@ u32 __init omap1_usb0_init(unsigned nwires, unsigned =
is_device)
>  	return syscon1 << 16;
>  }
> =20
> -u32 __init omap1_usb1_init(unsigned nwires)
> +static u32 __init omap1_usb1_init(unsigned nwires)
>  {
>  	u32	syscon1 =3D 0;
> =20
> @@ -475,7 +475,7 @@ bad:
>  	return syscon1 << 20;
>  }
> =20
> -u32 __init omap1_usb2_init(unsigned nwires, unsigned alt_pingroup)
> +static u32 __init omap1_usb2_init(unsigned nwires, unsigned alt_pingroup)
>  {
>  	u32	syscon1 =3D 0;
> =20
> --=20
> 1.7.10.4
>=20

--=20
balbi

--kunpHVz1op/+13PW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQjqz9AAoJEIaOsuA1yqREOxgQAJi+fgMvG9F5hpOdjBN+U/z3
7cAQTC+m+z2uX/NcgbD6jcMwev9lcigUdpz5fvsAiV4H7RpSrt9ZzzSdyTX+eZ99
uIP4gaFQR0HimVZO7zmDZnYK2LbIoQ4BE17R9KjOx8RC5Q07Wylyja5xqZ+uc4nz
R8F3tpX8uvG//Q97FGtrzxdkpmbBJsKl/zojKb2JktVxkPneQ7T8t15r9j2MvMMp
hHQTXfwM7QYrOeaisAPJemMfOBYEIvpawCbxkZ0N4jMZy3qRhtvnRpyxDeEXT1kd
Vs7kYlvhsVZpwuah4nRZpq7FZxQCqHA52kq2DOpZuFHJ9nJ+Od2I4+6Ipsb1snQz
hoFu4yw9jYgJl/UxBWnT+s5v1XErIbuPhaiN0aVFMbRs2eall0/RTbSsYPE+XdG4
EYnhPNSwSkFgXzjueTBn7S8LvNQEbH9o+Ft/IDT/hlhGTWxw4cj1NRDZ67Gqn4k1
NW2NcMUXTOMRGFuMK7QqsJW/ZmNgVtEqdbXXjPlH2rK7WaXvtPkemXXkXyj/HrY/
MA++EjikV0PmDu+LiNNB971KyuQ2pAo4BhEPiF15hqPeezCCxkTKmuk2S262M8jg
7x1iC7DnY9EFxF0g9rm23CDzHy4LBteGFnIR1YMUd4P1qD1pqJ9Joge5kx/NCRaW
v8CHUqUXoCtbtdsORjBX
=ms8U
-----END PGP SIGNATURE-----

--kunpHVz1op/+13PW--

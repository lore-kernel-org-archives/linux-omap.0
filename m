From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v8 9/9] net: can: c_can: Add support for TI am4372 DCAN
Date: Mon, 17 Nov 2014 13:12:13 +0100
Message-ID: <5469E61D.4050507@pengutronix.de>
References: <1415988591-6032-1-git-send-email-mkl@pengutronix.de> <5469E55F.1050502@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GhMwguK9iPsKhHvrEnuMJUSKGhAfnqEwO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54822 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbaKQMMW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Nov 2014 07:12:22 -0500
In-Reply-To: <5469E55F.1050502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, linux-can@vger.kernel.org
Cc: wsa@the-dreams.de, linux-omap@vger.kernel.org, kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GhMwguK9iPsKhHvrEnuMJUSKGhAfnqEwO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/17/2014 01:09 PM, Roger Quadros wrote:
> AM4372 SoC has 2 DCAN modules. Add compatible id and
> raminit driver data for it. The driver data is same as AM3352
> but this gives us flexibility to add AM4372 specific quirks
> if required later.

Strictly speaking we don't need the hunk in
"drivers/net/can/c_can/c_can_platform.c" yet, iff the AM4372 dts(i) has
this compatible:

"ti,am4372-d_can", "ti,am3352-d_can"

>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  Documentation/devicetree/bindings/net/can/c_can.txt | 3 ++-
>  drivers/net/can/c_can/c_can_platform.c              | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/c_can.txt b/Docu=
mentation/devicetree/bindings/net/can/c_can.txt
> index 6731730..5a1d8b0 100644
> --- a/Documentation/devicetree/bindings/net/can/c_can.txt
> +++ b/Documentation/devicetree/bindings/net/can/c_can.txt
> @@ -4,7 +4,8 @@ Bosch C_CAN/D_CAN controller Device Tree Bindings
>  Required properties:
>  - compatible		: Should be "bosch,c_can" for C_CAN controllers and
>  			  "bosch,d_can" for D_CAN controllers.
> -			  Can be "ti,dra7-d_can" or "ti,am3352-d_can".
> +			  Can be "ti,dra7-d_can", "ti,am3352-d_can" or
> +			  "ti,am4372-d_can".
>  - reg			: physical base address and size of the C_CAN/D_CAN
>  			  registers map
>  - interrupts		: property with a value describing the interrupt
> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c=
_can/c_can_platform.c
> index f4488e5..a4535d2 100644
> --- a/drivers/net/can/c_can/c_can_platform.c
> +++ b/drivers/net/can/c_can/c_can_platform.c
> @@ -235,6 +235,7 @@ static const struct of_device_id c_can_of_table[] =3D=
 {
>  	{ .compatible =3D "bosch,d_can", .data =3D &d_can_drvdata },
>  	{ .compatible =3D "ti,dra7-d_can", .data =3D &dra7_dcan_drvdata },
>  	{ .compatible =3D "ti,am3352-d_can", .data =3D &am3352_dcan_drvdata }=
,
> +	{ .compatible =3D "ti,am4372-d_can", .data =3D &am3352_dcan_drvdata }=
,
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, c_can_of_table);
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--GhMwguK9iPsKhHvrEnuMJUSKGhAfnqEwO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUaeYdAAoJECte4hHFiupUeB8P/38xMMCY19MewDAz9pcRBiyJ
GiCYNnIgvdNwzPOMcKpdZ+EIIG5X0qbUMLyKENSqceEaHKac+fysG6HJ8gHaKL7Q
tFOLYDHsJEAQMo0HrIxElnDvqnYQ3B8WAdrtox/Rkoem3NnAWvdYTkwZjHtaX1K1
fS+vZK/Vy3KpI22SnhP8CQmGfmtn48ct0E6gW0tJLMNNGzQaBjQWLX8TjJ8UQ8cy
PW+PZmoz5LtvrE9IJLrH2EwQhix2tPohMbE403eIVtSzkcMe++aqky2wKi2QJ9IL
Mzeo7wzmQ9gLZ3XcO1S/FG0lA2P54zVQXQVqFJ68iOWf6WB60X9QjrU2CPHzLe6Q
Lk2LFC5bj5OFeQEQ7g0yHL0dbUTHHiAK36QQSo1+yt+mfbcox/D6L5sjUv6scyqp
4JuuQPh07xcrp8Rx1haH5bmpWzINxjZoWWM3L0lP5gjzM5rpZBXFkJ0PUjsP5etD
O4YoVuFsTA2qQx99CtSqoNfCp/FHch2e+aHTeyd3o6bJvgo6phgUkA6G5bQDgECJ
uJsumW6MUT45HaObspA4nvYSGGvXVTpC5SK+1NANzbfjigFRLcmjGnvTzudotX3c
sdnSwlTB1zgXPxtNM18aIiL4nTkwSm6bUO3eP9PZgqtl1hxVhY/+mCEj15J1can7
zorXbXU9NtO9IsQOBKb/
=GUOm
-----END PGP SIGNATURE-----

--GhMwguK9iPsKhHvrEnuMJUSKGhAfnqEwO--

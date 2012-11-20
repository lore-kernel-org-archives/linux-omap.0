From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/3] ARM: dts: AM33XX: Add memory resource to d_can node
Date: Tue, 20 Nov 2012 11:13:04 +0100
Message-ID: <50AB57B0.7040502@pengutronix.de>
References: <1352916505-12343-1-git-send-email-anilkumar@ti.com> <1352916505-12343-4-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD07642B4D6E66FC7078DFB2B"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1352916505-12343-4-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, swarren@wwwdotorg.org, linux-can@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD07642B4D6E66FC7078DFB2B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/14/2012 07:08 PM, AnilKumar Ch wrote:
> Add a new address space/memory resource to d_can device tree node. D_CA=
N
> RAM initialization is achieved through RAMINIT register which is part o=
f
> AM33XX control module address space. D_CAN RAM init or de-init should b=
e
> done by writing instance corresponding value to control module register=
=2E
>=20
> Till we have a separate control module driver to write to control modul=
e,
> d_can driver will handle the register writes to control module by itsel=
f.
> So a new address space to represent this control module register is add=
ed
> to d_can driver.
>=20
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

This does not apply to net-next/master:

Applying: ARM: dts: AM33XX: Add memory resource to d_can node
error: patch failed: arch/arm/boot/dts/am33xx.dtsi:227
error: arch/arm/boot/dts/am33xx.dtsi: patch does not apply
Patch failed at 0003 ARM: dts: AM33XX: Add memory resource to d_can node

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigD07642B4D6E66FC7078DFB2B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlCrV7MACgkQjTAFq1RaXHOj4ACfWlm56jc7E1k49dK3WFCTIoCF
dNUAnjBrzUzmmlvDk/osFw93VZrWdmGh
=LhLo
-----END PGP SIGNATURE-----

--------------enigD07642B4D6E66FC7078DFB2B--

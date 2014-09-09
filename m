From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 05/12] arm: dts: am4372: Add dcan nodes
Date: Tue, 09 Sep 2014 17:09:30 +0200
Message-ID: <540F182A.9010702@pengutronix.de>
References: <1410274534-22826-1-git-send-email-rogerq@ti.com> <1410274534-22826-6-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XQpdEdXJUb9DE7dI3rjtr5si9nkQvOGk6"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1410274534-22826-6-git-send-email-rogerq@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: wg@grandegger.com, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, Afzal Mohammed <afzal@ti.com>
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XQpdEdXJUb9DE7dI3rjtr5si9nkQvOGk6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/09/2014 04:55 PM, Roger Quadros wrote:
> From: Afzal Mohammed <afzal@ti.com>
>=20
> Add dcan nodes.
>=20
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
> Signed-off-by: George Cherian <george.cherian@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/boot/dts/am4372.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.d=
tsi
> index 8689949..3514d0a 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -885,6 +885,28 @@
>  				clock-names =3D "fck";
>  			};
>  		};
> +
> +		dcan0: can@481cc000 {
> +			compatible =3D "bosch,d_can";
> +			ti,hwmods =3D "d_can0";
> +			clocks =3D <&dcan0_fck>;
> +			clock-names =3D "fck";
> +			reg =3D <0x481cc000 0x2000
> +				0x44e10644 0x4>;
> +			interrupts =3D <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;

Where are the syscon phandles?

> +			status =3D "disabled";
> +		};
> +
> +		dcan1: can@481d0000 {
> +			compatible =3D "bosch,d_can";
> +			ti,hwmods =3D "d_can1";
> +			clocks =3D <&dcan1_fck>;
> +			clock-names =3D "fck";
> +			reg =3D <0x481d0000 0x2000
> +				0x44e10644 0x4>;
> +			interrupts =3D <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +			status =3D "disabled";
> +		};
>  	};
>  };
> =20
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--XQpdEdXJUb9DE7dI3rjtr5si9nkQvOGk6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQPGCoACgkQjTAFq1RaXHO/FwCfRhzGv6myCBlZaHYV+tZSRI7/
SNwAn2CaEbqCTl7lfgc36MkufINq3AGs
=refp
-----END PGP SIGNATURE-----

--XQpdEdXJUb9DE7dI3rjtr5si9nkQvOGk6--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 02/12] ARM: dts: DRA7: Add DCAN nodes
Date: Tue, 09 Sep 2014 17:04:34 +0200
Message-ID: <540F1702.2000007@pengutronix.de>
References: <1410274534-22826-1-git-send-email-rogerq@ti.com> <1410274534-22826-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="vcpaMmdUwpu4D2envjBaXR3P2nh5UPVit"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1410274534-22826-3-git-send-email-rogerq@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: wg@grandegger.com, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vcpaMmdUwpu4D2envjBaXR3P2nh5UPVit
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/09/2014 04:55 PM, Roger Quadros wrote:
> The SoC supports 2 DCAN nodes. Add them.

I think you should put the device-tree ml for DT related patches on Cc.

>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/boot/dts/dra7.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 370009e..09d5739 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -34,6 +34,8 @@
>  		serial3 =3D &uart4;
>  		serial4 =3D &uart5;
>  		serial5 =3D &uart6;
> +		d_can0 =3D &dcan1;
> +		d_can1 =3D &dcan2;
>  	};
> =20
>  	timer {
> @@ -1267,6 +1269,34 @@
>  			ti,irqs-skip =3D <10 133 139 140>;
>  			ti,irqs-safe-map =3D <0>;
>  		};
> +
> +		dcan1: can@481cc000 {
> +			compatible =3D "bosch,d_can";
> +			ti,hwmods =3D "dcan1";
> +			reg =3D <0x4ae3c000 0x2000>,
> +			      <0x558 0x4>; /* index to RAMINIT reg within syscon */

Putting the offset within the syscon here doesn't look good.

> +			ti,raminit-syscon =3D <&dra7_ctrl_core>;

Why not add it as a second parameter to the ti,raminit-syscon instead?

> +			ti,raminit-start-bit =3D <3>;
> +			ti,raminit-done-bit =3D <1>;
> +			ti,raminit-pulse;
> +			interrupts =3D <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&dcan1_sys_clk_mux>;
> +			status =3D "disabled";
> +		};
> +
> +		dcan2: can@481d0000 {
> +			compatible =3D "bosch,d_can";
> +			ti,hwmods =3D "dcan2";
> +			reg =3D <0x48480000 0x2000>,
> +			      <0x558 0x4>; /* index to RAMINIT reg within syscon */
> +			ti,raminit-syscon =3D <&dra7_ctrl_core>;
> +			ti,raminit-start-bit =3D <5>;
> +			ti,raminit-done-bit =3D <2>;
> +			ti,raminit-pulse;
> +			interrupts =3D <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&sys_clkin1>;
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


--vcpaMmdUwpu4D2envjBaXR3P2nh5UPVit
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQPFwIACgkQjTAFq1RaXHPtAACeIhkp+s3gaaBmdbfva+Vu5bws
ftMAn1Pb+zYDjpsutYZXUgrYXkFeC+aQ
=Tk6Y
-----END PGP SIGNATURE-----

--vcpaMmdUwpu4D2envjBaXR3P2nh5UPVit--

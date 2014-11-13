From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4 06/10] ARM: dts: am4372: Add DCAN nodes
Date: Thu, 13 Nov 2014 15:07:52 +0100
Message-ID: <5464BB38.7020402@pengutronix.de>
References: <1415881371-4982-1-git-send-email-rogerq@ti.com> <1415881371-4982-7-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="BHJVNKOeO1HLWmKphmWEEG4pXlOBLssxE"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1415881371-4982-7-git-send-email-rogerq@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: wg@grandegger.com, wsa@the-dreams.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BHJVNKOeO1HLWmKphmWEEG4pXlOBLssxE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/13/2014 01:22 PM, Roger Quadros wrote:
> The SoC contains 2 DCAN modules. Add them.
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/boot/dts/am4372.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.d=
tsi
> index 899c57c..12fb1db 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -901,6 +901,28 @@
>  			compatible =3D "mmio-sram";
>  			reg =3D <0x40300000 0x40000>; /* 256k */
>  		};
> +
> +		dcan0: can@481cc000 {
> +			compatible =3D "ti,am3352-d_can";

You should add "ti,am4372-d_can" as first compatible here.

> +			ti,hwmods =3D "d_can0";
> +			clocks =3D <&dcan0_fck>;
> +			clock-names =3D "fck";
> +			reg =3D <0x481cc000 0x2000>;
> +			syscon-raminit =3D <&am43xx_control_module 0x644 0>;
> +			interrupts =3D <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> +			status =3D "disabled";
> +		};
> +
> +		dcan1: can@481d0000 {
> +			compatible =3D "ti,am3352-d_can";

Same here.

> +			ti,hwmods =3D "d_can1";
> +			clocks =3D <&dcan1_fck>;
> +			clock-names =3D "fck";
> +			reg =3D <0x481d0000 0x2000>;
> +			syscon-raminit =3D <&am43xx_control_module 0x644 1>;
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


--BHJVNKOeO1HLWmKphmWEEG4pXlOBLssxE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZLs4AAoJECte4hHFiupUla4QAIFE9OwX7qdb/K4WP788hh2V
ZlDIrzwhaGHqkFxmfaqbzyZBm7pWNjnev3UfNPUotnJ8nOL3qWL6U76+5QWvX8TK
koXa/RVhi+XbcDJ3WcsLLfMMu3VklxaOhCkvt+f0DzHkKqDYv13pfvGJsK9eJZpt
GUzMzAFjFSFItT2yipfQZfyYjheT8MXxVMXob1585Toc1N3QX1vYzcwn/msqbVYH
SO17Cng2W77W4LyYgk3bXE/gz9oWAqaC/nU3TCw4I/bigT47fzCvICyQvd8+MJcM
E0SmHUa0K4Bgc7PsLuq48HshpFbqSK58lo7xgYTCFGnPNEt+gUyjh35CBI8a+WzS
p+Ho6oy8Ryr0m6GdGIz3WHppxi20Qy7XPfWaPA1/9rBjnIGYVcdk7yN70wMXr58o
V0u1u6yOq/l/EpjD0IZAcLI8D1ro1JNm33JSb1DHv19lfpFy4hTFB6mJfAO9990x
yvCoOioEvjf51GxQfRCOf31ZC72nDe66NUp2hYrq1typyVwUCebxKY2eB3abXbJs
Mmi8YNMdHJWnnG8qitwxQZlraA6ECh2CmwhLP+ku+9AlloP8G6bdgmNfa/+/8tlj
UaTjTMm3FKUHzKugG7X5ZZw6m1VyfNbEgkr3DCLrc/W+BT/4CZxGt8GB/6hfpZ89
519zcIhmdVHdpdtbyutw
=gXIH
-----END PGP SIGNATURE-----

--BHJVNKOeO1HLWmKphmWEEG4pXlOBLssxE--

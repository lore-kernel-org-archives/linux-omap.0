From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 1/2] arm: dts: omap4+: Add DMM bindings
Date: Mon, 16 Sep 2013 14:19:28 +0300
Message-ID: <5236E940.9070503@ti.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com> <1379323815-14130-1-git-send-email-archit@ti.com> <1379323815-14130-2-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="AbmgsPsvPNUTrwiKEqnaiDIT2coc6u34G"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1379323815-14130-2-git-send-email-archit@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, robdclark@gmail.com, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Andy Gross <andygro@gmail.com>
List-Id: linux-omap@vger.kernel.org

--AbmgsPsvPNUTrwiKEqnaiDIT2coc6u34G
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 16/09/13 12:30, Archit Taneja wrote:
> Add Dynamic Memory Manager (DMM) bindings for OMAP4 and OMAP5 devices. =
DMM
> only requires address and irq information.
>=20
> Add documentation for the DMM bindings.
>=20
> Originally worked on by Andy Gross.
>=20
> Cc: Andy Gross <andygro@gmail.com>
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/omap/dmm.txt | 17 ++++++++++++++=
+++
>  arch/arm/boot/dts/omap4.dtsi                       |  7 +++++++
>  arch/arm/boot/dts/omap5.dtsi                       |  7 +++++++
>  3 files changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/dmm.txt
>=20
> diff --git a/Documentation/devicetree/bindings/arm/omap/dmm.txt b/Docum=
entation/devicetree/bindings/arm/omap/dmm.txt
> new file mode 100644
> index 0000000..237cd83
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/omap/dmm.txt
> @@ -0,0 +1,17 @@
> +OMAP Dynamic Memory Manager (DMM) bindings
> +
> +Required properties:
> +- compatible:	Must be "ti,omap4-dmm" for OMAP4 family
> +		Must be "ti,omap5-dmm" for OMAP5 family
> +- reg:		Contains timer register address range (base address and length=
)

"timer"?

> +- interrupts:	Contains interrupt information (source, etc) for the DMM=
 IRQ
> +- ti,hwmods:	Name of the hwmod associated to the counter, which is typ=
ically
> +		"dmm"

"associated to the counter"?

> +
> +Example:
> +
> +dmm: dmm@4e000000 {
> +	compatible =3D "ti,omap4-dmm";
> +	reg =3D <0x4e000000 0x800>;
> +	ti,hwmods =3D "dmm";
> +};
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dts=
i
> index 22d9f2b..24f388e 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -487,6 +487,13 @@
>  			ti,hwmods =3D "kbd";
>  		};
> =20
> +		dmm: dmm@4e000000 {

I don't think anyone refers to this node, so there shouldn't be any need
for the "dmm: " alias.

> +			compatible =3D "ti,omap4-dmm";
> +			reg =3D <0x4e000000 0x800>;
> +			interrupts =3D <0 113 0x4>;
> +			ti,hwmods =3D "dmm";
> +		};
> +
>  		emif1: emif@4c000000 {
>  			compatible =3D "ti,emif-4d";
>  			reg =3D <0x4c000000 0x100>;
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dts=
i
> index ac1f1e0..33b4fea 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -604,6 +604,13 @@
>  			ti,hwmods =3D "wd_timer2";
>  		};
> =20
> +		dmm: dmm@4e000000 {

Same here.

> +			compatible =3D "ti,omap5-dmm";
> +			reg =3D <0x4e000000 0x800>;
> +			interrupts =3D <0 113 0x4>;
> +			ti,hwmods =3D "dmm";
> +		};
> +
>  		emif1: emif@0x4c000000 {
>  			compatible	=3D "ti,emif-4d5";
>  			ti,hwmods	=3D "emif1";
>=20



--AbmgsPsvPNUTrwiKEqnaiDIT2coc6u34G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSNulAAAoJEPo9qoy8lh71XjUP/A7juBf1ow7T03k/m7NNBAcU
HtjnDkqtY8SI84p2/k4E2/u3UnbNYdKlMPDi2WQTliZHFebEqsD3ak28rK9EOfVf
/KIhg9o7l/6bG/IyOWZQcbR0EtGtQ+JwFYIwsMjrCoRE1tZurtCYfjl6e300CaeH
W0lwXBD3/vb/f6sV/Ai3YNH5Gz6jY+C+jdC/vJ1O3SBnlYO8GDYZAaGEdk5PkRlc
XDwKtbYBqKgXE69lLOhgolk8oT3gnPSsOccQflL2GgD//IIglBmSgiXijtNnsdz9
2XQ4kkL29zcQnlT3n3tyv4A39uSrAnPcFtZocwozeBSiwuVjz3K6qvzPKT9c9bs4
kSRMKCv5aQLCk+c/kC3ZZd4kTUPpEGOad6iSk31i8kgfTvDcP4guGYFJMyf3Gm7x
q4p4r1f/56yvIifclVF0qS6dSAbXE5vYufpblWuYn8KeP/7nDhTPX8unVbdgkWrv
CDMstgQYkY3UeOEQ+Rkuv7SF2iamtssW1/cMopO9/xPLjsJ5zxT6ywuLujb1U0DI
Ui8KS6PwQFWH+XgY5EYWW5E6fCQ/KKc03OTf0LV2SMcrmuhT5d0floIwq4r77/B9
JB6x3HHDbSv2O8vwfixHaLqU5vmrFzJPDK9wxGpnYo5Rtq8UikfN3+jXwr/Ua04A
4niP2P4Eka17Z36dOSOY
=z7Xx
-----END PGP SIGNATURE-----

--AbmgsPsvPNUTrwiKEqnaiDIT2coc6u34G--

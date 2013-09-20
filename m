From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/4] usb: usb: dsps: update code according to the binding
 document
Date: Fri, 20 Sep 2013 10:44:39 -0500
Message-ID: <20130920154439.GW26101@radagast>
References: <1376580112-17677-1-git-send-email-bigeasy@linutronix.de>
 <1376580112-17677-2-git-send-email-bigeasy@linutronix.de>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R0SsnouPYaG+7rP6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49475 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752327Ab3ITPpu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Sep 2013 11:45:50 -0400
Content-Disposition: inline
In-Reply-To: <1376580112-17677-2-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Benoit Cousson <benoit.cousson@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--R0SsnouPYaG+7rP6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

+ linux-omap, Benoit

On Thu, Aug 15, 2013 at 05:21:49PM +0200, Sebastian Andrzej Siewior wrote:
> This relfects the code and dts requires changes due to recent .dts
> binding updates:
> - use mg prefix for the Metor Graphics specific attributes
> - use power in mA not in mA/2 as specifed in the USB2.0 specification
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

hope this can go in during the -rc cycle

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/boot/dts/am335x-bone.dts  |  2 +-
>  arch/arm/boot/dts/am335x-evm.dts   |  6 +++---
>  arch/arm/boot/dts/am335x-evmsk.dts |  2 +-
>  arch/arm/boot/dts/am33xx.dtsi      | 26 +++++++++++++-------------
>  drivers/usb/musb/musb_dsps.c       | 11 ++++++-----
>  5 files changed, 24 insertions(+), 23 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x=
-bone.dts
> index a8907b5..e8447a7 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -127,7 +127,7 @@
>  				status =3D "okay";
>  			};
> =20
> -			phy@47401300 {
> +			usb-phy@47401300 {
>  				status =3D "okay";
>  			};
> =20
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-=
evm.dts
> index c26c16c..648a67e 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -178,11 +178,11 @@
>  				status =3D "okay";
>  			};
> =20
> -			phy@47401300 {
> +			usb-phy@47401300 {
>  				status =3D "okay";
>  			};
> =20
> -			phy@47401b00 {
> +			usb-phy@47401b00 {
>  				status =3D "okay";
>  			};
> =20
> @@ -194,7 +194,7 @@
>  				status =3D "okay";
>  			};
> =20
> -			dma@07402000  {
> +			dma-controller@07402000  {
>  				status =3D "okay";
>  			};
>  		};
> diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335=
x-evmsk.dts
> index e92446c..a6c5033 100644
> --- a/arch/arm/boot/dts/am335x-evmsk.dts
> +++ b/arch/arm/boot/dts/am335x-evmsk.dts
> @@ -214,7 +214,7 @@
>  				status =3D "okay";
>  			};
> =20
> -			phy@47401300 {
> +			usb-phy@47401300 {
>  				status =3D "okay";
>  			};
> =20
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index a38f8d3..c57c6b8 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -354,7 +354,7 @@
>  				status =3D "disabled";
>  			};
> =20
> -			usb0_phy: phy@47401300 {
> +			usb0_phy: usb-phy@47401300 {
>  				compatible =3D "ti,am335x-usb-phy";
>  				reg =3D <0x47401300 0x100>;
>  				reg-names =3D "phy";
> @@ -377,11 +377,11 @@
>  					reg-names =3D "mc";
>  					interrupts =3D <18>;
>  					interrupt-names =3D "mc";
> -					multipoint =3D <1>;
> -					num-eps =3D <16>;
> -					ram-bits =3D <12>;
> -					port-mode =3D <3>;
> -					power =3D <250>;
> +					mg,multipoint =3D <1>;
> +					mg,num-eps =3D <16>;
> +					mg,ram-bits =3D <12>;
> +					mg,port-mode =3D <3>;
> +					mg,power =3D <500>;
>  					phys =3D <&usb0_phy>;
> =20
>  				dmas =3D <&cppi41dma  0 0 &cppi41dma  1 0
> @@ -409,7 +409,7 @@
>  				};
>  			};
> =20
> -			usb1_phy: phy@47401b00 {
> +			usb1_phy: usb-phy@47401b00 {
>  				compatible =3D "ti,am335x-usb-phy";
>  				reg =3D <0x47401b00 0x100>;
>  				reg-names =3D "phy";
> @@ -432,11 +432,11 @@
>  					reg-names =3D "mc";
>  					interrupts =3D <19>;
>  					interrupt-names =3D "mc";
> -					multipoint =3D <1>;
> -					num-eps =3D <16>;
> -					ram-bits =3D <12>;
> -					port-mode =3D <3>;
> -					power =3D <250>;
> +					mg,multipoint =3D <1>;
> +					mg,num-eps =3D <16>;
> +					mg,ram-bits =3D <12>;
> +					mg,port-mode =3D <3>;
> +					mg,power =3D <500>;
>  					phys =3D <&usb1_phy>;
> =20
>  				dmas =3D <&cppi41dma 15 0 &cppi41dma 16 0
> @@ -464,7 +464,7 @@
>  				};
>  			};
> =20
> -			cppi41dma: dma@07402000 {
> +			cppi41dma: dma-controller@07402000 {
>  				compatible =3D "ti,am3359-cppi41";
>  				reg =3D  <0x47400000 0x1000
>  					0x47402000 0x1000
> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> index 4ffbaac..7368577 100644
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -485,11 +485,12 @@ static int dsps_create_musb_pdev(struct dsps_glue *=
glue,
>  	pdata.config =3D config;
>  	pdata.platform_ops =3D &dsps_ops;
> =20
> -	config->num_eps =3D get_int_prop(child_node, "num-eps");
> -	config->ram_bits =3D get_int_prop(child_node, "ram-bits");
> -	pdata.mode =3D get_int_prop(child_node, "port-mode");
> -	pdata.power =3D get_int_prop(child_node, "power");
> -	config->multipoint =3D of_property_read_bool(child_node, "multipoint");
> +	config->num_eps =3D get_int_prop(child_node, "mg,num-eps");
> +	config->ram_bits =3D get_int_prop(child_node, "mg,ram-bits");
> +	pdata.mode =3D get_int_prop(child_node, "mg,port-mode");
> +	/* DT keeps this entry in mA, musb expects it as per USB spec */
> +	pdata.power =3D get_int_prop(child_node, "mg,power") / 2;
> +	config->multipoint =3D of_property_read_bool(child_node, "mg,multipoint=
");
> =20
>  	ret =3D platform_device_add_data(musb, &pdata, sizeof(pdata));
>  	if (ret) {
> --=20
> 1.8.4.rc2
>=20

--=20
balbi

--R0SsnouPYaG+7rP6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSPG1nAAoJEIaOsuA1yqREtNIQAKr/JEHWwZO7rVmv5Nz/61Nr
t1nr+VVSZynXJsf7yW2j909vQi5rLJft9kQYCwQWOhSUomQo1p2iygBU7+oNyoT4
Vem7GvleUmiDH7ctwQ+6VUlw7/jGCVAh57CzFyxUgXnQ2wXzBFBl3Tb5rYOGxsnR
JAFgIoscMO1/HcPLgLa3tEYIPefC2A0EhRWH8mywhuBIRljZMEm9RsEPlST+i4kH
oZ48UiSbYlRK+nyNVBLRCZ+WlPxZqVhHpSgauFtu6oWDKK6k0j49MAet6bzfNO8y
nkq6yNhEZXVk2L0GuHZeQnYEk32tlGcerW32BWVj4XawwJISnFzs8AlSceNxAdJ5
973YUu6Un1fBp+TRru3UNFzm+AJKKjRPxSP5J/Z4cryVloB5bbAXCrTMcVn+QTn6
Hi/I11RGcX92++nA8mFUgyotatS+0kXWfYrXEZuOzPmnGl1RQ+n4/dAsRbzpfZ3a
ZJTfLDEmdG5tqU1Ft6jIY8VPRAST74yicQG3ctpid5ZfsEMhNXlc6qRYgaSSYwNJ
l9nE31SKcNNEgX6fzO4rLVpsL1hCtsnFzn9zFpvKNZX0Lcy2cCi0Jvipjydsqz29
PfC9dRNaOb2TDYYKzgpgxUPjGM66QMXQwtFGqJnQqTYzI6MoaaqcSMVa+dxuyXVN
W/6t3oavUUKUiqdtjEIl
=wZky
-----END PGP SIGNATURE-----

--R0SsnouPYaG+7rP6--

From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 4/4] ARM: dts: am335x-igep0033: use phandles for USB
 and DMA refs
Date: Tue, 6 May 2014 11:18:15 -0500
Message-ID: <20140506161815.GQ25849@saruman.home>
References: <1398693512-5355-1-git-send-email-guido@vanguardiasur.com.ar>
 <1398718475-1883-1-git-send-email-guido@vanguardiasur.com.ar>
 <1398718475-1883-4-git-send-email-guido@vanguardiasur.com.ar>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sxhug0Teuf3tiWmo"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53946 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753016AbaEFQS0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 May 2014 12:18:26 -0400
Content-Disposition: inline
In-Reply-To: <1398718475-1883-4-git-send-email-guido@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>
Cc: bcousson@baylibre.com, tony@atomide.com, linux-omap@vger.kernel.org, george.cherian@ti.com, Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>, Enric Balletbo i Serra <eballetbo@iseebcn.com>

--sxhug0Teuf3tiWmo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2014 at 05:54:35PM -0300, Guido Mart=EDnez wrote:
> Use phandles instead of unit adresses to reference usb and dma nodes.
> This makes the DT more robust and readable.
>=20
> Signed-off-by: Guido Mart=EDnez <guido@vanguardiasur.com.ar>
> Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/boot/dts/am335x-igep0033.dtsi | 38 +++++++++++++++++-----------=
------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/a=
m335x-igep0033.dtsi
> index 9f22c18..9c53b50 100644
> --- a/arch/arm/boot/dts/am335x-igep0033.dtsi
> +++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
> @@ -200,31 +200,31 @@
> =20
>  &usb {
>  	status =3D "okay";
> +};
> =20
> -	control@44e10620 {
> -		status =3D "okay";
> -	};
> +&usb_ctrl_mod {
> +	status =3D "okay";
> +};
> =20
> -	usb-phy@47401300 {
> -		status =3D "okay";
> -	};
> +&usb0_phy {
> +	status =3D "okay";
> +};
> =20
> -	usb-phy@47401b00 {
> -		status =3D "okay";
> -	};
> +&usb1_phy {
> +	status =3D "okay";
> +};
> =20
> -	usb@47401000 {
> -		status =3D "okay";
> -	};
> +&usb0 {
> +	status =3D "okay";
> +};
> =20
> -	usb@47401800 {
> -		status =3D "okay";
> -		dr_mode =3D "host";
> -	};
> +&usb1 {
> +	status =3D "okay";
> +	dr_mode =3D "host";
> +};
> =20
> -	dma-controller@47402000  {
> -		status =3D "okay";
> -	};
> +&cppi41dma  {
> +	status =3D "okay";
>  };
> =20
>  #include "tps65910.dtsi"
> --=20
> 1.9.2
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--sxhug0Teuf3tiWmo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTaQtHAAoJEIaOsuA1yqREe04QAIDDIY/9GY0EYGC9YkS7VLG1
1r5gp28uuT60CCoS4CQjo9qNGej9NBlsL9jNTXkHp3jy157Ougi/84GBZG5UeaR3
yPSIsKY4U48VC21PdEJu6RFwqFkvPs7dsGTXRIwiLv85yfXqWt0YbhzMiNsyyDph
9L+CRHGbRr2nojJE5GfnYsFViJy/6j4N9NWCaf2qLNWJxcHMGpE8175JEThE+WtL
6ZpUL/PqemwNy3ws5Z7vTxnrAvSr+PaTfWg4OnJCUWeMlFn1pDmUrMl7F0S1FYZy
eQ8206dASMQrIZ2X+KiwZdeW21o4fFbt0ZwLvdCSZOm42NTi2Xifwvp+kmzsbV/T
lw58ha80bkUK77N9Q5x2YLfUUkIA7c6T6hJHUa6+GRSJo+g3kVqerHvlMhw6fyOx
y5o2csqeTjte3Ncnr0O/wH5iSK5h0uOfIuunDzo9WUYDq2zf1XzwnyoVfTt0kmM2
OXVaHERspjfeUMkUCQw+ux9GUaB5MHLORz4kgTXJqDuX+60sYAjq6Zy3fwRX1CUJ
3dFb8b6vKtj7+a7Rm2yqNNZnI0CY6z4v5sV+pgflWgzkvxCfP8xQOxTV+YIA7FIr
fVSS2rlua3KuokSjbUcuFqC6dUzqHDi94Q/cMrIOZkuUFapCVEEC7VsrPPLAyqjD
po+WUywYDBSYXW5NIu4S
=8zHd
-----END PGP SIGNATURE-----

--sxhug0Teuf3tiWmo--

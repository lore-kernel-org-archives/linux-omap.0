From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 2/4] ARM: dts: am335x-evm: use phandles for USB and
 DMA refs
Date: Tue, 6 May 2014 11:18:00 -0500
Message-ID: <20140506161800.GO25849@saruman.home>
References: <1398693512-5355-1-git-send-email-guido@vanguardiasur.com.ar>
 <1398718475-1883-1-git-send-email-guido@vanguardiasur.com.ar>
 <1398718475-1883-2-git-send-email-guido@vanguardiasur.com.ar>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SavPGzlo48F1Gxyz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36838 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070AbaEFQSJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 May 2014 12:18:09 -0400
Content-Disposition: inline
In-Reply-To: <1398718475-1883-2-git-send-email-guido@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>
Cc: bcousson@baylibre.com, tony@atomide.com, linux-omap@vger.kernel.org, george.cherian@ti.com, Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>

--SavPGzlo48F1Gxyz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2014 at 05:54:33PM -0300, Guido Mart=EDnez wrote:
> Use phandles instead of unit adresses to reference usb and dma nodes.
> This makes the DT more robust and readable.
>=20
> Signed-off-by: Guido Mart=EDnez <guido@vanguardiasur.com.ar>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/boot/dts/am335x-evm.dts | 38 +++++++++++++++++++---------------=
----
>  1 file changed, 19 insertions(+), 19 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-=
evm.dts
> index 6028217..33f7c57 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -330,31 +330,31 @@
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
>  &i2c1 {
> --=20
> 1.9.2
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--SavPGzlo48F1Gxyz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTaQs4AAoJEIaOsuA1yqREV8EP/RG3I4j4d1xuG0El6jsxsHRO
e5y2eQ9wxHRt7G/rA12BfucbxZP3Wv1d7+EaPya6Q0cXX/WvBlYic8sQYjJDnv6K
xxn0oCHs16gQPlqKQMTKT3WdR62DEreWF1ZIxTzyWWNUsyNMmfZ13lBKGAG8tyaj
QjetRswl0eaHpbM0YufSCgoLthHK8J5a2y7RBxgaypO25oDtZTRlCip0hNqqtV98
YDLgawtZmOQ4kFNKhOwHF+6UKpP+a4Fz7aZ7A9gr/gtT6ekyQtYuchOih1+EKdWw
6AePrKbDz4qiWe628l3tPhp9VjpTkHFFubwSvqtE+NeYpBomd9IxwcLu9TUnKYQG
qsarGMa+7ZUjqrQPqvRZYvCP1JeI5OjtepQNPhW423MlPnVN0m5pFA32mr9AW1sB
Ghe48eTSukzR8fU2etvCS/ETpO8cWPLxWaOvyvqu5jAbiLc7V34R9BK4e3zldIHx
DiMEUmolF8ULzAamHW58inK7F4hMBGkY6g6YXOCSTKfDHzNM6h8BgzuvEEeGf4aX
OIYSQu0e+YLiIexCg5Qu5avu5vkyLTw4JyBPemBC0ge23jxbpu3Kq6loWxruDdwm
CVt3v/DRIoAhy6gLW1BXmGA+ZjPnat2Wsw/7A213eLkviPaZ51ziwUVGkVREFmJV
6l7o89LQg0SlsvL1ptm4
=oZPc
-----END PGP SIGNATURE-----

--SavPGzlo48F1Gxyz--

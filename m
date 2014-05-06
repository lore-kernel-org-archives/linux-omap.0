From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: am335x-bone-common: use phandles for
 USB and DMA refs
Date: Tue, 6 May 2014 11:17:49 -0500
Message-ID: <20140506161749.GN25849@saruman.home>
References: <1398693512-5355-1-git-send-email-guido@vanguardiasur.com.ar>
 <1398718475-1883-1-git-send-email-guido@vanguardiasur.com.ar>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0u4QAjBqqw4+MLTw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39651 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638AbaEFQSg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 May 2014 12:18:36 -0400
Content-Disposition: inline
In-Reply-To: <1398718475-1883-1-git-send-email-guido@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>
Cc: bcousson@baylibre.com, tony@atomide.com, linux-omap@vger.kernel.org, george.cherian@ti.com, Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>

--0u4QAjBqqw4+MLTw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2014 at 05:54:32PM -0300, Guido Mart=EDnez wrote:
> Use phandles instead of unit adresses to reference usb and dma nodes.
> This makes the DT more robust and readable.
>=20
> Signed-off-by: Guido Mart=EDnez <guido@vanguardiasur.com.ar>

(acked wrong version previously, sorry)

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/boot/dts/am335x-bone-common.dtsi | 38 +++++++++++++++----------=
------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dt=
s/am335x-bone-common.dtsi
> index 2e7d932..ded1283 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -182,31 +182,31 @@
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
>  &i2c0 {
> --=20
> 1.9.2
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--0u4QAjBqqw4+MLTw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTaQssAAoJEIaOsuA1yqRENk8P/0d0xwdoLCi5oIObAj9JpiZH
G9TP7RywO5DaaTHfdPmIM3oIKBxK3vJbKFxDcynKaDEtmPB2o1zkifxDU2ZemZRB
2ezgktDqyrl+Tzrkez3RK6tuMXNw9f2YsgwXDAe3TdGbzyeuvv/2PEm1J7iald0m
d5PQamJ9IqEOzuipyi3WWk8JAc805PuqmieQpYJ8MxNvuynKUCObtTqN+FjF+oo1
5OQS8y6tv7AbpsR7Kq3q1gtxkvYxqBiyyhgwJyTaKLsrBoSo1trGdHsFjO223CVH
sjJ3leb5c1ko7sUyjOGpEZFrU5MLzO7yG436dTcp1Ss9OmA40JkPMy6wWnxuue+B
rR0DOT4mCQffKsx5d8APeJmwwxdznCIUbMcUKC0Z1Bthd+qQyFc8EFSkcEr6WCYG
7ZOd5DM5nhfvK377tvcZih2CZgKQfhcVNGWi+mws2x0ricuFXBo36aW9bB2eke1c
CT/61P5yt7wLRUaODYsG/078S8Swm74qjz/ijpSpj9qzKg90Ty/DBlZN2HjmeA8s
Lol2OCvhe6mDlAodMyZNg0G1So7kxh+OIEaK4lXzH2VWokCZDDmllIqG96f0WPAb
OSiHv1M66n9i9B6UvxR0sVONCyVqheJHtjaOmF4/JJeVFqEJnssQk2rBIxjy2nhT
/kZZ1YMNaM82LvYvinVj
=MrnY
-----END PGP SIGNATURE-----

--0u4QAjBqqw4+MLTw--

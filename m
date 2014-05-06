From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 4/4] ARM: dts: am335x-igep0033: use phandles for USB and
 DMA refs
Date: Tue, 6 May 2014 11:17:03 -0500
Message-ID: <20140506161703.GM25849@saruman.home>
References: <1398693512-5355-1-git-send-email-guido@vanguardiasur.com.ar>
 <1398693512-5355-4-git-send-email-guido@vanguardiasur.com.ar>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="McpcKDxJRrEJVmOH"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53899 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753300AbaEFQRs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 May 2014 12:17:48 -0400
Content-Disposition: inline
In-Reply-To: <1398693512-5355-4-git-send-email-guido@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>
Cc: LKML <linux-kernel@vger.kernel.org>, bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>

--McpcKDxJRrEJVmOH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2014 at 10:58:32AM -0300, Guido Mart=EDnez wrote:
> Use phandles instead of unit adresses to reference usb and dma nodes.
> This makes the DT more robust and readable.
>=20
> Signed-off-by: Guido Mart=EDnez <guido@vanguardiasur.com.ar>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/boot/dts/am335x-igep0033.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/a=
m335x-igep0033.dtsi
> index 9f22c18..81cf68b 100644
> --- a/arch/arm/boot/dts/am335x-igep0033.dtsi
> +++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
> @@ -201,28 +201,28 @@
>  &usb {
>  	status =3D "okay";
> =20
> -	control@44e10620 {
> +	&usb_ctrl_mod {
>  		status =3D "okay";
>  	};
> =20
> -	usb-phy@47401300 {
> +	&usb0_phy {
>  		status =3D "okay";
>  	};
> =20
> -	usb-phy@47401b00 {
> +	&usb1_phy {
>  		status =3D "okay";
>  	};
> =20
> -	usb@47401000 {
> +	&usb0 {
>  		status =3D "okay";
>  	};
> =20
> -	usb@47401800 {
> +	&usb1 {
>  		status =3D "okay";
>  		dr_mode =3D "host";
>  	};
> =20
> -	dma-controller@47402000  {
> +	&cppi41dma  {
>  		status =3D "okay";
>  	};
>  };
> --=20
> 1.9.2
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
balbi

--McpcKDxJRrEJVmOH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTaQr/AAoJEIaOsuA1yqREYjEQAKiMKdTfGKKPkJO91rX2+EAO
5ec7cXNIiaNl/7vRZLxCU7sLR57iYHRvjt3kxjq2mrr8ObFkXQtFc0RbTo8flULk
bA4fTdm0xlweb7jz735shA0zDSh3eX4UtYxafUtGbtxjckY7vvT61JNOciayrPRJ
FTqvnOots9iOWhIYnfDE1+jBivTEZ3RmN5ftwF3SrsISns5im4JPtkVgl+jlwCFH
sUzftadNnxeZK6qmR5BSql5N9lWhRSqMIN1Fq/+M7P7u8qJiYhNDjWwfzbargLsW
28RarO93ZaAd5NiePCnVr5Hfp698iIu3l9mEk2frfF2Br4oVz0M4trtqqF0R4x8J
LoeJqTieTp1hasZNQwgbZ62n3TKkxSZ+rekJC25wgPlqecNpKlU+ciwN6BbbZKeN
21l9x/YKhL2i2yicALlMn6s/+yZAhc9zQx+4zj/fUWkxUXb3iltya4h/4kD8MtkJ
0tScREwV1pZQEIJj4LgEGQesuegA/6Ks1V/sdlGCCyCEMQdwOQUGbXbD8cs8B0v2
LcUrUnkNQKm8s3MbAP+gNkizrFkgurtQGytAtChFNCvt7aoAIjICJMU8Q6QeYzH9
sktTUYS9RHFgyqekjI1di05Qe6+lDuM+OX3MvcS3E12F3tUwk196l06sldaDkyLz
4GWA20JJ3z2sCW9AxucS
=ZZxB
-----END PGP SIGNATURE-----

--McpcKDxJRrEJVmOH--

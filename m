From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 3/4] ARM: dts: am335x-evmsk: use phandles for USB and
 DMA refs
Date: Tue, 6 May 2014 11:18:06 -0500
Message-ID: <20140506161806.GP25849@saruman.home>
References: <1398693512-5355-1-git-send-email-guido@vanguardiasur.com.ar>
 <1398718475-1883-1-git-send-email-guido@vanguardiasur.com.ar>
 <1398718475-1883-3-git-send-email-guido@vanguardiasur.com.ar>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NEaRsfQExFH3jWtg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54943 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755AbaEFQSv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2014 12:18:51 -0400
Content-Disposition: inline
In-Reply-To: <1398718475-1883-3-git-send-email-guido@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>
Cc: bcousson@baylibre.com, tony@atomide.com, linux-omap@vger.kernel.org, george.cherian@ti.com, Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>

--NEaRsfQExFH3jWtg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2014 at 05:54:34PM -0300, Guido Mart=EDnez wrote:
> Use phandles instead of unit adresses to reference usb and dma nodes.
> This makes the DT more robust and readable.
>=20
> Signed-off-by: Guido Mart=EDnez <guido@vanguardiasur.com.ar>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/boot/dts/am335x-evmsk.dts | 38 +++++++++++++++++++-------------=
------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335=
x-evmsk.dts
> index ab23885..a460c2e 100644
> --- a/arch/arm/boot/dts/am335x-evmsk.dts
> +++ b/arch/arm/boot/dts/am335x-evmsk.dts
> @@ -363,31 +363,31 @@
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
>  &epwmss2 {
> --=20
> 1.9.2
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--NEaRsfQExFH3jWtg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTaQs+AAoJEIaOsuA1yqREDlIP/34mJ0vD0COg1Q4kUYh/c6wR
vUbAfOC4G/BaSIiVttRj9LaDEDNGQsHMypWoQ2M6y374dxAEpPv/8uq/bg7QNknU
vslBlcEf6mBuWnPadcOYP6UKmBIV38PVEZwDDpy7320R2pPYJOU1kHEMNOAk+H3J
F66BOL0IPcgpjA902BaQAx23+QoxSpBFnwQyakG6EH7j1XeZy/G5/fIXtB96vMTf
z8UXgSPUhhrEo6Npu4pjUbLhdh2zmmXhHT+dbHEcv3fj3H0G8UpSJaoO8bBfqUqF
1xF3aq9phh0A+C01F9F9P5qVfojpj/WkGUbk9nPbN+1e6EPIS9ByJ0VSWJl/pJtG
lTATijJDDkCsuC8zCPQ5Ozjo2Ulvkou25YTSxjVbjJmSENBdI7IFurJoWd9/fPBQ
ZBbtF9AFpbha0ZPtR4rO2FaqVcWNvqvt6TuRvIHlWTM4DPoloNVFImO9lEgLUyh3
rNs+7zCvx2m6sKvsaYFbujtbyuIIY0QBMwy0/d9T3wbGXk64ji68x1lgygW81jy1
RTfzhY/aPRuWVzapiMLtx/msz9c7or0Y33JuaDJBONp/9dvSva+q6XG9ox6XxGuH
ziQgbghOGRjj+SVvegYNRKUM514+OWowfrH3Ea9c6yKn+8/cLJ2rr2d0sNXLw2kK
DSUY6kzVfZJWzYZO4Keu
=6gFy
-----END PGP SIGNATURE-----

--NEaRsfQExFH3jWtg--

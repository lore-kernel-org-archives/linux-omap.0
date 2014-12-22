From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: dts: am437x-sk-evm: Hook dcdc2 as the cpu0-supply
Date: Mon, 22 Dec 2014 14:38:54 -0600
Message-ID: <20141222203854.GD3083@saruman>
References: <1417706679-22294-1-git-send-email-balbi@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58008 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754858AbaLVUjo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Dec 2014 15:39:44 -0500
Content-Disposition: inline
In-Reply-To: <1417706679-22294-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Dave Gerlach <d-gerlach@ti.com>

--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2014 at 09:24:39AM -0600, Felipe Balbi wrote:
> From: Dave Gerlach <d-gerlach@ti.com>
>=20
> Hook dcdc2 as the cpu0-supply.
>=20
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

btw, before sending this, I tested on my AM437x Starter Kit, so

Tested-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/boot/dts/am437x-sk-evm.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am43=
7x-sk-evm.dts
> index 87aa4f3..f7f77a7 100644
> --- a/arch/arm/boot/dts/am437x-sk-evm.dts
> +++ b/arch/arm/boot/dts/am437x-sk-evm.dts
> @@ -611,3 +611,7 @@
>  &wdt {
>  	status =3D "okay";
>  };
> +
> +&cpu {
> +	cpu0-supply =3D <&dcdc2>;
> +};
> --=20
> 2.1.0.GIT
>=20

--=20
balbi

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUmIFeAAoJEIaOsuA1yqREAvIP/1voI7871GWPRDKtHioIy6VH
3+qxN0oGElkqJhha4v8V+1qDqnGWRNe7bBulifUKC+HAP6kZSORrjo0Rwi5KSAus
hLr3974mLrX3QyViCa3rKpHtrWtHeZJhhEfmo+IYKCqheu3702Z4ygUc3QQAjntN
m20B9RMfRaauiXIYbKzKU9PSS25Bo0+Chr4aJFpm/s34CtNjJKmW/JM2q/gpmaFk
gjelZ9gXnDyTjBiM1+OOiYPP71pGNskSy6wPtjFd//e3ZpEodrxPf7J8XdBSqZ7g
FaDKZjx6BbJtWJk6DACcb+5Rkj0WxzNM3Oj1H5iVJme7vaJua5x3Z8HlILJ+84FJ
IQqa6jwQtrIBJ3GM1QrkuZjbQrV4VEa+e3uMpya4GAFt5U/mvF+NKtBtFXiijGQu
cmdkCxF0GIASFWyibz9IuKP2KaLpk5u+D7aFnJTcIPJRL5LTMF3N0trobbATc1eV
aGbZhTYXHiqJgq2zT03w4zBSK4Krg6qnt38vvHx1ld1ngPPMoGliU1AnrXjAR+sR
HWBtKsB7J4BWAd4kxFMwjVqXZ3MfyNF5a8BpTLzJ136Lv130kCYaLdZ7Y2iaE2Er
E05Nn8QDJUEBxMVCOtUcneZ+XRfo6GgPpotj8fUV5krqCaEcpFZqW2CBg6i2IQLL
Ce6Rc+VZ5tIpTfQvC7Dp
=jXpy
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--

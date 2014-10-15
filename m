From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] arm: boot: dts: am437x-sk: fix lcd enable pin mux
 data
Date: Wed, 15 Oct 2014 15:24:20 +0300
Message-ID: <543E6774.8000406@ti.com>
References: <1413311335-25083-1-git-send-email-balbi@ti.com> <1413311335-25083-3-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="DpKqkh0OjP0Sdd9woLpoScDbT9aQXp1FQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37623 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539AbaJOMYt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Oct 2014 08:24:49 -0400
In-Reply-To: <1413311335-25083-3-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, Darren Etheridge <detheridge@ti.com>

--DpKqkh0OjP0Sdd9woLpoScDbT9aQXp1FQ
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 14/10/14 21:28, Felipe Balbi wrote:
> Caused by a copy & paste error. Note that even with
> this bug AM437x SK display still works because GPIO
> mux mode is always enabled. It's still wrong to mux
> somebody else's pin.
>=20
> Luckily ball D25 (offset 0x238 - gpio5_8) on AM437x
> isn't used for anything.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/boot/dts/am437x-sk-evm.dts | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am=
437x-sk-evm.dts
> index 859ff3d..681be00 100644
> --- a/arch/arm/boot/dts/am437x-sk-evm.dts
> +++ b/arch/arm/boot/dts/am437x-sk-evm.dts
> @@ -320,8 +320,7 @@
> =20
>  	lcd_pins: lcd_pins {
>  		pinctrl-single,pins =3D <
> -			/* GPIO 5_8 to select LCD / HDMI */
> -			0x238 (PIN_OUTPUT_PULLUP | MUX_MODE7)
> +			0x1c (PIN_OUTPUT_PULLUP | MUX_MODE7) /* gpcm_ad7.gpio1_7 */
>  		>;
>  	};
>  };

I didn't verify the offset, but based on the comments this looks fine to =
me.

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi



--DpKqkh0OjP0Sdd9woLpoScDbT9aQXp1FQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUPmd0AAoJEPo9qoy8lh71dYYP/2IXLI71kvGu4piJxqIQZFsc
Ioa6hjBEjnNLHq/rOb2TrTBVhfrkSmjRbF10I4VyZxWfxxNKUgRsaI1yri5g0QNs
kSZ3BXf8p9P6zejB5wgJ0bYv6uDzjkMdwHOXavBrr045LCJFuHJ+qk47rZyPpGOj
PrUekjZUs/0r/mZZ6NsQGVzAmW3GWE2VcalMaZpgDhGx6oQ0aBYIAQ657lt9//Ia
5Uv4GvB9yOPhxXRgRkJOZiscYM8xug2K6Bz91lbi7IBKdFi/XUwdh8IzylOl2aZE
DGpa0nUnua/pUKDgLD0YoyWsqNZ5mkVtaoSSwRcFaFloGvmt0gYlA1Np2CLPBUL7
4ebYaiYmAMY7qNOaC5bziK/0MQ2pBUnKeqVOvAd8Oe3L50J2UiS5L2yWh/l5yZrE
6tND/V01V9w9XhM2DIht3FbQPlR0RhXQTwB2IsEWUDtXwXRsV0sCemtguWtySA2m
eVkrN+EZDwvTMYwhnn1R2mx+mPsW6X7E1sixRGj9TiiT+XRnMhaKisc4zRdzTxP8
E+atLm5FChEKfEGgek7/aUYbtf6vQLwm7KprLTPNNTIKmiPtUmMjykkve/bN+ako
ZTNboNMbcIqb2gQ5oGoguZtbRktSiGzqdtT2crw+2UHnDK4kj1S+yfyrv88K47fs
93NNYyMp4WStP/KJaXg4
=7P3k
-----END PGP SIGNATURE-----

--DpKqkh0OjP0Sdd9woLpoScDbT9aQXp1FQ--

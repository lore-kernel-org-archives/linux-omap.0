From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] watchdog: Fix omap watchdogs to enable the magic close
 bit
Date: Wed, 15 Oct 2014 09:42:24 -0500
Message-ID: <20141015144224.GE10888@saruman>
References: <20141014192518.GH4972@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59200 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447AbaJOOmg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Oct 2014 10:42:36 -0400
Content-Disposition: inline
In-Reply-To: <20141014192518.GH4972@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org, Thomas Dziedzic <gostrc@gmail.com>

--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2014 at 12:25:19PM -0700, Tony Lindgren wrote:
> This allows testing the watchdog easily with distros just by
> doing pkill -9 watchdog.
>=20
> Reported-by: Thomas Dziedzic <gostrc@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

>=20
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -189,7 +189,7 @@ static int omap_wdt_set_timeout(struct watchdog_devic=
e *wdog,
>  }
> =20
>  static const struct watchdog_info omap_wdt_info =3D {
> -	.options =3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> +	.options =3D WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
>  	.identity =3D "OMAP Watchdog",
>  };
> =20
> --- a/drivers/watchdog/retu_wdt.c
> +++ b/drivers/watchdog/retu_wdt.c
> @@ -94,7 +94,7 @@ static int retu_wdt_set_timeout(struct watchdog_device =
*wdog,
>  }
> =20
>  static const struct watchdog_info retu_wdt_info =3D {
> -	.options =3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> +	.options =3D WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
>  	.identity =3D "Retu watchdog",
>  };
> =20
> --- a/drivers/watchdog/twl4030_wdt.c
> +++ b/drivers/watchdog/twl4030_wdt.c
> @@ -57,7 +57,7 @@ static int twl4030_wdt_set_timeout(struct watchdog_devi=
ce *wdt,
>  }
> =20
>  static const struct watchdog_info twl4030_wdt_info =3D {
> -	.options =3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> +	.options =3D WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
>  	.identity =3D "TWL4030 Watchdog",
>  };
> =20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUPofQAAoJEIaOsuA1yqRE7hoQAK41KMk+fbksOoVtu8i+x9zH
a8FBV0OsvmIl7qe5D4eVI7bqEy2Cp6JvACOyJB9fLoc7HWkn05BT+PAIMyI+y4fp
QXe7RLV3iZa3DX5Ao04uBoG3j5yEhBXizo0RvouS77pYSm7GGyhN2QOnVU5I/0yR
Y6Y11Aq7Sne0HeNJJ0r7A5C/Deej1vj2Sc/GM9RmEZ4F0PyCKvxAXoYQLVcBiV74
wLNyQbQsBVL6IedsdzR926k1op1v7as5ylyLjbA2BobpBT8zF6oJMXj99UXNz8XN
7Y8mKAl2a/lvrv7IpMBq8hSTpK2ljIwPc42kV5A+Ghm95yuNRVdVBlizjOuiV9BQ
dA4gmL2jstbl2AqmWPR7BHl/HCt3d8bQ9JfImdLr5HPdBufBWqjrKLDkOxNC3Von
wEjZlgYEMoMv8iXiKg6mDsezNahPvloLug3hoSB+v+x9v0ruaoLxyioJJCbgTk1m
cAcDTCjJ9tbSo6NcaYvLebeYBrF4xdqf+5f97oEOTpwUKIi/doNZ3RRRxpBTpVX6
U4bhmfyKJbiHqyFq7S0+BNEg6HU8QRSJYzKCCcVhUcjhSzYOUhFJs37b7iWzSFHi
kWpKbIkOOX4TiSD8LNrfoEzvN7gK7UYos2rRZBCJt6qpJ0RWLKZWg/YFuHpcvYIM
RdIPTBOAQZQe+E34bd+d
=qGCA
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--

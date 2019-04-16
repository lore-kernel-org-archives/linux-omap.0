From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ARM: OMAP1: ams-delta: fix early boot crash when LED
 support is disabled
Date: Tue, 16 Apr 2019 09:14:20 +0200
Message-ID: <20190416071420.GA14538@amd>
References: <20190415233732.3612-1-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190415233732.3612-1-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-04-16 02:37:32, Aaro Koskinen wrote:
> When we boot with the LED support (CONFIG_NEW_LEDS) disabled,
> gpio_led_register_device() will return a NULL pointer and we try
> to dereference it. Fix by checking also for a NULL pointer.
>=20
> Fixes: 19a2668a8ae3 ("ARM: OMAP1: ams-delta: Provide GPIO lookup table fo=
r LED device")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAly1gMwACgkQMOfwapXb+vLNiACgtHM3J/eHilRjovPi/HsUecPJ
3sgAnAnEyk1CZ+d8gZTBslnBFEdng6lt
=fEhN
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--

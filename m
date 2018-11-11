From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ARM: OMAP1: ams-delta: Provide GPIO lookup table for LED
 device
Date: Sun, 11 Nov 2018 12:29:50 +0100
Message-ID: <20181111112950.GB27666@amd>
References: <20181105232349.17351-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181105232349.17351-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Linus Walleij <linus.walleij@linaro.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-11-06 00:23:49, Janusz Krzysztofik wrote:
> Global GPIO numbers no longer have to be passed to leds-gpio driver,
> replace their assignment with a lookup table.
>=20
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvoEq4ACgkQMOfwapXb+vLA3wCeL5AHGI3kOXdULxN9/7QDIv4s
Uw4AoL9oW+QknlBG+sI9YSthCUv5GauC
=ENjW
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--

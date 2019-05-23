From: Pavel Machek <pavel@ucw.cz>
Subject: Droid 4 backlight support
Date: Fri, 24 May 2019 00:00:47 +0200
Message-ID: <20190523220047.GA15523@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, jacek.anaszewski@gmail.com, dmurphy@ti.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Good news .. we have driver for backlight in mainline, AFAICT.

Bad news .. it is called "lm3532::backlight" or something like that. I
guess we should switch to ":backlight" or something? It is quite
important to do that before someone starts to use the ABI...

And now... we have the driver, but it is not connected to the
backlight subsystem. I guess we could make the LED "default on" for
now... but if there's better plan, let me know.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlznGA8ACgkQMOfwapXb+vKvEACgqh7D8W9xEk0CYM0E6JZ/nYzP
NSwAn33OnShByv5jZg7ue2kh7hB/D4jj
=5e5V
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--

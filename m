From: Pavel Machek <pavel@ucw.cz>
Subject: bq27000: directory/files exists even when hardware is not available
Date: Fri, 20 Apr 2018 09:40:36 +0200
Message-ID: <20180420074036.GA16257@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, afd@ti.com, pali.rohar@gmail.com, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On droid4 (4.17-rc1), /sys/class/power_supply/bq27000-battery exists
even when hardware is not present (as on Droid 4).

Any ideas?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrZmXQACgkQMOfwapXb+vKifwCgw0cgRJUD8yOJ5gpCpq8g1see
1n8AnR1R3pvso3Rd21esB6VyxPe7E3SB
=Bql9
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--

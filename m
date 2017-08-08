From: Pavel Machek <pavel@ucw.cz>
Subject: Re: linux-next 2017-08-08 failure on Nokia N900
Date: Tue, 8 Aug 2017 12:34:44 +0200
Message-ID: <20170808103444.GA18247@amd>
References: <20170808101756.GA12922@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170808101756.GA12922@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I tried today's linux-next. It boots on n900 (up to X), but then my
> screen locks and I can't get back. Touchscreen worked, so my guess is
> keyboard does not...? Ssh connection over usb still works.

Confirmed, its the keyboard.

Additionally, battery monitoring fails, because neither

/sys/class/power_supply/{n900-,rx51-}battery/voltage_now

exists.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlmJk8QACgkQMOfwapXb+vLcSgCfcLDB+ZpCFWmSfz2CF9I1yQF0
8UsAnAkOjHutYg8I+i39jd8/NeBFIpQE
=X3eK
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--

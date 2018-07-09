From: Pavel Machek <pavel@ucw.cz>
Subject: Vibrations on Droid 4?
Date: Mon, 9 Jul 2018 10:15:35 +0200
Message-ID: <20180709081534.GA6799@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Do you have vibrations on d4 working?

I believe I have required drivers enabled, but no luck:

user@devuan:/sys/bus/platform/drivers$ ls pwm-vibrator/
bind  uevent  unbind
user@devuan:/sys/bus/platform/drivers$ ls omap-dmtimer-pwm/
bind  uevent  unbind

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltDGaYACgkQMOfwapXb+vIY8wCgsLvAz2+uSlrtYUy8SVb/Kksq
hPMAnRiZ4ueMjkw1p12epfiNnCk5hY25
=v4XT
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--

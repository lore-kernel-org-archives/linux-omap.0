From: Pavel Machek <pavel@ucw.cz>
Subject: Charge counter on droid 4
Date: Fri, 15 Jun 2018 10:00:14 +0200
Message-ID: <20180615080014.GA29192@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Droid 4 has non-removable battery, yet the charge counter is reset to
near zero on each boot of linux.

Unfortunately, that makes charge counter pretty much useless on d4, as
the "battery full" and "battery empty" limits will be different during
each boot.

Is it possible that we reset the cpcap needlessly, or something like
that?

unicsy_demo (github.com:pavelmachek/unicsy_demo.git) was updated to
read the charge counter, and attempt to estimate battery percentages
=66rom that. Use monitor/batmond... warning -- it provides a _lot_ of
information.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsjcg4ACgkQMOfwapXb+vIrjQCfTCJf0coRFkCzI7KVkz5WEoxa
zWEAoIBbxbwlP698hqj6EMFzWsO4DkDd
=0ZvM
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--

From: Pavel Machek <pavel@ucw.cz>
Subject: N900 failure in next-20170321
Date: Tue, 21 Mar 2017 14:57:09 +0100
Message-ID: <20170321135708.GA22358@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Tony asked me to test linux-next from time to time. I did... today I
moved from next-20170309 to next-20170321. Kernel boots and seems to
work fine (including audio and X startup), but if I leave it sitting
for a while RGB LED reverts from "system alive" to charging indication
that was disabled before and system does not react to any input.

Any ideas?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljRMTQACgkQMOfwapXb+vK1KACgjTbnDdCN5AIiiixGs/KgkVZf
Cv4An3TXWiBWqk6CDp/c3JKCKmPqW2Gs
=ErnI
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--

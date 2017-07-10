From: Pavel Machek <pavel@ucw.cz>
Subject: 4.13-rc0: stopped booting on Nokia N900
Date: Mon, 10 Jul 2017 09:46:11 +0200
Message-ID: <20170710074610.GA22846@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

First, I got segfault from make:

: 0: Can't open
scripts/Makefile.build:561: recipe for target
'drivers/iio/imu/st_lsm6dsx' failed
make[3]: *** [drivers/iio/imu/st_lsm6dsx] Segmentation fault (core
dumped)
scripts/Makefile.build:561: recipe for target 'drivers/iio/imu' failed
make[2]: *** [drivers/iio/imu] Error 2
scripts/Makefile.build:561: recipe for target 'drivers/iio' failed
make[1]: *** [drivers/iio] Error 2
make[1]: *** Waiting for unfinished jobs....
Makefile:1008: recipe for target 'drivers' failed
make: *** [drivers] Error 2
make: *** Waiting for unfinished jobs....
pavel@duo:/data/l/linux-n900$ ./mkit

Then compile worked, but it failed to boot. I've now cleaned caches
and am rebuilding to make sure it is not build machine that has
glitches.

No such luck :-(.

I tested linux-next relatively recently, and it worked ok.

af3c8d98508d37541d4bf57f13a984a7f73a328c is broken.
650fc87 worked ok.

Best regards,

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlljMMEACgkQMOfwapXb+vJpNgCfeBuszK81w+8fd68G2b6TIuOR
nv8AoMQvCsxXFVr6zYxw2Yycsymxq5Yj
=uEA/
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--

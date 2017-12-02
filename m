From: Pavel Machek <pavel@ucw.cz>
Subject: linux-next on Nokia N900: hang on boot
Date: Sat, 2 Dec 2017 11:14:56 +0100
Message-ID: <20171202101456.GA1810@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

next from 2017-12-01 was tested.

MMC is detected, but then I see wtl4030_bci: .. battery temperature
out of range, and machine halts. This is just before userspace would
be started.

4.15-rc1 seems to work ok on the box.

Any ideas?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloifSAACgkQMOfwapXb+vLX8gCgiTBEaejGB5EfMfelKztHBak3
VrAAoI6EuI7lAXzIH0qJk5UZLzbZfBeB
=W8Ab
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--

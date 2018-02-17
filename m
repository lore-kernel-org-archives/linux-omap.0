From: Pavel Machek <pavel@ucw.cz>
Subject: setterm -blank force no longer works after switch to omapdrm
Date: Sat, 17 Feb 2018 22:19:27 +0100
Message-ID: <20180217211927.GC9640@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I used to have use omap fb driver, and blanking worked as expected. It
no longer works with omap drm driver. (Tested on v4.16-rc1, but I
believe it is broken in older versions, too.)

Can you test it on your hw? Any ideas what could be wrong?

xset dpms force on/off works as expected.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqInF8ACgkQMOfwapXb+vL2dQCbBjh4ATmX6PNABemFiW5BYkDY
OLkAoJM1ggMNjEeommMEbzvgyCUTIw/o
=vZqS
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--

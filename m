From: Pavel Machek <pavel@ucw.cz>
Subject: Back camera working at 1MPix, not working at 5Mpix
Date: Fri, 14 Jul 2017 14:10:27 +0200
Message-ID: <20170714121027.GA31248@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

=46rom cca v4.6 kernel, I have working back camera in 1Mpix resolution.

I can't get 5Mpix to work at all. In preview mode, display is
distorted in various ways, in raw mode, I get
[  522.576354] omap3isp 480bc000.isp: Unable to stop OMAP3 ISP CCDC
and no data.

If you have recent kernel tree where 5MPix mode works, let me
know. 2.6.x probably does not help me, but 4.x would be interesting.=20

BTW my tree with camera is at
kernel.org:pub/scm/linux/kernel/git/pavel/linux-n900.git branch
camera-fw6-2 ... if someone wants to play.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllotLMACgkQMOfwapXb+vL0xgCeIJeikh20QwSUnzVISnjHLzBk
mH0AnRRyL8U/9BpaGu0PZBHYeC3trhw6
=znSQ
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--

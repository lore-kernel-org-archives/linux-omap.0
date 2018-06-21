From: Pavel Machek <pavel@ucw.cz>
Subject: v4.18-rc1 on droid 4: very bad CPU performance
Date: Thu, 21 Jun 2018 14:15:42 +0200
Message-ID: <20180621121542.GA4836@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

V4.18 is slower than it should be.

user@devuan:~$ time cat /dev/urandom | head -c 10000000 |  bzip2 -9 -
| wc -c
10044291
52.73user 2.40system 61.53 (1m1.534s) elapsed 89.60%CPU
user@devuan:~$ uname -a
Linux devuan 4.18.0-rc1-87964-gfa19934-dirty #743 SMP Sun Jun 17
19:26:37 CEST 2018 armv7l GNU/Linux

That bzip should take 12 seconds, not minute.

Any ideas? Do you see it, too?

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsrlu4ACgkQMOfwapXb+vI+ZgCgjGoE/b39+ozezf6HIClfCRPR
XMEAoIORuNoXvcljvgv1WlK55Qe1+Oz7
=51ml
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

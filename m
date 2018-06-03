From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Common config for N900 and D4
Date: Sun, 3 Jun 2018 23:01:15 +0200
Message-ID: <20180603210115.GA7438@amd>
References: <20180603104839.GA21197@amd>
 <20180603165336.GA26995@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180603165336.GA26995@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Cc: aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Aaro, I know I have asked before, but if you have common config for
> > N900 and Droid4, please send me a copy. Yes, it should be somewhere in
> > my inbox already, but I can't find it and version for v4.17 would be
> > more useful.
> >=20
> > While trying to came up with common config, I hit:
> >=20
> > [    0.000000] L2C-310 erratum 727915 enabled
> > [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
> > [    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
>=20
> I tried disabling outer cache to get rid of this. That got me further
> in boot, but not to working system:

I now have config that works.

My kernels were probably grossly misconfigured (OMAP4 not enabled on
droid4)... still I'd expect some kind of panic explaining board is not
compatible with kernel, not a random oops...

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsUVxsACgkQMOfwapXb+vLvkQCfZbppLGnuOsgB4b1v18Qxz12+
5i8AoLMw2tjfXzHyo7VWQkejyRK1Mvoh
=aRrE
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--

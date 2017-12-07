From: Pavel Machek <pavel@ucw.cz>
Subject: Re: linux-next on Nokia N900: hang on boot
Date: Thu, 7 Dec 2017 11:16:51 +0100
Message-ID: <20171207101651.GA23691@amd>
References: <20171202101456.GA1810@amd>
 <20171202111954.4gg43xkb2wf5ebmn@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171202111954.4gg43xkb2wf5ebmn@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2017-12-02 12:19:54, Pali Roh=E1r wrote:
> On Saturday 02 December 2017 11:14:56 Pavel Machek wrote:
> > Hi!
> >=20
> > next from 2017-12-01 was tested.
> >=20
> > MMC is detected, but then I see wtl4030_bci: .. battery temperature
> > out of range, and machine halts. This is just before userspace would
> > be started.
> >=20
> > 4.15-rc1 seems to work ok on the box.
> >=20
> > Any ideas?
>=20
> twl4030_bci is not available on Nokia N900, so we should not try to read
> its registers.

Today's git boots on N900; good. What is going on with twl4030_bci I
don't have time to investigate at the moment.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlopFRMACgkQMOfwapXb+vI14QCgwABhEAYvZVvFixVsmhRx+Wlk
T0sAoKjRLl7Xb1/p2jJ9CQSxad0O+GAE
=NV9x
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--

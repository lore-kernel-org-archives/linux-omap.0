From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900: u-SD card in v4.2+
Date: Sat, 9 Jan 2016 23:44:44 +0100
Message-ID: <201601092344.44641@pali>
References: <20160106204627.GA21477@amd> <568DFA4B.7030308@ti.com> <20160107113408.GA26618@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2905842.DSCUU8RpxL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160107113408.GA26618@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

--nextPart2905842.DSCUU8RpxL
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 07 January 2016 12:34:09 Pavel Machek wrote:
> Hi!
>=20
> > On Thursday 07 January 2016 02:16 AM, Pavel Machek wrote:
> > > Hi!
> > >=20
> > > In v4.1, both internal MMC and u-SD cards work ok.
> > >=20
> > > In v4.2, only the internal MMC is detected. In v4.3, not even
> > > internal MMC works. In v4.4, only the internal MMC is detected.
> > >=20
> > > Does it work for you? Any patches?
> >=20
> > I don't have Nokia N900 to check this, but can you share your
> > config and kernel logs? Check if CONFIG_REGULATOR_PBIAS is present
> > in your config. CONFIG_REGULATOR_PBIAS is now mandatory for all
> > omap3+ SoCs to work.
>=20
> I enabled CONFIG_REGULATOR_PBIAS and both MMCs now work.
>=20
> I wonder if we should add some selects, so that users updating from
> old kernels don't break their system?

Please add these selects. I had CONFIG_REGULATOR_PBIAS disabled too,=20
because I just updated defconfig from older kernel version.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2905842.DSCUU8RpxL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlaRjVwACgkQi/DJPQPkQ1LBtwCgol+Fa9cl2w+Yii+9MrCFymXt
lSkAoJ3O53xy0mEqiiLnZ1xkgWypMGyn
=nuLZ
-----END PGP SIGNATURE-----

--nextPart2905842.DSCUU8RpxL--

From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Missing OMAP PM layer
Date: Mon, 25 Jan 2016 18:24:13 +0100
Message-ID: <201601251824.13711@pali>
References: <201601242123.58871@pali> <20160125163442.GU19432@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1703238.IzMAliVeLd";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160125163442.GU19432@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart1703238.IzMAliVeLd
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 25 January 2016 17:34:42 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [160124 12:24]:
> > Hello,
> >=20
> > make menuconfig allows me to choose "OMAP PM layer selection" and
> > the only one option is CONFIG_OMAP_PM_NOOP "No-op/debug PM layer".
> >=20
> > What does it mean? Power manager is noop?
> >=20
> > I see that it has only two corresponding files in mainline kernel:
> > arch/arm/mach-omap2/omap-pm.h
> > arch/arm/mach-omap2/omap-pm-noop.c
> >=20
> > Nokia's kernels (for N900 and N950) had also:
> > arch/arm/mach-omap2/omap-pm-srf.c
> >=20
> > Can somebody explain it what happened with omap power management?
> >=20
> > Looks like that omap-pm.h provides some API, but the only
> > implementation is noop which do nothing.
>=20
> I believe none of that is needed any longer in mainline.

Ok, and what was that omap-pm? Do you know what Nokia omap-pm-srf.c do?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1703238.IzMAliVeLd
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlamWj0ACgkQi/DJPQPkQ1KvpgCfeGV+eS/aBqL30x2A7noZvjb8
+UgAoMz941EImT1215HrOT0LoQng8gWV
=iOBK
-----END PGP SIGNATURE-----

--nextPart1703238.IzMAliVeLd--

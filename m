From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.18-rc1 on droid 4: very bad CPU performance
Date: Mon, 25 Jun 2018 11:49:49 +0200
Message-ID: <20180625094949.GA17001@amd>
References: <20180621121542.GA4836@amd>
 <20180622072005.GF112168@atomide.com>
 <20180622074936.GG112168@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180622074936.GG112168@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > V4.18 is slower than it should be.
> > >=20
> > > user@devuan:~$ time cat /dev/urandom | head -c 10000000 |  bzip2 -9 -
> > > | wc -c
> > > 10044291
> > > 52.73user 2.40system 61.53 (1m1.534s) elapsed 89.60%CPU
> > > user@devuan:~$ uname -a
> > > Linux devuan 4.18.0-rc1-87964-gfa19934-dirty #743 SMP Sun Jun 17
> > > 19:26:37 CEST 2018 armv7l GNU/Linux
> > >=20
> > > That bzip should take 12 seconds, not minute.
> > >=20
> > > Any ideas? Do you see it, too?
> >=20
> > I've noticed firefox is super slow.. Git bisect time?
>=20
> Hmm not happening for me at least on duovero and droid4,
> I'm getting about 20s for v4.17 and v4.18-rc1.

Something weird is going on here. My notes say it should be 12
seconds.

It is indeed 20 seconds for v4.17, but it is 12 seconds in v4.14.

v4.14 is:
# CONFIG_CPU_FREQ is not set
CONFIG_CPU_IDLE=3Dy
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=3Dy
# CONFIG_ARM_CPUIDLE is not set

In v4.18, I have:

CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_GOV_ATTR_SET=3Dy
CONFIG_CPU_FREQ_GOV_COMMON=3Dy
CONFIG_CPU_FREQ_STAT=3Dy
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=3Dy

CONFIG_CPU_IDLE=3Dy
CONFIG_CPU_IDLE_GOV_MENU=3Dy
CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED=3Dy


									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlswur0ACgkQMOfwapXb+vKhQACgrGFTcCBW/YNXoN9+czegpDxS
mikAn1yfOKJwJhXspoJRWg86iz8itTRQ
=opgR
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--

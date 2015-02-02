From: Felipe Balbi <balbi@ti.com>
Subject: Re: v3.19: Nokia N900 - usb nokia gadget crash
Date: Mon, 2 Feb 2015 17:13:03 -0600
Message-ID: <20150202231303.GD30753@saruman.tx.rr.com>
References: <201501311006.11909@pali>
 <20150202221713.GB30753@saruman.tx.rr.com>
 <20150202222727.GC30753@saruman.tx.rr.com>
 <201502022347.26582@pali>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6WlEvdN9Dv0WHSBl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201502022347.26582@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 02, 2015 at 11:47:26PM +0100, Pali Roh=E1r wrote:
> On Monday 02 February 2015 23:27:27 Felipe Balbi wrote:
> > On Mon, Feb 02, 2015 at 04:17:13PM -0600, Felipe Balbi wrote:
> > > On Sat, Jan 31, 2015 at 10:25:09AM +0100, Pali Roh=E1r wrote:
> > > > On Saturday 31 January 2015 10:06:11 Pali Roh=E1r wrote:
> > > > > Hello,
> > > > >=20
> > > > > when I try to modprobe g_nokia.ko gadget module on n900
> > > > > device, it produce tons on lines to display and then
> > > > > crash and reboot device. So its not working and I
> > > > > (without Nokia (TM) serial console I cannot debug it).
> > > >=20
> > > > When I compile g_nokia into zImage (not as external
> > > > module) then it kernel loads correctly and usb is
> > > > working.
> > > >=20
> > > > Any idea why g_nokia as external kernel module cause
> > > > problems, but compiled into zImage is working??
> > >=20
> > > what I got here is a WARNING from f_phonet only, I'll look
> > > into it. Keep in mind I don't have N900 available, testing
> > > with beagleboneblack and AM437x SK.
> >=20
> > looks like there's a bug with MUSB too which needs fixing for
> > that. Did you get "inconsistent lock stae" WARN ?
>=20
> I cannot read any message after I modprobe g_nokia.ko
>=20
> I just see that kernel try to overwrite couple of lines on n900=20
> display and after 1-3 seconds device reboot.

alright, I guess I found both bugs. I'll send patches soon.

--=20
balbi

--6WlEvdN9Dv0WHSBl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU0AR/AAoJEIaOsuA1yqREXzcP/3bBab+XJKkgLJDyqtsvcDNn
S/7saXYYaJbj75aS+NbEdGIvqxNI9v9SGAb0fTBtocLan7u1OMRD2gnnNgNyTjwW
kxlVhLna6wRPPs7xtZdgBOb4hDUG/5C65D9OUOc0/98FJ/Ep8szYyUKs0i/M6aYp
MNLEO1aBjia2QgqJHiq7y3I/0GH2mtxWE1JYgxLUozEbnC+nXQfgLE1EisY4Zv8a
o8gm8kaEeo3SD0L3pssV8CdoFkyk8lXFg/8/QqUprRVrkET0tVBazj7owUiQQ98U
NhhaW5P3vAacYRf+AzLcQYezOmbJT1g9CvRWuZOmo3VIgem17TS0093vGm/1+N62
RrOa3FxKwLp/0prkO1LQlPgjMsKvslstea2YzQlaziT7rVFNG9VxedeRuou5se4e
D78mfRg3CpFTh7iv5IKst9QdXVEEmhOguwk9YmhJsh93n+gX/HqjBqShiMmw+GTp
vD1AMUBhERzzmZB74fjsaihQO4WAjawWL/wQyxi/FIq6njW9DWj4PxhdzoeIvHaJ
hSHu27m7sTIMrhhDH9eWZ9KU2GeKJusiIOIeImhvQpoK1lWnmnS6QBGSTcBkk5CM
X4vUUdwRolmg8fUFlqLtuw/Xeeuhz7pcixqtvAhzF3B3eJ7qsB/6N8LOI4ABzgKm
6GmnCs2gyZjgnpF78IoN
=/eow
-----END PGP SIGNATURE-----

--6WlEvdN9Dv0WHSBl--

From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: v3.19: Nokia N900 - boot errors
Date: Sat, 31 Jan 2015 12:26:42 +0100
Message-ID: <201501311226.42092@pali>
References: <201501311028.46357@pali> <201501311208.31745@pali> <20150131111130.GG591@fuloong-minipc.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7048666.V0e6alyT2U";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150131111130.GG591@fuloong-minipc.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

--nextPart7048666.V0e6alyT2U
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 31 January 2015 12:11:30 Aaro Koskinen wrote:
> Hi,
>=20
> On Sat, Jan 31, 2015 at 12:08:31PM +0100, Pali Roh=C3=A1r wrote:
> > On Saturday 31 January 2015 12:05:09 Aaro Koskinen wrote:
> > > Hi,
> > >=20
> > > On Sat, Jan 31, 2015 at 10:28:46AM +0100, Pali Roh=C3=A1r wrote:
> > > > when I boot 3.19 kernel on real n900 device it show
> > > > these errors in dmesg:
> > > >=20
> > > > [    0.256103] hw-breakpoint: debug architecture 0x4
> > > > unsupported. [    0.257659] In-band Error seen by MPU=20
> > > > at address 0 [    0.257720] ------------[ cut here
> > > > ]------------ [    0.257781] WARNING: CPU: 0 PID: 1 at
> > > > drivers/bus/omap_l3_smx.c:166
> > > > omap3_l3_app_irq+0xd4/0x118()
> > >=20
> > > This should be fixed in 3.16-rc6.
> >=20
> > Apparently not, still present in 3.19.0-rc5+.
>=20
> Sorry, I made a typo. I meant 3.19-rc6. The commit is:
>=20
> 	commit 4b149e417463bbb6d1d9b805f729627ca2b54495
> 	Author: Felipe Balbi <balbi@ti.com>
> 	Date:   Tue Jan 6 14:38:08 2015 -0600
>=20
> 	    irqchip: omap-intc: Fix legacy DMA regression
>=20
> A.

Right, that commit fix boot errors.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart7048666.V0e6alyT2U
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTMu/IACgkQi/DJPQPkQ1JHfwCgk/6ezurClm87U7Pp17Ft+kG6
z2oAoIm3QYgsWgP7D1TXKK0g62Jylv/3
=Yqwi
-----END PGP SIGNATURE-----

--nextPart7048666.V0e6alyT2U--

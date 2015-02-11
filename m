From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re: 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Wed, 11 Feb 2015 22:14:23 +0100
Message-ID: <201502112214.23721@pali>
References: <20131206213613.GA19648@earth.universe> <201502010956.28662@pali> <20150211204342.GE29636@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2655989.W9GA759My1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:43514 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004AbbBKVO1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Feb 2015 16:14:27 -0500
Received: by mail-wg0-f50.google.com with SMTP id l2so6087830wgh.9
        for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2015 13:14:25 -0800 (PST)
In-Reply-To: <20150211204342.GE29636@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, Joel Fernandes <joelf@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@ring0.de>

--nextPart2655989.W9GA759My1
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 11 February 2015 21:43:42 Pavel Machek wrote:
> Hi!
>=20
> On Sun 2015-02-01 09:56:28, Pali Roh=C3=A1r wrote:
> > On Sunday 01 February 2015 02:36:06 Matthijs van Duin wrote:
> > > On 31 January 2015 at 20:06, Pali Roh=C3=A1r
> > > <pali.rohar@gmail.com>
> > >=20
> > > wrote:
> > > > I have configured two testing N900 devices. One with
> > > > signed bootloader which enable omap aes support and one
> > > > device with signed bootloader which does not enable
> > > > omap aes support.
> > >=20
> > > I'm probably missing some context here, but why not just
> > > use the one with aes support? Alternatively, one may
> > > argue that it's the bootloader's job to provide the
> > > kernel with an accurate device tree. (Though one may
> > > equally well argue that it would be nice to avoid having
> > > to customize the device tree for every feature-flavor of
> > > a processor, especially if this depends on how it's
> > > initialized.)
> >=20
> > Nokia X-Loader is closed source and signed. So we cannot
> > modify it. And it is responsible for configuring L3/L4
> > firewall.
> >=20
> > Year ago it was possible to find on internet signed X-Loader
> > for N900 which enable omap aes support (for testing purpose
> > together with open source linux kernel modules), but it is
> > unofficial and I think there only too few people who
> > flashed it into N900 nand. If somebody needs binaries I
> > have backup all of them.
> >=20
> > More info about that aes enabled X-Loader:
> > http://maemo.org/community/maemo-developers/n900_aes_and_sha
> > 1-md5_hw_acceleration_drivers/
> >=20
> > Majority of users use only official X-Loader which does not
> > enable aes support so we cannot enable kernel modules (cause
> > crashes). And also we cannot force users to flash some
> > unofficial binary into their device...
>=20
> BTW... it would be interesting to know... are you doing some
> heavy crypto processing on N900? Are the accelerated drivers
> faster than non-accelerated ones? Because the link above says
> they are slower...
>=20
> # Eric Wheeler
> # ...
> # Hey guys, I have omap-aes compiled for my kernel and appears
> to be # working.
> #
> # I do not understand why non-accelerated software-crypto is
> faster than # the omap-aes hardware acceleration:
> #
> # mmcblk0 onboard 32GB: read=3D21.76MB/s write=3D12.97MB/s
> # aes_generic crypto: read=3D 8.47 write=3D 5.54
> # omap-aes hw crypto: read=3D 6.31 write=3D 5.45
> #
> # mmcblk1 uSD 16GB Class 10: read=3D16.05MB/s write=3D16.47MB/s
> # aes_generic crypto: read=3D 7.96 write=3D 7.43
> # omap-aes hw crypto: read=3D 6.67 write=3D 7.18
>=20
> Best regards,
> 									Pavel

Also depends on CPU usage. Same as there was preview of theora=20
decoder. One neon optimized running at arm core provided better=20
fps, but used 99%. Another implementation which used DSP core=20
provided lower fps, but enough for watching videos and did not=20
used full CPU usage...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2655989.W9GA759My1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTbxi8ACgkQi/DJPQPkQ1J9ngCZAaYQbMZOx3rlgwE1r8oh/kW3
IikAniyBzxjGYRBZygV7eaqxMTx7dI+h
=tIx0
-----END PGP SIGNATURE-----

--nextPart2655989.W9GA759My1--

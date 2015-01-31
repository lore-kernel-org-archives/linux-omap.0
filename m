From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: v3.19: Nokia N900 - boot errors
Date: Sat, 31 Jan 2015 12:08:31 +0100
Message-ID: <201501311208.31745@pali>
References: <201501311028.46357@pali> <20150131110509.GF591@fuloong-minipc.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1447020.zRpm0sIgKY";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:44016 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756041AbbAaLIe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Jan 2015 06:08:34 -0500
In-Reply-To: <20150131110509.GF591@fuloong-minipc.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

--nextPart1447020.zRpm0sIgKY
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 31 January 2015 12:05:09 Aaro Koskinen wrote:
> Hi,
>=20
> On Sat, Jan 31, 2015 at 10:28:46AM +0100, Pali Roh=C3=A1r wrote:
> > when I boot 3.19 kernel on real n900 device it show these
> > errors in dmesg:
> >=20
> > [    0.256103] hw-breakpoint: debug architecture 0x4
> > unsupported. [    0.257659] In-band Error seen by MPU  at
> > address 0 [    0.257720] ------------[ cut here
> > ]------------ [    0.257781] WARNING: CPU: 0 PID: 1 at
> > drivers/bus/omap_l3_smx.c:166 omap3_l3_app_irq+0xd4/0x118()
>=20
> This should be fixed in 3.16-rc6.
>=20
> A.

Apparently not, still present in 3.19.0-rc5+.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1447020.zRpm0sIgKY
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTMt68ACgkQi/DJPQPkQ1LRcQCgne+Uv35zyluulh2XpZhvDo7A
YVQAoMU74/lmNbGx8qBAdi3nBOjp68eX
=Rhnr
-----END PGP SIGNATURE-----

--nextPart1447020.zRpm0sIgKY--

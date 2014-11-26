From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Wed, 26 Nov 2014 20:22:03 +0100
Message-ID: <201411262022.03338@pali>
References: <20141027200008.GR2560@atomide.com> <201411261957.08860@pali> <20141126191027.GM2817@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1702352.Kss0k1jQFy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:57493 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbaKZTWH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2014 14:22:07 -0500
Received: by mail-wi0-f178.google.com with SMTP id hi2so6079174wib.5
        for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2014 11:22:05 -0800 (PST)
In-Reply-To: <20141126191027.GM2817@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--nextPart1702352.Kss0k1jQFy
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 26 November 2014 20:10:28 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [141126 10:59]:
> > On Wednesday 26 November 2014 19:19:35 Tony Lindgren wrote:
> > > Maybe Pali can try to restart that discussion? To me it
> > > seems the /proc/cpuinfo should be the same as it's a user
> > > interface. Sorry forgot the details of the previous
> > > discussion..
> >=20
> > Yes, two days ago I again wrote emails about this problem...
> >=20
> > E.g. one of them, see: https://lkml.org/lkml/2014/11/24/774
> >=20
> > > And with which app was that? Sorry I forgot..
> >=20
> > More applications/libraries for N900 which running on Maemo
> > 5 system. Some of them are Nokia proprietary, some of them
> > are open source and some are mine.
> >=20
> > Basically problem is that non DT boot provides this info in
> > /proc/cpuinfo:
> >=20
> > Hardware        : Nokia RX-51 board
> > Revision        : 0012
> >=20
> > New DT boot provides this:
> >=20
> > Hardware        : Generic OMAP3 (Flattened Device Tree)
> > Revision        : 0000
>=20
> Oh you can easily fix that by adding a n900 specific
> DT_MACHINE_START entry to mach-omap2/board-generic.c.
>=20

I would like to see some solution which does not depend on=20
distributing addition patch which will not be in mainline=20
kernel...

=46or this problem I proposed patch (which was rejected):=20
https://lkml.org/lkml/2014/6/18/853

Basically Hardware is used to check if application is running on=20
Nokia N900 or not. Also entry from Hardware is appended to Web=20
browser user agent and some internet services using it as=20
identifier (N900 device).

> The revision entry you can populate too in pdata-quirks.c,
> or maybe add something generic to populate it based on the
> cmdline or a dts entry as I believe that comes from the
> legacy ATAGs. I think that's just the system_rev or some
> other *_rev global in the kernel.
>=20
> Regards,
>=20
> Tony

Revision comes from bootloader (via ATAG) and it is HW revision=20
of N900 device. It cannot be hardcoded into kernel or DTS as it=20
it depends on HW.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1702352.Kss0k1jQFy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlR2KFsACgkQi/DJPQPkQ1JZFACdGgMCaWKN8wxfAlcCiMp1G0MV
7YUAoJWfUYYgYfWEM8EwYl9jObU9qA1J
=fmgJ
-----END PGP SIGNATURE-----

--nextPart1702352.Kss0k1jQFy--

From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Thu, 27 Nov 2014 00:01:44 +0100
Message-ID: <201411270001.44871@pali>
References: <20141027200008.GR2560@atomide.com> <201411262022.03338@pali> <20141126200806.GO2817@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2062931.yiNpufyFR2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:43040 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbaKZXBs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2014 18:01:48 -0500
Received: by mail-wi0-f177.google.com with SMTP id l15so6578574wiw.4
        for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2014 15:01:46 -0800 (PST)
In-Reply-To: <20141126200806.GO2817@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--nextPart2062931.yiNpufyFR2
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 26 November 2014 21:08:06 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [141126 11:24]:
> > On Wednesday 26 November 2014 20:10:28 Tony Lindgren wrote:
> > > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [141126 10:59]:
> > > > On Wednesday 26 November 2014 19:19:35 Tony Lindgren=20
wrote:
> > > > > Maybe Pali can try to restart that discussion? To me
> > > > > it seems the /proc/cpuinfo should be the same as it's
> > > > > a user interface. Sorry forgot the details of the
> > > > > previous discussion..
> > > >=20
> > > > Yes, two days ago I again wrote emails about this
> > > > problem...
> > > >=20
> > > > E.g. one of them, see:
> > > > https://lkml.org/lkml/2014/11/24/774
> > > >=20
> > > > > And with which app was that? Sorry I forgot..
> > > >=20
> > > > More applications/libraries for N900 which running on
> > > > Maemo 5 system. Some of them are Nokia proprietary,
> > > > some of them are open source and some are mine.
> > > >=20
> > > > Basically problem is that non DT boot provides this info
> > > > in /proc/cpuinfo:
> > > >=20
> > > > Hardware        : Nokia RX-51 board
> > > > Revision        : 0012
> > > >=20
> > > > New DT boot provides this:
> > > >=20
> > > > Hardware        : Generic OMAP3 (Flattened Device Tree)
> > > > Revision        : 0000
> > >=20
> > > Oh you can easily fix that by adding a n900 specific
> > > DT_MACHINE_START entry to mach-omap2/board-generic.c.
> >=20
> > I would like to see some solution which does not depend on
> > distributing addition patch which will not be in mainline
> > kernel...
>=20
> Yes mainline of course. Maybe you misunderstood what I was
> suggesting, maybe try the attached patch to fix the "Hardware"
> line problem in /proc/cpuinfo?
>=20

With your patch I'm getting:

Hardware        : Nokia RX-51 board

So patch is good.

> > For this problem I proposed patch (which was rejected):
> > https://lkml.org/lkml/2014/6/18/853
>=20
> Yes I think that should continue as a separate discussion
> too if there are other differences in /proc/cpuinfo.
>=20
> > Basically Hardware is used to check if application is
> > running on Nokia N900 or not. Also entry from Hardware is
> > appended to Web browser user agent and some internet
> > services using it as identifier (N900 device).
> >=20
> > > The revision entry you can populate too in pdata-quirks.c,
> > > or maybe add something generic to populate it based on the
> > > cmdline or a dts entry as I believe that comes from the
> > > legacy ATAGs. I think that's just the system_rev or some
> > > other *_rev global in the kernel.
> >=20
> > Revision comes from bootloader (via ATAG) and it is HW
> > revision of N900 device. It cannot be hardcoded into kernel
> > or DTS as it it depends on HW.
>=20
> Well for the "Revision" line problem, we could pass the
> revision in cmdline or .dts if not passed in the legacy
> ATAGs. It sounds like were just not copying it to system_rev
> for DT based booting? Maybe it's just some missing
> CONFIG_ATAG option that needs to be enabled?
>=20
> Regards,
>=20
> Tony
>=20

Yes it looks like DT code does not read Revision ATAG... I tried=20
to enable everything but always same problem...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2062931.yiNpufyFR2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlR2W9gACgkQi/DJPQPkQ1LsBACgy6xghnNsdh84qt/6WOPKRZMj
nAUAnRoAQ2S/zK+qUMEj9HNPtjtuGBZs
=q0uP
-----END PGP SIGNATURE-----

--nextPart2062931.yiNpufyFR2--

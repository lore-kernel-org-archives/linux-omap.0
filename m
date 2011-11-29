From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [GIT PULL] DSS fixes for v3.2-rc2
Date: Tue, 29 Nov 2011 10:12:27 +0200
Message-ID: <1322554347.1869.6.camel@deskari>
References: <20111123235542.GL31337@atomide.com>
	 <201111241606.54879.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-NxjAoynoc00xD5Tyd/K6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:57984 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752055Ab1K2IMh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Nov 2011 03:12:37 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id l5so1275548lah.33
        for <linux-omap@vger.kernel.org>; Tue, 29 Nov 2011 00:12:35 -0800 (PST)
In-Reply-To: <201111241606.54879.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


--=-NxjAoynoc00xD5Tyd/K6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-11-24 at 16:06 +0000, Arnd Bergmann wrote:
> On Wednesday 23 November 2011, Tony Lindgren wrote:
> > Hi Arnd,
> >=20
> > This one has been separated out from the rest of the fixes.
>=20
> Pulled into the fixes branch now. I'll send out the branch
> after testing it on tomorrow's linux-next.
>=20
> > If some of these need to go to stable, then Tomi should
> > do the rebasing and send them to stable@vger.kernel.org
> > as they don't apply cleanly on v3.1.
>=20
> Ok. I've taken Tomi on Cc as a reminder for him, although I guess
> you already discussed it with him.

I don't think we need these in 3.1 stable. The omapdss driver in 3.1
contains hacks to circumvent the HWMOD issues the patches below fix.
These hacks were removed for 3.2.

Well, the "ARM: OMAP2PLUS: DSS: Ensure DSS works correctly..." patch
could be used for 3.1 also, but I fear it depends on HWMOD and DSS
patches missing from 3.1. I'll check it out.

 Tomi

>=20
> Kiitoksia paljon,
>=20
> 	Arnd
>=20
> >=20
> > The following changes since commit cfcfc9eca2bcbd26a8e206baeb005b055dbf=
8e37:
> >   Linus Torvalds (1):
> >         Linux 3.2-rc2
> >=20
> > are available in the git repository at:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes=
-dss
> >=20
> > Archit Taneja (1):
> >       ARM: OMAP2PLUS: DSS: Ensure DSS works correctly if display is ena=
bled in bootloader
> >=20
> > Tomi Valkeinen (9):
> >       ARM: OMAP2xxx: HWMOD: Fix DSS reset
> >       ARM: OMAP2xxx: HWMOD: fix DSS clock data
> >       ARM: OMAP3: HWMOD: Fix DSS reset
> >       ARM: OMAP3: HWMOD: fix DSS clock data
> >       ARM: OMAP4: HWMOD: remove extra clocks
> >       ARM: OMAP4: HWMOD: Add HWMOD_CONTROL_OPT_CLKS_IN_RESET for dss_co=
re
> >       ARM: OMAP4: HWMOD: fix DSS clock data
> >       ARM: OMAP2/3: HWMOD: Add SYSS_HAS_RESET_STATUS for dss
> >       ARM: OMAP: HWMOD: Unify DSS resets for OMAPs
> >=20
> > Tony Lindgren (1):
> >       Merge branch 'hwmod_dss_fixes_3.2rc' of git://git.pwsan.com/linux=
-2.6 into fixes-dss
> >=20
> >  arch/arm/mach-omap2/Makefile                       |    5 +-
> >  arch/arm/mach-omap2/display.c                      |  159 ++++++++++++=
++++++++
> >  arch/arm/mach-omap2/display.h                      |   29 ++++
> >  arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   17 ++-
> >  arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   17 ++-
> >  .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    5 +-
> >  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   37 ++++-
> >  arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   24 ++--
> >  arch/arm/mach-omap2/omap_hwmod_common_data.c       |    4 +
> >  arch/arm/mach-omap2/omap_hwmod_common_data.h       |    4 +
> >  arch/arm/plat-omap/include/plat/common.h           |    3 +
> >  include/video/omapdss.h                            |    7 -
> >  12 files changed, 276 insertions(+), 35 deletions(-)
> >  create mode 100644 arch/arm/mach-omap2/display.h
> >=20
>=20


--=-NxjAoynoc00xD5Tyd/K6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO1JPrAAoJEPo9qoy8lh71+9oP/RNKQHAUBPhm7DIvhfHpM3r0
tGoBak3BZFxpt6ttr5AwXgKykBIMI1ufXnjUbtSXgZPKj512DTHggMFiY4x4ydRI
mQzCIv4ag163JXsh/g4vo/jXBF1KWgapE/RlofFwRLk3Mo0snodlzUCSWwnB+HHD
r/lGpzQZzWzL+bqV4OaByvOSIoDxZinKV83bLindSXpW/7PK4m0v6+GN0rQowTMq
dO3RXI32h1Mbr4PH712JpiexBJC/rk/mvxmabQSVlFhZQaY8tnjMueglYg7kJ8Qb
+RKWH6TZU9/0g8DqcVJUTNJNVhi3pDERgLCStRI7JkFk/bUtktphGmBEkUVIIhkE
jyQ+rEZ0oY140Ci5+ImdlYvaD3Dy8kHvYmO3IGLvMT55iaUNKqX3Qsvb/RIRuFTJ
hmAeOYlK+XJop4MSmHhXJ98hMe5qoFpQE5GUw4EIn//iaN/cqtDNq/OOXXMxg8GJ
t65+RFqNdfwgv23wk8ozKq+YnTzNRJuajz/nWBzDvksbwtj6sewVNK/k1YfLn6JN
g8AOxwdUUo53gm+iKv82LadLOIfH3LEOyyEZMGBanBW12KzQHuQlLSxht27SFyKc
ky3nizNj9c9H69f5DBmWacMvM4McBNmMaSSReKmFv5JWCUCaHBbQNv+wtxeoSE8E
qEKjqwoYgEfmP+543x5B
=t2Rp
-----END PGP SIGNATURE-----

--=-NxjAoynoc00xD5Tyd/K6--


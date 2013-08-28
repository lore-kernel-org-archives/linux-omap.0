From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [GIT PULL] OMAPDSS: use new display drivers
Date: Wed, 28 Aug 2013 10:52:11 +0300
Message-ID: <521DAC2B.4080100@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="6oB06CfWbXxpLAqSxU0m17Ugnca2eKf9I"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54077 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753977Ab3H1Hwh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Aug 2013 03:52:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

--6oB06CfWbXxpLAqSxU0m17Ugnca2eKf9I
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Here's a pull request for the board file changes to take the new display
drivers into use.

If there's an "early" pull request going to Linus during the merge window=
, it'd
be nice to have these in that request. That would give me time to send a =
pull
request to Linus containing removal of the old, no longer used, drivers.

 Tomi

The following changes since commit b36f4be3de1b123d8601de062e7dbfc904f305=
fb:

  Linux 3.11-rc6 (2013-08-18 14:36:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git 3.12/linu=
x-omap

for you to fetch changes up to d7b8eafbf513e414fa09dde61630b93be93a23a1:

  ARM: OMAP2+: Remove old display drivers from omap2plus_defconfig (2013-=
08-28 10:23:22 +0300)

----------------------------------------------------------------
Tomi Valkeinen (20):
      ARM: OMAP2+: Remove legacy DSS initialization for omap4
      ARM: OMAP2+: Add selected display drivers to omap2plus_defconfig
      ARM: OMAP: dss-common: use new display drivers
      ARM: OMAP: 4430SDP: remove picodlp device data
      ARM: OMAP: overo: use new display drivers
      ARM: OMAP: rx51: use new display drivers
      ARM: OMAP: beagle: use new display drivers
      ARM: OMAP: devkit8000: use new display drivers
      ARM: OMAP: 2430SDP: use new display drivers
      ARM: OMAP: LDP: use new display drivers
      ARM: OMAP: omap3stalker: use new display drivers
      ARM: OMAP: igep0020: use new display drivers
      ARM: OMAP: cm-t35: use new display drivers
      ARM: OMAP: H4: use new display drivers
      ARM: OMAP: 3430SDP: use new display drivers
      ARM: OMAP: OMAP3EVM: use new display drivers
      ARM: OMAP: Pandora: use new display drivers
      ARM: OMAP: Zoom: use new display drivers
      ARM: OMAP: AM3517EVM: use new display drivers
      ARM: OMAP2+: Remove old display drivers from omap2plus_defconfig

 arch/arm/configs/omap2plus_defconfig         |  12 +-
 arch/arm/mach-omap2/board-2430sdp.c          |  57 ++++---
 arch/arm/mach-omap2/board-3430sdp.c          |  83 +++++----
 arch/arm/mach-omap2/board-am3517evm.c        | 113 +++++++++----
 arch/arm/mach-omap2/board-cm-t35.c           | 100 +++++++----
 arch/arm/mach-omap2/board-devkit8000.c       |  96 +++++++----
 arch/arm/mach-omap2/board-h4.c               |  48 ++++--
 arch/arm/mach-omap2/board-igep0020.c         |  36 ++--
 arch/arm/mach-omap2/board-ldp.c              |  68 +++++---
 arch/arm/mach-omap2/board-omap3beagle.c      |  56 +++---
 arch/arm/mach-omap2/board-omap3evm.c         |  87 ++++++----
 arch/arm/mach-omap2/board-omap3pandora.c     |  48 +++---
 arch/arm/mach-omap2/board-omap3stalker.c     |  61 ++++---
 arch/arm/mach-omap2/board-overo.c            | 160 +++++++++++-------
 arch/arm/mach-omap2/board-rx51-peripherals.c |  12 ++
 arch/arm/mach-omap2/board-rx51-video.c       |  35 ++--
 arch/arm/mach-omap2/board-zoom-display.c     |  30 ++--
 arch/arm/mach-omap2/dss-common.c             | 244 ++++++++++++---------=
------
 arch/arm/mach-omap2/dss-common.h             |   2 -
 19 files changed, 787 insertions(+), 561 deletions(-)


--6oB06CfWbXxpLAqSxU0m17Ugnca2eKf9I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSHawrAAoJEPo9qoy8lh71IGIQAKpjh+VcEwa6zb1j8y1fWe2U
lhQlCSyR00WLaRg9cee2l4KuZHShP5fNPnPzifpzkbgwhyakeay2v6aTnpy+plzc
Jwu7sQ8W04m6zkLDUhgrUvP5c5EPA1Zs5Tmj+5r/8OEE39ujP/8eXK/acqCLfBdf
5/4M1MTar0doNs/szhtWrMvi8V2AMi026amLNOVaRFO+7PxGpADaYZL154LtHklr
a9wuGNDQ3GL11yF73j4HBR6kKFTF1DavZmMJ1HdtA9CEXIYc4jPCYfncDIrv0vVX
dynnMaSI5eQJdHwI/OfRGWd/SUJNWNo4O8h1VdvCXRZ8TXMKNxG70ufAd3J+9h6c
gVEG0GiS1SQV5EEcaP90TS5IXN4G+Po8zZn7ncOPQbemX5y3RhiDI/f6NSzznKqL
eDrzNDiouygCDREZMyHdY4HUQtQ1TS97+PJ8SichKDSHTS57G9zYjZU1GShlCb4Q
J6U2TZnuSP3vN1d+vxyeh50ErSGRMa5zoAdKBFIeENS4oofqdoqXKsb0zwCnBM6R
n+2Ro4Elb6QQb5jqhK8Z8FPsHhGV+gQX+cCB7VZdaIi+lEXy4cwONB6RWS7cvdX0
aiwrR/tJQZBBmAPr4fE60sgvJThoSS4ebN48pQm4T3AXoWaJEuzsGmZ3XBBSQU5A
294rgoiJhbnrqSgAT8jh
=T5Bg
-----END PGP SIGNATURE-----

--6oB06CfWbXxpLAqSxU0m17Ugnca2eKf9I--

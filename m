From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: CM/SCM: clean up direct register accesses
Date: Sat, 19 Oct 2013 17:11:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310191709220.11676@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48917 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056Ab3JSRLG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Oct 2013 13:11:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe680af:

  Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.13/cm-scm-cleanup-a

for you to fetch changes up to 49e03402327ab69a26f604398982ef14123900a2:

  ARM: OMAP3: control: add API for setting IVA bootmode (2013-10-19 10:11:52 -0600)

- ----------------------------------------------------------------
Move some of the OMAP2+ CM and System Control Module direct
register accesses into CM- and System Control
Module-specific "drivers" underneath arch/arm/mach-omap2/.  This
is a prerequisite for moving this code out of arch/arm/mach-omap2/ into
drivers/.

Basic test logs are available here:

http://www.pwsan.com/omap/testlogs/cm_scm_cleanup_a_v3.13/20131019101809/

- ----------------------------------------------------------------
Tero Kristo (5):
      ARM: OMAP2: CM/PM: remove direct register accesses outside CM code
      ARM: OMAP3: clock: add API to enable/disable autoidle for a single clock
      ARM: OMAP3: McBSP: do not access CM register directly
      ARM: OMAP3: CM/control: move CM scratchpad save to CM driver
      ARM: OMAP3: control: add API for setting IVA bootmode

 arch/arm/mach-omap2/clkt2xxx_apll.c          |  4 +-
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c      | 11 ++---
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c | 24 +++-------
 arch/arm/mach-omap2/clock.c                  | 38 ++++++++++++++++
 arch/arm/mach-omap2/clock.h                  |  2 +
 arch/arm/mach-omap2/cm2xxx.c                 | 67 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cm2xxx.h                 |  8 ++++
 arch/arm/mach-omap2/cm3xxx.c                 | 22 +++++++++
 arch/arm/mach-omap2/cm3xxx.h                 |  1 +
 arch/arm/mach-omap2/control.c                | 54 +++++++---------------
 arch/arm/mach-omap2/control.h                |  1 +
 arch/arm/mach-omap2/mcbsp.c                  | 16 +++----
 arch/arm/mach-omap2/pm24xx.c                 | 24 +---------
 arch/arm/mach-omap2/pm34xx.c                 |  3 +-
 14 files changed, 177 insertions(+), 98 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSYrwzAAoJEMePsQ0LvSpLAZoP/AkIs74RMF42SmWCfmhPHyz9
PiUI6AFchOHLoRPf06vZcVylFPH3Tyb6GvNrB+tlmdJ8K7hsJjHJW4JMsnL6jZlN
53Yhe9Ij/7Ydnat8D21dVFj+NX7Sks/qoqwMPDIa9BcLTvGZ9ruOpAWZQcK8qdRz
BaWM8uQeQXt0/Asgy+qJW2Rn9YwyGLaDQBOduSsidC6Jl5mk4rrRr1wBHkmjAfvn
g41/7ehbzt6BUFMn0hWy2x47bWv+LH5oJlrKr8X7Ocu7bgZC8H6dcAgMho6fdTe8
fIJAuCHs7X+tAYXtVoMBzm3bRIrr59x25PULVzzEkzj1B8q7e0y6AdB87aPIo4Yg
ebREEq5S+iWdniWvGNCqK5pKXeeAIPjWLVaGbDsFx1POq5JsvBNtlt1zCCGU73/S
wK9J15POnrHjeyDQZha2w+sdAxT8kj/EbTXakehPLkX1hW/vc7PZIbd4X6ws/Dsk
nPTuoI0IYARJK1T6vRJKfqyilAOFVjvjMB1yngTHMuN/wxUeJtjdiP/KnWv2EDGv
a2IKRf1dJpA9x6naLOeV3aSYsiB7KE+fvcLNuFsiyU6Kv9NVfNS9w86mr/AVfUAX
TsNTPVfkiAuqmCFRFkVHq7wyL8edx8dMeJewUlb5sxx/0awabHASpPz5x7OPnOaw
Yf1XC+AecmxJoAuLO/nG
=xSrk
-----END PGP SIGNATURE-----

From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: first set of PRM/CM cleanups for 3.8
Date: Sun, 21 Oct 2012 19:13:34 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210211912410.26128@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54758 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480Ab2JUTNe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Oct 2012 15:13:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:

  Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-cleanup-a-for-3.8

for you to fetch changes up to 2bb2a5d30abb0dc99d074877bfad2056142c730b:

  ARM: OMAP2+: PRM: create PRM reset source API for the watchdog timer driver (2012-10-21 01:01:13 -0600)

- ----------------------------------------------------------------
The first set of OMAP PRM/CM-related cleanup patches for 3.8.
Prepares for the future move of the PRM/CM code to drivers/.  Also
includes some prcm.[ch] cleanup patches from the WDTIMER cleanup
series that don't need external acks.

Basic test logs for this branch on top of v3.7-rc2 are here:

http://www.pwsan.com/omap/testlogs/prcm_cleanup_a_3.8/20121021123719/

But due to the number of unrelated regressions present in v3.7-rc[12],
it's not particularly usable as a testing base.  With reverts, fixes,
and workarounds applied as documented in:

http://www.pwsan.com/omap/testlogs/test_v3.7-rc2/20121020134755/README.txt

the following test logs were obtained:

http://www.pwsan.com/omap/testlogs/prcm_cleanup_a_3.8/20121020231757/

which indicate that the series tests cleanly.

- ----------------------------------------------------------------

vmlinux object size
(delta in bytes from test_v3.7-rc2 (6f0c0580b70c89094b3422ba81118c7b959c7556)):
   text     data      bss    total  kernel
   +112        0        0     +112  am33xx_only
  -1740     -104        0    -1844  n800_multi_omap2xxx
  -1648      -80        0    -1728  n800_only_a
    +80        0        0      +80  omap1_defconfig
    +32        0        0      +32  omap1_defconfig_1510innovator_only
    +80        0        0      +80  omap1_defconfig_5912osk_only
   +912      +64        0     +976  omap2plus_defconfig
  -1836     -112        0    -1948  omap2plus_defconfig_2430sdp_only
   +912     +136        0    +1048  omap2plus_defconfig_cpupm
   +896      +64        0     +960  omap2plus_defconfig_no_pm
  -6004      -80      +64    -6020  omap2plus_defconfig_omap2_4_only
   -428      -56        0     -484  omap2plus_defconfig_omap3_4_only
   -888     -136        0    -1024  rmk_omap3430_ldp_oldconfig
   +200      +56        0     +256  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.7-rc2 (6f0c0580b70c89094b3422ba81118c7b959c7556))
  avail  rsrvd   high  freed  board          kconfig
     8k    -8k      .      .  2420n800       omap2plus_defconfig
    -8k     8k      .      .  am335xbone     omap2plus_defconfig


Paul Walmsley (9):
      ARM: OMAP2+: PRM: remove PRM weak functions
      ARM: OMAP2+: PRM: split PRM functions into OMAP2, OMAP3-specific files
      ARM: OMAP2+: powerdomain/PRM: move the low-level powerdomain functions into PRM
      ARM: OMAP2+: CM/hwmod: split CM functions into OMAP2, OMAP3-specific files
      ARM: OMAP2/3: clockdomain/PRM/CM: move the low-level clockdomain functions into PRM/CM
      ARM: OMAP2+: PRM: prepare for use of prm_ll_data function pointers
      ARM: OMAP2+: CM: prepare for use of cm_ll_data function pointers
      ARM: OMAP1: create read_reset_sources() function (for initial use by watchdog)
      ARM: OMAP2+: PRM: create PRM reset source API for the watchdog timer driver

 arch/arm/mach-omap1/common.h                    |    2 +
 arch/arm/mach-omap1/reset.c                     |   38 +++
 arch/arm/mach-omap2/Makefile                    |  110 ++++---
 arch/arm/mach-omap2/clkt2xxx_apll.c             |    2 +-
 arch/arm/mach-omap2/clkt2xxx_dpll.c             |    2 +-
 arch/arm/mach-omap2/clock.c                     |    3 +-
 arch/arm/mach-omap2/clock2420_data.c            |    2 +-
 arch/arm/mach-omap2/clock2430.c                 |    2 +-
 arch/arm/mach-omap2/clock2430_data.c            |    2 +-
 arch/arm/mach-omap2/clock34xx.c                 |    2 +-
 arch/arm/mach-omap2/clock3517.c                 |    2 +-
 arch/arm/mach-omap2/clock3xxx_data.c            |    2 +-
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c      |  339 -------------------
 arch/arm/mach-omap2/clockdomain33xx.c           |   74 -----
 arch/arm/mach-omap2/clockdomain44xx.c           |  151 ---------
 arch/arm/mach-omap2/cm.h                        |   12 +
 arch/arm/mach-omap2/cm2xxx.c                    |  255 ++++++++++++++
 arch/arm/mach-omap2/cm2xxx.h                    |   66 ++++
 arch/arm/mach-omap2/cm2xxx_3xxx.h               |  119 +++----
 arch/arm/mach-omap2/cm33xx.c                    |   56 ++++
 arch/arm/mach-omap2/{cm2xxx_3xxx.c => cm3xxx.c} |  307 +++++++++--------
 arch/arm/mach-omap2/cm3xxx.h                    |   86 +++++
 arch/arm/mach-omap2/cm_common.c                 |   71 ++++
 arch/arm/mach-omap2/cminst44xx.c                |  142 +++++++-
 arch/arm/mach-omap2/control.c                   |    4 +-
 arch/arm/mach-omap2/omap_hwmod.c                |   51 ++-
 arch/arm/mach-omap2/pm24xx.c                    |    4 +-
 arch/arm/mach-omap2/pm34xx.c                    |    5 +-
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c      |  242 --------------
 arch/arm/mach-omap2/powerdomain33xx.c           |  229 -------------
 arch/arm/mach-omap2/powerdomain44xx.c           |  285 ----------------
 arch/arm/mach-omap2/prm-regbits-24xx.h          |    6 +-
 arch/arm/mach-omap2/prm-regbits-34xx.h          |   12 +-
 arch/arm/mach-omap2/prm.h                       |   53 +++
 arch/arm/mach-omap2/prm2xxx.c                   |  126 +++++++
 arch/arm/mach-omap2/prm2xxx.h                   |  132 ++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.c              |  332 +++++++------------
 arch/arm/mach-omap2/prm2xxx_3xxx.h              |  277 ++++------------
 arch/arm/mach-omap2/prm33xx.c                   |  202 ++++++++++++
 arch/arm/mach-omap2/prm3xxx.c                   |  403 +++++++++++++++++++++++
 arch/arm/mach-omap2/prm3xxx.h                   |  160 +++++++++
 arch/arm/mach-omap2/prm44xx.c                   |  355 +++++++++++++++++++-
 arch/arm/mach-omap2/prm44xx.h                   |    2 +
 arch/arm/mach-omap2/prm_common.c                |  104 +++---
 arch/arm/mach-omap2/sdrc2xxx.c                  |    2 +-
 arch/arm/mach-omap2/sleep34xx.S                 |    4 +-
 arch/arm/mach-omap2/sram242x.S                  |    4 +-
 arch/arm/mach-omap2/sram243x.S                  |    4 +-
 arch/arm/mach-omap2/sram34xx.S                  |    2 +-
 49 files changed, 2750 insertions(+), 2097 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
 delete mode 100644 arch/arm/mach-omap2/clockdomain33xx.c
 delete mode 100644 arch/arm/mach-omap2/clockdomain44xx.c
 create mode 100644 arch/arm/mach-omap2/cm2xxx.c
 create mode 100644 arch/arm/mach-omap2/cm2xxx.h
 rename arch/arm/mach-omap2/{cm2xxx_3xxx.c => cm3xxx.c} (72%)
 create mode 100644 arch/arm/mach-omap2/cm3xxx.h
 create mode 100644 arch/arm/mach-omap2/cm_common.c
 delete mode 100644 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
 delete mode 100644 arch/arm/mach-omap2/powerdomain33xx.c
 delete mode 100644 arch/arm/mach-omap2/powerdomain44xx.c
 create mode 100644 arch/arm/mach-omap2/prm2xxx.c
 create mode 100644 arch/arm/mach-omap2/prm2xxx.h
 create mode 100644 arch/arm/mach-omap2/prm3xxx.c
 create mode 100644 arch/arm/mach-omap2/prm3xxx.h
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhEkXAAoJEMePsQ0LvSpL5MQQAIep02VYn26LnKRaU34Oy6wW
zMpr8G1kPr+u6suoIylHceSQ8EKN72Icj1BpOCBENOtMkzy8YRsUBLy4+Olz6QEd
jttGKqfpK9OEBD1vTrU4OFAN5u481SlyM4EH4GnybfEf6PZBNiTMvW5cYYORxavF
GP91XJ7h0whUWLd241Elf7lkylOThrE1i7TRbQ/aSsR2TjQu0+j0Z85+hClb7tfj
Jgzzk8c6gYZ3xxye0Wa6+nZmnDrpzLtgqgQk/gwDUB1wXr4QRvnhwgVYMfcdrdDC
hySU/xlMEJPHKLCeiuh8C55XIOq6D+osIq75V9GiAWahIxjIuOgsFyfQnH7dbUp0
kFiC8gchOYTyXJzekqAnT37bD/a5UdVM7b9LoApayUKaOj+J931ArmgF65Phie0t
A8Drm27i973i65I5NYMaiHzEpV/flS6uGbvQGhzT1Lj962rst38wr+Tu+6byuqlJ
oo1at5ArBD32sXjaS0XDWJvbuk8htwGGF64VaL9gJKV/eovqPJjZ4/Qcaa+BNJHj
JlRigV2WWwXH8JZ4mDy6uMj6VWCDp24LHlQoyoErRVYNnLqZsQNYJVaN3LmEsYeR
Ccf6ortZ8Q5Hhbpxm6XJKAYHn8IWLvzZ9fIBB7wLAez3beNzYGpAJ8g0xq1updIU
mU00eXz6MpjI05wLMzkv
=Rcv0
-----END PGP SIGNATURE-----

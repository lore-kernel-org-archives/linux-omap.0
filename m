From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP: second set of PRCM cleanups for 3.8
Date: Thu, 1 Nov 2012 12:17:10 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211011216130.26661@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54652 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759260Ab2KAMRL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Nov 2012 08:17:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit 7fc54fd3084457c7f11b9e2e1e3fcd19a3badc33:

  Merge branch 'omap-for-v3.8/cleanup-headers' into omap-for-v3.8/cleanup-prcm (2012-10-26 13:32:22 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-cleanup-b-for-3.8

for you to fetch changes up to f17d60d20eb8e679cdd1e9d507394237e58ce0d8:

  ARM: OMAP2+: PRCM: remove obsolete prcm.[ch] (2012-11-01 04:48:18 -0600)

- ----------------------------------------------------------------
Second set of OMAP PRCM cleanups for 3.8.

These patches remove the use of omap_prcm_get_reset_sources() from the
OMAP watchdog driver, and remove mach-omap2/prcm.c and
plat-omap/include/plat/prcm.h.

Basic test logs for this branch on top of Tony's cleanup-prcm branch
at commit 7fc54fd3084457c7f11b9e2e1e3fcd19a3badc33 are here:

    http://www.pwsan.com/omap/testlogs/prcm_cleanup_b_3.8/20121101044824/

However, cleanup-prcm at 7fc54fd3 does not build for several
Kconfigs here and doesn't include some fixes that are needed for
a successful test.  With several reverts, fixes, and workarounds
applied, the following test logs were obtained:

    http://www.pwsan.com/omap/testlogs/TEST_prcm_cleanup_b_3.8/20121101045401/

 which indicate that the series tests cleanly.

- ----------------------------------------------------------------

vmlinux object size
(delta in bytes from test_cleanup-prcm_7fc54fd_v3.7-rc (7fc54fd3084457c7f11b9e2e1e3fcd19a3badc33)):
   text     data      bss    total  kernel
   -252      -56        0     -308  am33xx_only
    +16      -56        0      -40  n800_multi_omap2xxx
   +232      -24        0     +208  n800_only_a
    +88      -24        0      +64  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
   +132       -8        0     +124  omap1_defconfig_5912osk_only
   +652     -224        0     +428  omap2plus_defconfig
   +200      -24        0     +176  omap2plus_defconfig_2430sdp_only
   +652     -232        0     +420  omap2plus_defconfig_cpupm
   +708     -248        0     +460  omap2plus_defconfig_no_pm
   +200     -136        0      +64  omap2plus_defconfig_omap2_4_only
  +4316     -128        0    +4188  omap2plus_defconfig_omap3_4_only
   +196      -56        0     +140  rmk_omap3430_ldp_oldconfig
    +60      -56        0       +4  rmk_omap4430_sdp_oldconfig

Paul Walmsley (17):
      ARM: OMAP1: CGRM: fix omap1_get_reset_sources() return type
      ARM: OMAP2+: WDT: move init; add read_reset_sources pdata function pointer
      watchdog: OMAP: use standard GETBOOTSTATUS interface; use platform_data fn ptr
      ARM: OMAP2+: PRCM: remove omap_prcm_get_reset_sources()
      ARM: OMAP2+: common: remove mach-omap2/common.c globals and map_common_io code
      ARM: OMAP2/3: PRM: add SoC reset functions (using the CORE DPLL method)
      ARM: OMAP2xxx: clock: remove global 'dclk' variable
      ARM: OMAP2xxx: clock: move virt_prcm_set code into clkt2xxx_virt_prcm_set.c
      ARM: OMAP2+: PRCM: create SoC-specific chip restart functions
      ARM: OMAP2+: board files: use SoC-specific system restart functions
      ARM: OMAP2xxx: APLL/CM: convert to use omap2_cm_wait_module_ready()
      ARM: OMAP2+: CM/clock: convert _omap2_module_wait_ready() to use SoC-independent CM functions
      ARM: OMAP2+: PRCM: remove omap2_cm_wait_idlest()
      ARM: OMAP2+: PRCM: split and relocate the PRM/CM globals setup
      ARM: OMAP2+: PRCM: consolidate PRCM-related timeout macros
      ARM: OMAP2+: hwmod: call to _omap4_disable_module() should use the SoC-specific call
      ARM: OMAP2+: PRCM: remove obsolete prcm.[ch]

 arch/arm/mach-omap1/common.h                 |    2 +-
 arch/arm/mach-omap1/devices.c                |   21 ++-
 arch/arm/mach-omap1/reset.c                  |    9 +-
 arch/arm/mach-omap2/Makefile                 |    7 +-
 arch/arm/mach-omap2/am33xx.h                 |    1 +
 arch/arm/mach-omap2/board-2430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-3630sdp.c          |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-am3517crane.c      |    2 +-
 arch/arm/mach-omap2/board-am3517evm.c        |    2 +-
 arch/arm/mach-omap2/board-apollon.c          |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c           |   18 +--
 arch/arm/mach-omap2/board-cm-t3517.c         |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c       |    2 +-
 arch/arm/mach-omap2/board-generic.c          |   10 +-
 arch/arm/mach-omap2/board-h4.c               |    2 +-
 arch/arm/mach-omap2/board-igep0020.c         |    4 +-
 arch/arm/mach-omap2/board-ldp.c              |    2 +-
 arch/arm/mach-omap2/board-n8x0.c             |    6 +-
 arch/arm/mach-omap2/board-omap3beagle.c      |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
 arch/arm/mach-omap2/board-omap3logic.c       |    4 +-
 arch/arm/mach-omap2/board-omap3pandora.c     |    2 +-
 arch/arm/mach-omap2/board-omap3stalker.c     |    2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c   |    2 +-
 arch/arm/mach-omap2/board-omap4panda.c       |    2 +-
 arch/arm/mach-omap2/board-overo.c            |    2 +-
 arch/arm/mach-omap2/board-rm680.c            |    4 +-
 arch/arm/mach-omap2/board-rx51.c             |    2 +-
 arch/arm/mach-omap2/board-ti8168evm.c        |    4 +-
 arch/arm/mach-omap2/board-zoom.c             |    4 +-
 arch/arm/mach-omap2/clkt2xxx_apll.c          |   57 ++------
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c      |   36 ++++-
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |   70 ++++++++--
 arch/arm/mach-omap2/clkt_iclk.c              |    1 -
 arch/arm/mach-omap2/clock.c                  |   15 +-
 arch/arm/mach-omap2/clock.h                  |   28 ----
 arch/arm/mach-omap2/clock2420_data.c         |   26 +---
 arch/arm/mach-omap2/clock2430_data.c         |   26 +---
 arch/arm/mach-omap2/clock2xxx.c              |   16 ---
 arch/arm/mach-omap2/clock2xxx.h              |    9 +-
 arch/arm/mach-omap2/cm-regbits-24xx.h        |    2 +
 arch/arm/mach-omap2/cm.h                     |   20 ++-
 arch/arm/mach-omap2/cm2xxx.c                 |  128 ++++++++++++++++-
 arch/arm/mach-omap2/cm2xxx.h                 |    4 +
 arch/arm/mach-omap2/cm2xxx_3xxx.h            |    8 +-
 arch/arm/mach-omap2/cm3xxx.c                 |   66 +++++++++
 arch/arm/mach-omap2/cm3xxx.h                 |    5 +
 arch/arm/mach-omap2/cm_common.c              |   70 +++++++++-
 arch/arm/mach-omap2/cminst44xx.h             |    2 +
 arch/arm/mach-omap2/common.c                 |  183 -------------------------
 arch/arm/mach-omap2/common.h                 |  125 +++++------------
 arch/arm/mach-omap2/control.c                |   10 +-
 arch/arm/mach-omap2/control.h                |    2 +
 arch/arm/mach-omap2/cpuidle34xx.c            |    1 -
 arch/arm/mach-omap2/devices.c                |   26 ----
 arch/arm/mach-omap2/display.c                |    2 +-
 arch/arm/mach-omap2/hdq1w.c                  |    4 +-
 arch/arm/mach-omap2/i2c.c                    |    6 +-
 arch/arm/mach-omap2/id.c                     |    7 +-
 arch/arm/mach-omap2/io.c                     |   86 ++++++++++--
 arch/arm/mach-omap2/mcbsp.c                  |    2 +-
 arch/arm/mach-omap2/msdi.c                   |    4 +-
 arch/arm/mach-omap2/omap2-restart.c          |   65 +++++++++
 arch/arm/mach-omap2/omap3-restart.c          |   36 +++++
 arch/arm/mach-omap2/omap4-common.c           |   18 +++
 arch/arm/mach-omap2/omap_hwmod.c             |    8 +-
 arch/arm/mach-omap2/pm34xx.c                 |    1 -
 arch/arm/mach-omap2/powerdomain.c            |    2 -
 arch/arm/mach-omap2/prcm-common.h            |   22 ---
 arch/arm/mach-omap2/prcm.c                   |  189 --------------------------
 arch/arm/mach-omap2/prcm_mpu44xx.c           |   17 +++
 arch/arm/mach-omap2/prcm_mpu44xx.h           |    9 +-
 arch/arm/mach-omap2/prm.h                    |   24 +++-
 arch/arm/mach-omap2/prm2xxx.c                |   15 +-
 arch/arm/mach-omap2/prm2xxx.h                |    2 +
 arch/arm/mach-omap2/prm2xxx_3xxx.h           |    7 -
 arch/arm/mach-omap2/prm3xxx.c                |   16 ++-
 arch/arm/mach-omap2/prm3xxx.h                |    2 +
 arch/arm/mach-omap2/prm44xx.c                |    1 -
 arch/arm/mach-omap2/prm_common.c             |   16 ++-
 arch/arm/mach-omap2/prminst44xx.h            |    2 +
 arch/arm/mach-omap2/sdrc.c                   |    8 +-
 arch/arm/mach-omap2/sdrc.h                   |    2 +
 arch/arm/mach-omap2/ti81xx.h                 |    9 ++
 arch/arm/mach-omap2/wd_timer.c               |   40 +++++-
 arch/arm/plat-omap/include/plat/prcm.h       |   37 -----
 drivers/watchdog/omap_wdt.c                  |   26 ++--
 include/linux/platform_data/omap-wd-timer.h  |   38 ++++++
 90 files changed, 948 insertions(+), 843 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap2-restart.c
 create mode 100644 arch/arm/mach-omap2/omap3-restart.c
 delete mode 100644 arch/arm/mach-omap2/prcm.c
 delete mode 100644 arch/arm/plat-omap/include/plat/prcm.h
 create mode 100644 include/linux/platform_data/omap-wd-timer.h
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkmfKAAoJEMePsQ0LvSpLkskP/jNWB8Dt9r9V2g6wnvuym8YP
jj8Un5BwWdGdCV9wcd4A2jipJCEEEhuAF0sQlF/UV9+MgkPK5q000UTn3MFgY8/d
F2rpqeDKiYt0eS4pvdwvSj7Gx9ZLK/vNh5ILm2vpmfRhzbFuJFLQGUNg/M19XxHs
TWJdNGMAHhAlUefxUKhaeybzqUGx9WQ5pTIFJ+bKdZCtH61h8p3tJk24+m7gaBXr
034iu9imcpf4n2reHcFB3x79HnljHRxo00PlQh/2w6bKJ2rtU9EMdYudgWf36plS
7shziaokVNJ8zS2HpGm7yiEy/MaXuEjzzzTkPR2dhl0HvxhVfeQMZIJcPDACKIed
gbpGVQnXgliJ8bRQe72UdE++LLaQJfdCHtteBoQfKQi5o7qMSd0Wlq6htk6Dggdl
G6/jn2GRn0Vab6Ij9rrDNWoMqR7sS/Ujtq3AdF/Pd0QYs/Au88CDV0YOuIG55Tov
aYPzzOg0Fv1Z6ASvmOJYtaJK/P9EZ3NfdQyo2RWYCCm980B37VK/90YvyYoYKdFs
MBBm0B8ekDVRMvvQkoZhYY2QwUKsTO+mgV/qPanXZLp31rCPAC+Wg3A/RDZKfdWw
uvjjDko29Uxu8tncFW+6pfIQ5ib0Tt4fgGV9/65CD6R/0Q477xuh1XkJV7iI3Q3k
v4jtIO11lfToUr7W25lH
=eyog
-----END PGP SIGNATURE-----

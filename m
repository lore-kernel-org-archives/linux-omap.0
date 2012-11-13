From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: clock: convert to common clock framework
Date: Tue, 13 Nov 2012 16:49:14 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211131628410.22487@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47292 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923Ab2KMQtP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Nov 2012 11:49:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit c9d501e5cb0238910337213e12a09127221c35d8:

  Merge tag 'omap-cleanup-b2-for-3.8' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.8/cleanup-prcm (2012-11-09 14:13:43 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-cleanup-c-for-3.8

for you to fetch changes up to f9ae32a74f0242cbef76d9baa10993d707be1714:

  ARM: OMAP2+: clock: Cleanup !CONFIG_COMMON_CLK parts (2012-11-12 19:18:51 -0700)

- ----------------------------------------------------------------
Convert the OMAP2+ clock code and data to rely on the common
clock framework for internal bookkeeping and the driver API.

Basic test logs for this branch on top of Tony's cleanup-prcm branch
at commit c9d501e5cb0238910337213e12a09127221c35d8 are here:

http://www.pwsan.com/omap/testlogs/common_clk_devel_3.8_rebase/20121112192516/

However, cleanup-prcm at c9d501e5 does not include some fixes
that are needed for a successful test.  With several reverts,
fixes, and workarounds applied, the following test logs were
obtained:

http://www.pwsan.com/omap/testlogs/TEST_common_clk_devel_3.8_rebase/20121112192300/

which indicate that the series tests cleanly.

N.B. The common clock data addition patches result in many
checkpatch warnings of the form "WARNING: static const char *
array should probably be static const char * const".  However, it
appears that resolving these would require changes to the CCF
itself.  So the resolution of these warnings is being postponed
until that can be coordinated.

These patches result in a ~55KiB increase in runtime kernel memory
usage when booting omap2plus_defconfig kernels.

- ----------------------------------------------------------------

vmlinux object size
(delta in bytes from TEST_cleanup-prcm_c9d501e5_v3.7-rc (c9d501e5cb0238910337213e12a09127221c35d8)):
   text     data      bss    total  kernel
 +17493    +1264        0   +18757  am33xx_only
 +16437    +7224      +72   +23733  n800_multi_omap2xxx
 +12137    +3464      +72   +15673  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
 +39185   +17328        0   +56513  omap2plus_defconfig
 +13397    +3728      +64   +17189  omap2plus_defconfig_2430sdp_only
 +38945   +17200      +64   +56209  omap2plus_defconfig_cpupm
 +35733   +20392      +64   +56189  omap2plus_defconfig_no_pm
 +34693    +9616      +64   +44373  omap2plus_defconfig_omap2_4_only
 +30777    +8616      +64   +39457  omap2plus_defconfig_omap3_4_only
 +12780   +20340    -1400   +31720  rmk_omap3430_ldp_allnoconfig
 +21613    +8688      +64   +30365  rmk_omap3430_ldp_oldconfig
 +12780   +20340    -1400   +31720  rmk_omap4430_sdp_allnoconfig
  +8937    +3656      +64   +12657  rmk_omap4430_sdp_oldconfig


Boot-time memory difference
(delta in bytes from TEST_cleanup-prcm_c9d501e5_v3.7-rc (c9d501e5cb0238910337213e12a09127221c35d8))
  avail  rsrvd   high  freed  board          kconfig
   -20k    20k      .      .  2420n800       omap2plus_defconfig
   -56k    56k      .      .  2430sdp        omap2plus_defconfig
   -56k    56k      .      .  3517evm        omap2plus_defconfig
   -56k    56k      .      .  3530es3beagle  omap2plus_defconfig
   -56k    56k      .      .  3730beaglexm   omap2plus_defconfig
   -56k    56k      .      .  37xxevm        omap2plus_defconfig
   -56k    56k      .      .  4430es2panda   omap2plus_defconfig
   -16k    16k      .      .  am335xbone     omap2plus_defconfig
   -56k    56k      .      .  cmt3517        omap2plus_defconfig


Mike Turquette (3):
      ARM: OMAP4: clock: Convert to common clk
      ARM: OMAP2+: clockdomain: bypass clockdomain handling when disabling unused clks
      ARM: OMAP2+: clock: Cleanup !CONFIG_COMMON_CLK parts

Paul Walmsley (7):
      ARM: OMAP2xxx: clock: add APLL rate recalculation functions
      ARM: OMAP2+: clock: add OMAP CCF convenience macros to mach-omap2/clock.h
      ARM: OMAP44xx: clock: drop obsolete clock data
      ARM: OMAP3xxx: clk: drop obsolete clock data
      ARM: AM33xx: clock: drop obsolete clock data
      ARM: OMAP3+: DPLL: drop !CONFIG_COMMON_CLK sections
      ARM: OMAP2xxx: clock: drop obsolete clock data

Rajendra Nayak (15):
      ARM: OMAP: clock: Nuke plat/clock.c & reuse struct clk as clk_hw_omap
      ARM: OMAP: hwmod: Fix up hwmod based clkdm accesses
      ARM: OMAP3: clock: Convert to common clk
      ARM: OMAP2: clock: Convert to common clk
      ARM: OMAP: clock: list all clk_hw_omap clks to enable/disable autoidle
      ARM: OMAP: clock: Define a function to enable clocks at init
      ARM: OMAP: clock: Get rid of some clkdm assocations within clks
      ARM: OMAP4: clock: Add 44xx data using common struct clk
      ARM: OMAP3: clock: Add 3xxx data using common struct clk
      ARM: OMAP2: clock: Add 24xx data using common struct clk
      ARM: OMAP: clock: Switch to COMMON clk
      ARM: OMAP: hwmod: Cleanup !CONFIG_COMMON_CLK parts
      ARM: OMAP4: clock: Cleanup !CONFIG_COMMON_CLK parts
      ARM: OMAP3: clock: Cleanup !CONFIG_COMMON_CLK parts
      ARM: OMAP2: clock: Cleanup !CONFIG_COMMON_CLK parts

Vaibhav Hiremath (2):
      ARM: OMAP2+: hwmod: Invoke init_clkdm before other init functions
      ARM: AM33XX: clock: add clock data in common clock format

 arch/arm/mach-omap2/Kconfig                  |    5 +
 arch/arm/mach-omap2/Makefile                 |   10 +-
 arch/arm/mach-omap2/cclock2420_data.c        | 1950 ++++++++++++++
 arch/arm/mach-omap2/cclock2430_data.c        | 2065 +++++++++++++++
 arch/arm/mach-omap2/cclock33xx_data.c        |  961 +++++++
 arch/arm/mach-omap2/cclock3xxx_data.c        | 3595 +++++++++++++++++++++++++
 arch/arm/mach-omap2/cclock44xx_data.c        | 1987 ++++++++++++++
 arch/arm/mach-omap2/clkt2xxx_apll.c          |   62 +-
 arch/arm/mach-omap2/clkt2xxx_dpll.c          |    8 +-
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c      |   13 +-
 arch/arm/mach-omap2/clkt2xxx_osc.c           |   13 +-
 arch/arm/mach-omap2/clkt2xxx_sys.c           |    7 +-
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |    9 +-
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c       |    8 +-
 arch/arm/mach-omap2/clkt_clksel.c            |  194 +-
 arch/arm/mach-omap2/clkt_dpll.c              |   28 +-
 arch/arm/mach-omap2/clkt_iclk.c              |   30 +-
 arch/arm/mach-omap2/clock.c                  |  910 ++-----
 arch/arm/mach-omap2/clock.h                  |  329 +--
 arch/arm/mach-omap2/clock2420_data.c         | 1972 --------------
 arch/arm/mach-omap2/clock2430.c              |    8 +-
 arch/arm/mach-omap2/clock2430_data.c         | 2071 ---------------
 arch/arm/mach-omap2/clock2xxx.c              |    1 +
 arch/arm/mach-omap2/clock2xxx.h              |   41 +-
 arch/arm/mach-omap2/clock33xx_data.c         | 1107 --------
 arch/arm/mach-omap2/clock34xx.c              |   51 +-
 arch/arm/mach-omap2/clock3517.c              |   24 +-
 arch/arm/mach-omap2/clock36xx.c              |   22 +-
 arch/arm/mach-omap2/clock36xx.h              |    2 +-
 arch/arm/mach-omap2/clock3xxx.c              |    6 +-
 arch/arm/mach-omap2/clock3xxx.h              |    6 +-
 arch/arm/mach-omap2/clock3xxx_data.c         | 3613 --------------------------
 arch/arm/mach-omap2/clock44xx_data.c         | 3398 ------------------------
 arch/arm/mach-omap2/clock_common_data.c      |   22 +-
 arch/arm/mach-omap2/clockdomain.c            |   89 +-
 arch/arm/mach-omap2/cm-regbits-24xx.h        |    5 +
 arch/arm/mach-omap2/cm-regbits-34xx.h        |   31 +
 arch/arm/mach-omap2/cm2xxx_3xxx.h            |    1 +
 arch/arm/mach-omap2/dpll3xxx.c               |  183 +-
 arch/arm/mach-omap2/dpll44xx.c               |   21 +-
 arch/arm/mach-omap2/io.c                     |    9 +
 arch/arm/mach-omap2/omap_hwmod.c             |   63 +-
 arch/arm/mach-omap2/pm24xx.c                 |    4 +-
 arch/arm/mach-omap2/prm-regbits-24xx.h       |    2 +
 arch/arm/mach-omap2/prm-regbits-34xx.h       |    1 +
 arch/arm/mach-omap2/prm2xxx_3xxx.h           |    1 +
 arch/arm/mach-omap2/scrm44xx.h               |    2 +
 47 files changed, 11482 insertions(+), 13458 deletions(-)
 create mode 100644 arch/arm/mach-omap2/cclock2420_data.c
 create mode 100644 arch/arm/mach-omap2/cclock2430_data.c
 create mode 100644 arch/arm/mach-omap2/cclock33xx_data.c
 create mode 100644 arch/arm/mach-omap2/cclock3xxx_data.c
 create mode 100644 arch/arm/mach-omap2/cclock44xx_data.c
 delete mode 100644 arch/arm/mach-omap2/clock2420_data.c
 delete mode 100644 arch/arm/mach-omap2/clock2430_data.c
 delete mode 100644 arch/arm/mach-omap2/clock33xx_data.c
 delete mode 100644 arch/arm/mach-omap2/clock3xxx_data.c
 delete mode 100644 arch/arm/mach-omap2/clock44xx_data.c
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQonUsAAoJEMePsQ0LvSpL2P0QAKaqbQffi3q/9ZpedmfF6mfn
rywQYn9lt3UOEV2csw84At2foWxCDfjT7kz9W6q5GhamiYCynnI2H8QfL0Y0Dcs9
ZeG1wmKEOfZl6fLu2XMcKBSbZg4dg12P1zkkcUozB4Nd9TyG8TzknuuPZySAh8xG
SOUxWz/BNvNCryX2bED2vwXbeDf0JaBxb/IgdN3dRoUR+FEyLFFEAMx2q75+Wo6H
wbDKJjYdI/lWWWlYesRGbN9zbWvB1mIaTdGOO4GAg4hkuHPZ+g9YjP0tf0O/K6+M
I1Du2i64t1GcOiiHqPpTs6c2Y0o6YdWLahwWRNqN6BbH2Z8cH2jAOs8BU8elou7e
OI8GLrSSqbZfCHuA0Zf6QVoATOB9mm7JgtdR4ga0SeDwdcfQLo+JFYDnC5K8YaAd
J5MCERcTHjuIGymqYkFvN4vv637UlhqqnGwfUH02M2y8rgMotn8f0/6TRsZV164S
BuEHFVuHwQjlsce/apgsVp5VBmqnjbDjob8A3EOWTGtR+m2SRHJYczvhT8sNdz7e
eA1k7ZoceSS2Uvq2zHmZ0G+u925ONQ/ePoDX06Fb1bRzVGtxMjpWMvPeJ01FepMZ
9AfmVDrjzrf0ptwXrZqOOKVuEq+2j08nazgtBAP47r+8rjer8BB0HRpL+Fdbpso1
Ialp5HyUwD92LD+FocYt
=CLnb
-----END PGP SIGNATURE-----

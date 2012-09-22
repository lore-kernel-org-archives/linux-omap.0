From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: PRCM/runtime PM patches for 3.7
Date: Sat, 22 Sep 2012 18:01:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209221759590.10663@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36131 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095Ab2IVSBO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 Sep 2012 14:01:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit 9fe0624e1b9faa43d1f6136c70409c4716fb73c9:

  Merge tag 'omap-devel-am33xx-for-v3.7' into test_v3.6-rc6_cff3.7_odaf3.7 (2012-09-22 10:00:35 -0600)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-b-c-for-3.7

for you to fetch changes up to 55e16433bffc70538f304987776b000e730e497c:

  ARM: OMAP4460/4470: PMU: Enable PMU for OMAP4460/70 (2012-09-22 10:57:44 -0600)

- ----------------------------------------------------------------
OMAP patches intended for the 3.7 merge window:

- - Runtime PM conversions for the GPMC and RNG IP blocks
- - Preparation patches for the OMAP common clock framework conversion
- - clkdev alias additions required by other drivers
- - Performance Monitoring Unit (PMU) support for OMAP2, 3, and non-4430 OMAP4
- - OMAP hwmod code and data improvements
- - Preparation patches for the IOMMU runtime PM conversion
- - Preparation patches for OMAP4 full-chip retention support

Based on a merge of v3.6-rc6, the cleanup-fixes-for-v3.7 tag
(de6ca33a96a6bf61fcb91d3d399703e19ead9d1e), and the
omap-devel-am33xx-for-v3.7 tag
(11964f53eb4d9ce59a058be9999d9cfcb1ced878), due to dependencies.

These patches have been tested for meaningful warnings from
checkpatch, sparse, smatch, and cppcheck.  Basic build, boot[1], and
PM test logs are available here:

    http://www.pwsan.com/omap/testlogs/omap_hwmod_prcm_devel_a_3.7/20120922105800/

...

1. Note that the N800 boot fails due to a known issue present in the
   base commit:

    http://www.spinics.net/lists/arm-kernel/msg196034.html

- ----------------------------------------------------------------

object size (delta in bytes from test_v3.6-rc6_cff3.7_odaf3.7 (9fe0624e1b9faa43d1f6136c70409c4716fb73c9)):
  text 	  data 	   bss 	 total 	kernel
 +1304 	 +1112 	   +64 	 +2480 	2430_testconfig
   +84 	  +432 	     0 	  +516 	5912osk_testconfig
 +1040 	 +3408 	     0 	 +4448 	am33xx_testconfig
 +1204 	 +1000 	   +56 	 +2260 	n800_b_testconfig
 +5296 	 +1680 	    -8 	 +6968 	n800_multi_omap2xxx
 +1188 	  +976 	   +56 	 +2220 	n800_testconfig
   -96 	     0 	     0 	   -96 	omap1510_defconfig
   +56 	  +448 	     0 	  +504 	omap1_defconfig
 +1372 	 +3096 	   +56 	 +4524 	omap2_4_testconfig
  +988 	 +5312 	   +64 	 +6364 	omap2plus_defconfig
  +984 	 +5280 	     0 	 +6264 	omap2plus_defconfig_cpupm
 +5080 	 +5320 	   +64 	+10464 	omap2plus_no_pm
 +1268 	 +3576 	     0 	 +4844 	omap3_4_testconfig
  +944 	 +2088 	     0 	 +3032 	omap3_testconfig
 +1408 	 +1800 	   +64 	 +3272 	omap4_testconfig
  +960 	 +2088 	   +64 	 +3112 	rmk_omap3430_ldp_oldconfig
 +1244 	 +1768 	     0 	 +3012 	rmk_omap4430_sdp_oldconfig


Afzal Mohammed (3):
      ARM: OMAP2/3: hwmod data: add gpmc
      ARM: OMAP2+: gpmc: Adapt to HWMOD
      ARM: OMAP2+: gpmc: minimal driver support

AnilKumar Ch (1):
      ARM: OMAP2+: AM33XX: clock data: Add clkdev alias for cpu0

Benoit Cousson (1):
      ARM: OMAP4: hwmod data: Fix ocp2scp_usb_phy and usb_host_hs entries

Igor Grinberg (1):
      ARM: OMAP: hwmod code: remove unused hwmod function prototypes

Jon Hunter (7):
      ARM: OMAP2420: Cosmetic fix for timer clock aliases
      ARM: OMAP4: Add timer clock aliases for device-tree
      ARM: OMAP: Add a timer attribute for timers that can interrupt the DSP
      ARM: OMAP3: hwmod data: Add debugss HWMOD data
      ARM: OMAP2+: PMU: Convert OMAP2/3 devices to use HWMOD
      ARM: OMAP2+: PMU: Add runtime PM support
      ARM: OMAP4460/4470: PMU: Enable PMU for OMAP4460/70

Kishon Vijay Abraham I (1):
      ARM: OMAP4: hwmod data: make *phy_48m* as the main_clk of ocp2scp

Michael Jones (1):
      ARM: OMAP3: clock data: remove obsolete comment

Mike Turquette (1):
      ARM: OMAP4: cm: add bitfield width values

Ming Lei (1):
      ARM: OMAP4430: PMU: prepare to create PMU device via HWMOD

Omar Ramirez Luna (5):
      ARM: OMAP2+: omap_device: expose hwmod assert/deassert to omap devices
      ARM: OMAP: hwmod: partially un-reset hwmods might not be properly enabled
      ARM: OMAP: hwmod: revise deassert sequence
      ARM: OMAP: iommu: fix including iommu.h without IOMMU_API selected
      ARM: OMAP4: hwmod data: add mmu hwmod for ipu and dsp

Paul Walmsley (13):
      ARM: OMAP3: clock data: Add the USB TLL clocks device name
      ARM: OMAP2+: clock data: add some aliases for use by CPUFreq only
      SPI: OMAP: remove unnecessary includes of plat/clock.h
      ARM: OMAP4+: hwmod code: remove clkdm requirement in _omap4_wait_target_*()
      ARM: OMAP2+: hwmod code: convert missing clockdomain warnings to debug messages
      ARM: OMAP4: hwmod data: add missing HWMOD_NO_IDLEST flags to some PRCM IP blocks
      ARM: OMAP3: hwmod data: add mmu data for iva and isp
      ARM: OMAP2xxx: hwmod/CM: add RNG integration data
      hwrng: OMAP: store per-device data in per-device variables, not file statics
      hwrng: OMAP: convert to use runtime PM
      ARM: OMAP: split OMAP1, OMAP2+ RNG device registration
      hwrng: OMAP: remove SoC restrictions from driver registration
      ARM: OMAP2+: clockdomain/hwmod: add workaround for EMU clockdomain idle problems

Rajendra Nayak (3):
      ARM: omap: clk: add clk_prepare and clk_unprepare
      ARM: OMAP2+: hwmod: get rid of all omap_clk_get_by_name usage
      ARM: OMAP2+: clock: Remove all direct dereferencing of struct clk

Tero Kristo (4):
      ARM: OMAP4: powerdomain: add support for reading prev logic and mem states
      ARM: OMAP4: hwmod data: add support for lostcontext_mask
      ARM: OMAP4: hwmod: flag hwmods/modules not supporting module level context status
      ARM: OMAP3: hwmod data: add sad2d hwmod

Vaibhav Hiremath (1):
      ARM: AM33XX: cm: Add bit-field width values

 arch/arm/mach-omap1/devices.c                      |   28 ++
 arch/arm/mach-omap1/timer.c                        |    2 +-
 arch/arm/mach-omap2/Makefile                       |    1 +
 arch/arm/mach-omap2/board-apollon.c                |    4 +-
 arch/arm/mach-omap2/board-h4.c                     |    6 +-
 arch/arm/mach-omap2/board-omap4panda.c             |    2 +-
 arch/arm/mach-omap2/clkt2xxx_apll.c                |    2 +-
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c       |   10 +-
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c             |   20 +-
 arch/arm/mach-omap2/clkt_clksel.c                  |   91 +++--
 arch/arm/mach-omap2/clkt_dpll.c                    |   26 +-
 arch/arm/mach-omap2/clock.c                        |   11 +-
 arch/arm/mach-omap2/clock2420_data.c               |   24 +-
 arch/arm/mach-omap2/clock2430_data.c               |   23 ++
 arch/arm/mach-omap2/clock33xx_data.c               |    1 +
 arch/arm/mach-omap2/clock3xxx.c                    |    8 +-
 arch/arm/mach-omap2/clock3xxx_data.c               |   37 +-
 arch/arm/mach-omap2/clock44xx_data.c               |   21 +
 arch/arm/mach-omap2/clockdomain.c                  |   17 +
 arch/arm/mach-omap2/clockdomain.h                  |   20 +-
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c         |   49 ++-
 arch/arm/mach-omap2/clockdomain44xx.c              |   11 +
 arch/arm/mach-omap2/clockdomains3xxx_data.c        |    7 +-
 arch/arm/mach-omap2/clockdomains44xx_data.c        |    3 +-
 arch/arm/mach-omap2/cm-regbits-33xx.h              |  158 +++++++-
 arch/arm/mach-omap2/cm-regbits-34xx.h              |    2 +
 arch/arm/mach-omap2/cm-regbits-44xx.h              |  411 ++++++++++++++++----
 arch/arm/mach-omap2/cm2xxx_3xxx.c                  |    2 +-
 arch/arm/mach-omap2/cm2xxx_3xxx.h                  |    1 +
 arch/arm/mach-omap2/control.h                      |    1 +
 arch/arm/mach-omap2/devices.c                      |   39 +-
 arch/arm/mach-omap2/display.c                      |    4 +-
 arch/arm/mach-omap2/dpll3xxx.c                     |   48 ++-
 arch/arm/mach-omap2/gpmc.c                         |  194 ++++++---
 arch/arm/mach-omap2/omap_hwmod.c                   |  138 +++++--
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   19 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   19 +
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |   17 +
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  110 +++++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  280 ++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  243 +++++++++++-
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    6 +-
 arch/arm/mach-omap2/pm.c                           |    5 +-
 arch/arm/mach-omap2/pmu.c                          |   95 +++++
 arch/arm/mach-omap2/powerdomain44xx.c              |   61 ++-
 arch/arm/mach-omap2/prcm-common.h                  |    2 +
 arch/arm/plat-omap/clock.c                         |   27 --
 arch/arm/plat-omap/include/plat/clock.h            |    5 +
 arch/arm/plat-omap/include/plat/dmtimer.h          |    1 +
 arch/arm/plat-omap/include/plat/iommu.h            |   15 +
 arch/arm/plat-omap/include/plat/omap_device.h      |    4 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h       |   26 +-
 arch/arm/plat-omap/omap_device.c                   |   59 ++-
 drivers/char/hw_random/omap-rng.c                  |  121 +++---
 drivers/spi/spi-omap-100k.c                        |    2 -
 drivers/spi/spi-omap2-mcspi.c                      |    1 -
 56 files changed, 2113 insertions(+), 427 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pmu.c
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQXfyKAAoJEMePsQ0LvSpL9agQALAeH8QHm0ZwXlOnovkBLfEZ
Hg5QmLyP5Dlmz8iQsmy/rW6AAwIYliJhWtarTrhM1vcm4K7r7KIcjvCS501B0CoW
JVD5W9GFVNY5KfECADw3HnfJK8TL01BMJT/15IK/6s7/Iw4bq2lk6etEcTk6Bnr/
PNx4rIPW5f/PlqEuvftZQUSca2mwCdFQcjghj0LmBJFEX3p9uxtGn/LQIMjcRwfM
2stLNXGApSpDNTtGMr/Ixuy2aqU0j2Lrx9SSTYXwuRjgOus6QWia4HVHgVPujBOy
E2K19YyaTZXL6Ooinzym8gUv6ahOa65ySHYnBThS8O9LDMLIhPh27AvRbvWwwA2e
c18N8/MRaVe92V86BBCPuXux/bsALsGME3aoVmmpOKIsM2uarwKv5Mk0oYRtPn3U
Qy7IkzAh6jL6d5J0PglTQft6v4p748BRaYBmLz94zquw9QoYVQQxMdaSvqObjM7Q
tP6bClaqs6u43RJFLkE5aGYsps8u0kidxTSALPvRKnp6yaEZkj5G8xvH7C1JkJ59
bBm5/iSnUHxiX8T81runhD5MpjUZLRz8+6zjTgOtccU9/bw8k3aCDTFpNCptlVBp
he1sOc1xd8vu7AO5JUt38TxBrkZCmKbCKPcwnZQ3Tp61cQOlW5dWwSM7ZXIhFyx1
NzJM0nJASnjlVqLV2/Mf
=hSWt
-----END PGP SIGNATURE-----

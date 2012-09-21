From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP: hwmod/PMU/PRCM patches for 3.7
Date: Fri, 21 Sep 2012 01:04:53 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209210103140.6888@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60975 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026Ab2IUBEy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Sep 2012 21:04:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit c4dbc7c086ce96d17f18b7a4a965b01d54d45f46:

  Merge tag 'cleanup-fixes-for-v3.7' into test_merge_v3.6-rc6_cleanup-fixes (2012-09-19 13:54:08 -0600)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-b-for-3.7

for you to fetch changes up to 2d8abe08923834bc41fb4d811b437033f567531e:

  ARM: OMAP4460/4470: PMU: Enable PMU for OMAP4460/70 (2012-09-20 18:23:39 -0600)

- ----------------------------------------------------------------
Behind this tag are OMAP patches intended for the 3.7 merge window, for:

- - Runtime PM conversions for the GPMC and RNG IP blocks
- - Performance Monitoring Unit (PMU) support for OMAP2, 3, and non-4430 OMAP4
- - OMAP hwmod code and data improvements
- - Preparation patches for the IOMMU runtime PM conversion
- - Preparation patches for OMAP4 full-chip retention support

Based on a merge of v3.6-rc6 and the cleanup-fixes-for-v3.7
tag (de6ca33a96a6bf61fcb91d3d399703e19ead9d1e), due to
dependencies.

These patches have been tested for meaningful warnings from
checkpatch, sparse, smatch, and cppcheck.  Basic build, boot[1], and
PM test logs are available here:

    http://www.pwsan.com/omap/testlogs/omap_hwmod_prcm_devel_a_3.7/20120920182344/

...

1. Note that the N800 boot fails due to a known issue present in the
   base commit:

    http://www.spinics.net/lists/arm-kernel/msg196034.html

- ----------------------------------------------------------------

object size (delta in bytes from test_merge_v3.6-rc6_cleanup-fixes (c4dbc7c086ce96d17f18b7a4a965b01d54d45f46)):
  text 	  data 	   bss 	 total 	kernel
 +1428 	  +256 	     0 	 +1684 	2430_testconfig
  +180 	  +432 	     0 	  +612 	5912osk_testconfig
 +1152 	 +1736 	     0 	 +2888 	am33xx_testconfig
 +1304 	  +280 	    -8 	 +1576 	n800_b_testconfig
 +1336 	  +352 	   +56 	 +1744 	n800_multi_omap2xxx
 +1288 	  +256 	    -8 	 +1536 	n800_testconfig
     0 	     0 	     0 	     0 	omap1510_defconfig
  +184 	  +448 	     0 	  +632 	omap1_defconfig
 +5564 	 +1392 	    -8 	 +6948 	omap2_4_testconfig
 +1104 	 +2608 	     0 	 +3712 	omap2plus_defconfig
 +1100 	 +2584 	     0 	 +3684 	omap2plus_defconfig_cpupm
 +5104 	 +2592 	     0 	 +7696 	omap2plus_no_pm
 +1424 	 +1840 	     0 	 +3264 	omap3_4_testconfig
 +1036 	  +864 	   +64 	 +1964 	omap3_testconfig
 +5592 	 +1088 	     0 	 +6680 	omap4_testconfig
 +1096 	  +800 	     0 	 +1896 	rmk_omap3430_ldp_oldconfig
 +1344 	  +968 	     0 	 +2312 	rmk_omap4430_sdp_oldconfig


Afzal Mohammed (3):
      ARM: OMAP2/3: hwmod data: add gpmc
      ARM: OMAP2+: gpmc: Adapt to HWMOD
      ARM: OMAP2+: gpmc: minimal driver support

Benoit Cousson (1):
      ARM: OMAP4: hwmod data: Fix ocp2scp_usb_phy and usb_host_hs entries

Igor Grinberg (1):
      ARM: OMAP: hwmod code: remove unused hwmod function prototypes

Jon Hunter (5):
      ARM: OMAP: Add a timer attribute for timers that can interrupt the DSP
      ARM: OMAP3: hwmod data: Add debugss HWMOD data
      ARM: OMAP2+: PMU: Convert OMAP2/3 devices to use HWMOD
      ARM: OMAP2+: PMU: Add runtime PM support
      ARM: OMAP4460/4470: PMU: Enable PMU for OMAP4460/70

Kishon Vijay Abraham I (1):
      ARM: OMAP4: hwmod data: make *phy_48m* as the main_clk of ocp2scp

Ming Lei (1):
      ARM: OMAP4430: PMU: prepare to create PMU device via HWMOD

Omar Ramirez Luna (5):
      ARM: OMAP2+: omap_device: expose hwmod assert/deassert to omap devices
      ARM: OMAP: hwmod: partially un-reset hwmods might not be properly enabled
      ARM: OMAP: hwmod: revise deassert sequence
      ARM: OMAP: iommu: fix including iommu.h without IOMMU_API selected
      ARM: OMAP4: hwmod data: add mmu hwmod for ipu and dsp

Paul Walmsley (10):
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

Tero Kristo (4):
      ARM: OMAP4: powerdomain: add support for reading prev logic and mem states
      ARM: OMAP4: hwmod data: add support for lostcontext_mask
      ARM: OMAP4: hwmod: flag hwmods/modules not supporting module level context status
      ARM: OMAP3: hwmod data: add sad2d hwmod

 arch/arm/mach-omap1/devices.c                      |   28 ++
 arch/arm/mach-omap1/timer.c                        |    2 +-
 arch/arm/mach-omap2/Makefile                       |    1 +
 arch/arm/mach-omap2/clockdomain.c                  |   17 ++
 arch/arm/mach-omap2/clockdomain.h                  |   20 +-
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c         |   22 ++
 arch/arm/mach-omap2/clockdomain44xx.c              |   11 +
 arch/arm/mach-omap2/clockdomains3xxx_data.c        |    7 +-
 arch/arm/mach-omap2/clockdomains44xx_data.c        |    3 +-
 arch/arm/mach-omap2/cm-regbits-34xx.h              |    2 +
 arch/arm/mach-omap2/cm2xxx_3xxx.c                  |    2 +-
 arch/arm/mach-omap2/cm2xxx_3xxx.h                  |    1 +
 arch/arm/mach-omap2/devices.c                      |   39 +--
 arch/arm/mach-omap2/gpmc.c                         |  194 ++++++++++----
 arch/arm/mach-omap2/omap_hwmod.c                   |   93 +++++--
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   19 ++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   19 ++
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |   17 ++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  110 +++++++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  280 +++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  243 ++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    6 +-
 arch/arm/mach-omap2/pm.c                           |    3 +-
 arch/arm/mach-omap2/pmu.c                          |   95 +++++++
 arch/arm/mach-omap2/powerdomain44xx.c              |   61 ++++-
 arch/arm/mach-omap2/prcm-common.h                  |    2 +
 arch/arm/plat-omap/include/plat/dmtimer.h          |    1 +
 arch/arm/plat-omap/include/plat/iommu.h            |   15 ++
 arch/arm/plat-omap/include/plat/omap_device.h      |    4 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h       |   26 +-
 arch/arm/plat-omap/omap_device.c                   |   55 ++++
 drivers/char/hw_random/omap-rng.c                  |  121 +++++----
 32 files changed, 1336 insertions(+), 183 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pmu.c
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQW7zCAAoJEMePsQ0LvSpL9vgP/3daPbDgjtyXx6DpHMOhdoU7
ShlGI7oGoq4SNCyUgq0zbYJCyp1+hplGj8JL/jA9ELVjnt0np5obQKWh0dGzU2pF
X2TudDqSMgXJmzS2h3cjIPujJ/lWQIt2500F6Fhtf7msrWqdfnXeMBHs/q6s+Hco
LMZh79pGnUwxjCjApdANmnEKjcKckGJBOUTHCWdol4cOyo8FbFaJDj74+6jd1PGV
FtlvHtgBKaBMOY3lTnIyai53i+rnQ3peUYWDR9HubA1rJhfBvcW/tMiiPMTYPKz1
efcpbMV70y6SOIoX3pJ0r+EwChUtYxWFoe1SiOmrhE6aSvmwtTwEDhDiDWNn4eYI
zSKtiU2EJaCj4gUBlx8C/siSGhNRqAKWAdsDOOTU7XYhYshLcVOWDcZGZ1L/R6An
0utW1Uv3/BoPxJ0sIsgFcxFuPH4uFXkwDy7TXUO9LLFRsFibQCoxfWXuUBqwFOIQ
BxyjUlA4Hj2/8PdypgqVJJp+22hAWca1w/gsoSAxd9MHcY9CLX0FryiRcqoxUGWd
Q5HKA284TE9/upYYwAiQ+CimRtJh/nwQlZMd7yLiSjaQcwEskq53rxFWklN3ki3L
uAVoWcaAkUklPAL4x0XU7VQ82ZO3hk3NnhZo0Bd/j9EZXT/XGiof8wVg2baUWC0B
WF7lfJDDivg9smyLYKWR
=WJc2
-----END PGP SIGNATURE-----

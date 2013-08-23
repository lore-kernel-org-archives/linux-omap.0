From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP: DRA7xx PRCM/hwmod support
Date: Fri, 23 Aug 2013 19:10:07 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1308231909020.22768@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37915 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756170Ab3HWTKI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Aug 2013 15:10:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit cf470a1b1a741bca00080ebc70968b4f22d9b1ea:

  Merge tag 'dra7-core-support-minus-dt' of git://github.com/rrnayak/linux into omap-for-v3.12/soc (2013-08-14 01:01:41 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.12/dra7xx

for you to fetch changes up to 7de516a63c634a0db1920757f501f98f68f92716:

  ARM: OMAP: DRA7: Enable PM framework initializations (2013-08-23 04:29:37 -0600)

- ----------------------------------------------------------------
This series adds basic TI DRA7xx PRCM and hwmod support.

Basic test logs are available here:

http://www.pwsan.com/omap/testlogs/dra7xx_prcm_devel_v3.12/20130823050445/

Note that DRA7xx could not be tested locally, since I don't have a board.

- ----------------------------------------------------------------
vmlinux object size
(delta in bytes from tony_soc_for_v3.12 (cf470a1b1a741bca00080ebc70968b4f22d9b1ea)):
   text     data      bss    total  kernel
      0        0        0        0  n800_multi_omap2xxx
      0        0        0        0  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
    +72        0        0      +72  omap2plus_defconfig
      0        0        0        0  omap2plus_defconfig_2430sdp_only
    +72        0        0      +72  omap2plus_defconfig_cpupm
     +8        0        0       +8  omap2plus_defconfig_no_pm
     +8        0        0       +8  omap2plus_defconfig_omap2_4_only
     +8        0        0       +8  omap2plus_defconfig_omap3_4_only
      0        0        0        0  rmk_omap3430_ldp_allnoconfig
      0        0        0        0  rmk_omap3430_ldp_oldconfig
    +56        0      -16      +40  rmk_omap4430_sdp_allnoconfig

Boot-time memory difference
(delta in bytes from tony_soc_for_v3.12 (cf470a1b1a741bca00080ebc70968b4f22d9b1ea))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)

Ambresh K (7):
      ARM: OMAP: DRA7: PRM: Add DRA7XX register definitions
      ARM: OMAP: DRA7: CM: Add DRA7XX register defines
      ARM: OMAP: DRA7: PRCM: Add DRA7XX local MPU PRCM regsiters
      ARM: OMAP: DRA7: clockdomain: Add DRA7XX data and update header
      ARM: OMAP: DRA7: powerdomain: Add DRA7XX data and update header
      ARM: OMAP: DRA7: hwmod: Create initial DRA7XX SoC data
      ARM: OMAP: DRA7: Enable PM framework initializations

Rajendra Nayak (3):
      ARM: OMAP: DRA7: CM: Add minimal regbit shifts
      ARM: OMAP: DRA7: powerdomain: Handle missing vc/vp
      ARM: OMAP: DRA7: Reuse the omap44xx_restart and fix the device instance

 arch/arm/mach-omap2/Makefile               |    4 +
 arch/arm/mach-omap2/board-generic.c        |    1 +
 arch/arm/mach-omap2/clockdomain.h          |    1 +
 arch/arm/mach-omap2/clockdomains7xx_data.c |  740 ++++++++
 arch/arm/mach-omap2/cm-regbits-7xx.h       |   51 +
 arch/arm/mach-omap2/cm1_7xx.h              |  324 ++++
 arch/arm/mach-omap2/cm2_7xx.h              |  513 ++++++
 arch/arm/mach-omap2/io.c                   |    5 +
 arch/arm/mach-omap2/omap_hwmod.h           |    1 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 2724 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h          |    1 +
 arch/arm/mach-omap2/powerdomains7xx_data.c |  454 +++++
 arch/arm/mach-omap2/prcm44xx.h             |    5 +
 arch/arm/mach-omap2/prcm_mpu7xx.h          |   78 +
 arch/arm/mach-omap2/prm44xx.c              |   12 +-
 arch/arm/mach-omap2/prm7xx.h               |  678 +++++++
 arch/arm/mach-omap2/prminst44xx.c          |   20 +-
 17 files changed, 5607 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains7xx_data.c
 create mode 100644 arch/arm/mach-omap2/cm-regbits-7xx.h
 create mode 100644 arch/arm/mach-omap2/cm1_7xx.h
 create mode 100644 arch/arm/mach-omap2/cm2_7xx.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_7xx_data.c
 create mode 100644 arch/arm/mach-omap2/powerdomains7xx_data.c
 create mode 100644 arch/arm/mach-omap2/prcm_mpu7xx.h
 create mode 100644 arch/arm/mach-omap2/prm7xx.h
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSF7MqAAoJEMePsQ0LvSpLVWcP/RLLMneCi2myW40UctJwHDIw
+c58TJnYt6aFmp5ht+MhKGS3BIrRRD6uWZx4/HfxytjxKyV/t7hbkrsHzUMfN32z
FL6d9IDN+IvIMUhbQyaW/se1j8dqAJlAM/ef5xavN2wgDb/4XiYkFT3BNybqe374
fpr7qQ4727kVrPp3h0olLDDUDUPY7LCseSGlFql+g8txHsOok+VnmXxPP1E/IMEa
OxCO8CTDibDQCvq+uw1OACUvHOG9yzbNfjcbXWttNNNgWuti2OL0xnAGEs+yqG+9
cI8pHurRHKYPDrv1nnq4uEOsse+iCbsQNaj1ws32u/3ye0wDCRSDOq2Whe69xBvs
7EdoT5nVjisF916Ij/xzX/zwOSAgIO3iu5DitHUOaCtrhOoJA8Rcpcl+S0xr8S4w
z8oi+7aC+OLByn1hXITV+FNhBs+uNMMOmIfiC4G7uHSK3fYu8vv2X6vdfrm5NYFI
vzjBPaoqDNg4S+4h3AGwe6ZuTI4KMRm1juYWlQJFjim+T23Fjlas9Xm5bQ7f1wwE
mZLQLKsosiwit+23bDtAOEVmtKv7SmDMJSjKRlqJJsEkdIhyI3xmzjXGJdpmCNV7
ErEWa08ddS0o1GJvbkmdFyvAiSwO5ZRx2krUehVUKtztmgf64HcNVSjp3z91uL6p
YthaxPvyzwLzFXXnbOGF
=tsf/
-----END PGP SIGNATURE-----

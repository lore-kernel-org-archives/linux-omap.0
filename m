From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL v2] ARM: OMAP4: PM fixes and AESS integration for 3.9
Date: Sun, 10 Feb 2013 19:15:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302101901530.2672@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58024 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756136Ab3BJTPN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Feb 2013 14:15:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit 88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7:

  Linux 3.8-rc6 (2013-02-01 12:08:14 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-d2-for-3.9

for you to fetch changes up to a5a8c31d9f7587b601ecf0106c8abeabe3da24c3:

  Merge branches 'sg_aess_reset_devel_3.9' and 'omap4_pm_fixes_a_3.9' into omap4_prcm_devel_a_3.9 (2013-02-10 11:27:02 -0700)

- ----------------------------------------------------------------

Some OMAP4 power management fixes and audio device integration
patches.  This pull request contains a fix for an issue discovered during
branch integration.

Basic test logs are available at:

    http://www.pwsan.com/omap/testlogs/omap4_prcm_devel_a_3.9/20130210112717/

- ----------------------------------------------------------------
vmlinux object size
(delta in bytes from test_v3.8-rc6 (88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7)):
   text     data      bss    total  kernel
    +92     +128        0     +220  am33xx_only
    +96      +96        0     +192  n800_multi_omap2xxx
    +96      +96        0     +192  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
   +148    +1176        0    +1324  omap2plus_defconfig
   +124      +96        0     +220  omap2plus_defconfig_2430sdp_only
   +148    +1104        0    +1252  omap2plus_defconfig_cpupm
    +84    +1176        0    +1260  omap2plus_defconfig_no_pm
   +156     +912        0    +1068  omap2plus_defconfig_omap2_4_only
   +148    +1112        0    +1260  omap2plus_defconfig_omap3_4_only
   +452    +1104    +3784    +5340  rmk_omap3430_ldp_allnoconfig
    +96     +256        0     +352  rmk_omap3430_ldp_oldconfig
   +452    +1104    +3784    +5340  rmk_omap4430_sdp_allnoconfig
   +140     +920        0    +1060  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.8-rc6 (88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7))
  avail  rsrvd   high  freed  board          kconfig
     8k    -8k      .      .  4430es2panda   omap2plus_defconfig
   -12k    12k      .      .  4460pandaes    omap2plus_defconfig

Paul Walmsley (4):
      ARM: OMAP2+: hwmod: add enable_preprogram hook
      ASoC: TI AESS: add autogating-enable function, callable from architecture code
      ARM: OMAP4+: AESS: enable internal auto-gating during initial setup
      Merge branches 'sg_aess_reset_devel_3.9' and 'omap4_pm_fixes_a_3.9' into omap4_prcm_devel_a_3.9

Rajendra Nayak (1):
      ARM: OMAP4: PM: Warn users about usage of older bootloaders

Santosh Shilimkar (1):
      ARM: OMAP2+: PM: Fix the dt return condition in pm_late_init()

Sebastien Guiriec (2):
      ARM: OMAP4: hwmod data: Update AESS data with memory bank area
      ARM: OMAP4: hwmod data: Enable AESS hwmod device

 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c           |   18 ++++++++++
 arch/arm/mach-omap2/omap_hwmod.h           |    8 +++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   51 +++++++++++++++++++++++---
 arch/arm/mach-omap2/omap_hwmod_reset.c     |   52 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.c                   |   20 +++++------
 arch/arm/mach-omap2/pm44xx.c               |   21 +++++++++--
 include/sound/aess.h                       |   53 ++++++++++++++++++++++++++++
 8 files changed, 208 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_reset.c
 create mode 100644 include/sound/aess.h
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRF+3SAAoJEMePsQ0LvSpLwmIP/RsvesZ/OLzTO1Np6utauYhb
T8DzXBf3FqZOO4kXWBHorF4yzdav6xPS97k1YKLRgp6vPD78TzP6/ar1zcDMP4ju
pKxjy7D6QaLmv0Vio1VYEc2Dz/05TTz3mwClDgpYTorzwogQgUugGemO3aEdiKy1
zJFGhRqRDna/+g5lSTEZLgT3tPTjx1v3jN+m9D9y6VhGoNxCWXmVmYAy26kufvg2
qtg/QyY6N/EaukdumzPuuAidnlV+Mfcnl2ylRSEA2Cl5aafElyQiiJfHP+e/S4GC
qI/i12NoGfvSWvkvJ11H+CRlxUFpMODjJqAzJNlg34jkO4fMR2DQxB46k3mT75IC
n7sqqHw6Bqzrb0kTqNchZYdD8mT2BqJDpKQJd47GpX468Y7p2tMh9uEDpKCYL2zu
UVFG/IQwGccbUNlN/AV4nJ8kk+GVnJ95y8jZMmN+JefUtvV8a/ABy8fEsz/W/mpn
OZb4Zyh3Y8GXJMJSD78MmeG9OqBWjY4DnfISKBCqH1mPK4vBbiO8qcKMYu3A8YET
8IISSegByj8YZewZCVTevJ7jdvPQ3Oktj1v9wY7OWmCFr59XRDpe2hsY8zy8H8uU
L8venLgu+oGJfiEH6zj94tRTrDqbyNb08GQHnC9Zyr2sjBuwmu9V9XzDMxDhgqYA
oKAnWMbbNDpY9+9JiQxK
=3m4T
-----END PGP SIGNATURE-----

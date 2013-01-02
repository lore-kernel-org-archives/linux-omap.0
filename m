From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL v2] ARM: OMAP2+: sparse & PRCM fixes for v3.8-rc1
Date: Wed, 2 Jan 2013 19:38:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301021931430.17366@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41620 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab3ABTi5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jan 2013 14:38:57 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:

  Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-fixes-a2-for-v3.8-rc

for you to fetch changes up to 7e7fff8254e318cede06a1a8c55b0d86dd4d8c5b:

  ARM: OMAP2/3: PRM: fix bogus OMAP2xxx powerstate return values (2013-01-02 12:07:16 -0700)

----------------------------------------------------------------
Some OMAP PRCM and sparse fixes against v3.8-rc1.  A basic set of test
logs are available here:

    http://www.pwsan.com/omap/testlogs/prcm_fixes_b_3.8-rc/20130102120724/

The 3730 Beagle XM here has an intermittent failure mounting SD root,
but the suspicion right now is that this is due to a failing SD card,
rather than any change introduced by these patches.

This second version includes a few changes requested by Tony Lindgren.

----------------------------------------------------------------

vmlinux object size
(delta in bytes from test_v3.8-rc1 (a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565)):
   text     data      bss    total  kernel
      0        0        0        0  am33xx_only
    +96        0        0      +96  n800_multi_omap2xxx
    +96        0        0      +96  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
   +244       +8        0     +252  omap2plus_defconfig
    +88        0        0      +88  omap2plus_defconfig_2430sdp_only
  +4276       +8        0    +4284  omap2plus_defconfig_cpupm
   +180       +8        0     +188  omap2plus_defconfig_no_pm
   +120        0        0     +120  omap2plus_defconfig_omap2_4_only
     -8        0        0       -8  omap2plus_defconfig_omap3_4_only
      0        0        0        0  rmk_omap3430_ldp_oldconfig
      0        0        0        0  rmk_omap4430_sdp_oldconfig

Ivan Khoronzhuk (2):
      ARM: OMAP4: PRM: Correct reset source map
      ARM: OMAP4: PRM: Correct wrong instance usage for reading reset sources

Jon Hunter (1):
      ARM: OMAP3: clock data: Add missing enable/disable for EMU clock

Nishanth Menon (1):
      ARM: OMAP4: PRM: fix RSTTIME and RSTST offsets

Paul Walmsley (4):
      ARM: OMAP: 32k counter: resolve sparse warnings
      ARM: OMAP AM33xx: hwmod data: resolve sparse warnings
      ARM: OMAP: SRAM: resolve sparse warnings
      ARM: OMAP2/3: PRM: fix bogus OMAP2xxx powerstate return values

 arch/arm/mach-omap2/cclock3xxx_data.c      |    2 +
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    4 +-
 arch/arm/mach-omap2/prm2xxx.c              |   88 +++++++++++++++++++++++++++-
 arch/arm/mach-omap2/prm2xxx_3xxx.c         |   22 -------
 arch/arm/mach-omap2/prm3xxx.c              |   28 ++++++++-
 arch/arm/mach-omap2/prm44xx.c              |    6 +-
 arch/arm/mach-omap2/prm44xx.h              |    4 +-
 arch/arm/plat-omap/counter_32k.c           |    2 +
 arch/arm/plat-omap/sram.c                  |    2 +
 9 files changed, 123 insertions(+), 35 deletions(-)

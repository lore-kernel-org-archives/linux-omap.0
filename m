From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] OMAP: SoC data/core: fixes for 3.1
Date: Sun, 10 Jul 2011 01:34:19 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107100132470.15984@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36624 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab1GJHeU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jul 2011 03:34:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

The following changes since commit c402c0d9dfa8d4fb54dd98fc12525f39d0f29bfe:

  Merge branches 'dmtimer_precleanup_3.1', 'hwmod_core_cleanup_a_3.1', 'combine_common_hwmod_3.1', 'omap4_hwmod_data_cleanup_a_3.1', 'clock_cleanup_a_3.1', 'prcm_cleanup_a_3.1', 'omap_pm_cleanup_3.1' and 'omap_device_cleanup_3.1' into prcm-cleanup-3.1 (2011-07-09 20:24:07 -0600)

are available in the git repository at:

  git://git.pwsan.com/linux-2.6 prcm-fixes-3.1

Andy Green (6):
      I2C: OMAP2+: Set hwmod flags to only allow 16-bit accesses to i2c
      I2C: OMAP2+: increase omap_i2c_dev_attr flags from u8 to u32
      I2C: OMAP2+:  Introduce I2C IP versioning constants
      I2C: OMAP1/OMAP2+: create omap I2C functionality flags for each cpu_... test
      I2C: OMAP2+: Tag all OMAP2+ hwmod defintions with I2C IP revision
      I2C: OMAP2+: add correct functionality flags to all omap2plus i2c dev_attr

Avinash.H.M (1):
      OMAP: hwmod: fix the i2c-reset timeout during bootup

Benoit Cousson (1):
      OMAP4: powerdomain data: Fix core mem states and missing cefuse flag

Paul Walmsley (1):
      Merge branches 'powerdomain_fixes_3.1', 'hardware_workarounds_3.1', 'hwmod_dss_fix_3.1' and 'i2c_fixes_3.1' into prcm-fixes-3.1

Rajendra Nayak (1):
      OMAP2+: PM: Initialise sleep_switch to a non-valid value

Santosh Shilimkar (2):
      OMAP4: clock data: Keep GPMC clocks always enabled and hardware managed
      OMAP4: powerdomain data: Remove unsupported MPU powerdomain state

Tomi Valkeinen (2):
      OMAP4: hwmod data: Modify DSS opt clocks
      OMAP4: hwmod data: Change DSS main_clk scheme

 arch/arm/mach-omap2/clock44xx_data.c         |    9 ++-
 arch/arm/mach-omap2/i2c.c                    |   68 +++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.c             |   27 +++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |    9 +++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |    7 ++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |   18 +++++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   81 ++++++++++++++++++++------
 arch/arm/mach-omap2/pm.c                     |    2 +-
 arch/arm/mach-omap2/powerdomains44xx_data.c  |    9 ++-
 arch/arm/plat-omap/include/plat/i2c.h        |    6 ++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 include/linux/i2c-omap.h                     |   27 +++++++++
 12 files changed, 233 insertions(+), 31 deletions(-)

omap2plus_defconfig
   text    data     bss     dec     hex filename
6353285  528944 5591048 12473277         be53bd vmlinux.orig
6352073	 529392	5591048	12472513	 be50c1	vmlinux.patched


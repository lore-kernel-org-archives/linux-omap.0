From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] OMAP: SoC data/core: new code for 3.1
Date: Sun, 10 Jul 2011 06:38:39 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107100632040.15984@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59516 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755930Ab1GJMik (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jul 2011 08:38:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Hi Tony,

The following changes since commit c84584139aaeef7631df152e13cbf319d8e55950:

  Merge branches 'powerdomain_fixes_3.1', 'hardware_workarounds_3.1', 'hwmod_dss_fix_3.1' and 'i2c_fixes_3.1' into prcm-fixes-3.1 (2011-07-10 05:44:23 -0600)

are available in the git repository at:

  git://git.pwsan.com/linux-2.6 prcm-devel-3.1

Note that to test this branch, you'll probably need Balaji's PM runtime 
changes for HSMMC merged.  (Chris Ball has queued these for 3.1.)

Benoit Cousson (13):
      OMAP: omap_device: Create clkdev entry for hwmod main_clk
      OMAP4: hwmod data: Add clock domain attribute
      OMAP2+: hwmod: Init clkdm field at boot time
      OMAP4: hwmod: Replace CLKCTRL absolute address with offset macros
      OMAP: hwmod: Wait the idle status to be disabled
      OMAP4: hwmod: Replace RSTCTRL absolute address with offset macros
      OMAP4: prm: Replace warm reset API with the offset based version
      OMAP4: prm: Remove deprecated functions
      OMAP4: hwmod data: Add PRM context register offset
      OMAP4: hwmod data: Add modulemode entry in omap_hwmod structure
      OMAP4: cm: Add two new APIs for modulemode control
      OMAP4: hwmod: Introduce the module control in hwmod control
      OMAP2+: clockdomain: Add 2 APIs to control clockdomain from hwmod framework

Jon Hunter (1):
      OMAP: Add debugfs node to show the summary of all clocks

Paul Walmsley (3):
      OMAP2+: clockdomain: add clkdm_in_hwsup()
      OMAP2+: clock: allow per-SoC clock init code to prevent clockdomain calls from clock code
      Merge branches 'omap4_clockdomain_hwmod_3.1', 'clock_debugfs_a_3.1', 'omap4_clock_auxclk_3.1' and 'omap_device_a_3.1' into prcm-devel-3.1

Rajendra Nayak (4):
      OMAP4: clock data: Add missing divider selection for auxclks
      OMAP2+: PM: idle clkdms only if already in idle
      OMAP2+: clockdomain: Add per clkdm lock to prevent concurrent state programming
      OMAP2+: hwmod: Follow the recommended PRCM module enable sequence

Vaibhav Bedia (1):
      OMAP: clockdomain: Remove redundant call to pwrdm_wait_transition()

 arch/arm/mach-omap2/clock.c                  |   27 ++-
 arch/arm/mach-omap2/clock.h                  |    3 +
 arch/arm/mach-omap2/clock2420_data.c         |   22 +-
 arch/arm/mach-omap2/clock2430_data.c         |   32 +-
 arch/arm/mach-omap2/clock3xxx_data.c         |   44 ++--
 arch/arm/mach-omap2/clock44xx_data.c         |  215 +++++++++++---
 arch/arm/mach-omap2/clockdomain.c            |  210 +++++++++++---
 arch/arm/mach-omap2/clockdomain.h            |   11 +
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c   |    6 +-
 arch/arm/mach-omap2/clockdomain44xx.c        |   13 +-
 arch/arm/mach-omap2/clockdomains44xx_data.c  |    2 +-
 arch/arm/mach-omap2/cm44xx.h                 |    8 +-
 arch/arm/mach-omap2/cminst44xx.c             |  150 +++++++++-
 arch/arm/mach-omap2/cminst44xx.h             |   10 +-
 arch/arm/mach-omap2/omap_hwmod.c             |  234 +++++++++++++--
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |  412 +++++++++++++++++++++-----
 arch/arm/mach-omap2/pm.c                     |    4 +-
 arch/arm/mach-omap2/prcm.c                   |    2 +-
 arch/arm/mach-omap2/prm44xx.c                |  145 +---------
 arch/arm/mach-omap2/prm44xx.h                |   10 -
 arch/arm/mach-omap2/prminst44xx.c            |  112 +++++++-
 arch/arm/mach-omap2/prminst44xx.h            |   12 +-
 arch/arm/plat-omap/clock.c                   |   39 +++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   14 +-
 arch/arm/plat-omap/omap_device.c             |   85 +++---
 25 files changed, 1346 insertions(+), 476 deletions(-)

omap2plus_defconfig
   text	   data	    bss	    dec	    hex	filename
6349889	 529328	5591048	12470265	 be47f9	vmlinux.orig
6353065	 532816	5591048	12476929	 be6201	vmlinux.patched


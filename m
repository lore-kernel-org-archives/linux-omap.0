From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/5] ARM: omap4 related fixes for 2.6.39
Date: Sat, 12 Feb 2011 16:59:42 +0530
Message-ID: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34418 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988Ab1BLLaA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Feb 2011 06:30:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

The series mainly does below
	- Makes ARM local timers selection runtime instead of compile time.
	- Enables the LOCAL_TIMER support for OMAP4430
	- Add and enable PL310 Errata for flush by Way
	- Fixes the NR_CPU value in omap2plus config
	- Removes the un-necessary omap44xx_sram_init FIXME

Boot tested on OMAP4430 ES1.0 and ES2.X silicons.

The following changes since commit 100b33c8bd8a3235fd0b7948338d6cbb3db3c63d:
  Linus Torvalds (1):
        Linux 2.6.38-rc4

are available in the git repository at:

  git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git omap4-misc_for.39

Santosh Shilimkar (5):
  ARM: smp: Select local timers vs dummy timer support runtime
  omap4: Enable ARM local timers with OMAP4430 es1.0 exception
  ARM: l2x0: Errata fix for flush by Way operation can cause data
    corruption
  omap2plus: omap4: Set NR_CPU to 2 instead of default 4
  omap4: Remove 'FIXME: omap44xx_sram_init not implemented'

 arch/arm/Kconfig                     |   11 +++++++++++
 arch/arm/configs/omap2plus_defconfig |    1 +
 arch/arm/include/asm/localtimer.h    |    8 +++++++-
 arch/arm/kernel/smp.c                |    7 +++----
 arch/arm/mach-msm/timer.c            |    3 ++-
 arch/arm/mach-omap2/Kconfig          |    2 ++
 arch/arm/mach-omap2/timer-mpu.c      |    7 ++++++-
 arch/arm/mach-realview/localtimer.c  |    3 ++-
 arch/arm/mach-s5pv310/localtimer.c   |    3 ++-
 arch/arm/mach-shmobile/localtimer.c  |    3 ++-
 arch/arm/mach-tegra/localtimer.c     |    3 ++-
 arch/arm/mach-ux500/localtimer.c     |    3 ++-
 arch/arm/mach-vexpress/localtimer.c  |    3 ++-
 arch/arm/mm/cache-l2x0.c             |   16 ++++++++++------
 arch/arm/plat-omap/sram.c            |   16 ----------------
 15 files changed, 54 insertions(+), 35 deletions(-)


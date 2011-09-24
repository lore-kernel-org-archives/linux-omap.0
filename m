From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 00/24 V2] OMAP4: PM: suspend, CPU-hotplug and CPUilde support
Date: Sat, 24 Sep 2011 11:44:20 +0530
Message-ID: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42024 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab1IXGO5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 24 Sep 2011 02:14:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

The series adds OMAP4 MPUSS (MPU SubSystem) power management support for
suspend (S2R), CPU hotplug and CPUidle.

This is a repost with minor changelog updates, re-basing against 3.1-rc6,
adding reiwed-by/tested-by etc and re-ordering of errata patch.
The main change is the errata i688 is cleanly separated and kept as
last patch in the series as per Tony's suggestion.

Now Russell's L2 suspend series is merged in his for-next branch and CPU
PM notifiers series pull request is out, most of the dependencies are taken
care. The irq/core patch is also in Thomas's 3.2 queue.

An integrated branch with these branches merged can be found here [1].
The series is tested on OMAP4430 SDP for suspend, hotplug and CPUidle
with OMAP4 GP and HS (secure) devices.

The following changes since commit b6fd41e29dea9c6753b1843a77e50433e6123bcb:

  Linux 3.1-rc6 (2011-09-12 14:02:02 -0700)

are available in the git repository at:
  git://gitorious.org/omap-sw-develoment/linux-omap-dev.git for_3_2/omap4-mpuss-pm

Santosh Shilimkar (24):
      OMAP4: Use WARN_ON() instead of BUG_ON() with graceful exit
      OMAP4: Export omap4_get_base*() rather than global address pointers
      OMAP4: PM: Add SAR RAM support
      OMAP4: PM: Keep static dep between MPUSS-EMIF and MPUSS-L3/L4 and DUCATI-L3
      OMAP4: PM: Avoid omap4_pm_init() on OMAP4430 ES1.0
      OMAP4: PM: Initialise all the clockdomains to supported states
      OMAP: Add Secure HAL and monitor mode API infrastructure.
      OMAP: PM: Add support to allocate the memory for secure RAM
      OMAP4: PM: Add WakeupGen module as OMAP gic_arch_extn
      OMAP4: PM: Add CPUX OFF mode support
      OMAP4: Remove __INIT from omap_secondary_startup() to re-use it for hotplug.
      OMAP4: PM: Program CPU1 to hit OFF when off-lined
      OMAP4: PM: CPU1 wakeup workaround from Low power modes
      OMAP4: PM: Use custom omap_do_wfi() for default idle.
      OMAP4: suspend: Add MPUSS power domain RETENTION support
      OMAP4: Remove un-used do_wfi() macro.
      OMAP4: PM: Add WakeupGen and secure GIC low power support
      OMAP4: PM: Add L2X0 cache lowpower support
      OMAP4: PM: Add MPUSS power domain OSWR support
      OMAP4: PM: Add power domain statistics support
      OMAP4: PM: Add CPUidle support
      OMAP4: cpuidle: Switch to gptimer from twd in deeper C-states.
      OMAP3: CPUidle: Make use of CPU PM notifiers
      OMAP4: Fix errata i688 with MPU interconnect barriers.

 arch/arm/mach-omap2/Kconfig                        |   21 +
 arch/arm/mach-omap2/Makefile                       |   16 +-
 arch/arm/mach-omap2/cpuidle34xx.c                  |   15 +
 arch/arm/mach-omap2/cpuidle44xx.c                  |  218 +++++++++++
 arch/arm/mach-omap2/include/mach/barriers.h        |   31 ++
 arch/arm/mach-omap2/include/mach/omap-secure.h     |   57 +++
 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h  |   39 ++
 arch/arm/mach-omap2/include/mach/omap4-common.h    |   71 +++-
 arch/arm/mach-omap2/omap-headsmp.S                 |    5 -
 arch/arm/mach-omap2/omap-hotplug.c                 |   14 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c          |  398 ++++++++++++++++++++
 arch/arm/mach-omap2/omap-secure.c                  |   81 ++++
 arch/arm/mach-omap2/{omap44xx-smc.S => omap-smc.S} |   23 ++
 arch/arm/mach-omap2/omap-smp.c                     |   45 +++
 arch/arm/mach-omap2/omap-wakeupgen.c               |  387 +++++++++++++++++++
 arch/arm/mach-omap2/omap4-common.c                 |   88 +++++-
 arch/arm/mach-omap2/omap4-sar-layout.h             |   50 +++
 arch/arm/mach-omap2/pm.h                           |    1 +
 arch/arm/mach-omap2/pm44xx.c                       |  156 ++++++++-
 arch/arm/mach-omap2/sleep44xx.S                    |  378 +++++++++++++++++++
 arch/arm/plat-omap/common.c                        |    3 +
 arch/arm/plat-omap/include/plat/omap44xx.h         |    1 +
 arch/arm/plat-omap/sram.c                          |   43 ++-
 23 files changed, 2091 insertions(+), 50 deletions(-)
 create mode 100644 arch/arm/mach-omap2/cpuidle44xx.c
 create mode 100644 arch/arm/mach-omap2/include/mach/barriers.h
 create mode 100644 arch/arm/mach-omap2/include/mach/omap-secure.h
 create mode 100644 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
 create mode 100644 arch/arm/mach-omap2/omap-mpuss-lowpower.c
 create mode 100644 arch/arm/mach-omap2/omap-secure.c
 rename arch/arm/mach-omap2/{omap44xx-smc.S => omap-smc.S} (70%)
 create mode 100644 arch/arm/mach-omap2/omap-wakeupgen.c
 create mode 100644 arch/arm/mach-omap2/omap4-sar-layout.h
 create mode 100644 arch/arm/mach-omap2/sleep44xx.S

Regards,
Santosh

[1] git://gitorious.org/omap-sw-develoment/linux-omap-dev.git for_3_2/omap4_mpuss_pm-integrated

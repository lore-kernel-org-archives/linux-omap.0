From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] OMAP: PM support for OMAP4 MPU sub-system
Date: Thu, 08 Dec 2011 10:45:40 -0800
Message-ID: <874nxaewbv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:47992 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751272Ab1LHSpn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 13:45:43 -0500
Received: by iakk12 with SMTP id k12so3960565iak.35
        for <linux-omap@vger.kernel.org>; Thu, 08 Dec 2011 10:45:42 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Tony,

Please pull the OMAP4 MPUSS PM series below.  It is based on the
Russell's devel-stable branch due to dependencies

Kevin

The following changes since commit 3ee0fc5ca129cbae81c073756febcb1c552af446:

  Merge branch 'kexec/idmap' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into devel-stable (2011-12-06 20:27:54 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.3/pm/omap4-mpuss

Santosh Shilimkar (24):
      ARM: OMAP4: Use WARN_ON() instead of BUG_ON() with graceful exit
      ARM: OMAP4: Export omap4_get_base*() rather than global address pointers
      ARM: OMAP4: PM: Add SAR RAM support
      ARM: OMAP4: PM: Keep static dep between MPUSS-EMIF and MPUSS-L3/L4 and DUCATI-L3
      ARM: OMAP4: PM: Avoid omap4_pm_init() on OMAP4430 ES1.0
      ARM: OMAP4: PM: Initialise all the clockdomains to supported states
      ARM: OMAP: Add Secure HAL and monitor mode API infrastructure.
      ARM: OMAP: PM: Add support to allocate the memory for secure RAM
      ARM: OMAP4: PM: Add WakeupGen module as OMAP gic_arch_extn
      ARM: OMAP4: PM: Add CPUX OFF mode support
      ARM: OMAP4: Remove __INIT from omap_secondary_startup() to re-use it for hotplug.
      ARM: OMAP4: PM: Program CPU1 to hit OFF when off-lined
      ARM: OMAP4: PM: CPU1 wakeup workaround from Low power modes
      ARM: OMAP4: PM: Use custom omap_do_wfi() for default idle.
      ARM: OMAP4: suspend: Add MPUSS power domain RETENTION support
      ARM: OMAP4: Remove un-used do_wfi() macro.
      ARM: OMAP4: PM: Add WakeupGen and secure GIC low power support
      ARM: OMAP4: PM: Add L2X0 cache lowpower support
      ARM: OMAP4: PM: Add MPUSS power domain OSWR support
      ARM: OMAP4: PM: Add power domain statistics support
      ARM: OMAP4: Fix errata i688 with MPU interconnect barriers.
      ARM: OMAP4: PM: Add CPUidle support
      ARM: OMAP4: cpuidle: Switch to gptimer from twd in deeper C-states.
      ARM: OMAP3: CPUidle: Make use of CPU PM notifiers

 arch/arm/mach-omap2/Kconfig                        |   21 +
 arch/arm/mach-omap2/Makefile                       |   16 +-
 arch/arm/mach-omap2/common.h                       |   64 +++-
 arch/arm/mach-omap2/cpuidle34xx.c                  |   15 +
 arch/arm/mach-omap2/cpuidle44xx.c                  |  245 ++++++++++++
 arch/arm/mach-omap2/include/mach/barriers.h        |   31 ++
 arch/arm/mach-omap2/include/mach/omap-secure.h     |   57 +++
 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h  |   39 ++
 arch/arm/mach-omap2/io.c                           |    9 +
 arch/arm/mach-omap2/omap-headsmp.S                 |    5 -
 arch/arm/mach-omap2/omap-hotplug.c                 |   14 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c          |  398 ++++++++++++++++++++
 arch/arm/mach-omap2/omap-secure.c                  |   81 ++++
 arch/arm/mach-omap2/{omap44xx-smc.S => omap-smc.S} |   23 ++
 arch/arm/mach-omap2/omap-smp.c                     |   45 +++
 arch/arm/mach-omap2/omap-wakeupgen.c               |  389 +++++++++++++++++++
 arch/arm/mach-omap2/omap4-common.c                 |   94 +++++-
 arch/arm/mach-omap2/omap4-sar-layout.h             |   50 +++
 arch/arm/mach-omap2/pm.h                           |    1 +
 arch/arm/mach-omap2/pm44xx.c                       |  153 ++++++++-
 arch/arm/mach-omap2/sleep44xx.S                    |  379 +++++++++++++++++++
 arch/arm/plat-omap/common.c                        |    3 +
 arch/arm/plat-omap/include/plat/omap-secure.h      |   13 +
 arch/arm/plat-omap/include/plat/omap44xx.h         |    1 +
 arch/arm/plat-omap/include/plat/sram.h             |    6 +-
 arch/arm/plat-omap/sram.c                          |    8 +
 26 files changed, 2126 insertions(+), 34 deletions(-)
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
 create mode 100644 arch/arm/plat-omap/include/plat/omap-secure.h

From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] PM support for omap4 for v3.3 merge window
Date: Fri, 9 Dec 2011 13:21:56 -0800
Message-ID: <20111209212155.GZ31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:65153 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751899Ab1LIVWA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 16:22:00 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd & Olof,

Please pull omap4 PM support from: 

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap omap4

Note that because of the map_io and common.h changes this is based
on commit deee6d5359969a0ce4e2760cfd7b9f379bd5698a in Russell's
devel-stable.

FYI, other omap SoC related changes that I'll post later will have a
build dependency to this series for the omap-secure.c changes.

Regards,

Tony


The following changes since commit deee6d5359969a0ce4e2760cfd7b9f379bd5698a:
  Tony Lindgren (1):
        ARM: 7194/1: OMAP: Fix build after a merge between v3.2-rc4 and ARM restart changes

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap omap4

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

Tony Lindgren (1):
      Merge branch 'for_3.3/pm/omap4-mpuss' of git://git.kernel.org/.../khilman/linux-omap-pm into omap4

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

From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 00/25] OMAP4: PM: suspend, CPU-hotplug and CPUilde support
Date: Sun, 4 Sep 2011 19:24:01 +0530
Message-ID: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36778 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754545Ab1IDNzs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 4 Sep 2011 09:55:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

This series adds OMAP4 MPUSS (MPU SubSystem) power management support for
suspend (S2R), CPU hotplug and CPUidle.

Most of these patches have been posted and reviewed earlier [1] on the list
and have missed last couple of merge windows because of dependencies.
New set of patches have diverged more and hence the series version
continuity isn't maintained. 

Below are the main updates from previous versions.
- Use of generic ARM suspend hooks instead of OMAP custom code.
- Making use of common GIC code instead of OMAP custom code.
- Use of generic CPU PM notifiers for CPUIDLE and suspend.
- Use of CPU PM notifiers and hotplug notifiers for GIC extension.
- PM support of OMAP4 HS devices.
- Introduction of interconnect barriers as per the OMAP4 requirements.
	
Special thanks to,
- Kevin Hilman for the detailed reviews.
- Russell for adding the L2 cache handling support to generic suspend.
- Colin Cross for the generic CPU PM notifier patches.
- Rajendra Nayak and Paul Walmsley for clock-domain sequencing series.

Below series has dependency on Russell's L2 generic suspend support [2] 
and earlier posted CPU PM notifiers series [3].
An integrated branch with these dependencies can be found here [4].

The series is tested on OMAP4430 SDP for suspend, hotplug and CPUidle
with OMAP4 GP and HS (secure) devices.

The following changes since commit c6a389f123b9f68d605bb7e0f9b32ec1e3e14132:

  Linux 3.1-rc4 (2011-08-28 21:16:01 -0700)

are available in the git repository at:
  git://gitorious.org/omap-sw-develoment/linux-omap-dev.git v3.1-rc4-omap4-mpuss-pm

Santosh Shilimkar (25):
      ARM: mm: Add strongly ordered descriptor support.
      OMAP4: Redefine mandatory barriers for OMAP to include interconnect barriers.
      OMAP4: PM: Use custom omap_do_wfi() for suspend and default idle.
      OMAP4: Remove un-used do_wfi() macro.
      OMAP4: Use WARN_ON() instead of BUG_ON() with graceful exit
      OMAP4: Export omap4_get_base*() rather than global address pointers
      OMAP4: PM: Add SAR RAM support
      OMAP4: PM: Keep static dep between MPUSS-EMIF and MPUSS-L3 and DUCATI-L3
      OMAP4: PM: Avoid omap4_pm_init() on OMAP4430 ES1.0
      OMAP4: PM: Initialise all the clockdomains to supported states
      OMAP: Add Secure HAL and monitor mode API infrastructure.
      OMAP: Add support to allocate the memory for secure RAM
      OMAP4: PM: Add WakeupGen module as OMAP gic_arch_extn
      OMAP4: PM: Add CPUX OFF mode support
      OMAP4: Remove __INIT from omap_secondary_startup() to re-use it for hotplug.
      OMAP4: PM: Program CPU1 to hit OFF when off-lined
      OMAP4: PM: CPU1 wakeup workaround from Low power modes
      OMAP4: suspend: Add MPUSS power domain RETENTION support
      OMAP4: PM: Add WakeupGen and secure GIC low power support
      OMAP4: PM: Add L2X0 cache lowpower support
      OMAP4: PM: Add MPUSS power domain OSWR support
      OMAP4: PM: Add power domain statistics support
      OMAP4: PM: Add CPUidle support
      OMAP4: cpuidle: Switch to gptimer from twd in deeper C-states.
      OMAP3: CPUidle: Make use of CPU PM notifiers

 arch/arm/include/asm/mach/map.h                    |    1 +
 arch/arm/include/asm/pgtable.h                     |    3 +
 arch/arm/mach-omap2/Kconfig                        |    1 +
 arch/arm/mach-omap2/Makefile                       |   15 +-
 arch/arm/mach-omap2/cpuidle34xx.c                  |    7 +
 arch/arm/mach-omap2/cpuidle44xx.c                  |  206 ++++++++++
 arch/arm/mach-omap2/include/mach/barriers.h        |   48 +++
 arch/arm/mach-omap2/include/mach/omap-secure.h     |   57 +++
 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h  |   39 ++
 arch/arm/mach-omap2/include/mach/omap4-common.h    |   70 +++-
 arch/arm/mach-omap2/omap-headsmp.S                 |    5 -
 arch/arm/mach-omap2/omap-hotplug.c                 |   14 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c          |  398 +++++++++++++++++++
 arch/arm/mach-omap2/omap-secure.c                  |   81 ++++
 arch/arm/mach-omap2/{omap44xx-smc.S => omap-smc.S} |   23 ++
 arch/arm/mach-omap2/omap-smp.c                     |   38 ++
 arch/arm/mach-omap2/omap-wakeupgen.c               |  403 ++++++++++++++++++++
 arch/arm/mach-omap2/omap4-common.c                 |   93 +++++-
 arch/arm/mach-omap2/omap4-sar-layout.h             |   50 +++
 arch/arm/mach-omap2/pm.h                           |    1 +
 arch/arm/mach-omap2/pm44xx.c                       |  155 ++++++++-
 arch/arm/mach-omap2/sleep44xx.S                    |  385 +++++++++++++++++++
 arch/arm/mm/mmu.c                                  |    8 +
 arch/arm/plat-omap/common.c                        |    3 +
 arch/arm/plat-omap/include/plat/omap44xx.h         |    1 +
 arch/arm/plat-omap/include/plat/sram.h             |    1 +
 arch/arm/plat-omap/sram.c                          |   47 ++-
 27 files changed, 2104 insertions(+), 49 deletions(-)
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

Regards
Santosh

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg47511.html

[2] http://www.spinics.net/lists/arm-kernel/msg138803.html

[3] https://lkml.org/lkml/2011/9/3/49

[4] https://gitorious.org/omap-sw-develoment/linux-omap-dev/commits/v3.1-rc4-omap4-pm-integrated

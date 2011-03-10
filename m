From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 00/19] OMAP4: PM: Suspend, CPU-hotplug and CPUilde support.
Date: Thu, 10 Mar 2011 19:37:56 +0530
Message-ID: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52812 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752367Ab1CJOI3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 09:08:29 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

V2 updates:
Rebased on latest pm-core branch and fixes below comments
from Kevin Hilman <khilman@ti.com>. 
- All acronym fixes
- Use WARN_ON() instead of BUG_ON() with graceful exit.
- Export omap4_get_base*() rather than global address pointers
- CPUidle prepare() hook + hotplug notifier to manage C-state dynamically.
- Dropped debugfs way of changing C-state valid flags in favor of above.

Full series with cherry-picked dependencies are available on below
git branch. 

git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git
omap4_pm_for-next_v2

This series adds OMAP4 suspend and cpuidle support till MPU subsystem
(MPUSS) off-mode. The suspend on SMP machines uses cpu-hotplug 
infrastructure to take down the non-boot CPUs. We put secondary
CPU(CPU1 in OMAP4) to OFF state via cpu-hotplug.
In cpuidle too, low power states are attempted only when the
CPU1 is put to OFF state via cpu-hotplug because of hardware
constraints.

Timer wakeup from suspend, debug pm counters and enable_off_mode
provisions are supported as well.

Special thanks to Kevin Hilman <khilman@ti.com> for doing detail
off-the list reviews.

The patches are generated against mainline 2.6.38-rc5 and tested with
OMAP4430 SDP and OMAP4 PANDA board. Any OMAP4 board with ES2.X silicon,
below features should work with this series. On ES1.0, these PM 
features are not supported.
	1. CPU hotplug (CPU is put into off-mode)
	2. Suspend (Both CPUs put to off-mode and MPUSS to OFF/RET)
	3. CPUILDE with below C-states.
		C1 - CPU0 ON + CPU1 ON/OFF + MPU ON + CORE ON
		C2 - CPU0 ON + CPU1 OFF + MPU ON + CORE ON
		C3 - CPU0 OFF + CPU1 OFF + MPU CSWR + CORE ON
		C4 - CPU0 OFF + CPU1 OFF + MPU OFF + CORE ON

In OMAP4 mpuss consist of dual Cortex-A9 with per-cpu local timers
GIC(Generic Interrupt Controller), SCU(Snoop Control Unit) and PL310
L2 cache controller and  CPU0/CPU1 LPRM modules.
CPU0, CPU1 and MPUSS have there own power domain and hence multiple
low power state combinations are possible. The CPU10 and CPU1
Close switch Retention(CSWR) isn't supported by hardware.
Based on various studies, measurements, hardware constraints
and recommendations from hardware team, only below low power
modes are supported on OMAP4.
----------------------------------------
CPU0		CPU1		MPUSS
----------------------------------------
ON		ON		ON
OFF		OFF		CSWR
OFF		OFF		OSWR 
OFF		OFF		OFF
-----------------------------------------
Note: CPU0 is the master core and it is the last CPU to go down
and first to wake-up when MPUSS low power states are attempted

OSWR(Open Switch Retention) is not added as part of this series
because it needs some power domain level support which isn't ready
yet.
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg38667.html

Powerdomain INACTIVE support is also dropped because of its 
inconsistency between OMAP4 and OMAP3.
More information  on this thread -
	http://www.spinics.net/lists/linux-omap/msg45370.html

This series has a dependency on few patches from below series.
	- GIC and SCU patches from [1] (queued up in RMK's for-next)
	- Local Timer patches from [2] (queued up in RMK's for-next)
	- Not clearing the static deps hack which is getting sorted out.

The cpu-hotplug and suspend works with omap2plus_defconfig. Not to damage
your file system with current omap2plus_defconfig, disable ARCH_OMAP2 so
that V6 and V7 support is not built together with SMP.
To tryout cpuidle, CONFIG_CPU_IDLE needs to be enabled in the build.

CPU-HOTPLUG commands :
	offline : $echo 0 > /sys/devices/system/cpu/cpu1/online
	online : $echo 1 > /sys/devices/system/cpu/cpu1/online

Suspend :$echo mem > /sys/power/state

cpuilde : To trigger cpuidle deeper C-states on OMAP4, CPU1 needs
	to be offlied
	$echo 0 > /sys/devices/system/cpu/cpu1/online

To see PM debug counters,
	$mount -t debugfs debugfs /proc/sys/debug/
	$cat /proc/sys/debug/pm_debug/count
off-mode debugfs control:
	enable: $echo 1 > /proc/sys/debug/pm_debug/enable_off_mode
	disable: $echo 0 > /proc/sys/debug/pm_debug/enable_off_mode

Summary:

Rajendra Nayak (1):
  OMAP4: cpuidle: Basic CPUidle support

Santosh Shilimkar (18):
  OMAP4: PM: Add omap WakeupGen module support
  OMAP4: Use WARN_ON() instead of BUG_ON() with graceful exit
  OMAP4: PM: Export omap4_get_base*() rather than global address
    pointers
  OMAP4: PM: Add SAR RAM support
  OMAP4: PM: Add CPUX OFF mode support
  OMAP4: PM: Initialise all the clockdomains to supported states
  OMAP4: PM: Program CPU1 to hit OFF when off-lined
  OMAP4: PM: CPU1 wakeup workaround from Low power modes
  OMAP4: PM: Add GIC distributor and interface enable/disable accessory
    api
  OMAP4: PM: Add GIC save/restore support
  OMAP4: PM: Add WakeupGen save/restore support
  OMAP4: PM: Add L2 cache lowpower support
  OMAP4: suspend: Add MPUSS RET and OFF support
  OMAP4: pm-debug: Add wakeup timer and debug counters
  OMAP4: cpuidle: Add MPUSS RET OFF states
  OMAP4: cpuidle: Switch to gptimer from twd in deeper C-states.
  OMAP4: cpuidle: Add CPU hotplug notifier and prepare() hook.
  OMAP4: Remove un-used do_wfi() macro.

 arch/arm/mach-omap2/Makefile                      |    8 +-
 arch/arm/mach-omap2/cpuidle44xx.c                 |  352 ++++++++++++++++
 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h |   41 ++
 arch/arm/mach-omap2/include/mach/omap4-common.h   |   73 +++-
 arch/arm/mach-omap2/omap-hotplug.c                |   30 ++-
 arch/arm/mach-omap2/omap-smp.c                    |   32 ++-
 arch/arm/mach-omap2/omap-wakeupgen.c              |  319 +++++++++++++++
 arch/arm/mach-omap2/omap4-common.c                |   85 ++++-
 arch/arm/mach-omap2/omap4-mpuss-lowpower.c        |  451 +++++++++++++++++++++
 arch/arm/mach-omap2/omap4-sar-layout.h            |   66 +++
 arch/arm/mach-omap2/pm-debug.c                    |   12 +-
 arch/arm/mach-omap2/pm.h                          |    2 +
 arch/arm/mach-omap2/pm44xx.c                      |  119 ++++++-
 arch/arm/mach-omap2/sleep44xx.S                   |  400 ++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap44xx.h        |    1 +
 15 files changed, 1958 insertions(+), 33 deletions(-)
 create mode 100644 arch/arm/mach-omap2/cpuidle44xx.c
 create mode 100644 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
 create mode 100644 arch/arm/mach-omap2/omap-wakeupgen.c
 create mode 100644 arch/arm/mach-omap2/omap4-mpuss-lowpower.c
 create mode 100644 arch/arm/mach-omap2/omap4-sar-layout.h
 create mode 100644 arch/arm/mach-omap2/sleep44xx.S
 
Regrads,
Santosh
[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42939.html
[2] http://www.spinics.net/lists/linux-omap/msg45710.html


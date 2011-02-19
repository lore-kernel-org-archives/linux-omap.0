From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 00/17] omap4: pm: suspend, hotplug and cpuilde support
Date: Sat, 19 Feb 2011 16:12:21 +0530
Message-ID: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50538 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753948Ab1BSKmw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Feb 2011 05:42:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

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

This series has a dependency on few patches from below series which
are posted earlier.
	- Clock domain split series [1] (Already in Paul's queue)  
	- Few power domain patches from [2] (Already in Paul's queue)
	- GIC and SCU patches from [3]
	- Local Timer patches from [4]

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

For testing, I have put together all these patches and dependencies
on below git branch. 

git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git omap4_pm_fornext

Rajendra Nayak (1):
  omap4: cpuidle: Basic CPUidle support

Santosh Shilimkar (16):
  omap4: pm: Add omap WakeupGen module support
  omap4: pm: Add SAR RAM support
  omap4: Export scu base address
  omap4: pm: Add CPUx OFF mode support
  omap4: pm: Initialise all the clockdomains to supported states
  omap4: pm: Program CPU1 to hit OFF when off-lined
  omap4: pm: CPU1 wakeup workaround form Low power modes
  omap4: pm: Add GIC save/restore support
  omap4: pm: Add WakeupGen save/restore support
  omap4: pm: Add L2 cache lowpower support
  omap4: suspend: Add MPUSS RET and OFF support
  omap4: pm-debug: Add wakeup timer and debug counters
  omap4: cpuidle: Add MPUSS RET OFF states
  omap4: cpuidle: Switch to gptimer from twd in deeper C-states.
  omap4: cpuidle: Allow debugfs control through enable_off_mode
  omap4: Remove un-used do_wfi() macro.

 arch/arm/mach-omap2/Makefile                      |    8 +-
 arch/arm/mach-omap2/cpuidle44xx.c                 |  365 +++++++++++++++++
 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h |   41 ++
 arch/arm/mach-omap2/include/mach/omap4-common.h   |   56 +++-
 arch/arm/mach-omap2/omap-hotplug.c                |   31 ++-
 arch/arm/mach-omap2/omap-smp.c                    |   29 ++-
 arch/arm/mach-omap2/omap-wakeupgen.c              |  287 +++++++++++++
 arch/arm/mach-omap2/omap4-common.c                |   28 ++-
 arch/arm/mach-omap2/omap4-mpuss-lowpower.c        |  442 +++++++++++++++++++++
 arch/arm/mach-omap2/omap4-sar-layout.h            |   71 ++++
 arch/arm/mach-omap2/pm-debug.c                    |    8 +-
 arch/arm/mach-omap2/pm.h                          |    3 +
 arch/arm/mach-omap2/pm44xx.c                      |  125 ++++++-
 arch/arm/mach-omap2/sleep44xx.S                   |  398 +++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap44xx.h        |    1 +
 15 files changed, 1870 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm/mach-omap2/cpuidle44xx.c
 create mode 100644 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
 create mode 100644 arch/arm/mach-omap2/omap-wakeupgen.c
 create mode 100644 arch/arm/mach-omap2/omap4-mpuss-lowpower.c
 create mode 100644 arch/arm/mach-omap2/omap4-sar-layout.h
 create mode 100644 arch/arm/mach-omap2/sleep44xx.S


Regrads,
Santosh
[1] http://www.spinics.net/lists/linux-omap/msg44153.html
[2] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg43257.html
[3] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42939.html
[4] http://www.spinics.net/lists/linux-omap/msg45710.html

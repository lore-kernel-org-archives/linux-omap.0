From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 00/15] ARM: OMAP5: PM: Add MPUSS suspend and CPUidle support
Date: Fri, 1 Mar 2013 17:40:49 +0530
Message-ID: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44857 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157Ab3CAMJt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Mar 2013 07:09:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Series adds OMAP5 MPUSS power management support for system wide suspend
and CPUidle. Its heavy re-use from OMAP4 and hence only ~390 odd lines are
needed to add OMAP5 PM support on top of existing OMAP4 PM support.

OMAP5 adds a mercury retention feature which is an enhancement of
existing retention feature to reduce the leakage. No change in
programming model except one time enabling of mercury retention
during init.

One more notable change in OMAP5 vs OMAP4 devices, CPUx power domains
support retention state which lets you hit MPUSS and Core retention with
very low latency C-state.

Series is built on top of my OMAP5 clean-up series posted earlier but there
is no hard dependency as such. For testing though, you also need out
of tree data files and hence I have put together a testing branch which
can be found here [1]

Tested on OMAP4430 SDP, OMAP4460 Panda, OMAP5430 SDP and OMAP5432 Panda
devices with suspend and CPUIdle. On OMAP5 DT build though, there is an
issue with UART wakeup from suspend as discussed already on lists.

Nishanth Menon (1):
  ARM: OMAP5: PM: handle device instance for for coldreset

Santosh Shilimkar (14):
  ARM: OMAP4+: PM: Consolidate MPU subsystem PM code for re-use
  ARM: OMAP5: PM: Update CPU context register offset
  ARM: OMAP4+: PM: Consolidate and use OMAP4 PM code for OMAP5
  ARM: OMAP5: PM: Set MPUSS-EMIF clock-domain static dependency
  ARM: OMAP5: PM: Enables ES2 PM mode by default
  ARM: OMAP5: PM: Enable Mercury retention mode on CPUx powerdomains
  ARM: OMAP5: Add init_late() hook to enable pm initialization
  ARM: OMAP5: PM: Add CPU power off mode support
  ARM: OMAP4+: PM: Restore CPU power state to ON with clockdomain force
    wakeup method
  ARM: OMAP5: PM: Add MPU Open Switch Retention support
  ARM: OMAP5: PM: Add L2 memory power down support
  ARM: OMAP4+: CPUidle: Cleanup idle driver for OMAP5 support
  ARM: OMAP4+: CPUidle: Deprecate use of
    omap4_mpuss_read_prev_context_state()
  ARM: OMAP4+: CPUidle: Add OMAP5 idle driver support

 arch/arm/mach-omap2/Kconfig                        |    1 +
 arch/arm/mach-omap2/Makefile                       |   13 +-
 arch/arm/mach-omap2/board-generic.c                |    1 +
 arch/arm/mach-omap2/common.h                       |    8 +-
 .../{cpuidle44xx.c => cpuidle_omap4plus.c}         |  133 ++++++++++++++++---
 arch/arm/mach-omap2/io.c                           |    8 ++
 arch/arm/mach-omap2/omap-mpuss-lowpower.c          |  134 ++++++++++++++------
 arch/arm/mach-omap2/omap-secure.h                  |    9 ++
 arch/arm/mach-omap2/omap-smp.c                     |   12 +-
 arch/arm/mach-omap2/omap-wakeupgen.c               |   25 +++-
 arch/arm/mach-omap2/omap-wakeupgen.h               |    1 +
 arch/arm/mach-omap2/omap4-sar-layout.h             |    2 +
 arch/arm/mach-omap2/{pm44xx.c => pm_omap4plus.c}   |  111 +++++++++++-----
 arch/arm/mach-omap2/prminst44xx.c                  |   10 +-
 .../mach-omap2/{sleep44xx.S => sleep_omap4plus.S}  |  133 +++++++++++++++++++
 15 files changed, 498 insertions(+), 103 deletions(-)
 rename arch/arm/mach-omap2/{cpuidle44xx.c => cpuidle_omap4plus.c} (61%)
 rename arch/arm/mach-omap2/{pm44xx.c => pm_omap4plus.c} (66%)
 rename arch/arm/mach-omap2/{sleep44xx.S => sleep_omap4plus.S} (74%)

Regards,
Santosh

[1] git://github.com/SantoshShilimkar/linux.git	testing/3.10/omap5-int-rebuild

-- 
1.7.9.5


From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 00/10] ARM: OMAP4: Add PMU Support
Date: Thu, 7 Jun 2012 16:22:02 -0500
Message-ID: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56647 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932960Ab2FGVXF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 17:23:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Jon Hunter <jon-hunter@ti.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

This series adds PMU support for OMAP4 devices. This is based upon Will Deacons
series [1]. This series fixes the management of the EMU power domain so that
PMU can be enabled at runtime and low-power states are not prevented when PMU
is not in-use. The fix is based upon inputs from Benoit, Paul and Kevin [2].

This series also converts OMAP2/3 devices to use HWMOD to create the PMU device
and add a new file to mach-omap2 directory called pmu.c where the PMU devices
are created.

This series is based upon the latest linux-omap master branch from Tony
(3.5-rc1).

Testing:
- Verified that PMU is working on OMAP3430 Beagle Board, OMAP4430 Blaze and
  4460 Panda.
- Tested on the above boards with CPU-idle enabled to ensure that PMU is working
  with power management. For OMAP4 boards I have disabled CPU1 so that CPU0 and
  hence the MPU power domain is reaching the low-power retention state.
- I have booted the kernel on an OMAP2430 SDP but not verified PMU is working.
- Unable to verify 4470 Blaze because kernel is not currently booting.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git perf/omap4
[2] http://marc.info/?l=oprofile-list&m=133657425417229&w=3

Cc: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>

Jon Hunter (8):
  ARM: PMU: Add runtime PM Support
  ARM: OMAP2+: PMU: Convert OMAP2/3 devices to use HWMOD
  ARM: OMAP4: Re-map the CTIs IRQs from MPU to DEBUGSS
  ARM: OMAP2+: PMU: Add runtime PM support
  ARM: OMAP4: CLKDM: Update supported transition modes
  ARM: OMAP4: Prevent EMU power domain transitioning to OFF when in-use
  ARM: OMAP4: Enable PMU for OMAP4460/70
  ARM: OMAP2+: PMU: Add QoS constraint

Ming Lei (2):
  ARM: OMAP4430: Create PMU device via HWMOD
  ARM: OMAP4: Route PMU IRQs to CTI IRQs

 arch/arm/include/asm/pmu.h                         |   20 +-
 arch/arm/kernel/perf_event.c                       |   41 +++-
 arch/arm/mach-omap2/Makefile                       |    1 +
 arch/arm/mach-omap2/clockdomain44xx.c              |    7 +-
 arch/arm/mach-omap2/clockdomains44xx_data.c        |    2 +-
 arch/arm/mach-omap2/cminst44xx.c                   |   14 --
 arch/arm/mach-omap2/devices.c                      |   33 ---
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    6 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    6 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   11 +-
 arch/arm/mach-omap2/pmu.c                          |  251 ++++++++++++++++++++
 arch/arm/plat-omap/include/plat/irqs.h             |    1 +
 arch/arm/plat-omap/include/plat/omap44xx.h         |    3 +
 13 files changed, 328 insertions(+), 68 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pmu.c

-- 
1.7.9.5


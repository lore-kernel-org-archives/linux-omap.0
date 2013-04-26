From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 0/6] ARM; OMAP2+: hwmod and SERIAL: Remove sysc handling from driver
Date: Fri, 26 Apr 2013 16:24:49 +0530
Message-ID: <1366973695-2088-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42827 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759275Ab3DZKze (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Apr 2013 06:55:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: santosh.shilimkar@ti.com, linux@arm.linux.org.uk, paul@pwsan.com, khilman@deeprootsystems.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

changes in v2:
---
1. Addressed the concerns from Paul Wamsley around cleanups in
_enable_wakeup()/_disable_wakeup(), and left them intact
2. Updates in changelogs in the serial patch about changes
needed when dma support is added back for serial
3. Dropped 1/8 from v1 since its already pulled in

The patches are based of 'fixes-non-critical' branch of
'git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap' tree
since patch 1/8 from v1 was pulled in here.

Patches can be found here:
git://github.com/rrnayak/linux.git sysc-cleanups
---

OMAP UART IP needs manual idle modes based on functional state of the
IP. Currently this is handled by the driver with function pointers
implemented in platform code.

This however breaks in case of device tree because of missing
idle handling. 

The series tries to address the issue and tries to remove complete
sysc handling from serial driver.

Patches has been tested on OMAP4430 SDP and OMAP5 EVM where the console
sluggishness was observed without idle mode handling. CPUIDLE and
suspend tested ok on these devices.

Thanks to Vaibhav Bedia for testing on Beaglebone(AM33XX) with suspend and
also the UART async wakeup from suspend.

Thanks to Sourav Poddar for Beagle XM(OMAP3630) devices testing with
retention and offmode in Idle and suspend for non-DT builds.

Serial driver platform code still has one more function pointer
left which is used to trigger io_ring(). This one needs some
discussion with pincontrol driver folks on how to implement
such a feature with generic pincontrol driver.

Rajendra Nayak (2):
  ARM: OMAP2+: hwmod: Fix sidle programming in
    _enable_sysc()/_idle_sysc()
  ARM: OMAP2+: hwmod: Add a new flag to handle SIDLE in SWSUP only in
    active

Santosh Shilimkar (4):
  ARM: OMAP2+: hwmod-data: UART IP needs software control to manage
    sidle modes
  SERIAL: OMAP: Remove the slave idle handling from the driver
  ARM: OMAP2+: serial: Remove the un-used slave idle hooks
  ARM: OMAP2+: hwmod: Remove sysc slave idle and auto idle apis

 arch/arm/mach-omap2/omap_hwmod.c                   |  111 +++++---------------
 arch/arm/mach-omap2/omap_hwmod.h                   |    7 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    3 +
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    6 ++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    4 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 +-
 arch/arm/mach-omap2/serial.c                       |   31 ------
 drivers/tty/serial/omap-serial.c                   |   23 ----
 include/linux/platform_data/serial-omap.h          |    2 -
 9 files changed, 48 insertions(+), 145 deletions(-)

-- 
1.7.9.5


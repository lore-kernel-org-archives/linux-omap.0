From: Charulatha V <charu@ti.com>
Subject: [PATCH 0/5] OMAP: GPIO: use PM runtime framework
Date: Mon, 28 Feb 2011 16:27:45 +0530
Message-ID: <1298890670-5481-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54282 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740Ab1B1K4b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 05:56:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, paul@pwsan.com, Charulatha V <charu@ti.com>

Use PM runtime framework in OMAP GPIO driver.

Patch series is based on LO Kernel omap_for_linus branch.

Dependency patches to test system wide suspend on omap_for_linus branch:
https://patchwork.kernel.org/patch/550551/
https://patchwork.kernel.org/patch/513481/

Compile tested for:
 - omap1_defconfig
 - omap2plus_defconfig

Boot test (success on the following boards):
 - OMAP1710-H3
 - OMAP2420-H4
 - OMAP2430-SDP (Tested-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>)
 - OMAP3430-SDP
 - OMAP3630-Zoom3
 - OMAP4430-Blaze
 - OMAP4430-SDP

GPIO module functionality testing (success on the following boards):
 - OMAP2420-H4
 - OMAP2430-SDP (Tested-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>)
 - OMAP3430-SDP
 - OMAP3630-Zoom3
 - OMAP4430-Blaze
 - OMAP4430-SDP

PM Testing:
OMAP3430-SDP(success):
 - retention
 - off_mode
 - system_wide suspend
OMAP3630-Zoom3(success):
 - retention
 - off_mode
 - system_wide suspend
 - wakeup test

using the following:
echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout
echo '3' > /debug/pm_debug/wakeup_timer_seconds
echo 1 > /debug/pm_debug/sleep_while_idle
echo 1 > /debug/pm_debug/enable_off_mode
echo mem > /sys/power/state
cat /debug/pm_debug/count

Link to previous patch series for GPIO PM runtime framework adaptation
as part of GPIO hwmod adaptation series:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg35123.html
https://patchwork.kernel.org/patch/189832/

Charulatha V (5):
  OMAP: GPIO: Make gpio_context part of gpio_bank structure
  OMAP: GPIO: Use pwrdmn name to find wkup dmn GPIO
  OMAP4: GPIO: Save/restore context
  OMAP: GPIO: handle save/restore ctxt in GPIO driver
  OMAP: GPIO: Use PM runtime framework

 arch/arm/mach-omap2/gpio.c             |    6 +
 arch/arm/mach-omap2/pm24xx.c           |    2 +-
 arch/arm/mach-omap2/pm34xx.c           |   20 +-
 arch/arm/plat-omap/gpio.c              |  563 ++++++++++++++++++--------------
 arch/arm/plat-omap/include/plat/gpio.h |    5 +-
 5 files changed, 330 insertions(+), 266 deletions(-)


From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 00/15] OMAP: GPIO: Cleanup OMAP GPIO driver
Date: Tue, 24 May 2011 19:54:39 +0530
Message-ID: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37629 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756325Ab1EXOZQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 May 2011 10:25:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Do some more cleanup of OMAP GPIO driver and avoid usage of gpio_bank_count
and gpio_bank pointer array by means of maintaining a list.

Patch series is on following commit of linux-omap-pm (branch: wip/gpio-cleanup):
commit d04952091a3b9b4b47696cee48e92a9173fd9ffb
GPIO: OMAP: cleanup show revision, remove cpu_is checks, display only once

Diff summary between RFC(prev version) and this version:
*Patches 0012*-0015* are added to the series
*Call gpio_save(restore)_context from OMAP GPIO driver instead
of calling them from PM sepcific funcs
	-For this, few more patches (patches 0004*-8*) are added
		to the series
*Move mpuio_init() from probe() to omap_gpio_mod_init()
*Correctly add the wake set/clear/status regs offsets at omap16xx_gpio_regs
*Remove usage of unnecessary variable "offset" locally inside prepare_for_idle()
*wake_set/clear related access is done only after validity check

Links to previous version (RFC) of this series:
https://patchwork.kernel.org/patch/787692/
https://patchwork.kernel.org/patch/787742/
https://patchwork.kernel.org/patch/787762/
https://patchwork.kernel.org/patch/787722/
https://patchwork.kernel.org/patch/787712/
https://patchwork.kernel.org/patch/787732/
http://permalink.gmane.org/gmane.linux.ports.arm.omap/57524

Test Details:
Compile tested for omap1_defconfig and omap2plus_defconfig.
Bootup success on OMAP1710-H3.
Functional testing success on OMAP2430-SDP, OMAP3430-SDP, OMAP4430-SDP.
PM Testing success on OMAP3430-SDP: retention, off_mode, system_wide
suspend and gpio wakeup.

Charulatha V (12):
  OMAP: GPIO: Avoid cpu_is checks during module ena/disable
  OMAP2PLUS: GPIO: Fix non-wakeup GPIO and rev_ids
  OMAP: GPIO: Remove dependency on gpio_bank_count
  OMAP2PLUS: GPIO: Use flag to identify wkup dmn GPIO
  OMAP: GPIO: Make gpio_context part of gpio_bank structure
  OMAP4: GPIO: Save/restore context
  OMAP: GPIO: handle save/restore ctx in GPIO driver
  OMAP2+: GPIO: make workaround_enabled bank specific
  OMAP: GPIO: Fix: use wake set/clear regs
  OMAP: GPIO: clean set_gpio_triggering function
  OMAP: GPIO: Use memset for omap_gpio_reg_offs
  OMAP: GPIO: clean omap_gpio_mod_init function

Tarun Kanti DebBarma (3):
  OMAP: GPIO: cleanup suspend and resume functions
  OMAP: GPIO: cleanup prepare/resume idle functions
  OMAP: GPIO: Remove hardcoded offsets in ctxt save/restore

 arch/arm/mach-omap1/gpio15xx.c             |   42 +-
 arch/arm/mach-omap1/gpio16xx.c             |   55 ++-
 arch/arm/mach-omap1/gpio7xx.c              |   42 +-
 arch/arm/mach-omap2/gpio.c                 |   53 ++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 arch/arm/mach-omap2/pm34xx.c               |   22 +-
 arch/arm/plat-omap/include/plat/gpio.h     |   20 +-
 drivers/gpio/gpio_omap.c                   |  797 ++++++++++------------------
 10 files changed, 438 insertions(+), 599 deletions(-)


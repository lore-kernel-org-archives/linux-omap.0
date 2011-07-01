From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v3 00/20] GPIO: OMAP: driver cleanup and fixes
Date: Fri, 1 Jul 2011 15:16:54 +0530
Message-ID: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59291 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161Ab1GAJrS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 05:47:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, Tarun Kanti DebBarma <tarun.kanti@ti.com>

This series is continuation of cleanup of OMAP GPIO driver and fixes.
The cleanup include getting rid of cpu_is_* checks wherever possible,
use of gpio_bank list instead of static array, use of unique platform
specific value associated data member to OMAP platforms to avoid
cpu_is_* checks. The series also include PM runtime support.

Baseline: git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
Branch: wip/gpio-cleanup

Test Details:
- Compile tested for omap1_defconfig and omap2plus_defconfig.
- OMAP1710-H3: Bootup test.
- OMAP2430-SDP, OMAP3430-SDP, OMAP4430-SDP: Functional testing. 
- PM Testing on OMAP3430-SDP: retention, off_mode, system_wide
  suspend and gpio wakeup.

Following patch is required for testing retention and off-mode:
https://patchwork.kernel.org/patch/834372/
OMAP: PM: omap_device: fix device power domain callbacks

v3:
- Avoid use of wkup_set and wkup_clear registers. Instead use wkup_status
  register for all platforms. This is because on OMAP4 it is recommended
  not to use them.

- Remove duplicate code in omap_gpio_mod_init() for handling the same for
  32-bit and 16-bit GPIO bank widths. This is accomplished by having two
  functions to handle each case while assiging a common function pointer
  during initialization.
  
- Remove OMAP16xx specific one time initialization from omap_gpio_mod_init().
  Move it inside omap16xx_gpio_init().

- Avoid usage of USHRT_MAX to indicate undefined values. Use 0 instead.

- In omap_gpio_suspend()/resume() functions remove code that checks
  if the feature is supported. Instead, assign these functions to
  struct platform_driver's suspend & resume function pointers for those
  OMAP platforms whcih support this feature.

- Remove 'suspend_support' flag because it is redundant. Instead use
  wkup_* registers to decode the same information.

- Restore context also when we don't know if the context is lost.

- Make omap_gpio_save_context() and omap_gpio_restore_context()
  static.

v2:
- Do special handling of non-wakeup GPIOs only on OMAP2420. Avoid this
  handling on OMAP3430.
- Isolate cleanups and fixes into separate set of patches. Keep the cleanup
  first followed by the fixes.
- Avoid calling omap_gpio_get_context_loss() directly and instead call it
  through function pointer in pdata initialized during init.
- workaround_enabled flag is not longer needed and is removed.
- Call pwrdm_post_transition() before calling omap_gpio_resume_after_idle().
- In omap2_gpio_resume_after_idle() do context restore before handling
  workaround.
- Use PM runtime framework.
- Modify register offset names to : wkup_status, wkup_clear, wkup_set.
  Also use 'base + offset' for readibility in all relevant places.
- Remove unwanted messages from commit section like TODO, etc.


Charulatha V (15):
  GPIO: OMAP: Remove dependency on gpio_bank_count
  GPIO: OMAP2+: Use flag to identify wakeup domain
  GPIO: OMAP: Make gpio_context part of gpio_bank structure
  GPIO: OMAP: Fix pwrdm_post_transition call sequence
  GPIO: OMAP: Handle save/restore ctx in GPIO driver
  GPIO: OMAP2+: Make non-wakeup GPIO part of pdata
  GPIO: OMAP: Avoid cpu checks during module ena/disable
  GPIO: OMAP: Use wkup regs off/suspend support flag
  GPIO: OMAP: Use level/edge detect reg offsets
  GPIO: OMAP: Clean set_gpio_triggering function
  GPIO: OMAP15xx: Use pinctrl offset instead of macro
  GPIO: OMAP: Use readl in irq_handler for all access
  GPIO: OMAP: Remove bank->method & METHOD_* macros
  GPIO: OMAP: Fix bankwidth for OMAP7xx MPUIO
  GPIO: OMAP: Use PM runtime framework

Tarun Kanti DebBarma (5):
  GPIO: OMAP: Remove hardcoded offsets in ctxt save/restore
  GPIO: OMAP: Use wkup_status for all SoCs
  GPIO: OMAP: Clean omap_gpio_mod_init function
  GPIO: OMAP: optimize suspend and resume functions
  GPIO: OMAP2+: Clean prepare_for_idle and resume_after_idle

 arch/arm/mach-omap1/gpio15xx.c         |    7 +-
 arch/arm/mach-omap1/gpio16xx.c         |   31 +-
 arch/arm/mach-omap1/gpio7xx.c          |   14 +-
 arch/arm/mach-omap2/gpio.c             |   47 ++-
 arch/arm/mach-omap2/pm34xx.c           |   21 +-
 arch/arm/plat-omap/include/plat/gpio.h |   31 +-
 drivers/gpio/gpio-omap.c               | 1070 +++++++++++++-------------------
 7 files changed, 533 insertions(+), 688 deletions(-)


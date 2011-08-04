From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v5 00/22] gpio/omap: driver cleanup and fixes
Date: Thu, 4 Aug 2011 16:34:31 +0530
Message-ID: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41592 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753428Ab1HDLF1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Aug 2011 07:05:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

This series is continuation of cleanup of OMAP GPIO driver and fixes.
The cleanup include getting rid of cpu_is_* checks wherever possible,
use of gpio_bank list instead of static array, use of unique platform
specific value associated data member to OMAP platforms to avoid
cpu_is_* checks. The series also include PM runtime support.*

Baseline: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
Branch: master
Commit: 02f8c6a (Linux 3.0)

The patch series was applied on the mainline on top of Kevin's gpio cleanup
patch series taken from following location:
git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
Branch: for_3.1/gpio-cleanup-2

Test Details:
- Compile tested for omap1_defconfig and omap2plus_defconfig.
- OMAP1710-H3: Bootup test.
- OMAP2430/SDP, OMAP3430/SDP, OMAP4430/SDP, 4430/Blaze: Functional testing. 
- PM Testing on OMAP3430-SDP: retention, off_mode, system_wide
  suspend and gpio wakeup.

v5:
- Reduce runtime callback overhead when *_get/put_sync() called from probe()
  and *_gpio_request/free().

- Dynamic context save within functions where context is modified instead of
  saving all context within a common function.

- Removed call to mpuio_init() from omap_gpio_mod_init(). Both the functions are
  called once during initialization in *_gpio_probe().
  Call to omap_gpio_mod_init() has been removed from omap_gpio_request() on the
  first access to gpio bank. One time initialization looks sufficient.

- In *_gpio_irq_handler() use *_put_sync_suspend() instead of *_put_sync().

- Removed hardcoding of OMAP16xx sysconfig register value and instead defined an
  associated constant.

- Removed *_get_sync() call from *_gpio_suspend() and *_put_sync() call from
  *_gpio_resume(). They got wrongly slipped into the code.

- Removed following redundant zero allocated initialization from mach-omap2/gpio.c
+	pdata->regs->irqctrl = 0;
+	pdata->regs->edgectrl1 = 0;
+	pdata->regs->edgectrl2 = 0;

- Removed following redundant code in gpio-omap.c
  -#define bank_is_mpuio(bank)	((bank)->method == METHOD_MPUIO)

v4:
- since all accesses to registers are 4-byte aligned, removing special
  checks and handling of 16 and 32-bit wide bank registers and instead
  use 32-bit read/write access consistently.
  
- redundant usage of MOD_REG_BIT has been corrected and replaced with
  _gpio_rmw().
  
- omap_gpio_mod_init() function has been simplified further using _gpio_rmw().

- sysconfig register offset specific to omap16xx has been removed along
  with its usage.

- additional logic to skip from suspend/resume:
  
  if (!bank->regs->wkup_status || !bank->suspend_wakeup)
  	return 0;
  
  if (!bank->regs->wkup_status || !bank->saved_wakeup)
  	return 0;
  	
- separated mpuio related changes into a different patch from the patch where
  wakeup status register related changes are done.

- Incorrect replacement of !cpu_class_is_omap2() in gpio_irq_type()
  corrected:
+	if (!bank->regs->leveldetect0 &&
+		(type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
 		return -EINVAL;

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

Charulatha V (12):
  gpio/omap: remove dependency on gpio_bank_count
  gpio/omap: use flag to identify wakeup domain
  gpio/omap: make gpio_context part of gpio_bank structure
  gpio/omap: fix pwrdm_post_transition call sequence
  gpio/omap: handle save/restore ctx in GPIO driver
  gpio/omap: make non-wakeup GPIO part of pdata
  gpio/omap: avoid cpu checks during module ena/disable
  gpio/omap: cleanup omap1 related macros
  gpio/omap: use pinctrl offset instead of macro
  gpio/omap: use readl in irq_handler for all access
  gpio/omap: remove bank->method & METHOD_* macros
  gpio/omap: fix bankwidth for OMAP7xx MPUIO

Tarun Kanti DebBarma (10):
  gpio/omap: further cleanup using wakeup_status register
  gpio/omap: use level/edge detect reg offsets
  gpio/omap: remove hardcoded offsets in ctxt save/restore
  gpio/omap: cleanup set_gpio_triggering function
  gpio/omap: cleanup omap_gpio_mod_init function
  gpio/omap: use pm-runtime framework
  gpio/omap: optimize suspend and resume functions
  gpio/omap: cleanup prepare_for_idle and resume_after_idle
  gpio/omap: skip operations in runtime callbacks
  gpio/omap: remove omap_gpio_save_context overhead

 arch/arm/mach-omap1/gpio15xx.c         |    7 +-
 arch/arm/mach-omap1/gpio16xx.c         |   46 ++-
 arch/arm/mach-omap1/gpio7xx.c          |   14 +-
 arch/arm/mach-omap2/gpio.c             |   43 ++-
 arch/arm/mach-omap2/pm34xx.c           |   21 +-
 arch/arm/plat-omap/include/plat/gpio.h |   29 +-
 drivers/gpio/gpio-omap.c               | 1054 +++++++++++++-------------------
 7 files changed, 521 insertions(+), 693 deletions(-)


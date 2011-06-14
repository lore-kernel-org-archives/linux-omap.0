From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v2 00/18] GPIO: OMAP: Driver Cleanup and Fixes
Date: Tue, 14 Jun 2011 19:01:43 +0530
Message-ID: <1308058321-12875-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, santosh.shilimkar@ti.com, Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This series is continuation of cleanup of OMAP GPIO driver and fixes.
The cleanup include getting rid of cpu_is_* checks wherever possible,
use of gpio_bank list instead of static array, use of unique platform
specific value associated data member to OMAP platforms to avoid
cpu_is_* checks. The series also include PM runtime support.

Baseline: git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
Branch: wip/gpio-cleanup
commit 1bb718191ab0158837ea6633d6fbdeb08fb755dc
GPIO: OMAP: cleanup show revision, remove cpu_is checks, display only once

v2:
(1) Do special handling of non-wakeup GPIOs only on OMAP2420. Avoid this
handling on OMAP3430.

(2) Isolate cleanups and fixes into separate set of patches. Keep the cleanup
first followed by the fixes.

(3) Avoid calling omap_gpio_get_context_loss() directly and instead call it
through function pointer in pdata initialized during init.

(4) workaround_enabled flag is not longer needed and is removed.

(5) Call pwrdm_post_transition() before calling omap_gpio_resume_after_idle().

(6) In omap2_gpio_resume_after_idle() do context restore before handling
workaround.

(7) Use PM runtime framework.

(8) Modify register offset names to : wkup_status, wkup_clear, wkup_set.
Also use 'base + offset' for readibility in all relevant places.

(9) Remove unwanted messages from commit section like TODO, etc.

Test Details:
* Compile tested for omap1_defconfig and omap2plus_defconfig.
* OMAP1710-H3: Bootup test.
* OMAP2430-SDP, OMAP3430-SDP, OMAP4430-SDP: Functional testing. 
* PM Testing on OMAP3430-SDP: retention, off_mode, system_wide
suspend and gpio wakeup.

Charulatha V (13):
  OMAP: GPIO: Remove dependency on gpio_bank_count
  OMAP2PLUS: GPIO: Use flag to identify wakeup domain
  OMAP: GPIO: Make gpio_context part of gpio_bank structure
  OMAP: GPIO: Fix pwrdm_post_transition call sequence
  OMAP: GPIO: handle save/restore ctx in GPIO driver
  OMAP2PLUS: GPIO: make non-wakeup GPIO part of pdata
  OMAP: GPIO: Avoid cpu checks during module ena/disable
  OMAP: GPIO: clean set_gpio_triggering function
  OMAP: GPIO: clean omap_gpio_mod_init function
  OMAP15xx: GPIO: Use pinctrl offset instead of macro
  OMAP: GPIO: Fix use of readl/readw to access isr_reg
  OMAP: GPIO: Remove bank->method & METHOD_* macros
  OMAP: GPIO: Fix bankwidth for OMAP7xx MPUIO

Tarun Kanti DebBarma (5):
  OMAP: GPIO: Use wkup regs off/suspend support flag
  OMAP: GPIO: Use level/edge detect reg offsets
  OMAP: GPIO: Remove hardcoded offsets in ctxt save/restore
  OMAP: GPIO: use PM runtime framework
  OMAP2: GPIO: clean prepare_for_idle and resume_after_idle

 arch/arm/mach-omap1/gpio15xx.c         |    7 +-
 arch/arm/mach-omap1/gpio16xx.c         |   20 +-
 arch/arm/mach-omap1/gpio7xx.c          |   14 +-
 arch/arm/mach-omap2/gpio.c             |   52 ++-
 arch/arm/mach-omap2/pm34xx.c           |   21 +-
 arch/arm/plat-omap/include/plat/gpio.h |   35 +-
 drivers/gpio/gpio-omap.c               | 1082 ++++++++++++++------------------
 7 files changed, 572 insertions(+), 659 deletions(-)

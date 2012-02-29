From: Robert Lee <rob.lee@linaro.org>
Subject: [PATCH v6 0/9] Consolidate cpuidle functionality
Date: Tue, 28 Feb 2012 21:11:40 -0600
Message-ID: <1330485109-7327-1-git-send-email-rob.lee@linaro.org>
Mime-Version: 1.0
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: len.brown@intel.com, khilman@ti.com
Cc: robherring2@gmail.com, Baohua.Song@csr.com, amit.kucheria@linaro.org, nicolas.ferre@atmel.com, linux@maxim.org.za, kgene.kim@samsung.com, amit.kachhap@linaro.org, magnus.damm@gmail.com, nsekhar@ti.com, daniel.lezcano@linaro.org, mturquette@linaro.org, vincent.guittot@linaro.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, deepthi@linux.vnet.ibm.com, broonie@opensource.wolfsonmicro.com, nicolas.pitre@linaro.org, linux@arm.linux.org.uk, jean.pihet@newoldbits.com, venki@google.com, ccross@google.com, g.trinabh@gmail.com, kernel@wantstofly.org, lethal@linux-sh.org, jon-hunter@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch series moves various functionality duplicated in platform 
cpuidle drivers to the core cpuidle driver. Also, the platform irq
disabling was removed as it appears that all calls into 
cpuidle_call_idle will have already called local_irq_disable().

NOTE to Maintainers: Platform code changes are not required due to patch 1/9
but please review and push these platform changes as possible to allow
this consolidation to occur.

Based on 3.3-rc5 plus recent exynos cpuidle patch (affect exynos cpuidle only):
http://www.spinics.net/lists/linux-samsung-soc/msg09467.html

v5 submission can be found here:
http://www.spinics.net/lists/arm-kernel/msg161596.html
Changes since v5:
* Fixed mindless bug in CONFIG_ARCH_HAS_RELAX code in drivers/cpuidle/cpuidle.c
* Removed inline from wrapper function (thanks Mike Turquette and Rob Herring)
* Add zeroing out of last_residency if error value is returned (thanks Mike)
* Made drivers/cpuidle/cpuidle.c more intelligently handle en_core_tk_irqen
flag allowing removal of the if (en_core_tk_irqen) in cpuidle_idle_call (thanks
Daniel Lezcano)
* Moved CPUIDLE_ARM_WFI_STATE macro to arch/arm/include/asm/cpuidle.h (thanks
Jean Pihet)
* Cleaned up some comments and a stray change (thanks Jean)


v4 submission can be found here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/082742.html

Changes since v4:
* Added common cpu_do_idle function to core cpuidle
* Added time keep irq en wrapper to core cpuidle
* Removed pre/post enter
* Re-added platforms that can use new common code.

v3 submission can be found here:
http://www.spinics.net/lists/arm-kernel/msg156751.html
Changes since v3:
* Removed drivers/cpuidle/common.c
** Removed the initialization helper functions
** Removed the wrapper used to consolidate time keeping and irq enable/disable
* Add time keeping and local_irq_disable handling in cpuidle_call_idle().
* Made necessary modifications to a few platforms that required the most changes
** Note on omap3: changed structure of omap3_idle_drvdata and added
  per_next_state and per_saved_state vars to accomodate new framework.

v2 submission can be found here:
http://comments.gmane.org/gmane.linux.ports.arm.kernel/144199

Changes since v2:
* Made various code organization and style changes as suggested in v1 review.
* Removed at91 use of common code.  A separate effort is underway to clean
at91 code and the author has offered to convert to common interface as part
of those changes (if this common interface is accepted in time).
* Made platform cpuidle_driver objects __initdata and dynamically added one
persistent instance of this object in common code.
* Removed imx5 pm usage of gpc_dvfs clock as it is no longer needed after
being enabled during clock initialization.
* Re-organized patches.

v1 submission can be found here:
http://comments.gmane.org/gmane.linux.ports.arm.kernel/142791

Changes since v1:
* Common interface moved to drivers/cpuidle and made non arch-specific.
* Made various fixes and suggested additions to the common cpuidle
code from v1 review.
* Added callback for filling in driver_data field as needed.
* Modified the various platforms with these changes.

Robert Lee (9):
  cpuidle: Add common time keeping and irq enabling
  ARM: at91: Consolidate time keeping and irq enable
  ARM: exynos: Consolidate time keeping and irq enable
  ARM: kirkwood: Consolidate time keeping and irq enable
  ARM: davinci: Consolidate time keeping and irq enable
  ARM: omap: Consolidate OMAP3 time keeping and irq enable
  ARM: omap: Consolidate OMAP4 time keeping and irq enable
  ARM: shmobile: Consolidate time keeping and irq enable
  SH: shmobile: Consolidate time keeping and irq enable

 arch/arm/include/asm/cpuidle.h        |   14 +++++
 arch/arm/mach-at91/cpuidle.c          |   67 +++++++++----------------
 arch/arm/mach-davinci/cpuidle.c       |   78 +++++++++++-----------------
 arch/arm/mach-exynos/cpuidle.c        |   53 ++-----------------
 arch/arm/mach-kirkwood/cpuidle.c      |   72 ++++++++------------------
 arch/arm/mach-omap2/cpuidle34xx.c     |   42 ++++++---------
 arch/arm/mach-omap2/cpuidle44xx.c     |   21 +-------
 arch/arm/mach-shmobile/cpuidle.c      |   23 +-------
 arch/sh/kernel/cpu/shmobile/cpuidle.c |   10 +---
 drivers/cpuidle/cpuidle.c             |   90 ++++++++++++++++++++++++++-------
 include/linux/cpuidle.h               |   13 +++++
 11 files changed, 207 insertions(+), 276 deletions(-)
 create mode 100644 arch/arm/include/asm/cpuidle.h


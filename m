From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 24/25] ARM: pm: hide 1st and 2nd arguments to cpu_suspend
 from platform code
Date: Thu, 23 Jun 2011 20:17:08 +0100
Message-ID: <E1QZpOm-0005nx-T1@rmk-PC.arm.linux.org.uk>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The first and second arguments shouldn't concern platform code, so
hide them from each platforms caller.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/suspend.h |   19 +++++++++++++++++++
 arch/arm/include/asm/system.h  |    2 --
 arch/arm/kernel/sleep.S        |    2 +-
 arch/arm/mach-omap2/pm34xx.c   |    5 +++--
 arch/arm/mach-pxa/palmz72.c    |    1 +
 arch/arm/mach-pxa/pxa25x.c     |    4 ++--
 arch/arm/mach-pxa/pxa27x.c     |    4 ++--
 arch/arm/mach-pxa/pxa3xx.c     |    3 ++-
 arch/arm/mach-pxa/zeus.c       |    4 ++--
 arch/arm/mach-sa1100/pm.c      |    3 ++-
 arch/arm/plat-samsung/pm.c     |    3 ++-
 11 files changed, 36 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/include/asm/suspend.h

diff --git a/arch/arm/include/asm/suspend.h b/arch/arm/include/asm/suspend.h
new file mode 100644
index 0000000..8d5b446
--- /dev/null
+++ b/arch/arm/include/asm/suspend.h
@@ -0,0 +1,19 @@
+#ifndef __ASM_ARM_SUSPEND_H
+#define __ASM_ARM_SUSPEND_H
+
+#include <asm/memory.h>
+
+extern void cpu_resume(void);
+
+/*
+ * Hide the first two arguments to __cpu_suspend - these are an implementation
+ * detail which platform code shouldn't have to know about.
+ */
+static inline void cpu_suspend(unsigned long arg, void (*fn)(unsigned long))
+{
+	extern void __cpu_suspend(int, long, unsigned long,
+				  void (*)(unsigned long));
+	__cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, arg, fn);
+}
+
+#endif
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 50be605..832888d 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -106,8 +106,6 @@ extern void __show_regs(struct pt_regs *);
 
 extern int cpu_architecture(void);
 extern void cpu_init(void);
-extern void cpu_suspend(int, long, unsigned long, void (*)(unsigned long));
-extern void cpu_resume(void);
 
 void arm_machine_restart(char mode, const char *cmd);
 extern void (*arm_pm_restart)(char str, const char *cmd);
diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 5392274..0bdcc72 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -14,7 +14,7 @@
  *  r3 = suspend function
  * Note: does not return until system resumes
  */
-ENTRY(cpu_suspend)
+ENTRY(__cpu_suspend)
 	stmfd	sp!, {r4 - r11, lr}
 #ifdef MULTI_CPU
 	ldr	r10, =processor
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ae40177..3e9a13e 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -31,6 +31,8 @@
 #include <linux/console.h>
 #include <trace/events/power.h>
 
+#include <asm/suspend.h>
+
 #include <plat/sram.h>
 #include "clockdomain.h"
 #include "powerdomain.h"
@@ -411,8 +413,7 @@ void omap_sram_idle(void)
 	 * from there before resuming.
 	 */
 	if (save_state == 1 || save_state == 3)
-		cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, save_state,
-			    omap34xx_do_sram_idle);
+		cpu_suspend(save_state, omap34xx_do_sram_idle);
 	else
 		omap34xx_do_sram_idle(save_state);
 
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index 65f24f0..5a5329b 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -33,6 +33,7 @@
 #include <linux/i2c-gpio.h>
 
 #include <asm/mach-types.h>
+#include <asm/suspend.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index fd7725c..9c434d2 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -25,6 +25,7 @@
 #include <linux/irq.h>
 
 #include <asm/mach/map.h>
+#include <asm/suspend.h>
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/gpio.h>
@@ -244,8 +245,7 @@ static void pxa25x_cpu_pm_enter(suspend_state_t state)
 
 	switch (state) {
 	case PM_SUSPEND_MEM:
-		cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, PWRMODE_SLEEP,
-			    pxa25x_finish_suspend);
+		cpu_suspend(PWRMODE_SLEEP, pxa25x_finish_suspend);
 		break;
 	}
 }
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 824379d..9d2400b 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -24,6 +24,7 @@
 #include <asm/mach/map.h>
 #include <mach/hardware.h>
 #include <asm/irq.h>
+#include <asm/suspend.h>
 #include <mach/irqs.h>
 #include <mach/gpio.h>
 #include <mach/pxa27x.h>
@@ -304,8 +305,7 @@ void pxa27x_cpu_pm_enter(suspend_state_t state)
 		pxa_cpu_standby();
 		break;
 	case PM_SUSPEND_MEM:
-		cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, pwrmode,
-			    pxa27x_finish_suspend);
+		cpu_suspend(pwrmode, pxa27x_finish_suspend);
 #ifndef CONFIG_IWMMXT
 		asm volatile("mar acc0, %Q0, %R0" : "=r" (acc0));
 #endif
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 220fd8c..9fe947b 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -24,6 +24,7 @@
 #include <linux/i2c/pxa-i2c.h>
 
 #include <asm/mach/map.h>
+#include <asm/suspend.h>
 #include <mach/hardware.h>
 #include <mach/gpio.h>
 #include <mach/pxa3xx-regs.h>
@@ -167,7 +168,7 @@ static void pxa3xx_cpu_pm_suspend(void)
 	/* overwrite with the resume address */
 	*p = virt_to_phys(cpu_resume);
 
-	cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, 0, pxa3xx_finish_suspend);
+	cpu_suspend(0, pxa3xx_finish_suspend);
 
 	*p = saved_data;
 
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 28eb410..9b99cc1 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -31,6 +31,7 @@
 #include <linux/can/platform/mcp251x.h>
 
 #include <asm/mach-types.h>
+#include <asm/suspend.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
@@ -676,8 +677,7 @@ static struct pxa2xx_udc_mach_info zeus_udc_info = {
 static void zeus_power_off(void)
 {
 	local_irq_disable();
-	cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, PWRMODE_DEEPSLEEP,
-		    pxa27x_finish_suspend);
+	cpu_suspend(PWRMODE_DEEPSLEEP, pxa27x_finish_suspend);
 }
 #else
 #define zeus_power_off   NULL
diff --git a/arch/arm/mach-sa1100/pm.c b/arch/arm/mach-sa1100/pm.c
index 259ed3b..cf9a1e9 100644
--- a/arch/arm/mach-sa1100/pm.c
+++ b/arch/arm/mach-sa1100/pm.c
@@ -29,6 +29,7 @@
 
 #include <mach/hardware.h>
 #include <asm/memory.h>
+#include <asm/suspend.h>
 #include <asm/system.h>
 #include <asm/mach/time.h>
 
@@ -75,7 +76,7 @@ static int sa11x0_pm_enter(suspend_state_t state)
 	PSPR = virt_to_phys(cpu_resume);
 
 	/* go zzz */
-	cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, 0, sa1100_finish_suspend);
+	cpu_suspend(0, sa1100_finish_suspend);
 
 	/*
 	 * Ensure not to come back here if it wasn't intended
diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index 3a6d076..69d6b04 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 
 #include <asm/cacheflush.h>
+#include <asm/suspend.h>
 #include <mach/hardware.h>
 #include <mach/map.h>
 
@@ -298,7 +299,7 @@ static int s3c_pm_enter(suspend_state_t state)
 	 * we resume as it saves its own register state and restores it
 	 * during the resume.  */
 
-	cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, 0, pm_cpu_sleep);
+	cpu_suspend(0, pm_cpu_sleep);
 
 	/* restore the system state */
 
-- 
1.7.4.4

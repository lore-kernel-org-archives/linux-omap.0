From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Add clocksource driver for OMAP
Date: Sun, 12 Nov 2006 18:11:55 +0100
Message-ID: <455755DB.1040308@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050008080708090308080200"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------050008080708090308080200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Add clocksource driver for OMAP.

This is an update of

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3876/1

from Daniel Walker and Kevin Hilman.

Changes:

- Apply cleanly to recent git (pt_regs change)
- Move clocksource init to extra function. Can be called 
later by clocksource subsystem
- Remove warning
arch/arm/plat-omap/timer32k.c:216: warning: 
'omap_32k_timer_handler' defined but not used
if CONFIG_NO_IDLE_HZ isn't set.
- Minor cleanups

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------050008080708090308080200
Content-Type: text/plain;
 name="omap1_clocksource_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap1_clocksource_patch.txt"

Index: linux-osk/arch/arm/mach-omap1/time.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap1/time.c
+++ linux-osk/arch/arm/mach-omap1/time.c
@@ -7,6 +7,7 @@
  * Partial timer rewrite and additional dynamic tick timer support by
  * Tony Lindgen <tony@atomide.com> and
  * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ * Clocksource infrastructure added by Daniel Walker <dwalker@mvista.com>
  *
  * MPU timer code based on the older MPU timer code for OMAP
  * Copyright (C) 2000 RidgeRun, Inc.
@@ -39,6 +40,7 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <linux/clocksource.h>
 
 #include <asm/system.h>
 #include <asm/hardware.h>
@@ -140,34 +142,13 @@ unsigned long omap_mpu_timer_ticks_to_us
 }
 
 /*
- * Last processed system timer interrupt
- */
-static unsigned long omap_mpu_timer_last = 0;
-
-/*
- * Returns elapsed usecs since last system timer interrupt
- */
-static unsigned long omap_mpu_timer_gettimeoffset(void)
-{
-	unsigned long now = 0 - omap_mpu_timer_read(0);
-	unsigned long elapsed = now - omap_mpu_timer_last;
-
-	return omap_mpu_timer_ticks_to_usecs(elapsed);
-}
-
-/*
  * Elapsed time between interrupts is calculated using timer0.
  * Latency during the interrupt is calculated using timer1.
  * Both timer0 and timer1 are counting at 6MHz (P2 6.5MHz).
  */
 static irqreturn_t omap_mpu_timer_interrupt(int irq, void *dev_id)
 {
-	unsigned long now, latency;
-
 	write_seqlock(&xtime_lock);
-	now = 0 - omap_mpu_timer_read(0);
-	latency = MPU_TICKS_PER_SEC / HZ - omap_mpu_timer_read(1);
-	omap_mpu_timer_last = now - latency;
 	timer_tick();
 	write_sequnlock(&xtime_lock);
 
@@ -181,6 +162,7 @@ static struct irqaction omap_mpu_timer_i
 };
 
 static unsigned long omap_mpu_timer1_overflows;
+
 static irqreturn_t omap_mpu_timer1_interrupt(int irq, void *dev_id)
 {
 	omap_mpu_timer1_overflows++;
@@ -196,7 +178,7 @@ static struct irqaction omap_mpu_timer1_
 static __init void omap_init_mpu_timer(void)
 {
 	set_cyc2ns_scale(MPU_TICKS_PER_SEC / 1000);
-	omap_timer.offset = omap_mpu_timer_gettimeoffset;
+
 	setup_irq(INT_TIMER1, &omap_mpu_timer1_irq);
 	setup_irq(INT_TIMER2, &omap_mpu_timer_irq);
 	omap_mpu_timer_start(0, 0xffffffff);
@@ -220,15 +202,47 @@ unsigned long long sched_clock(void)
 
 /*
  * ---------------------------------------------------------------------------
+ * MPU clocksource
+ * ---------------------------------------------------------------------------
+ */
+static cycle_t mpu_read(void)
+{
+      return ~omap_mpu_timer_read(0);
+}
+
+/*
+ * Clock source structure for the MPU timer.
+ */
+struct clocksource clocksource_mpu = {
+      .name           = "mpu-timer",
+      .rating         = 300,
+      .read           = mpu_read,
+      .mask           = CLOCKSOURCE_MASK(32),
+      .shift          = 24,
+      .is_continuous  = 1,
+};
+
+static __init void omap_init_clocksource(void)
+{
+	clocksource_mpu.mult =
+		clocksource_hz2mult(MPU_TICKS_PER_SEC, clocksource_mpu.shift);
+
+	if (clocksource_register(&clocksource_mpu))
+		printk("omap_init_mpu_timer : Error registering"
+		       " mpu-timer clocksource!\n");
+}
+
+/*
+ * ---------------------------------------------------------------------------
  * Timer initialization
  * ---------------------------------------------------------------------------
  */
 static void __init omap_timer_init(void)
 {
 	omap_init_mpu_timer();
+	omap_init_clocksource();
 }
 
 struct sys_timer omap_timer = {
 	.init		= omap_timer_init,
-	.offset		= NULL,		/* Initialized later */
 };
Index: linux-osk/arch/arm/plat-omap/Kconfig
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/Kconfig
+++ linux-osk/arch/arm/plat-omap/Kconfig
@@ -11,6 +11,7 @@ choice
 
 config ARCH_OMAP1
 	bool "TI OMAP1"
+	select GENERIC_TIME
 
 config ARCH_OMAP2
 	bool "TI OMAP2"
Index: linux-osk/arch/arm/plat-omap/timer32k.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/timer32k.c
+++ linux-osk/arch/arm/plat-omap/timer32k.c
@@ -8,6 +8,7 @@
  * Tony Lindgen <tony@atomide.com> and
  * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
  * OMAP Dual-mode timer framework support by Timo Teras
+ * Clocksource infrastructure added by Daniel Walker <dwalker@mvista.com>
  *
  * MPU timer code based on the older MPU timer code for OMAP
  * Copyright (C) 2000 RidgeRun, Inc.
@@ -42,6 +43,8 @@
 #include <linux/spinlock.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/cpu.h>
+#include <linux/clocksource.h>
 
 #include <asm/system.h>
 #include <asm/hardware.h>
@@ -80,7 +83,8 @@ struct sys_timer omap_timer;
 #define OMAP1_32K_TIMER_TVR		0x00
 #define OMAP1_32K_TIMER_TCR		0x04
 
-#define OMAP_32K_TICKS_PER_HZ		(32768 / HZ)
+#define OMAP_32K_TICKS_PER_SEC		(32768)
+#define OMAP_32K_TICKS_PER_HZ		(OMAP_32K_TICKS_PER_SEC / HZ)
 
 /*
  * TRM says 1 / HZ = ( TVR + 1) / 32768, so TRV = (32768 / HZ) - 1
@@ -171,15 +175,6 @@ omap_32k_ticks_to_nsecs(unsigned long ti
 static unsigned long omap_32k_last_tick = 0;
 
 /*
- * Returns elapsed usecs since last 32k timer interrupt
- */
-static unsigned long omap_32k_timer_gettimeoffset(void)
-{
-	unsigned long now = omap_32k_sync_timer_read();
-	return omap_32k_ticks_to_usecs(now - omap_32k_last_tick);
-}
-
-/*
  * Returns current time from boot in nsecs. It's OK for this to wrap
  * around for now, as it's just a relative time stamp.
  */
@@ -217,6 +212,19 @@ static inline irqreturn_t _omap_32k_time
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t omap_32k_timer_interrupt(int irq, void *dev_id)
+{
+	unsigned long flags;
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	_omap_32k_timer_interrupt(irq, dev_id);
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_NO_IDLE_HZ
+
 static irqreturn_t omap_32k_timer_handler(int irq, void *dev_id)
 {
 	unsigned long now;
@@ -233,18 +241,6 @@ static irqreturn_t omap_32k_timer_handle
 	return _omap_32k_timer_interrupt(irq, dev_id);
 }
 
-static irqreturn_t omap_32k_timer_interrupt(int irq, void *dev_id)
-{
-	unsigned long flags;
-
-	write_seqlock_irqsave(&xtime_lock, flags);
-	_omap_32k_timer_interrupt(irq, dev_id);
-	write_sequnlock_irqrestore(&xtime_lock, flags);
-
-	return IRQ_HANDLED;
-}
-
-#ifdef CONFIG_NO_IDLE_HZ
 /*
  * Programs the next timer interrupt needed. Called when dynamic tick is
  * enabled, and to reprogram the ticks to skip from pm_idle. Note that
@@ -302,7 +298,6 @@ static __init void omap_init_32k_timer(v
 
 	if (cpu_class_is_omap1())
 		setup_irq(INT_OS_TIMER, &omap_32k_timer_irq);
-	omap_timer.offset  = omap_32k_timer_gettimeoffset;
 	omap_32k_last_tick = omap_32k_sync_timer_read();
 
 #ifdef CONFIG_ARCH_OMAP2
@@ -324,6 +319,36 @@ static __init void omap_init_32k_timer(v
 
 /*
  * ---------------------------------------------------------------------------
+ * 32KHz clocksource
+ * ---------------------------------------------------------------------------
+ */
+static cycle_t omap_32k_read(void)
+{
+	return (cycle_t)omap_32k_sync_timer_read();
+}
+
+static struct clocksource clocksource_32k = {
+	.name		= "32k-timer",
+	.rating		= 250,
+	.read		= omap_32k_read,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.shift		= 10,
+	.is_continuous	= 1,
+};
+
+static __init void omap_init_clocksource_32k(void)
+{
+	clocksource_32k.mult =
+		clocksource_hz2mult(OMAP_32K_TICKS_PER_SEC,
+				    clocksource_32k.shift);
+
+	if (clocksource_register(&clocksource_32k))
+		printk("omap_init_32k_timer : Error registering"
+		       " 32k timer clocksource!\n");
+}
+
+/*
+ * ---------------------------------------------------------------------------
  * Timer initialization
  * ---------------------------------------------------------------------------
  */
@@ -333,9 +358,9 @@ static void __init omap_timer_init(void)
 	omap_dm_timer_init();
 #endif
 	omap_init_32k_timer();
+	omap_init_clocksource_32k();
 }
 
 struct sys_timer omap_timer = {
 	.init		= omap_timer_init,
-	.offset		= NULL,		/* Initialized later */
 };



--------------050008080708090308080200
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050008080708090308080200--

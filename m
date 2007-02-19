From: Kevin Hilman <khilman@mvista.com>
Subject: [RFC, PATCH 5/7] ARM: clocksource support for Versatile platform
Date: Mon, 19 Feb 2007 13:47:24 -0800
Message-ID: <20070219214740.785798000@mvista.com>
References: <20070219214719.379287000@mvista.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline; filename=arm-versatile-clocksource.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: tglx@linutronix.de, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@mvista.com>

Index: linux-2.6/arch/arm/mach-versatile/core.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-versatile/core.c
+++ linux-2.6/arch/arm/mach-versatile/core.c
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
+#include <linux/clocksource.h>
 
 #include <asm/cnt32_to_63.h>
 #include <asm/system.h>
@@ -829,46 +830,6 @@ void __init versatile_init(void)
 #endif
 
 /*
- * Returns number of ms since last clock interrupt.  Note that interrupts
- * will have been disabled by do_gettimeoffset()
- */
-static unsigned long versatile_gettimeoffset(void)
-{
-	unsigned long ticks1, ticks2, status;
-
-	/*
-	 * Get the current number of ticks.  Note that there is a race
-	 * condition between us reading the timer and checking for
-	 * an interrupt.  We get around this by ensuring that the
-	 * counter has not reloaded between our two reads.
-	 */
-	ticks2 = readl(TIMER0_VA_BASE + TIMER_VALUE) & 0xffff;
-	do {
-		ticks1 = ticks2;
-		status = __raw_readl(VA_IC_BASE + VIC_RAW_STATUS);
-		ticks2 = readl(TIMER0_VA_BASE + TIMER_VALUE) & 0xffff;
-	} while (ticks2 > ticks1);
-
-	/*
-	 * Number of ticks since last interrupt.
-	 */
-	ticks1 = TIMER_RELOAD - ticks2;
-
-	/*
-	 * Interrupt pending?  If so, we've reloaded once already.
-	 *
-	 * FIXME: Need to check this is effectively timer 0 that expires
-	 */
-	if (status & IRQMASK_TIMERINT0_1)
-		ticks1 += TIMER_RELOAD;
-
-	/*
-	 * Convert the ticks to usecs
-	 */
-	return TICKS2USECS(ticks1);
-}
-
-/*
  * IRQ handler for the timer
  */
 static irqreturn_t versatile_timer_interrupt(int irq, void *dev_id)
@@ -891,6 +852,36 @@ static struct irqaction versatile_timer_
 	.handler	= versatile_timer_interrupt,
 };
 
+static cycle_t versatile_get_cycles(void)
+{
+	return ~readl(TIMER3_VA_BASE + TIMER_VALUE);
+}
+
+static struct clocksource clocksource_versatile = {
+	.name 		= "timer3",
+ 	.rating		= 200,
+ 	.read		= versatile_get_cycles,
+	.mask		= CLOCKSOURCE_MASK(32),
+ 	.shift 		= 20,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static int __init versatile_clocksource_init(void)
+{
+	/* setup timer3 as free-running clocksource */
+	writel(0, TIMER3_VA_BASE + TIMER_CTRL);
+	writel(0xffffffff, TIMER3_VA_BASE + TIMER_LOAD);
+	writel(0xffffffff, TIMER3_VA_BASE + TIMER_VALUE);
+	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
+	       TIMER3_VA_BASE + TIMER_CTRL);
+
+ 	clocksource_versatile.mult =
+ 		clocksource_khz2mult(1000, clocksource_versatile.shift);
+ 	clocksource_register(&clocksource_versatile);
+
+ 	return 0;
+}
+
 /*
  * Set up timer interrupt, and return the current time in seconds.
  */
@@ -927,9 +918,11 @@ static void __init versatile_timer_init(
 	 * Make irqs happen for the system timer
 	 */
 	setup_irq(IRQ_TIMERINT0_1, &versatile_timer_irq);
+
+	versatile_clocksource_init();
 }
 
 struct sys_timer versatile_timer = {
 	.init		= versatile_timer_init,
-	.offset		= versatile_gettimeoffset,
 };
+
Index: linux-2.6/arch/arm/Kconfig
===================================================================
--- linux-2.6.orig/arch/arm/Kconfig
+++ linux-2.6/arch/arm/Kconfig
@@ -162,6 +162,7 @@ config ARCH_VERSATILE
 	select ARM_AMBA
 	select ARM_VIC
 	select ICST307
+	select GENERIC_TIME
 	help
 	  This enables support for ARM Ltd Versatile board.
 

--

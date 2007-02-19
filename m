From: Kevin Hilman <khilman@mvista.com>
Subject: [RFC, PATCH 6/7] ARM: clockevent support for Versatile platform
Date: Mon, 19 Feb 2007 13:47:25 -0800
Message-ID: <20070219214741.124986000@mvista.com>
References: <20070219214719.379287000@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=arm-versatile-clockevents.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: tglx@linutronix.de, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@mvista.com>

Index: linux-2.6/arch/arm/mach-versatile/core.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-versatile/core.c
+++ linux-2.6/arch/arm/mach-versatile/core.c
@@ -27,6 +27,7 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 
 #include <asm/cnt32_to_63.h>
 #include <asm/system.h>
@@ -829,19 +830,61 @@ void __init versatile_init(void)
 #define TICKS2USECS(x)	((x) / TICKS_PER_uSEC)
 #endif
 
+static void timer_set_mode(enum clock_event_mode mode,
+			   struct clock_event_device *clk)
+{
+	unsigned long ctrl;
+
+	switch(mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		writel(TIMER_RELOAD, TIMER0_VA_BASE + TIMER_LOAD);
+
+		ctrl = TIMER_CTRL_PERIODIC;
+		ctrl |= TIMER_CTRL_32BIT | TIMER_CTRL_IE | TIMER_CTRL_ENABLE;
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		/* period set, and timer enabled in 'next_event' hook */
+		ctrl = TIMER_CTRL_ONESHOT;
+		ctrl |= TIMER_CTRL_32BIT | TIMER_CTRL_IE;
+		break;
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	default:
+		ctrl = 0;
+	}
+
+	writel(ctrl, TIMER0_VA_BASE + TIMER_CTRL);
+}
+
+static int timer_set_next_event(unsigned long evt,
+				struct clock_event_device *unused)
+{
+	unsigned long ctrl = readl(TIMER0_VA_BASE + TIMER_CTRL);
+
+	writel(evt, TIMER0_VA_BASE + TIMER_LOAD);
+	writel(ctrl | TIMER_CTRL_ENABLE, TIMER0_VA_BASE + TIMER_CTRL);
+
+	return 0;
+}
+
+static struct clock_event_device timer0_clockevent =	 {
+	.name		= "timer0",
+	.shift		= 32,
+	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.set_mode	= timer_set_mode,
+	.set_next_event	= timer_set_next_event,
+};
+
 /*
  * IRQ handler for the timer
  */
 static irqreturn_t versatile_timer_interrupt(int irq, void *dev_id)
 {
-	write_seqlock(&xtime_lock);
+	struct clock_event_device *evt = &timer0_clockevent;
 
-	// ...clear the interrupt
 	writel(1, TIMER0_VA_BASE + TIMER_INTCLR);
 
-	timer_tick();
-
-	write_sequnlock(&xtime_lock);
+	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
 }
@@ -909,17 +952,22 @@ static void __init versatile_timer_init(
 	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
 	writel(0, TIMER3_VA_BASE + TIMER_CTRL);
 
-	writel(TIMER_RELOAD, TIMER0_VA_BASE + TIMER_LOAD);
-	writel(TIMER_RELOAD, TIMER0_VA_BASE + TIMER_VALUE);
-	writel(TIMER_DIVISOR | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC |
-	       TIMER_CTRL_IE, TIMER0_VA_BASE + TIMER_CTRL);
-
 	/* 
 	 * Make irqs happen for the system timer
 	 */
 	setup_irq(IRQ_TIMERINT0_1, &versatile_timer_irq);
 
 	versatile_clocksource_init();
+
+	timer0_clockevent.mult =
+		div_sc(1000000, NSEC_PER_SEC, timer0_clockevent.shift);
+	timer0_clockevent.max_delta_ns =
+		clockevent_delta2ns(0xffffffff, &timer0_clockevent);
+	timer0_clockevent.min_delta_ns =
+		clockevent_delta2ns(0xf, &timer0_clockevent);
+
+	timer0_clockevent.cpumask = cpumask_of_cpu(0);
+	clockevents_register_device(&timer0_clockevent);
 }
 
 struct sys_timer versatile_timer = {
Index: linux-2.6/arch/arm/Kconfig
===================================================================
--- linux-2.6.orig/arch/arm/Kconfig
+++ linux-2.6/arch/arm/Kconfig
@@ -163,6 +163,7 @@ config ARCH_VERSATILE
 	select ARM_VIC
 	select ICST307
 	select GENERIC_TIME
+	select GENERIC_CLOCKEVENTS
 	help
 	  This enables support for ARM Ltd Versatile board.
 

--

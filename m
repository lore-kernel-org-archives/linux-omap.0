From: Kevin Hilman <khilman@mvista.com>
Subject: [RFC, PATCH 4/7] ARM: clockevent support for ixp4xx platform
Date: Mon, 19 Feb 2007 13:47:23 -0800
Message-ID: <20070219214740.473972000@mvista.com>
References: <20070219214719.379287000@mvista.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline; filename=arm-ixp4xx-clockevents.patch
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

Index: linux-2.6/arch/arm/mach-ixp4xx/common.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-ixp4xx/common.c
+++ linux-2.6/arch/arm/mach-ixp4xx/common.c
@@ -27,6 +27,7 @@
 #include <linux/time.h>
 #include <linux/timex.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 
 #include <asm/arch/udc.h>
 #include <asm/hardware.h>
@@ -41,6 +42,8 @@
 #include <asm/mach/time.h>
 
 static int __init ixp4xx_clocksource_init(void);
+static int __init ixp4xx_clockevent_init(void);
+static struct clock_event_device clockevent_ixp4xx;
 
 /*************************************************************************
  * IXP4xx chipset I/O mapping
@@ -239,52 +242,40 @@ void __init ixp4xx_init_irq(void)
  * counter as a source of real clock ticks to account for missed jiffies.
  *************************************************************************/
 
-static unsigned volatile last_jiffy_time;
-
-#define CLOCK_TICKS_PER_USEC	((CLOCK_TICK_RATE + USEC_PER_SEC/2) / USEC_PER_SEC)
-
 static irqreturn_t ixp4xx_timer_interrupt(int irq, void *dev_id)
 {
-	write_seqlock(&xtime_lock);
+	struct clock_event_device *evt = &clockevent_ixp4xx;
 
 	/* Clear Pending Interrupt by writing '1' to it */
 	*IXP4XX_OSST = IXP4XX_OSST_TIMER_1_PEND;
 
-	/*
-	 * Catch up with the real idea of time
-	 */
-	while ((signed long)(*IXP4XX_OSTS - last_jiffy_time) >= LATCH) {
-		timer_tick();
-		last_jiffy_time += LATCH;
-	}
-
-	write_sequnlock(&xtime_lock);
+	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
 }
 
 static struct irqaction ixp4xx_timer_irq = {
-	.name		= "IXP4xx Timer Tick",
+	.name		= "timer1",
 	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= ixp4xx_timer_interrupt,
 };
 
 static void __init ixp4xx_timer_init(void)
 {
+	/* Reset/disable counter */
+	*IXP4XX_OSRT1 = 0;
+
 	/* Clear Pending Interrupt by writing '1' to it */
 	*IXP4XX_OSST = IXP4XX_OSST_TIMER_1_PEND;
 
-	/* Setup the Timer counter value */
-	*IXP4XX_OSRT1 = (LATCH & ~IXP4XX_OST_RELOAD_MASK) | IXP4XX_OST_ENABLE;
-
 	/* Reset time-stamp counter */
 	*IXP4XX_OSTS = 0;
-	last_jiffy_time = 0;
 
 	/* Connect the interrupt handler and enable the interrupt */
 	setup_irq(IRQ_IXP4XX_TIMER1, &ixp4xx_timer_irq);
 
 	ixp4xx_clocksource_init();
+	ixp4xx_clockevent_init();
 }
 
 struct sys_timer ixp4xx_timer = {
@@ -384,6 +375,9 @@ void __init ixp4xx_sys_init(void)
 			ixp4xx_exp_bus_size >> 20);
 }
 
+/*
+ * clocksource
+ */
 cycle_t ixp4xx_get_cycles(void)
 {
 	return *IXP4XX_OSTS;
@@ -408,3 +402,64 @@ static int __init ixp4xx_clocksource_ini
 
 	return 0;
 }
+
+/*
+ * clockevents
+ */
+static int ixp4xx_set_next_event(unsigned long evt,
+				 struct clock_event_device *unused)
+{
+	unsigned long opts = *IXP4XX_OSRT1 & IXP4XX_OST_RELOAD_MASK;
+
+	*IXP4XX_OSRT1 = (evt & ~IXP4XX_OST_RELOAD_MASK) | opts;
+
+	return 0;
+}
+
+static void ixp4xx_set_mode(enum clock_event_mode mode,
+			    struct clock_event_device *evt)
+{
+	unsigned long opts, osrt = *IXP4XX_OSRT1 & ~IXP4XX_OST_RELOAD_MASK;
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		osrt = LATCH & ~IXP4XX_OST_RELOAD_MASK;
+ 		opts = IXP4XX_OST_ENABLE;
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		/* period set by 'set next_event' */
+		osrt = 0;
+		opts = IXP4XX_OST_ENABLE | IXP4XX_OST_ONE_SHOT;
+		break;
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_UNUSED:
+	default:
+		osrt = opts = 0;
+		break;
+	}
+
+	*IXP4XX_OSRT1 = osrt | opts;
+}
+
+static struct clock_event_device clockevent_ixp4xx = {
+	.name		= "ixp4xx timer1",
+	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.rating         = 200,
+	.shift		= 24,
+	.set_mode	= ixp4xx_set_mode,
+	.set_next_event	= ixp4xx_set_next_event,
+};
+
+static int __init ixp4xx_clockevent_init(void)
+{
+	clockevent_ixp4xx.mult = div_sc(FREQ, NSEC_PER_SEC,
+					clockevent_ixp4xx.shift);
+	clockevent_ixp4xx.max_delta_ns =
+		clockevent_delta2ns(0xfffffffe, &clockevent_ixp4xx);
+	clockevent_ixp4xx.min_delta_ns =
+		clockevent_delta2ns(0xf, &clockevent_ixp4xx);
+	clockevent_ixp4xx.cpumask = cpumask_of_cpu(0);
+
+	clockevents_register_device(&clockevent_ixp4xx);
+	return 0;
+}
Index: linux-2.6/arch/arm/Kconfig
===================================================================
--- linux-2.6.orig/arch/arm/Kconfig
+++ linux-2.6/arch/arm/Kconfig
@@ -255,6 +255,7 @@ config ARCH_IXP4XX
 	bool "IXP4xx-based"
 	depends on MMU
 	select GENERIC_TIME
+	select GENERIC_CLOCKEVENTS
 	help
 	  Support for Intel's IXP4XX (XScale) family of processors.
 

--

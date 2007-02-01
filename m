From: Kevin Hilman <khilman@mvista.com>
Subject: [patch 2.6.20-rc6-rt6 6/6] ARM: clockevent support for OMAP1
	platform
Date: Wed, 31 Jan 2007 16:13:06 -0800
Message-ID: <20070201001317.702237000@mvista.com>
References: <20070201001300.820659000@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=arm-omap-clockevent-fixups.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
Cc: linux-omap-open-source@linux.omap.com, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

These are minor fixups to the clockevent support which is
already in 2.6.20-rc6-rt6 for OMAP.

Index: linux-2.6/arch/arm/plat-omap/common.c
===================================================================
--- linux-2.6.orig/arch/arm/plat-omap/common.c
+++ linux-2.6/arch/arm/plat-omap/common.c
@@ -186,7 +186,7 @@ static struct clocksource clocksource_32
 	.read		= omap_32k_read,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.shift		= 10,
-	.is_continuous	= 1,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
 static int __init omap_init_clocksource_32k(void)
Index: linux-2.6/arch/arm/plat-omap/timer32k.c
===================================================================
--- linux-2.6.orig/arch/arm/plat-omap/timer32k.c
+++ linux-2.6/arch/arm/plat-omap/timer32k.c
@@ -144,35 +144,16 @@ static inline void omap_32k_timer_ack_ir
 
 #endif
 
-static void omap_32k_timer_set_next_event(unsigned long cycles,
-				    struct clock_event_device *evt)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	omap_32k_timer_stop();
-	omap_32k_timer_start(cycles);
-	local_irq_restore(flags);
-}
-
 static void omap_32k_timer_set_mode(enum clock_event_mode mode,
-			      struct clock_event_device *evt)
+				    struct clock_event_device *evt)
 {
-	static int periodic_requests = 0;
-
 	switch (mode) {
-	case CLOCK_EVT_ONESHOT:
-		/* 32k timer does not have one-shot support in hardware.
-		 * instead, wet just to a stop in the next_event hook,
-		 * and dont support PERIODIC */
+	case CLOCK_EVT_MODE_ONESHOT:
+	case CLOCK_EVT_MODE_PERIODIC:
+		omap_32k_timer_start(OMAP_32K_TIMER_TICK_PERIOD);
 		break;
-	case CLOCK_EVT_PERIODIC:
-		if (periodic_requests)
-			printk(KERN_ERR "32k-timer: CLOCK_EVT_PERIODIC "
-			       "is not supported.\n");
-		periodic_requests++;
-		break;
-	case CLOCK_EVT_SHUTDOWN:
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
 		omap_32k_timer_stop();
 		break;
 	}
@@ -180,10 +161,8 @@ static void omap_32k_timer_set_mode(enum
 
 static struct clock_event_device clockevent_32k_timer = {
 	.name		= "32k-timer",
-	.capabilities	= CLOCK_CAP_NEXTEVT | CLOCK_CAP_TICK |
-			  CLOCK_CAP_UPDATE,
+	.features       = CLOCK_EVT_FEAT_PERIODIC,
 	.shift		= 32,
-	.set_next_event	= omap_32k_timer_set_next_event,
 	.set_mode	= omap_32k_timer_set_mode,
 };
 
@@ -226,9 +205,10 @@ unsigned long long sched_clock(void)
 
 static irqreturn_t omap_32k_timer_interrupt(int irq, void *dev_id)
 {
+	struct clock_event_device *evt = &clockevent_32k_timer;
 	omap_32k_timer_ack_irq();
 
-	clockevent_32k_timer.event_handler();
+	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
 }
@@ -259,8 +239,6 @@ static __init void omap_init_32k_timer(v
 	}
 #endif
 
-	omap_32k_timer_start(OMAP_32K_TIMER_TICK_PERIOD);
-
 	clockevent_32k_timer.mult = div_sc(OMAP_32K_TICKS_PER_SEC,
 					   NSEC_PER_SEC,
 					   clockevent_32k_timer.shift);
@@ -269,7 +247,8 @@ static __init void omap_init_32k_timer(v
 	clockevent_32k_timer.min_delta_ns =
 		clockevent_delta2ns(1, &clockevent_32k_timer);
 
-	register_global_clockevent(&clockevent_32k_timer);
+	clockevent_32k_timer.cpumask = cpumask_of_cpu(0);
+	clockevents_register_device(&clockevent_32k_timer);
 }
 
 /*
Index: linux-2.6/arch/arm/mach-omap1/time.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap1/time.c
+++ linux-2.6/arch/arm/mach-omap1/time.c
@@ -137,31 +137,32 @@ static inline void omap_mpu_timer_start(
  * MPU timer 1 ... count down to zero, interrupt, reload
  * ---------------------------------------------------------------------------
  */
-static void omap_mpu_set_next_event(unsigned long cycles,
+static int omap_mpu_set_next_event(unsigned long cycles,
 				    struct clock_event_device *evt)
 {
 	omap_mpu_timer_start(0, cycles, 0);
+	return 0;
 }
 
 static void omap_mpu_set_mode(enum clock_event_mode mode,
 			      struct clock_event_device *evt)
 {
 	switch (mode) {
-	case CLOCK_EVT_PERIODIC:
+	case CLOCK_EVT_MODE_PERIODIC:
 		omap_mpu_set_autoreset(0);
 		break;
-	case CLOCK_EVT_ONESHOT:
+	case CLOCK_EVT_MODE_ONESHOT:
 		omap_mpu_remove_autoreset(0);
 		break;
-	case CLOCK_EVT_SHUTDOWN:
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
 		break;
 	}
 }
 
 static struct clock_event_device clockevent_mpu_timer1 = {
 	.name		= "mpu_timer1",
-	.capabilities	= CLOCK_CAP_NEXTEVT | CLOCK_CAP_TICK |
-			  CLOCK_CAP_UPDATE,
+	.features       = CLOCK_EVT_FEAT_PERIODIC, CLOCK_EVT_FEAT_ONESHOT,
 	.shift		= 32,
 	.set_next_event	= omap_mpu_set_next_event,
 	.set_mode	= omap_mpu_set_mode,
@@ -169,7 +170,9 @@ static struct clock_event_device clockev
 
 static irqreturn_t omap_mpu_timer1_interrupt(int irq, void *dev_id)
 {
-	clockevent_mpu_timer1.event_handler();
+	struct clock_event_device *evt = &clockevent_mpu_timer1;
+
+	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
 }
@@ -194,7 +197,8 @@ static __init void omap_init_mpu_timer(u
 	clockevent_mpu_timer1.min_delta_ns =
 		clockevent_delta2ns(1, &clockevent_mpu_timer1);
 
-        register_global_clockevent(&clockevent_mpu_timer1);
+	clockevent_mpu_timer1.cpumask = cpumask_of_cpu(0);
+	clockevents_register_device(&clockevent_mpu_timer1);
 }
 
 
@@ -229,7 +233,7 @@ static struct clocksource clocksource_mp
 	.read		= mpu_read,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.shift		= 24,
-	.is_continuous	= 1,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
 static void __init omap_init_clocksource(unsigned long rate)

--

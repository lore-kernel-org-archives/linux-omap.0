From: Kevin Hilman <khilman@mvista.com>
Subject: [patch 2.6.20-rc6-rt6 2/6] ARM NO_HZ idle loop fixup
Date: Wed, 31 Jan 2007 16:13:02 -0800
Message-ID: <20070201001316.305795000@mvista.com>
References: <20070201001300.820659000@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=arm-nohz-idle.patch
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

Index: linux-2.6/arch/arm/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/arm/kernel/process.c
+++ linux-2.6/arch/arm/kernel/process.c
@@ -28,6 +28,7 @@
 #include <linux/cpu.h>
 #include <linux/elfcore.h>
 #include <linux/pm.h>
+#include <linux/tick.h>
 
 #include <asm/leds.h>
 #include <asm/processor.h>
@@ -154,12 +155,12 @@ void cpu_idle(void)
 		if (!idle)
 			idle = default_idle;
 		leds_event(led_idle_start);
-		hrtimer_stop_sched_tick();
+		tick_nohz_stop_sched_tick();
 		while (!need_resched() && !need_resched_delayed())
 			idle();
 		leds_event(led_idle_end);
-		hrtimer_restart_sched_tick();
 		local_irq_disable();
+		tick_nohz_restart_sched_tick();
 		__preempt_enable_no_resched();
 		__schedule();
 		preempt_disable();

--

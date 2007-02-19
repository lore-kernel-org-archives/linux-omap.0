From: Kevin Hilman <khilman@mvista.com>
Subject: [RFC, PATCH 3/7] ARM: dynamic tick support in idle loop
Date: Mon, 19 Feb 2007 13:47:22 -0800
Message-ID: <20070219214740.154734000@mvista.com>
References: <20070219214719.379287000@mvista.com>
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
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: tglx@linutronix.de, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@mvista.com>

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
@@ -154,9 +155,11 @@ void cpu_idle(void)
 		if (!idle)
 			idle = default_idle;
 		leds_event(led_idle_start);
+		tick_nohz_stop_sched_tick();
 		while (!need_resched())
 			idle();
 		leds_event(led_idle_end);
+		tick_nohz_restart_sched_tick();
 		preempt_enable_no_resched();
 		schedule();
 		preempt_disable();

--

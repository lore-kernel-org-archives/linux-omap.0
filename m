From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 4/4] ARM: OMAP: Move timer32k to mach-omap1
Date: Mon, 12 Nov 2007 15:24:05 -0800
Message-ID: <20071112232414.938304344@mvista.com>
References: <20071112232401.723638265@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=move-timer32k-to-omap1.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Move now OMAP1-specific timer32k code to mach-omap1 since OMAP2/3 32k
timers are done in gptimer code.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 arch/arm/mach-omap1/Makefile   |    3 
 arch/arm/mach-omap1/timer32k.c |  209 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/Makefile    |    4 
 arch/arm/plat-omap/timer32k.c  |  209 -----------------------------------------
 4 files changed, 211 insertions(+), 214 deletions(-)

Index: dev/arch/arm/mach-omap1/Makefile
===================================================================
--- dev.orig/arch/arm/mach-omap1/Makefile
+++ dev/arch/arm/mach-omap1/Makefile
@@ -5,7 +5,8 @@
 # Common support
 obj-y := io.o id.o clock.o irq.o mux.o serial.o devices.o
 
-obj-$(CONFIG_OMAP_MPU_TIMER)		+= time.o
+obj-$(CONFIG_OMAP_MPU_TIMER)	+= time.o
+obj-$(CONFIG_OMAP_32K_TIMER)	+= timer32k.o
 
 # Power Management
 obj-$(CONFIG_PM) += pm.o sleep.o
Index: dev/arch/arm/mach-omap1/timer32k.c
===================================================================
--- /dev/null
+++ dev/arch/arm/mach-omap1/timer32k.c
@@ -0,0 +1,209 @@
+/*
+ * linux/arch/arm/plat-omap/timer32k.c
+ *
+ * OMAP 32K Timer
+ *
+ * Copyright (C) 2004 - 2005 Nokia Corporation
+ * Partial timer rewrite and additional dynamic tick timer support by
+ * Tony Lindgen <tony@atomide.com> and
+ * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ * OMAP Dual-mode timer framework support by Timo Teras
+ *
+ * MPU timer code based on the older MPU timer code for OMAP
+ * Copyright (C) 2000 RidgeRun, Inc.
+ * Author: Greg Lonnon <glonnon@ridgerun.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+
+#include <asm/system.h>
+#include <asm/hardware.h>
+#include <asm/io.h>
+#include <asm/leds.h>
+#include <asm/irq.h>
+#include <asm/mach/irq.h>
+#include <asm/mach/time.h>
+#include <asm/arch/dmtimer.h>
+
+struct sys_timer omap_timer;
+
+/*
+ * ---------------------------------------------------------------------------
+ * 32KHz OS timer
+ *
+ * This currently works only on 16xx, as 1510 does not have the continuous
+ * 32KHz synchronous timer. The 32KHz synchronous timer is used to keep track
+ * of time in addition to the 32KHz OS timer. Using only the 32KHz OS timer
+ * on 1510 would be possible, but the timer would not be as accurate as
+ * with the 32KHz synchronized timer.
+ * ---------------------------------------------------------------------------
+ */
+
+#if defined(CONFIG_ARCH_OMAP16XX)
+#define TIMER_32K_SYNCHRONIZED		0xfffbc410
+#else
+#error OMAP 32KHz timer does not currently work on 15XX!
+#endif
+
+/* 16xx specific defines */
+#define OMAP1_32K_TIMER_BASE		0xfffb9000
+#define OMAP1_32K_TIMER_CR		0x08
+#define OMAP1_32K_TIMER_TVR		0x00
+#define OMAP1_32K_TIMER_TCR		0x04
+
+#define OMAP_32K_TICKS_PER_SEC		(32768)
+
+/*
+ * TRM says 1 / HZ = ( TVR + 1) / 32768, so TRV = (32768 / HZ) - 1
+ * so with HZ = 128, TVR = 255.
+ */
+#define OMAP_32K_TIMER_TICK_PERIOD	((OMAP_32K_TICKS_PER_SEC / HZ) - 1)
+
+#define JIFFIES_TO_HW_TICKS(nr_jiffies, clock_rate)			\
+				(((nr_jiffies) * (clock_rate)) / HZ)
+
+static inline void omap_32k_timer_write(int val, int reg)
+{
+	omap_writew(val, OMAP1_32K_TIMER_BASE + reg);
+}
+
+static inline unsigned long omap_32k_timer_read(int reg)
+{
+	return omap_readl(OMAP1_32K_TIMER_BASE + reg) & 0xffffff;
+}
+
+static inline void omap_32k_timer_start(unsigned long load_val)
+{
+	if (!load_val)
+		load_val = 1;
+	omap_32k_timer_write(load_val, OMAP1_32K_TIMER_TVR);
+	omap_32k_timer_write(0x0f, OMAP1_32K_TIMER_CR);
+}
+
+static inline void omap_32k_timer_stop(void)
+{
+	omap_32k_timer_write(0x0, OMAP1_32K_TIMER_CR);
+}
+
+#define omap_32k_timer_ack_irq()
+
+static int omap_32k_timer_set_next_event(unsigned long delta,
+					 struct clock_event_device *dev)
+{
+	omap_32k_timer_start(delta);
+
+	return 0;
+}
+
+static void omap_32k_timer_set_mode(enum clock_event_mode mode,
+				    struct clock_event_device *evt)
+{
+	omap_32k_timer_stop();
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+	case CLOCK_EVT_MODE_ONESHOT:
+		omap_32k_timer_start(OMAP_32K_TIMER_TICK_PERIOD);
+		break;
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		break;
+	case CLOCK_EVT_MODE_RESUME:
+		break;
+	}
+}
+
+static struct clock_event_device clockevent_32k_timer = {
+	.name		= "32k-timer",
+	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.shift		= 32,
+	.set_next_event	= omap_32k_timer_set_next_event,
+	.set_mode	= omap_32k_timer_set_mode,
+};
+
+/*
+ * The 32KHz synchronized timer is an additional timer on 16xx.
+ * It is always running.
+ */
+static inline unsigned long omap_32k_sync_timer_read(void)
+{
+	return omap_readl(TIMER_32K_SYNCHRONIZED);
+}
+
+static irqreturn_t omap_32k_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = &clockevent_32k_timer;
+	omap_32k_timer_ack_irq();
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction omap_32k_timer_irq = {
+	.name		= "32KHz timer",
+	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= omap_32k_timer_interrupt,
+};
+
+static __init void omap_init_32k_timer(void)
+{
+	setup_irq(INT_OS_TIMER, &omap_32k_timer_irq);
+
+	clockevent_32k_timer.mult = div_sc(OMAP_32K_TICKS_PER_SEC,
+					   NSEC_PER_SEC,
+					   clockevent_32k_timer.shift);
+	clockevent_32k_timer.max_delta_ns =
+		clockevent_delta2ns(0xfffffffe, &clockevent_32k_timer);
+	clockevent_32k_timer.min_delta_ns =
+		clockevent_delta2ns(1, &clockevent_32k_timer);
+
+	clockevent_32k_timer.cpumask = cpumask_of_cpu(0);
+	clockevents_register_device(&clockevent_32k_timer);
+}
+
+/*
+ * ---------------------------------------------------------------------------
+ * Timer initialization
+ * ---------------------------------------------------------------------------
+ */
+static void __init omap_timer_init(void)
+{
+#ifdef CONFIG_OMAP_DM_TIMER
+	omap_dm_timer_init();
+#endif
+	omap_init_32k_timer();
+}
+
+struct sys_timer omap_timer = {
+	.init		= omap_timer_init,
+};
Index: dev/arch/arm/plat-omap/Makefile
===================================================================
--- dev.orig/arch/arm/plat-omap/Makefile
+++ dev/arch/arm/plat-omap/Makefile
@@ -9,10 +9,6 @@ obj-m :=
 obj-n :=
 obj-  :=
 
-ifeq ($(CONFIG_ARCH_OMAP1),y)
-obj-$(CONFIG_OMAP_32K_TIMER)	+= timer32k.o
-endif
-
 # OCPI interconnect support for 1710, 1610 and 5912
 obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
 
Index: dev/arch/arm/plat-omap/timer32k.c
===================================================================
--- dev.orig/arch/arm/plat-omap/timer32k.c
+++ /dev/null
@@ -1,209 +0,0 @@
-/*
- * linux/arch/arm/plat-omap/timer32k.c
- *
- * OMAP 32K Timer
- *
- * Copyright (C) 2004 - 2005 Nokia Corporation
- * Partial timer rewrite and additional dynamic tick timer support by
- * Tony Lindgen <tony@atomide.com> and
- * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
- * OMAP Dual-mode timer framework support by Timo Teras
- *
- * MPU timer code based on the older MPU timer code for OMAP
- * Copyright (C) 2000 RidgeRun, Inc.
- * Author: Greg Lonnon <glonnon@ridgerun.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
- * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
- * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * You should have received a copy of the  GNU General Public License along
- * with this program; if not, write  to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/sched.h>
-#include <linux/spinlock.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
-
-#include <asm/system.h>
-#include <asm/hardware.h>
-#include <asm/io.h>
-#include <asm/leds.h>
-#include <asm/irq.h>
-#include <asm/mach/irq.h>
-#include <asm/mach/time.h>
-#include <asm/arch/dmtimer.h>
-
-struct sys_timer omap_timer;
-
-/*
- * ---------------------------------------------------------------------------
- * 32KHz OS timer
- *
- * This currently works only on 16xx, as 1510 does not have the continuous
- * 32KHz synchronous timer. The 32KHz synchronous timer is used to keep track
- * of time in addition to the 32KHz OS timer. Using only the 32KHz OS timer
- * on 1510 would be possible, but the timer would not be as accurate as
- * with the 32KHz synchronized timer.
- * ---------------------------------------------------------------------------
- */
-
-#if defined(CONFIG_ARCH_OMAP16XX)
-#define TIMER_32K_SYNCHRONIZED		0xfffbc410
-#else
-#error OMAP 32KHz timer does not currently work on 15XX!
-#endif
-
-/* 16xx specific defines */
-#define OMAP1_32K_TIMER_BASE		0xfffb9000
-#define OMAP1_32K_TIMER_CR		0x08
-#define OMAP1_32K_TIMER_TVR		0x00
-#define OMAP1_32K_TIMER_TCR		0x04
-
-#define OMAP_32K_TICKS_PER_SEC		(32768)
-
-/*
- * TRM says 1 / HZ = ( TVR + 1) / 32768, so TRV = (32768 / HZ) - 1
- * so with HZ = 128, TVR = 255.
- */
-#define OMAP_32K_TIMER_TICK_PERIOD	((OMAP_32K_TICKS_PER_SEC / HZ) - 1)
-
-#define JIFFIES_TO_HW_TICKS(nr_jiffies, clock_rate)			\
-				(((nr_jiffies) * (clock_rate)) / HZ)
-
-static inline void omap_32k_timer_write(int val, int reg)
-{
-	omap_writew(val, OMAP1_32K_TIMER_BASE + reg);
-}
-
-static inline unsigned long omap_32k_timer_read(int reg)
-{
-	return omap_readl(OMAP1_32K_TIMER_BASE + reg) & 0xffffff;
-}
-
-static inline void omap_32k_timer_start(unsigned long load_val)
-{
-	if (!load_val)
-		load_val = 1;
-	omap_32k_timer_write(load_val, OMAP1_32K_TIMER_TVR);
-	omap_32k_timer_write(0x0f, OMAP1_32K_TIMER_CR);
-}
-
-static inline void omap_32k_timer_stop(void)
-{
-	omap_32k_timer_write(0x0, OMAP1_32K_TIMER_CR);
-}
-
-#define omap_32k_timer_ack_irq()
-
-static int omap_32k_timer_set_next_event(unsigned long delta,
-					 struct clock_event_device *dev)
-{
-	omap_32k_timer_start(delta);
-
-	return 0;
-}
-
-static void omap_32k_timer_set_mode(enum clock_event_mode mode,
-				    struct clock_event_device *evt)
-{
-	omap_32k_timer_stop();
-
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-	case CLOCK_EVT_MODE_ONESHOT:
-		omap_32k_timer_start(OMAP_32K_TIMER_TICK_PERIOD);
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		break;
-	case CLOCK_EVT_MODE_RESUME:
-		break;
-	}
-}
-
-static struct clock_event_device clockevent_32k_timer = {
-	.name		= "32k-timer",
-	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.shift		= 32,
-	.set_next_event	= omap_32k_timer_set_next_event,
-	.set_mode	= omap_32k_timer_set_mode,
-};
-
-/*
- * The 32KHz synchronized timer is an additional timer on 16xx.
- * It is always running.
- */
-static inline unsigned long omap_32k_sync_timer_read(void)
-{
-	return omap_readl(TIMER_32K_SYNCHRONIZED);
-}
-
-static irqreturn_t omap_32k_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = &clockevent_32k_timer;
-	omap_32k_timer_ack_irq();
-
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction omap_32k_timer_irq = {
-	.name		= "32KHz timer",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= omap_32k_timer_interrupt,
-};
-
-static __init void omap_init_32k_timer(void)
-{
-	setup_irq(INT_OS_TIMER, &omap_32k_timer_irq);
-
-	clockevent_32k_timer.mult = div_sc(OMAP_32K_TICKS_PER_SEC,
-					   NSEC_PER_SEC,
-					   clockevent_32k_timer.shift);
-	clockevent_32k_timer.max_delta_ns =
-		clockevent_delta2ns(0xfffffffe, &clockevent_32k_timer);
-	clockevent_32k_timer.min_delta_ns =
-		clockevent_delta2ns(1, &clockevent_32k_timer);
-
-	clockevent_32k_timer.cpumask = cpumask_of_cpu(0);
-	clockevents_register_device(&clockevent_32k_timer);
-}
-
-/*
- * ---------------------------------------------------------------------------
- * Timer initialization
- * ---------------------------------------------------------------------------
- */
-static void __init omap_timer_init(void)
-{
-#ifdef CONFIG_OMAP_DM_TIMER
-	omap_dm_timer_init();
-#endif
-	omap_init_32k_timer();
-}
-
-struct sys_timer omap_timer = {
-	.init		= omap_timer_init,
-};

--

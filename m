From: Kevin Hilman <khilman@mvista.com>
Subject: [patch 2.6.20-rc6-rt6 4/6] ARM: LEDS_TIMER hackery for clockevents
Date: Wed, 31 Jan 2007 16:13:04 -0800
Message-ID: <20070201001316.991832000@mvista.com>
References: <20070201001300.820659000@mvista.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline; filename=arm-leds-timer.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
Cc: linux-omap-open-source@linux.omap.com, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

The clockevent layer now handles everything done by the ARM 
timer_tick() call, except the LED stuff.  Here we add an
arch_tick_leds() to handle LED toggling which is called by 
do_timer().

Index: linux-2.6/arch/arm/kernel/time.c
===================================================================
--- linux-2.6.orig/arch/arm/kernel/time.c
+++ linux-2.6/arch/arm/kernel/time.c
@@ -244,6 +244,13 @@ static inline void do_leds(void)
 #define	do_leds()
 #endif
 
+void arch_tick_leds(void)
+{
+#ifdef CONFIG_LEDS_TIMER
+	do_leds();
+#endif
+}
+
 #ifndef CONFIG_GENERIC_TIME
 void do_gettimeofday(struct timeval *tv)
 {
Index: linux-2.6/kernel/timer.c
===================================================================
--- linux-2.6.orig/kernel/timer.c
+++ linux-2.6/kernel/timer.c
@@ -1471,6 +1471,9 @@ static void run_timer_softirq(struct sof
 void do_timer(unsigned long ticks)
 {
 	jiffies_64 += ticks;
+#ifdef CONFIG_LEDS_TIMER
+ 	arch_tick_leds();
+#endif
 }
 
 #ifdef __ARCH_WANT_SYS_ALARM

--

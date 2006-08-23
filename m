From: Tim Bird <tim.bird@am.sony.com>
Subject: [PATCH] support printk-times by fixing sched_clock to be callable
 in early boot
Date: Wed, 23 Aug 2006 11:36:11 -0700
Message-ID: <44ECA01B.7000408@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Hi all,

This patch has been sitting in my 'to-submit' queue for a long time.

Basically, you can't use the printk times feature on omap, because
by default it calls sched_clock() before the timer is set up, which
causes the machine to hang.  This simplistic fix makes sched_clock()
return 0 until the clock has been properly initialized.

The overhead of the flag check is not big, but it's impact could
be reduced by moving the test into a separate printk_clock()
routine (which would front the sched_clock() function, and
is only called by printk when printk timing is active.)
Let me know if you would prefer that I rework this patch to
use that approach instead.

Regards,
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

Signed-off-by: Tim Bird <tim.bird@am.sony.com>

Index: alp-linux--import-2-6-15--0/arch/arm/mach-omap1/time.c
===================================================================
--- alp-linux--import-2-6-15--0.orig/arch/arm/mach-omap1/time.c	2006-01-10 15:16:05.000000000 -0800
+++ alp-linux--import-2-6-15--0/arch/arm/mach-omap1/time.c	2006-01-10 15:19:09.000000000 -0800
@@ -196,6 +196,8 @@
 	.handler	= omap_mpu_timer1_interrupt,
 };

+static int omap_mpu_timer1_initialized = 0;
+
 static __init void omap_init_mpu_timer(void)
 {
 	set_cyc2ns_scale(MPU_TICKS_PER_SEC / 1000);
@@ -204,6 +206,7 @@
 	setup_irq(INT_TIMER2, &omap_mpu_timer_irq);
 	omap_mpu_timer_start(0, 0xffffffff);
 	omap_mpu_timer_start(1, MPU_TIMER_TICK_PERIOD);
+	omap_mpu_timer1_initialized = 1;
 }

 /*
@@ -211,9 +215,13 @@
  */
 unsigned long long sched_clock(void)
 {
-	unsigned long ticks = 0 - omap_mpu_timer_read(0);
+	unsigned long ticks;
 	unsigned long long ticks64;

+	if (unlikely(!omap_mpu_timer1_initialized)) return 0;
+
+	ticks = 0 - omap_mpu_timer_read(0);
+
 	ticks64 = omap_mpu_timer1_overflows;
 	ticks64 <<= 32;
 	ticks64 |= ticks;

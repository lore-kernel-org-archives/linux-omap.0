From: Paul Walmsley <paul@pwsan.com>
Subject: Re: State of LDP3430 platform
Date: Tue, 18 Jan 2011 12:36:26 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101181234130.13225@utopia.booyaka.com>
References: <20101206125526.GC31777@n2100.arm.linux.org.uk> <20101206181913.GH8345@atomide.com> <alpine.DEB.2.00.1012061125400.13430@utopia.booyaka.com> <20101207083720.GB18336@n2100.arm.linux.org.uk> <alpine.DEB.2.00.1012071745120.13430@utopia.booyaka.com>
 <alpine.DEB.2.00.1012072012000.13430@utopia.booyaka.com> <20110115000301.GT4957@atomide.com> <alpine.DEB.2.00.1101151237240.32245@utopia.booyaka.com> <20110115233744.GA18159@n2100.arm.linux.org.uk> <alpine.DEB.2.00.1101152028580.13225@utopia.booyaka.com>
 <4D3309F9.8090900@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35719 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063Ab1ARTg2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 14:36:28 -0500
In-Reply-To: <4D3309F9.8090900@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Thomas Weber <thomas.weber.linux@googlemail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Richard Woodruff <r-woodruff2@ti.com>


Here's a slightly updated version of this patch, fixing a bug in one of 
the comments, and revising the commit message.  There's no functional 
difference between this and the previous version of this patch.


- Paul

[PATCH] OMAP: counter_32k: init clocksource as part of machine timer init

After commit dc548fbbd2ecd0fc3b02301d551e5f8e19ae58fd ("ARM: omap: convert 
sched_clock() to use new infrastructure"), OMAPs that use the 32KiHz 
"synchronization timer" as their clocksource crash during boot:

[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    0.000000] pgd = c0004000
[    0.000000] [00000000] *pgd=00000000
[    0.000000] Internal error: Oops: 80000005 [#1] SMP
[    0.000000] last sysfs file:
[    0.000000] Modules linked in:
[    0.000000] CPU: 0    Tainted: G        W    (2.6.37-07734-g2467802 #7)
[    0.000000] PC is at 0x0
[    0.000000] LR is at sched_clock_poll+0x2c/0x3c
[    0.000000] pc : [<00000000>]    lr : [<c0060b74>]    psr: 600001d3
[    0.000000] sp : c058bfd0  ip : c058a000  fp : 00000000
[    0.000000] r10: 00000000  r9 : 411fc092  r8 : 800330c8
[    0.000000] r7 : c05a08e0  r6 : c0034c48  r5 : c05ffc40  r4 : c0034c4c
[    0.000000] r3 : c05ffe6c  r2 : c05a0bc0  r1 : c059f098  r0 : 00000000
[    0.000000] Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
[    0.000000] Control: 10c53c7f  Table: 8000404a  DAC: 00000017

This is due to the recent ARM init_sched_clock() changes and the late
initialization of the counter_32k clock source.  More information here:

   http://marc.info/?l=linux-omap&m=129513468605208&w=2

Fix by initializing the counter_32k clocksource during the machine timer
initialization.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Tested-by: Thomas Weber <weber@corscience.de>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/time.c               |    7 +++++++
 arch/arm/mach-omap2/timer-gp.c           |   10 ++++++++--
 arch/arm/plat-omap/counter_32k.c         |    3 +--
 arch/arm/plat-omap/include/plat/common.h |    1 +
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index ed7a61f..6ec65e5 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -244,6 +244,13 @@ static void __init omap_timer_init(void)
 
 	omap_init_mpu_timer(rate);
 	omap_init_clocksource(rate);
+	/*
+	 * XXX Since this file seems to deal mostly with the MPU timer,
+	 * this doesn't seem like the correct place for the sync timer
+	 * clocksource init.
+	 */
+	if (!cpu_is_omap7xx() && !cpu_is_omap15xx())
+		omap_init_clocksource_32k();
 }
 
 struct sys_timer omap_timer = {
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 4e48e78..7b7c268 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -42,6 +42,8 @@
 
 #include "timer-gp.h"
 
+#include <plat/common.h>
+
 /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
 #define MAX_GPTIMER_ID		12
 
@@ -176,10 +178,14 @@ static void __init omap2_gp_clockevent_init(void)
 /* 
  * When 32k-timer is enabled, don't use GPTimer for clocksource
  * instead, just leave default clocksource which uses the 32k
- * sync counter.  See clocksource setup in see plat-omap/common.c. 
+ * sync counter.  See clocksource setup in plat-omap/counter_32k.c
  */
 
-static inline void __init omap2_gp_clocksource_init(void) {}
+static void __init omap2_gp_clocksource_init(void)
+{
+	omap_init_clocksource_32k();
+}
+
 #else
 /*
  * clocksource
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index ea46440..0367998 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -160,7 +160,7 @@ void read_persistent_clock(struct timespec *ts)
 	*ts = *tsp;
 }
 
-static int __init omap_init_clocksource_32k(void)
+int __init omap_init_clocksource_32k(void)
 {
 	static char err[] __initdata = KERN_ERR
 			"%s: can't register clocksource!\n";
@@ -195,7 +195,6 @@ static int __init omap_init_clocksource_32k(void)
 	}
 	return 0;
 }
-arch_initcall(omap_init_clocksource_32k);
 
 #endif	/* !(defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP15XX)) */
 
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 6b8088e..84c707f 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -35,6 +35,7 @@ struct sys_timer;
 
 extern void omap_map_common_io(void);
 extern struct sys_timer omap_timer;
+extern int __init omap_init_clocksource_32k(void);
 
 extern void omap_reserve(void);
 
-- 
1.7.2.3


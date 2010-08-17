From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] omap: Fix SMP on UP interrupt handling for multi-omap
Date: Tue, 17 Aug 2010 13:53:32 +0300
Message-ID: <20100817105332.19061.44765.stgit@baageli.muru.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59555 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753170Ab0HQKx1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Aug 2010 06:53:27 -0400
In-Reply-To: <20100817104414.19061.38999.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, bryan.wu@canonical.com

Fix SMP on UP interrupt handling for multi-omap

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/include/mach/entry-macro.S |   22 ++++++++++++++++++++++
 arch/arm/mach-omap2/omap-smp.c                 |   16 ++++++++++++----
 arch/arm/mach-omap2/timer-gp.c                 |    7 +++++--
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
index 06e64e1..75c67aa 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -189,17 +189,38 @@ omap_irq_base:	.word	0
 		 */
 
 		.macro test_for_ipi, irqnr, irqstat, base, tmp
+
+#ifdef MULTI_OMAP2
+		ldr	\tmp, =OMAP4_IRQ_BASE
+		cmp	\base, \tmp
+		beq	9993f
+		cmpne	\tmp, \tmp
+		beq	9994f
+9993:
+#endif
+
 		bic	\irqnr, \irqstat, #0x1c00
 		cmp	\irqnr, #16
 		it	cc
 		strcc	\irqstat, [\base, #GIC_CPU_EOI]
 		it	cs
 		cmpcs	\irqnr, \irqnr
+9994:
 		.endm
 
 		/* As above, this assumes that irqstat and base are preserved */
 
 		.macro test_for_ltirq, irqnr, irqstat, base, tmp
+
+#ifdef MULTI_OMAP2
+		ldr	\tmp, =OMAP4_IRQ_BASE
+		cmp	\base, \tmp
+		beq	9995f
+		cmpne	\tmp, \tmp
+		beq	9996f
+9995:
+#endif
+
 		bic	\irqnr, \irqstat, #0x1c00
 		mov 	\tmp, #0
 		cmp	\irqnr, #29
@@ -207,6 +228,7 @@ omap_irq_base:	.word	0
 		moveq	\tmp, #1
 		streq	\irqstat, [\base, #GIC_CPU_EOI]
 		cmp	\tmp, #0
+9996:
 		.endm
 #endif	/* CONFIG_SMP */
 
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 9e9f70e..8ea16de 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -22,6 +22,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/localtimer.h>
+#include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
@@ -114,11 +115,15 @@ void __init smp_init_cpus(void)
 {
 	unsigned int i, ncores;
 
-	/* Never released */
-	scu_base = ioremap(OMAP44XX_SCU_BASE, SZ_256);
-	BUG_ON(!scu_base);
+	if (smp_on_up()) {
+		ncores = 1;
+	} else {
+		/* Never released */
+		scu_base = ioremap(OMAP44XX_SCU_BASE, SZ_256);
+		BUG_ON(!scu_base);
 
-	ncores = get_core_count();
+		ncores = get_core_count();
+	}
 
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);
@@ -146,6 +151,9 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 	smp_store_cpu_info(cpu);
 
+	if (smp_on_up())
+		ncores = 1;
+
 	/*
 	 * are we trying to boot more cores than exist?
 	 */
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 74fbed8..badf5f2 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -37,6 +37,7 @@
 #include <linux/clockchips.h>
 
 #include <asm/mach/time.h>
+#include <asm/smp_plat.h>
 #include <plat/dmtimer.h>
 #include <asm/localtimer.h>
 
@@ -228,8 +229,10 @@ static void __init omap2_gp_clocksource_init(void)
 static void __init omap2_gp_timer_init(void)
 {
 #ifdef CONFIG_LOCAL_TIMERS
-	twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_256);
-	BUG_ON(!twd_base);
+	if (smp_on_up()) {
+		twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_256);
+		BUG_ON(!twd_base);
+	}
 #endif
 	omap_dm_timer_init();
 


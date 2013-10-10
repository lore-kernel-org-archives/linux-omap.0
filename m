From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH V5] ARM: OMAP5/DRA7: realtime_counter: Configure CNTFRQ register
Date: Thu, 10 Oct 2013 13:13:48 +0530
Message-ID: <1381391028-4189-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43629 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754707Ab3JJHoU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Oct 2013 03:44:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, R Sricharan <r.sricharan@ti.com>, Rajendra Nayak <rnayak@ti.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>

From: R Sricharan <r.sricharan@ti.com>

The realtime counter called master counter, produces the count
used by the private timer peripherals in the MPU_CLUSTER. The
CNTFRQ per cpu register is used to denote the frequency of the counter.
Currently the frequency value is passed from the
DT file, but this is not scalable when we have other non-DT guest
OS. This register must be set to the right value by the
secure rom code. Setting this register helps in propagating the right
frequency value across OSes.

More discussions and the reason for adding this in a non-DT
way can be seen from below.
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg93832.html

So configuring this secure register for all the cpus here.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Tony Lindgren <tony@atomide.com>
Tested-by: Nishanth Menon <nm@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 [V5] Removed the use of extern variable in omap-smp.c
      as per suggestion from Santosh Shilimkar <santosh.shilimkar@ti.com>

 arch/arm/mach-omap2/omap-secure.h |    4 ++++
 arch/arm/mach-omap2/omap-smp.c    |    7 +++++++
 arch/arm/mach-omap2/timer.c       |   10 ++++++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
index 0e72917..a5ee09d 100644
--- a/arch/arm/mach-omap2/omap-secure.h
+++ b/arch/arm/mach-omap2/omap-secure.h
@@ -42,6 +42,8 @@
 #define OMAP4_MON_L2X0_AUXCTRL_INDEX	0x109
 #define OMAP4_MON_L2X0_PREFETCH_INDEX	0x113
 
+#define OMAP5_DRA7_MON_SET_CNTFRQ_INDEX	0x109
+
 /* Secure PPA(Primary Protected Application) APIs */
 #define OMAP4_PPA_L2_POR_INDEX		0x23
 #define OMAP4_PPA_CPU_ACTRL_SMP_INDEX	0x25
@@ -60,5 +62,7 @@ extern int omap_barrier_reserve_memblock(void);
 static inline void omap_barrier_reserve_memblock(void)
 { }
 #endif
+
+void set_cntfreq(void);
 #endif /* __ASSEMBLER__ */
 #endif /* OMAP_ARCH_OMAP_SECURE_H */
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 22c3129..b1c6e5d 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -78,6 +78,13 @@ static void omap4_secondary_init(unsigned int cpu)
 							4, 0, 0, 0, 0, 0);
 
 	/*
+	 * Configure the CNTFRQ register for the secondary cpu's which
+	 * indicates the frequency of the cpu local timers.
+	 */
+	if (soc_is_omap54xx() || soc_is_dra7xx())
+		set_cntfreq();
+
+	/*
 	 * Synchronise with the boot thread.
 	 */
 	spin_lock(&boot_lock);
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index fa74a06..60df58a 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -55,6 +55,7 @@
 #include "soc.h"
 #include "common.h"
 #include "powerdomain.h"
+#include "omap-secure.h"
 
 #define REALTIME_COUNTER_BASE				0x48243200
 #define INCREMENTER_NUMERATOR_OFFSET			0x10
@@ -65,6 +66,12 @@
 
 static struct omap_dm_timer clkev;
 static struct clock_event_device clockevent_gpt;
+static unsigned long arch_timer_freq;
+
+void set_cntfreq(void)
+{
+	omap_smc1(OMAP5_DRA7_MON_SET_CNTFRQ_INDEX, arch_timer_freq);
+}
 
 static irqreturn_t omap2_gp_timer_interrupt(int irq, void *dev_id)
 {
@@ -542,6 +549,9 @@ static void __init realtime_counter_init(void)
 	reg |= den;
 	__raw_writel(reg, base + INCREMENTER_DENUMERATOR_RELOAD_OFFSET);
 
+	arch_timer_freq = (rate / den) * num;
+	set_cntfreq();
+
 	iounmap(base);
 }
 #else
-- 
1.7.9.5


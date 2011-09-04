From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 17/25] OMAP4: PM: CPU1 wakeup workaround from Low power modes
Date: Sun, 4 Sep 2011 19:24:18 +0530
Message-ID: <1315144466-9395-18-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38046 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754590Ab1IDN4H (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 4 Sep 2011 09:56:07 -0400
In-Reply-To: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

The SGI(Software Generated Interrupts) are not wakeup capable from
low power states. This is known limitation on OMAP4 and needs to be
worked around by using software forced clockdomain wake-up. CPU0 forces
the CPU1 clockdomain to software force wakeup.

More details can be found in OMAP4430 TRM - Version J
Section :
	4.3.4.2 Power States of CPU0 and CPU1

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap-smp.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index f920abe..4872e04 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -27,6 +27,8 @@
 #include <mach/omap4-common.h>
 #include <mach/omap-secure.h>
 
+#include "clockdomain.h"
+
 /* SCU base address */
 static void __iomem *scu_base;
 
@@ -60,6 +62,8 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 
 int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
+	static struct clockdomain *cpu1_clkdm;
+	static bool booted;
 	/*
 	 * Set synchronisation state between this boot processor
 	 * and the secondary one
@@ -75,6 +79,29 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	omap_modify_auxcoreboot0(0x200, 0xfffffdff);
 	flush_cache_all();
 	smp_wmb();
+
+	if (!cpu1_clkdm)
+		cpu1_clkdm = clkdm_lookup("mpu1_clkdm");
+
+	/*
+	 * The SGI(Software Generated Interrupts) are not wakeup capable
+	 * from low power states. This is known limitation on OMAP4 and
+	 * needs to be worked around by using software forced clockdomain
+	 * wake-up. To wakeup CPU1, CPU0 forces the CPU1 clockdomain to
+	 * software force wakeup. The clockdomain is then put back to
+	 * hardware supervised mode.
+	 * More details can be found in OMAP4430 TRM - Version J
+	 * Section :
+	 *	4.3.4.2 Power States of CPU0 and CPU1
+	 */
+	if (booted) {
+		clkdm_wakeup(cpu1_clkdm);
+		clkdm_allow_idle(cpu1_clkdm);
+	} else {
+		dsb_sev();
+		booted = true;
+	}
+
 	gic_raise_softirq(cpumask_of(cpu), 1);
 
 	/*
-- 
1.7.4.1


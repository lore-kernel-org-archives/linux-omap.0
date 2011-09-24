From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 13/24] OMAP4: PM: CPU1 wakeup workaround from Low power modes
Date: Sat, 24 Sep 2011 11:44:33 +0530
Message-ID: <1316844884-21700-14-git-send-email-santosh.shilimkar@ti.com>
References: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39743 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583Ab1IXGPK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 24 Sep 2011 02:15:10 -0400
In-Reply-To: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

The SGI(Software Generated Interrupts) are not wakeup capable from
low power states. This is known limitation on OMAP4 and needs to be
worked around by using software forced clockdomain wake-up. CPU0 forces
the CPU1 clockdomain to software force wakeup.

More details can be found in OMAP4430 TRM - Version J
Section :
	4.3.4.2 Power States of CPU0 and CPU1

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
Tested-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/omap-smp.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 844ca5d..d550a44 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -27,6 +27,8 @@
 #include <mach/omap4-common.h>
 #include <mach/omap-secure.h>
 
+#include "clockdomain.h"
+
 /* SCU base address */
 static void __iomem *scu_base;
 
@@ -67,6 +69,8 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 
 int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
+	static struct clockdomain *cpu1_clkdm;
+	static bool booted;
 	/*
 	 * Set synchronisation state between this boot processor
 	 * and the secondary one
@@ -82,6 +86,29 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
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


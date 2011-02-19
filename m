From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 06/17] omap4: pm: Program CPU1 to hit OFF when off-lined
Date: Sat, 19 Feb 2011 16:12:27 +0530
Message-ID: <1298112158-28469-7-git-send-email-santosh.shilimkar@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34187 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753027Ab1BSKms (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Feb 2011 05:42:48 -0500
In-Reply-To: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Program non-boot CPUs to hit lowest supported power state
when it is off-lined using cpu hotplug framework.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap-hotplug.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index 4976b93..9f8f097 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -20,6 +20,9 @@
 
 #include <asm/cacheflush.h>
 #include <mach/omap4-common.h>
+#include <mach/omap-wakeupgen.h>
+
+#include "powerdomain.h"
 
 int platform_cpu_kill(unsigned int cpu)
 {
@@ -32,6 +35,8 @@ int platform_cpu_kill(unsigned int cpu)
  */
 void platform_cpu_die(unsigned int cpu)
 {
+	unsigned int this_cpu;
+
 	flush_cache_all();
 	dsb();
 
@@ -39,18 +44,21 @@ void platform_cpu_die(unsigned int cpu)
 	 * we're ready for shutdown now, so do it
 	 */
 	if (omap_modify_auxcoreboot0(0x0, 0x200) != 0x0)
-		printk(KERN_CRIT "Secure clear status failed\n");
+		pr_err("Secure clear status failed\n");
 
 	for (;;) {
 		/*
-		 * Execute WFI
+		 * Enter into low power state
+		 * clear all interrupt wakeup sources
 		 */
-		do_wfi();
-
-		if (omap_read_auxcoreboot0() == cpu) {
+		omap_wakeupgen_irqmask_all(cpu, 1);
+		omap4_enter_lowpower(cpu, PWRDM_POWER_OFF);
+		this_cpu = hard_smp_processor_id();
+		if (omap_read_auxcoreboot0() == this_cpu) {
 			/*
 			 * OK, proper wakeup, we're done
 			 */
+			omap_wakeupgen_irqmask_all(this_cpu, 0);
 			break;
 		}
 		pr_debug("CPU%u: spurious wakeup call\n", cpu);
-- 
1.6.0.4


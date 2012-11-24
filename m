From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/6] ARM: OMAP4: MPUSS PM: remove unnecessary shim functions
 for powerdomain control
Date: Fri, 23 Nov 2012 20:42:38 -0700
Message-ID: <20121124034237.24638.3621.stgit@dusk.lan>
References: <20121124033809.24638.11090.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57028 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932609Ab2KXDoR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Nov 2012 22:44:17 -0500
In-Reply-To: <20121124033809.24638.11090.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

The OMAP4 MPU subsystem power management code contains several unnecessary
shim functions for powerdomain control; remove them.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   43 +++++------------------------
 1 file changed, 7 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 3f5fd7e..80d4742 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -86,37 +86,6 @@ static inline void set_cpu_wakeup_addr(unsigned int cpu_id, u32 addr)
 }
 
 /*
- * Set the CPUx powerdomain's previous power state
- */
-static inline void set_cpu_next_pwrst(unsigned int cpu_id,
-				unsigned int power_state)
-{
-	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu_id);
-
-	pwrdm_set_next_pwrst(pm_info->pwrdm, power_state);
-}
-
-/*
- * Read CPU's previous power state
- */
-static inline unsigned int read_cpu_prev_pwrst(unsigned int cpu_id)
-{
-	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu_id);
-
-	return pwrdm_read_prev_pwrst(pm_info->pwrdm);
-}
-
-/*
- * Clear the CPUx powerdomain's previous power state
- */
-static inline void clear_cpu_prev_pwrst(unsigned int cpu_id)
-{
-	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu_id);
-
-	pwrdm_clear_all_prev_pwrst(pm_info->pwrdm);
-}
-
-/*
  * Store the SCU power status value to scratchpad memory
  */
 static void scu_pwrst_prepare(unsigned int cpu_id, unsigned int cpu_state)
@@ -229,6 +198,7 @@ static void save_l2x0_context(void)
  */
 int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 {
+	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu);
 	unsigned int save_state = 0;
 	unsigned int wakeup_cpu;
 
@@ -267,7 +237,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 		save_state = 2;
 
 	cpu_clear_prev_logic_pwrst(cpu);
-	set_cpu_next_pwrst(cpu, power_state);
+	pwrdm_set_next_pwrst(pm_info->pwrdm, power_state);
 	set_cpu_wakeup_addr(cpu, virt_to_phys(omap4_cpu_resume));
 	scu_pwrst_prepare(cpu, power_state);
 	l2x0_pwrst_prepare(cpu, save_state);
@@ -285,7 +255,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	 * domain transition
 	 */
 	wakeup_cpu = smp_processor_id();
-	set_cpu_next_pwrst(wakeup_cpu, PWRDM_POWER_ON);
+	pwrdm_set_next_pwrst(pm_info->pwrdm, PWRDM_POWER_ON);
 
 	pwrdm_post_transition(NULL);
 
@@ -299,6 +269,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
  */
 int __cpuinit omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
 {
+	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu);
 	unsigned int cpu_state = 0;
 
 	if (omap_rev() == OMAP4430_REV_ES1_0)
@@ -307,8 +278,8 @@ int __cpuinit omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
 	if (power_state == PWRDM_POWER_OFF)
 		cpu_state = 1;
 
-	clear_cpu_prev_pwrst(cpu);
-	set_cpu_next_pwrst(cpu, power_state);
+	pwrdm_clear_all_prev_pwrst(pm_info->pwrdm);
+	pwrdm_set_next_pwrst(pm_info->pwrdm, power_state);
 	set_cpu_wakeup_addr(cpu, virt_to_phys(omap_secondary_startup));
 	scu_pwrst_prepare(cpu, power_state);
 
@@ -319,7 +290,7 @@ int __cpuinit omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
 	 */
 	omap4_finish_suspend(cpu_state);
 
-	set_cpu_next_pwrst(cpu, PWRDM_POWER_ON);
+	pwrdm_set_next_pwrst(pm_info->pwrdm, PWRDM_POWER_ON);
 	return 0;
 }
 



From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v3 3/4] ARM: OMAP4+: Make secondary_startup function name more
 consistent
Date: Fri, 5 Apr 2013 18:29:02 +0530
Message-ID: <1365166743-5940-4-git-send-email-santosh.shilimkar@ti.com>
References: <1365166743-5940-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1365166743-5940-1-git-send-email-santosh.shilimkar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: khilman@deeprootsystems.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Current code has rather inconsistent function names for 'secondary_startup'
routines. Update it to make it more consistent.

Suggested by Kevin Hilman as part of OMAP5 PM patch review.

Cc: Kevin Hilman <khilman@deeprootsystems.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/common.h              |    4 ++--
 arch/arm/mach-omap2/omap-headsmp.S        |    8 ++++----
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    6 +++---
 arch/arm/mach-omap2/omap-smp.c            |    6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index f5c9983..1fe86be 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -230,8 +230,8 @@ extern void omap_do_wfi(void);
 
 #ifdef CONFIG_SMP
 /* Needed for secondary core boot */
-extern void omap_secondary_startup(void);
-extern void omap_secondary_startup_4460(void);
+extern void omap4_secondary_startup(void);
+extern void omap4460_secondary_startup(void);
 extern u32 omap_modify_auxcoreboot0(u32 set_mask, u32 clear_mask);
 extern void omap_auxcoreboot_addr(u32 cpu_addr);
 extern u32 omap_read_auxcoreboot0(void);
diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
index 0ea09fa..4ea3081 100644
--- a/arch/arm/mach-omap2/omap-headsmp.S
+++ b/arch/arm/mach-omap2/omap-headsmp.S
@@ -49,7 +49,7 @@ END(omap5_secondary_startup)
  * The primary core will update this flag using a hardware
  * register AuxCoreBoot0.
  */
-ENTRY(omap_secondary_startup)
+ENTRY(omap4_secondary_startup)
 hold:	ldr	r12,=0x103
 	dsb
 	smc	#0			@ read from AuxCoreBoot0
@@ -64,9 +64,9 @@ hold:	ldr	r12,=0x103
 	 * should now contain the SVC stack for this core
 	 */
 	b	secondary_startup
-ENDPROC(omap_secondary_startup)
+ENDPROC(omap4_secondary_startup)
 
-ENTRY(omap_secondary_startup_4460)
+ENTRY(omap4460_secondary_startup)
 hold_2:	ldr	r12,=0x103
 	dsb
 	smc	#0			@ read from AuxCoreBoot0
@@ -101,4 +101,4 @@ hold_2:	ldr	r12,=0x103
 	 * should now contain the SVC stack for this core
 	 */
 	b	secondary_startup
-ENDPROC(omap_secondary_startup_4460)
+ENDPROC(omap4460_secondary_startup)
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 391bf2d..f993a41 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -310,7 +310,7 @@ int __cpuinit omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
 	/*
 	 * CPU never retuns back if targeted power state is OFF mode.
 	 * CPU ONLINE follows normal CPU ONLINE ptah via
-	 * omap_secondary_startup().
+	 * omap4_secondary_startup().
 	 */
 	omap_pm_ops.finish_suspend(cpu_state);
 
@@ -356,9 +356,9 @@ int __init omap4_mpuss_init(void)
 	pm_info->wkup_sar_addr = sar_base + CPU1_WAKEUP_NS_PA_ADDR_OFFSET;
 	pm_info->l2x0_sar_addr = sar_base + L2X0_SAVE_OFFSET1;
 	if (cpu_is_omap446x())
-		pm_info->secondary_startup = omap_secondary_startup_4460;
+		pm_info->secondary_startup = omap4460_secondary_startup;
 	else
-		pm_info->secondary_startup = omap_secondary_startup;
+		pm_info->secondary_startup = omap4_secondary_startup;
 
 	pm_info->pwrdm = pwrdm_lookup("cpu1_pwrdm");
 	if (!pm_info->pwrdm) {
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index e4441cc..8106e8d 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -94,7 +94,7 @@ static int __cpuinit omap4_boot_secondary(unsigned int cpu, struct task_struct *
 
 	/*
 	 * Update the AuxCoreBoot0 with boot state for secondary core.
-	 * omap_secondary_startup() routine will hold the secondary core till
+	 * omap4_secondary_startup() routine will hold the secondary core till
 	 * the AuxCoreBoot1 register is updated with cpu state
 	 * A barrier is added to ensure that write buffer is drained
 	 */
@@ -207,7 +207,7 @@ static void __init omap4_smp_init_cpus(void)
 
 static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
 {
-	void *startup_addr = omap_secondary_startup;
+	void *startup_addr = omap4_secondary_startup;
 	void __iomem *base = omap_get_wakeupgen_base();
 
 	/*
@@ -218,7 +218,7 @@ static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
 		scu_enable(scu_base);
 
 	if (cpu_is_omap446x()) {
-		startup_addr = omap_secondary_startup_4460;
+		startup_addr = omap4460_secondary_startup;
 		pm44xx_errata |= PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD;
 	}
 
-- 
1.7.9.5

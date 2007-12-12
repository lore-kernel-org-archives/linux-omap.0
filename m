From: Vivek Kutal <vivek.kutal@celunite.com>
Subject: [PATCH] PM fixes for OMAP1
Date: Wed, 12 Dec 2007 14:16:31 +0530
Message-ID: <11974491911449-git-send-email-vivek.kutal@celunite.com>
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

This patch does the following
	- Fixes the omap_pm_idle() code so that we enter WFI mode in idle.
	- /sys/power/sleep_while_idle is created only when 32k timer is used.

Signed-off-by: Vivek Kutal <vivek.kutal@celunite.com>
---
 arch/arm/mach-omap1/pm.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index afc4874..647c58e 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -66,6 +66,8 @@ static unsigned int mpui730_sleep_save[MPUI730_SLEEP_SAVE_SIZE];
 static unsigned int mpui1510_sleep_save[MPUI1510_SLEEP_SAVE_SIZE];
 static unsigned int mpui1610_sleep_save[MPUI1610_SLEEP_SAVE_SIZE];
 
+#ifdef CONFIG_OMAP_32K_TIMER
+
 static unsigned short enable_dyn_sleep = 1;
 
 static ssize_t omap_pm_sleep_while_idle_show(struct kset *kset, char *buf)
@@ -96,6 +98,8 @@ static struct subsys_attribute sleep_while_idle_attr = {
 	.store  = omap_pm_sleep_while_idle_store,
 };
 
+#endif
+
 static void (*omap_sram_idle)(void) = NULL;
 static void (*omap_sram_suspend)(unsigned long r0, unsigned long r1) = NULL;
 
@@ -109,9 +113,7 @@ void omap_pm_idle(void)
 {
 	extern __u32 arm_idlect1_mask;
 	__u32 use_idlect1 = arm_idlect1_mask;
-#ifndef CONFIG_OMAP_MPU_TIMER
-	int do_sleep;
-#endif
+	int do_sleep = 0;
 
 	local_irq_disable();
 	local_fiq_disable();
@@ -133,7 +135,6 @@ void omap_pm_idle(void)
 	use_idlect1 = use_idlect1 & ~(1 << 9);
 #else
 
-	do_sleep = 0;
 	while (enable_dyn_sleep) {
 
 #ifdef CONFIG_CBUS_TAHVO_USB
@@ -146,6 +147,8 @@ void omap_pm_idle(void)
 		break;
 	}
 
+#endif
+
 #ifdef CONFIG_OMAP_DM_TIMER
 	use_idlect1 = omap_dm_timer_modify_idlect_mask(use_idlect1);
 #endif
@@ -173,7 +176,6 @@ void omap_pm_idle(void)
 	}
 	omap_sram_suspend(omap_readl(ARM_IDLECT1),
 			  omap_readl(ARM_IDLECT2));
-#endif
 
 	local_fiq_enable();
 	local_irq_enable();
@@ -666,8 +668,6 @@ static struct platform_suspend_ops omap_pm_ops ={
 
 static int __init omap_pm_init(void)
 {
-	int error;
-
 	printk("Power Management for TI OMAP.\n");
 
 	/*
@@ -724,9 +724,10 @@ static int __init omap_pm_init(void)
 	omap_pm_init_proc();
 #endif
 
-	error = subsys_create_file(&power_subsys, &sleep_while_idle_attr);
-	if (error)
-		printk(KERN_ERR "subsys_create_file failed: %d\n", error);
+#ifdef CONFIG_OMAP_32K_TIMER
+	if (subsys_create_file(&power_subsys, &sleep_while_idle_attr))
+		printk(KERN_ERR "%s :subsys_create_file failed", __FUNCTION__);
+#endif
 
 	if (cpu_is_omap16xx()) {
 		/* configure LOW_PWR pin */
-- 
1.5.2.5

From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 10/18] ARM: OMAP5: PM: Add MPU Open Switch Retention support
Date: Mon, 25 Mar 2013 15:35:02 +0530
Message-ID: <1364205910-32392-11-git-send-email-santosh.shilimkar@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38574 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754986Ab3CYKEF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Mar 2013 06:04:05 -0400
In-Reply-To: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

In MPUSS OSWR(Open Switch Retention), entire CPU cluster is powered down
except L2 cache memory. For MPUSS OSWR state, both CPU's needs to be in
power off state.

Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    1 +
 arch/arm/mach-omap2/omap-secure.h         |    5 +++++
 arch/arm/mach-omap2/omap-wakeupgen.c      |   11 ++++++-----
 arch/arm/mach-omap2/sleep_omap4plus.S     |    1 +
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 096f489..995443a 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -452,6 +452,7 @@ int __init omap4_mpuss_init(void)
 	} else if (soc_is_omap54xx()) {
 		omap_pm_ops.finish_suspend = omap5_finish_suspend;
 		omap_pm_ops.hotplug_restart = omap5_secondary_startup;
+		omap_pm_ops.resume = cpu_resume;
 		cpu_context_offset = OMAP54XX_RM_CPU0_CPU0_CONTEXT_OFFSET;
 		enable_mercury_retention_mode();
 	}
diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
index 6f4dbee..1739468 100644
--- a/arch/arm/mach-omap2/omap-secure.h
+++ b/arch/arm/mach-omap2/omap-secure.h
@@ -34,6 +34,10 @@
 #define OMAP4_HAL_SAVEHW_INDEX		0x1b
 #define OMAP4_HAL_SAVEALL_INDEX		0x1c
 #define OMAP4_HAL_SAVEGIC_INDEX		0x1d
+#define OMAP5_HAL_SAVESECURERAM_INDEX	0x1c
+#define OMAP5_HAL_SAVEHW_INDEX		0x1d
+#define OMAP5_HAL_SAVEALL_INDEX		0x1e
+#define OMAP5_HAL_SAVEGIC_INDEX		0x1f
 
 /* Secure Monitor mode APIs */
 #define OMAP4_MON_SCU_PWR_INDEX		0x108
@@ -42,6 +46,7 @@
 #define OMAP4_MON_L2X0_AUXCTRL_INDEX	0x109
 #define OMAP4_MON_L2X0_PREFETCH_INDEX	0x113
 #define OMAP5_MON_CACHES_CLEAN_INDEX	0x103
+#define OMAP5_MON_AUX_CTRL_INDEX	0x107
 
 #define OMAP5_MON_AMBA_IF_INDEX		0x108
 
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 8bcaa8c..1697cec 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -50,7 +50,7 @@ static DEFINE_RAW_SPINLOCK(wakeupgen_lock);
 static unsigned int irq_target_cpu[MAX_IRQS];
 static unsigned int irq_banks = MAX_NR_REG_BANKS;
 static unsigned int max_irqs = MAX_IRQS;
-static unsigned int omap_secure_apis;
+static unsigned int omap_secure_apis, secure_api_index;
 
 /*
  * Static helper functions.
@@ -320,7 +320,7 @@ static void irq_sar_clear(void)
 static void irq_save_secure_context(void)
 {
 	u32 ret;
-	ret = omap_secure_dispatcher(OMAP4_HAL_SAVEGIC_INDEX,
+	ret = omap_secure_dispatcher(secure_api_index,
 				FLAG_START_CRITICAL,
 				0, 0, 0, 0, 0);
 	if (ret != API_HAL_RET_VALUE_OK)
@@ -382,9 +382,7 @@ static struct notifier_block irq_notifier_block = {
 
 static void __init irq_pm_init(void)
 {
-	/* FIXME: Remove this when MPU OSWR support is added */
-	if (!soc_is_omap54xx())
-		cpu_pm_register_notifier(&irq_notifier_block);
+	cpu_pm_register_notifier(&irq_notifier_block);
 }
 #else
 static void __init irq_pm_init(void)
@@ -425,6 +423,9 @@ int __init omap_wakeupgen_init(void)
 		irq_banks = OMAP4_NR_BANKS;
 		max_irqs = OMAP4_NR_IRQS;
 		omap_secure_apis = 1;
+		secure_api_index = OMAP4_HAL_SAVEGIC_INDEX;
+	} else if (soc_is_omap54xx()) {
+		secure_api_index = OMAP5_HAL_SAVEGIC_INDEX;
 	}
 
 	/* Clear all IRQ bitmasks at wakeupGen level */
diff --git a/arch/arm/mach-omap2/sleep_omap4plus.S b/arch/arm/mach-omap2/sleep_omap4plus.S
index 5a372a6..4a5e2e4 100644
--- a/arch/arm/mach-omap2/sleep_omap4plus.S
+++ b/arch/arm/mach-omap2/sleep_omap4plus.S
@@ -336,6 +336,7 @@ ENDPROC(omap4_cpu_resume)
  * save_state =
  *	0 - Nothing lost and no need to save: MPUSS INA/CSWR
  *	1 - CPUx L1 and logic lost: CPU OFF, MPUSS INA/CSWR
+ *	2 - CPUx L1 and logic lost + GIC lost: MPUSS OSWR
  */
 ENTRY(omap5_finish_suspend)
 	stmfd	sp!, {r4-r12, lr}
-- 
1.7.9.5


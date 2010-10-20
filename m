From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/3] OMAP: PM: formalize idle notifications
Date: Wed, 20 Oct 2010 16:31:21 -0700
Message-ID: <1287617483-24170-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:56536 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab0JTXb0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Oct 2010 19:31:26 -0400
Received: by pxi16 with SMTP id 16so1050453pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 20 Oct 2010 16:31:26 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Currently in the idle path, we have custom function calls into device
code to handle device specific actions that need to be coordinated CPU
idle transitions. Rather than continue this ad-hoc method of calling
device code from the PM core, create a formal way for device/driver
code to register for idle notifications.

Idle notifications are done late in the idle path when interrupts are
disabled, hence use atomic notifier chains.  These notifications will
also be atomic with respect to CPU idle transitions.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm.c                 |   26 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm24xx.c             |    4 ++++
 arch/arm/mach-omap2/pm34xx.c             |    5 +++++
 arch/arm/plat-omap/include/plat/common.h |   11 +++++++++++
 4 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 59ca03b..343e8d6 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/err.h>
+#include <linux/notifier.h>
 
 #include <plat/omap-pm.h>
 #include <plat/omap_device.h>
@@ -28,6 +29,31 @@ static struct device *iva_dev;
 static struct device *l3_dev;
 static struct device *dsp_dev;
 
+/* idle notifications late in the idle path (atomic, interrupts disabled) */
+static ATOMIC_NOTIFIER_HEAD(idle_notifier);
+
+void omap_idle_notifier_register(struct notifier_block *n)
+{
+	atomic_notifier_chain_register(&idle_notifier, n);
+}
+EXPORT_SYMBOL_GPL(omap_idle_notifier_register);
+
+void omap_idle_notifier_unregister(struct notifier_block *n)
+{
+	atomic_notifier_chain_unregister(&idle_notifier, n);
+}
+EXPORT_SYMBOL_GPL(omap_idle_notifier_unregister);
+
+void omap_idle_notifier_start(void)
+{
+	atomic_notifier_call_chain(&idle_notifier, OMAP_IDLE_START, NULL);
+}
+
+void omap_idle_notifier_end(void)
+{
+	atomic_notifier_call_chain(&idle_notifier, OMAP_IDLE_END, NULL);
+}
+
 struct device *omap2_get_mpuss_device(void)
 {
 	WARN_ON_ONCE(!mpu_dev);
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index a40457d..cb1b333 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -108,6 +108,8 @@ static void omap2_enter_full_retention(void)
 
 	omap2_gpio_prepare_for_idle(PWRDM_POWER_RET);
 
+	omap_idle_notifier_start();
+
 	if (omap2_pm_debug) {
 		omap2_pm_dump(0, 0, 0);
 		getnstimeofday(&ts_preidle);
@@ -140,6 +142,8 @@ no_sleep:
 		tmp = timespec_to_ns(&ts_idle) * NSEC_PER_USEC;
 		omap2_pm_dump(0, 1, tmp);
 	}
+
+	omap_idle_notifier_end();
 	omap2_gpio_resume_after_idle();
 
 	clk_enable(osc_ck);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 75c0cd1..713bd04 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -37,6 +37,7 @@
 #include <plat/prcm.h>
 #include <plat/gpmc.h>
 #include <plat/dma.h>
+#include <plat/common.h>
 
 #include <asm/tlbflush.h>
 
@@ -375,6 +376,8 @@ void omap_sram_idle(void)
 	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
 		pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
 
+	omap_idle_notifier_start();
+
 	/* Enable IO-PAD and IO-CHAIN wakeups */
 	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
 	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
@@ -471,6 +474,8 @@ void omap_sram_idle(void)
 		omap3_disable_io_chain();
 	}
 
+	omap_idle_notifier_end();
+
 	pwrdm_post_transition();
 
 	omap2_clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index a9d69a0..1ca32cf 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -27,6 +27,8 @@
 #ifndef __ARCH_ARM_MACH_OMAP_COMMON_H
 #define __ARCH_ARM_MACH_OMAP_COMMON_H
 
+#include <linux/notifier.h>
+
 #include <plat/i2c.h>
 
 struct sys_timer;
@@ -95,4 +97,13 @@ extern struct device *omap2_get_iva_device(void);
 extern struct device *omap2_get_l3_device(void);
 extern struct device *omap4_get_dsp_device(void);
 
+#define OMAP_IDLE_START 1
+#define OMAP_IDLE_END	2
+
+/* idle notifications late in the idle path (atomic, interrupts disabled) */
+extern void omap_idle_notifier_register(struct notifier_block *n);
+extern void omap_idle_notifier_unregister(struct notifier_block *n);
+extern void omap_idle_notifier_start(void);
+extern void omap_idle_notifier_end(void);
+
 #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */
-- 
1.7.2.1


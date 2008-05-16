From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 3/9] PM: Add pm.c file for omap2 and omap3 common code
Date: Fri, 16 May 2008 13:57:12 +0300
Message-ID: <1210935432-27598-1-git-send-email-jouni.hogander@nokia.com>
References: <878wyav7ti.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:36589 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbYEPK5w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 06:57:52 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4GAvOxE024865
	for <linux-omap@vger.kernel.org>; Fri, 16 May 2008 05:57:50 -0500
In-Reply-To: <878wyav7ti.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com

Add pm.c file for common code and move handling of sleep_while_idle
attribute and sleep_block to it.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/Makefile |    2 +
 arch/arm/mach-omap2/pm.c     |   91 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h     |    4 ++
 arch/arm/mach-omap2/pm24xx.c |   49 +----------------------
 4 files changed, 98 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pm.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 8f80382..12f6a6f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -12,6 +12,8 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sram24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= sram34xx.o
 
 # Power Management
+obj-$(CONFIG_PM) += pm.o
+
 ifeq ($(CONFIG_ARCH_OMAP2),y)
 obj-$(CONFIG_PM) += pm24xx.o sleep24xx.o
 endif
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
new file mode 100644
index 0000000..55ed75b
--- /dev/null
+++ b/arch/arm/mach-omap2/pm.c
@@ -0,0 +1,91 @@
+/*
+ * linux/arch/arm/mach-omap2/pm.c
+ *
+ * OMAP Power Management Common Routines
+ *
+ * Copyright (C) 2005 Texas Instruments, Inc.
+ * Copyright (C) 2006-2008 Nokia Corporation
+ *
+ * Written by:
+ * Richard Woodruff <r-woodruff2@ti.com>
+ * Tony Lindgren
+ * Juha Yrjola
+ * Amit Kucheria <amit.kucheria@nokia.com>
+ * Igor Stoppa <igor.stoppa@nokia.com>
+ * Jouni Hogander
+ *
+ * Based on pm.c for omap1
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/suspend.h>
+#include <linux/time.h>
+
+#include <asm/arch/cpu.h>
+#include <asm/mach/time.h>
+#include <asm/atomic.h>
+
+#include "pm.h"
+
+unsigned short enable_dyn_sleep;
+atomic_t sleep_block = ATOMIC_INIT(0);
+
+static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	return sprintf(buf, "%hu\n", enable_dyn_sleep);
+}
+
+static ssize_t idle_store(struct kobject *kobj, struct kobj_attribute *attr,
+			  const char *buf, size_t n)
+{
+	unsigned short value;
+	if (sscanf(buf, "%hu", &value) != 1 ||
+	    (value != 0 && value != 1)) {
+		printk(KERN_ERR "idle_sleep_store: Invalid value\n");
+		return -EINVAL;
+	}
+	enable_dyn_sleep = value;
+	return n;
+}
+
+static struct kobj_attribute sleep_while_idle_attr =
+	__ATTR(sleep_while_idle, 0644, idle_show, idle_store);
+
+void omap2_block_sleep(void)
+{
+	atomic_inc(&sleep_block);
+}
+
+void omap2_allow_sleep(void)
+{
+	int i;
+
+	i = atomic_dec_return(&sleep_block);
+	BUG_ON(i < 0);
+}
+
+int __init omap_pm_init(void)
+{
+	int error = -1;
+
+	if (cpu_is_omap24xx())
+		error = omap2_pm_init();
+	if (error) {
+		printk(KERN_ERR "omap2_pm_init failed: %d\n", error);
+		return error;
+	}
+
+	/* disabled till drivers are fixed */
+	enable_dyn_sleep = 0;
+	error = sysfs_create_file(power_kobj, &sleep_while_idle_attr.attr);
+	if (error)
+		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
+
+	return error;
+}
+
+late_initcall(omap_pm_init);
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 541bf90..15482ba 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -13,6 +13,10 @@
  * published by the Free Software Foundation.
  */
 
+extern int omap2_pm_init(void);
+extern unsigned short enable_dyn_sleep;
+extern atomic_t sleep_block;
+
 #ifdef CONFIG_PM_DEBUG
 extern u32 omap2_read_32k_sync_counter(void);
 extern void omap2_pm_dump(int mode, int resume, unsigned int us);
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 593f629..7bb654f 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -31,7 +31,6 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 
-#include <asm/atomic.h>
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
 #include <asm/mach-types.h>
@@ -61,30 +60,6 @@ static void (*omap2_sram_idle)(void);
 static void (*omap2_sram_suspend)(void __iomem *dllctrl);
 static void (*saved_idle)(void);
 
-static unsigned short enable_dyn_sleep = 0; /* disabled till drivers are fixed */
-
-static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
-			 char *buf)
-{
-	return sprintf(buf, "%hu\n", enable_dyn_sleep);
-}
-
-static ssize_t idle_store(struct kobject *kobj, struct kobj_attribute *attr,
-			  const char *buf, size_t n)
-{
-	unsigned short value;
-	if (sscanf(buf, "%hu", &value) != 1 ||
-	    (value != 0 && value != 1)) {
-		printk(KERN_ERR "idle_sleep_store: Invalid value\n");
-		return -EINVAL;
-	}
-	enable_dyn_sleep = value;
-	return n;
-}
-
-static struct kobj_attribute sleep_while_idle_attr =
-	__ATTR(sleep_while_idle, 0644, idle_show, idle_store);
-
 static struct clk *osc_ck, *emul_ck;
 
 static int omap2_fclks_active(void)
@@ -112,21 +87,6 @@ static int omap2_irq_pending(void)
 	return 0;
 }
 
-static atomic_t sleep_block = ATOMIC_INIT(0);
-
-void omap2_block_sleep(void)
-{
-	atomic_inc(&sleep_block);
-}
-
-void omap2_allow_sleep(void)
-{
-	int i;
-
-	i = atomic_dec_return(&sleep_block);
-	BUG_ON(i < 0);
-}
-
 static void omap2_enter_full_retention(void)
 {
 	u32 l, sleep_time = 0;
@@ -519,10 +479,9 @@ static void __init prcm_setup_regs(void)
 			  WKUP_MOD, PM_WKEN);
 }
 
-static int __init omap2_pm_init(void)
+int __init omap2_pm_init(void)
 {
 	u32 l;
-	int error;
 
 	printk(KERN_INFO "Power Management for OMAP2 initializing\n");
 	l = __raw_readl(OMAP24XX_PRCM_REVISION);
@@ -579,11 +538,5 @@ static int __init omap2_pm_init(void)
 	suspend_set_ops(&omap_pm_ops);
 	pm_idle = omap2_pm_idle;
 
-	error = sysfs_create_file(power_kobj, &sleep_while_idle_attr.attr);
-	if (error)
-		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
-
 	return 0;
 }
-
-late_initcall(omap2_pm_init);
-- 
1.5.5


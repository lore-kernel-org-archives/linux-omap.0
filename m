From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH] OMAP GPTimer for OProfile(Errata#628216)
Date: Thu,  1 Apr 2010 20:54:08 +0530
Message-ID: <1270135448-11604-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37440 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754661Ab0DAPBk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Apr 2010 11:01:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, Siarhei Siamashka <siarhei.siamashka@nokia.com>, Manjunatha GK <manjugk@ti.com>

From: DebBarma, Tarun Kanti <tarun.kanti@ti.com>

[ARM Cortex-A8 Errata 628216]
If a Perf Counter OVFL occurs simultaneously with an update to a CP14 or
CP15 register, the OVFL status can be lost.

In order to workaround problem in Cortex-A8 Performance Counter, OMAP
GPTIMER is used by OProfile.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: Manjunatha GK <manjugk@ti.com>
---
 arch/arm/Kconfig                          |   59 +++++++++++++++---
 arch/arm/oprofile/Makefile                |    1 +
 arch/arm/oprofile/common.c                |    4 +
 arch/arm/oprofile/op_arm_model.h          |    1 +
 arch/arm/oprofile/op_model_omap_gptimer.c |   96 +++++++++++++++++++++++++++++
 5 files changed, 153 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/oprofile/op_model_omap_gptimer.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 410d3e3..a753c8c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -175,27 +175,70 @@ config ARM_L1_CACHE_SHIFT_6
 	help
 	  Setting ARM L1 cache line size to 64 Bytes.
 
-if OPROFILE
+menuconfig INSTRUMENTATION
+	bool	"Instrumentation Support"
+	default y
+	---help---
+	  Say Y here to get to see options related to performance measurement,
+	  system-wide debugging and testing. This option alone does not add any
+	  kernel code.
+
+	  If you say N, all options in this submenu will be skipped and
+	  disabled. If you're trying to debug the kernel itself, check the
+	  Kernel Hacking menu.
+
+if INSTRUMENTATION
+
+config PROFILING
+	bool "Profiling support"
+	help
+	  Say Y here to enable the extended profiling support mechanisms
+	  used by profilers such as OProfile.
+
+config OPROFILE
+	tristate "OProfile system profiling"
+	depends on PROFILING
+	help
+	  OProfile is a profiling system capable of profiling the
+	  whole system, including the kernel, kernel modules, libraries,
+	  and applications.
+
+	  If unsure, say N.
+choice
+        prompt "Oprofile Mode"
+        depends on OPROFILE
+        default OPROFILE_OMAP_GPTIMER
 
 config OPROFILE_ARMV6
-	def_bool y
+	bool "Oprofile ARMv6"
 	depends on CPU_V6 && !SMP
 	select OPROFILE_ARM11_CORE
 
 config OPROFILE_MPCORE
-	def_bool y
+	bool "Oprofile MPcore"
 	depends on CPU_V6 && SMP
 	select OPROFILE_ARM11_CORE
 
-config OPROFILE_ARM11_CORE
-	bool
-
 config OPROFILE_ARMV7
-	def_bool y
+	bool "Oprofile ARMv7"
 	depends on CPU_V7 && !SMP
+	help
+	  Uses Performance counters for profiling
+
+config OPROFILE_OMAP_GPTIMER
+	bool "Oprofile GPTimer"
+	depends on ARCH_OMAP
+	select OMAP_32K_TIMER
+	select OMAP_DM_TIMER
+	help
+	  Uses GPTIMER for profiling. Currently this is the preferred
+	  way since Performance counters have known bugs in Cortex-A8
+endchoice
+
+config OPROFILE_ARM11_CORE
 	bool
 
-endif
+endif # INSTRUMENTATION
 
 config VECTORS_BASE
 	hex
diff --git a/arch/arm/oprofile/Makefile b/arch/arm/oprofile/Makefile
index 88e31f5..fc2bc02 100644
--- a/arch/arm/oprofile/Makefile
+++ b/arch/arm/oprofile/Makefile
@@ -8,6 +8,7 @@ DRIVER_OBJS = $(addprefix ../../../drivers/oprofile/, \
 
 oprofile-y				:= $(DRIVER_OBJS) common.o backtrace.o
 oprofile-$(CONFIG_CPU_XSCALE)		+= op_model_xscale.o
+oprofile-$(CONFIG_OPROFILE_OMAP_GPTIMER)	+= op_model_omap_gptimer.o
 oprofile-$(CONFIG_OPROFILE_ARM11_CORE)	+= op_model_arm11_core.o
 oprofile-$(CONFIG_OPROFILE_ARMV6)	+= op_model_v6.o
 oprofile-$(CONFIG_OPROFILE_MPCORE)	+= op_model_mpcore.o
diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
index 3fcd752..9eb2b9b 100644
--- a/arch/arm/oprofile/common.c
+++ b/arch/arm/oprofile/common.c
@@ -133,6 +133,10 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 
 	ops->backtrace = arm_backtrace;
 
+#ifdef CONFIG_OPROFILE_OMAP_GPTIMER
+	spec = &op_omap_gptimer_spec;
+#endif
+
 #ifdef CONFIG_CPU_XSCALE
 	spec = &op_xscale_spec;
 #endif
diff --git a/arch/arm/oprofile/op_arm_model.h b/arch/arm/oprofile/op_arm_model.h
index 8c4e4f6..55f22e4 100644
--- a/arch/arm/oprofile/op_arm_model.h
+++ b/arch/arm/oprofile/op_arm_model.h
@@ -24,6 +24,7 @@ struct op_arm_model_spec {
 extern struct op_arm_model_spec op_xscale_spec;
 #endif
 
+extern struct op_arm_model_spec op_omap_gptimer_spec;
 extern struct op_arm_model_spec op_armv6_spec;
 extern struct op_arm_model_spec op_mpcore_spec;
 extern struct op_arm_model_spec op_armv7_spec;
diff --git a/arch/arm/oprofile/op_model_omap_gptimer.c b/arch/arm/oprofile/op_model_omap_gptimer.c
new file mode 100644
index 0000000..49bab30
--- /dev/null
+++ b/arch/arm/oprofile/op_model_omap_gptimer.c
@@ -0,0 +1,96 @@
+/**
+ * OMAP gptimer based event monitor driver for oprofile
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Author: Siarhei Siamashka <siarhei.siamashka@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/oprofile.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <plat/dmtimer.h>
+
+#include "op_counter.h"
+#include "op_arm_model.h"
+
+static struct omap_dm_timer *gptimer;
+
+static int gptimer_init(void)
+{
+	return 0;
+}
+
+static int gptimer_setup(void)
+{
+	return 0;
+}
+
+static irqreturn_t gptimer_interrupt(int irq, void *arg)
+{
+	omap_dm_timer_write_status(gptimer, OMAP_TIMER_INT_OVERFLOW);
+	oprofile_add_sample(get_irq_regs(), 0);
+	return IRQ_HANDLED;
+}
+
+static int gptimer_start(void)
+{
+	int err;
+	u32 count = counter_config[0].count;
+
+	BUG_ON(gptimer != NULL);
+	/* First try to request timers from CORE power domain for OMAP3 */
+	if (cpu_is_omap34xx()) {
+		gptimer = omap_dm_timer_request_specific(10);
+		if (gptimer == NULL)
+			gptimer = omap_dm_timer_request_specific(11);
+	}
+	/* Just any timer would be fine */
+	if (gptimer == NULL)
+		gptimer = omap_dm_timer_request();
+
+	if (gptimer == NULL)
+		return -ENODEV;
+
+	omap_dm_timer_set_source(gptimer, OMAP_TIMER_SRC_32_KHZ);
+	err = request_irq(omap_dm_timer_get_irq(gptimer), gptimer_interrupt,
+				IRQF_DISABLED, "oprofile gptimer", NULL);
+	if (err) {
+		omap_dm_timer_free(gptimer);
+		gptimer = NULL;
+		printk(KERN_ERR "oprofile: unable to request gptimer IRQ\n");
+		return err;
+	}
+
+	/* opcontrol sets default value as 100000 which makes the sample rate
+	 * too low, hence resetting
+	 */
+	if ((count < 0) || (count == 100000))
+		count = 1;
+
+	omap_dm_timer_set_load_start(gptimer, 1, 0xffffffff - count);
+	omap_dm_timer_set_int_enable(gptimer, OMAP_TIMER_INT_OVERFLOW);
+	return 0;
+}
+
+static void gptimer_stop(void)
+{
+	omap_dm_timer_set_int_enable(gptimer, 0);
+	free_irq(omap_dm_timer_get_irq(gptimer), NULL);
+	omap_dm_timer_free(gptimer);
+	gptimer = NULL;
+}
+
+struct op_arm_model_spec op_omap_gptimer_spec = {
+	.init		= gptimer_init,
+	.num_counters	= 1,
+	.setup_ctrs	= gptimer_setup,
+	.start		= gptimer_start,
+	.stop		= gptimer_stop,
+	.name		= "arm/armv6",
+};
-- 
1.6.0.4


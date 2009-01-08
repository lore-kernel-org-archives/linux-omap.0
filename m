From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: [PATCH 1/1] OMAP gptimer based event monitor driver for oprofile
Date: Thu, 8 Jan 2009 20:21:23 +0200
Message-ID: <ESEBH102NgEpTX5V3Gy000037d9@esebh102.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <oprofile-list-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=oprofile-list>
List-Post: <mailto:oprofile-list@lists.sourceforge.net>
List-Help: <mailto:oprofile-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: oprofile-list-bounces@lists.sourceforge.net
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: oprofile-list <oprofile-list@lists.sourceforge.net>
List-Id: linux-omap@vger.kernel.org


Signed-off-by: Siarhei Siamashka <siarhei.siamashka@nokia.com>
---
 arch/arm/Kconfig                          |    6 ++
 arch/arm/oprofile/Makefile                |    1 +
 arch/arm/oprofile/common.c                |    5 ++
 arch/arm/oprofile/op_arm_model.h          |    2 +
 arch/arm/oprofile/op_model_omap_gptimer.c |   76 +++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/oprofile/op_model_omap_gptimer.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 72b45cd..5f0acee 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -161,6 +161,12 @@ config GENERIC_HARDIRQS_NO__DO_IRQ
 
 if OPROFILE
 
+config OPROFILE_OMAP_GPTIMER
+	def_bool y
+	depends on ARCH_OMAP
+	select CONFIG_OMAP_32K_TIMER
+	select CONFIG_OMAP_DM_TIMER
+
 config OPROFILE_ARMV6
 	def_bool y
 	depends on CPU_V6 && !SMP
diff --git a/arch/arm/oprofile/Makefile b/arch/arm/oprofile/Makefile
index 88e31f5..7e9f76e 100644
--- a/arch/arm/oprofile/Makefile
+++ b/arch/arm/oprofile/Makefile
@@ -10,5 +10,6 @@ oprofile-y				:= $(DRIVER_OBJS) common.o backtrace.o
 oprofile-$(CONFIG_CPU_XSCALE)		+= op_model_xscale.o
 oprofile-$(CONFIG_OPROFILE_ARM11_CORE)	+= op_model_arm11_core.o
 oprofile-$(CONFIG_OPROFILE_ARMV6)	+= op_model_v6.o
+oprofile-$(CONFIG_OPROFILE_OMAP_GPTIMER)	+= op_model_omap_gptimer.o
 oprofile-$(CONFIG_OPROFILE_MPCORE)	+= op_model_mpcore.o
 oprofile-$(CONFIG_OPROFILE_ARMV7)	+= op_model_v7.o
diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
index 3fcd752..add3cb4 100644
--- a/arch/arm/oprofile/common.c
+++ b/arch/arm/oprofile/common.c
@@ -133,6 +133,11 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 
 	ops->backtrace = arm_backtrace;
 
+/* comes first, so that it can be overrided by a better implementation */
+#ifdef CONFIG_OPROFILE_OMAP_GPTIMER
+	spec = &op_omap_gptimer_spec;
+#endif
+
 #ifdef CONFIG_CPU_XSCALE
 	spec = &op_xscale_spec;
 #endif
diff --git a/arch/arm/oprofile/op_arm_model.h b/arch/arm/oprofile/op_arm_model.h
index 8c4e4f6..db936da 100644
--- a/arch/arm/oprofile/op_arm_model.h
+++ b/arch/arm/oprofile/op_arm_model.h
@@ -24,6 +24,8 @@ struct op_arm_model_spec {
 extern struct op_arm_model_spec op_xscale_spec;
 #endif
 
+extern struct op_arm_model_spec op_omap_gptimer_spec;
+
 extern struct op_arm_model_spec op_armv6_spec;
 extern struct op_arm_model_spec op_mpcore_spec;
 extern struct op_arm_model_spec op_armv7_spec;
diff --git a/arch/arm/oprofile/op_model_omap_gptimer.c b/arch/arm/oprofile/op_model_omap_gptimer.c
new file mode 100644
index 0000000..d67a291
--- /dev/null
+++ b/arch/arm/oprofile/op_model_omap_gptimer.c
@@ -0,0 +1,76 @@
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
+
+#include <mach/dmtimer.h>
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
+	u32 count = counter_config[0].count;
+	gptimer = omap_dm_timer_request();
+	BUG_ON(gptimer == NULL);
+	omap_dm_timer_set_source(gptimer, OMAP_TIMER_SRC_32_KHZ);
+	if (request_irq(omap_dm_timer_get_irq(gptimer), gptimer_interrupt,
+			IRQF_DISABLED, "oprofile gptimer", NULL) != 0) {
+		printk(KERN_ERR "oprofile: unable to request gptimer IRQ\n");
+		return -1;
+	}
+
+	if (count < 1)
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
+}
+
+struct op_arm_model_spec op_omap_gptimer_spec = {
+	.init		= gptimer_init,
+	.num_counters	= 1,
+	.setup_ctrs	= gptimer_setup,
+	.start		= gptimer_start,
+	.stop		= gptimer_stop,
+	.name		= "hrtimer",
+};
-- 
1.5.6.5


------------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It is the best place to buy or sell services for
just about anything Open Source.
http://p.sf.net/sfu/Xq1LFB

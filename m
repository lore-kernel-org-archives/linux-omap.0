From: virtuoso@slind.org
Subject: [PATCH 6/6] omap3: make coresight register save across OFF modes a sysfs option
Date: Sat,  1 May 2010 20:38:21 +0300
Message-ID: <1272735501-2963-7-git-send-email-virtuoso@slind.org>
References: <1272735501-2963-1-git-send-email-virtuoso@slind.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:44782 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983Ab0EARlY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 May 2010 13:41:24 -0400
In-Reply-To: <1272735501-2963-1-git-send-email-virtuoso@slind.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, r-woodruff2@ti.com, Alexander Shishkin <virtuoso@slind.org>

From: Alexander Shishkin <virtuoso@slind.org>

This adds a sysfs file at /sys/power/coresight_save which is used to
control if the ETM and debug components' states should be saved and
restored across OFF modes.

Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
---
 arch/arm/mach-omap2/Makefile    |    1 +
 arch/arm/mach-omap2/debug34xx.c |   66 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h        |    6 +++
 arch/arm/mach-omap2/pm34xx.c    |    3 ++
 4 files changed, 76 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/debug34xx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4b9fc57..3185114 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -47,6 +47,7 @@ ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o
+obj-$(CONFIG_ENABLE_OFF_MODE_JTAG_ETM_DEBUG) += debug34xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
diff --git a/arch/arm/mach-omap2/debug34xx.c b/arch/arm/mach-omap2/debug34xx.c
new file mode 100644
index 0000000..698e83a
--- /dev/null
+++ b/arch/arm/mach-omap2/debug34xx.c
@@ -0,0 +1,66 @@
+/*
+ * Control saving and restoring of coresight components' state during
+ * OFF mode.
+ *
+ * Copyright (C) 2010 Nokia Corporation
+ * Alexander Shishkin
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
+
+#include "pm.h"
+
+/*
+ * Pointer to a place in sram where the ETM/debug state save
+ * flag is. It can be calculated after the omap_sram_idle is
+ * pushed to sram.
+ */
+static unsigned int *_etm_save;
+
+/*
+ * sysfs file /sys/power/coresight_save controls whether the
+ * state of coresight components should be saved and restored
+ * across OFF modes.
+ */
+static ssize_t coresight_save_show(struct kobject *kobj,
+				  struct kobj_attribute *attr,
+				  char *buf)
+{
+	return sprintf(buf, "%u\n", *_etm_save);
+}
+
+static ssize_t coresight_save_store(struct kobject *kobj,
+				   struct kobj_attribute *attr,
+				   const char *buf, size_t n)
+{
+	unsigned int value;
+
+	if (sscanf(buf, "%u", &value) != 1)
+		return -EINVAL;
+
+	*_etm_save = !!value;
+
+	return n;
+}
+
+static struct kobj_attribute coresight_save_attr =
+	__ATTR(coresight_save, 0644, coresight_save_show, coresight_save_store);
+
+int omap3_coresight_pm_init(void *sram_addr)
+{
+	int ret;
+
+	/* the last word from the top of omap_sram_idle */
+	_etm_save = (unsigned *)((u8 *)sram_addr + omap34xx_cpu_suspend_sz - 4);
+
+	ret = sysfs_create_file(power_kobj, &coresight_save_attr.attr);
+
+	return ret;
+}
+
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index bd6466a..06f5e0e 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -75,6 +75,12 @@ extern void omap34xx_cpu_suspend(u32 *addr, int save_state);
 extern void save_secure_ram_context(u32 *addr);
 extern void omap3_save_scratchpad_contents(void);
 
+#ifdef CONFIG_ENABLE_OFF_MODE_JTAG_ETM_DEBUG
+int omap3_coresight_pm_init(void *sram_addr);
+#else
+#define omap3_coresight_pm_init(x) do {} while (0)
+#endif
+
 extern unsigned int omap24xx_idle_loop_suspend_sz;
 extern unsigned int omap34xx_suspend_sz;
 extern unsigned int save_secure_ram_context_sz;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ea0000b..7a96bbe 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -1072,6 +1072,9 @@ static int __init omap3_pm_init(void)
 	core_clkdm = clkdm_lookup("core_clkdm");
 
 	omap_push_sram_idle();
+
+	omap3_coresight_pm_init(_omap_sram_idle);
+
 #ifdef CONFIG_SUSPEND
 	suspend_set_ops(&omap_pm_ops);
 #endif /* CONFIG_SUSPEND */
-- 
1.7.1.1.g15764


From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 2/9] OMAP1: Dual mode timer device registration.
Date: Sat, 29 May 2010 20:07:04 +0530
Message-ID: <1275143831-7629-3-git-send-email-thara@ti.com>
References: <1275143831-7629-1-git-send-email-thara@ti.com>
 <1275143831-7629-2-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36639 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755976Ab0E2OhU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 May 2010 10:37:20 -0400
In-Reply-To: <1275143831-7629-2-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch converts OMAP1 dual mode timers into platform devices
and adds support for registering them through generic linux
platform device layer.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap1/Makefile   |    1 +
 arch/arm/mach-omap1/dmtimers.c |  148 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap1/timer32k.c |    3 -
 3 files changed, 149 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-omap1/dmtimers.c

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index b6a537c..9abc6b7 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
 obj-$(CONFIG_OMAP_MPU_TIMER)	+= time.o
 obj-$(CONFIG_OMAP_32K_TIMER)	+= timer32k.o
+obj-$(CONFIG_OMAP_DM_TIMER)	+= dmtimers.o
 
 # Power Management
 obj-$(CONFIG_PM) += pm.o sleep.o
diff --git a/arch/arm/mach-omap1/dmtimers.c b/arch/arm/mach-omap1/dmtimers.c
new file mode 100644
index 0000000..4034fb7
--- /dev/null
+++ b/arch/arm/mach-omap1/dmtimers.c
@@ -0,0 +1,148 @@
+/**
+ * OMAP1 Dual-Mode Timers
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Thara Gopinath <thara@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+
+#include <mach/irqs.h>
+#include <plat/dmtimer.h>
+
+#define OMAP1610_GPTIMER1_BASE		0xfffb1400
+#define OMAP1610_GPTIMER2_BASE          0xfffb1c00
+#define OMAP1610_GPTIMER3_BASE          0xfffb2400
+#define OMAP1610_GPTIMER4_BASE          0xfffb2c00
+#define OMAP1610_GPTIMER5_BASE          0xfffb3400
+#define OMAP1610_GPTIMER6_BASE          0xfffb3c00
+#define OMAP1610_GPTIMER7_BASE          0xfffb7400
+#define OMAP1610_GPTIMER8_BASE          0xfffbd400
+
+#define OMAP1_DM_TIMER_COUNT	8
+
+static int omap1_dm_timer_set_clk(struct platform_device *pdev, int source)
+{
+	int n = (pdev->id) << 1;
+	u32 l;
+
+	l = omap_readl(MOD_CONF_CTRL_1) & ~(0x03 << n);
+	l |= source << n;
+	omap_writel(l, MOD_CONF_CTRL_1);
+
+	return 0;
+}
+
+int __init omap1_dm_timer_init(void)
+{
+	int i = 0;
+
+	if (!cpu_is_omap16xx())
+		return 0;
+
+	omap_dm_timer_count = OMAP1_DM_TIMER_COUNT;
+
+	for (i = 0; i < omap_dm_timer_count; i++) {
+		struct platform_device *pdev;
+		struct omap_dm_timer_plat_info *pdata;
+		struct resource res[2];
+		u32 base, irq;
+		int ret;
+
+		switch (i) {
+		case 0:
+			base = OMAP1610_GPTIMER1_BASE;
+			irq = INT_1610_GPTIMER1;
+			break;
+		case 1:
+			base = OMAP1610_GPTIMER2_BASE;
+			irq = INT_1610_GPTIMER2;
+			break;
+		case 2:
+			base = OMAP1610_GPTIMER3_BASE;
+			irq = INT_1610_GPTIMER3;
+			break;
+		case 3:
+			base = OMAP1610_GPTIMER4_BASE;
+			irq = INT_1610_GPTIMER4;
+			break;
+		case 4:
+			base = OMAP1610_GPTIMER5_BASE;
+			irq = INT_1610_GPTIMER5;
+			break;
+		case 5:
+			base = OMAP1610_GPTIMER6_BASE;
+			irq = INT_1610_GPTIMER6;
+			break;
+		case 6:
+			base = OMAP1610_GPTIMER7_BASE;
+			irq = INT_1610_GPTIMER7;
+			break;
+		case 7:
+			base = OMAP1610_GPTIMER8_BASE;
+			irq = INT_1610_GPTIMER8;
+			break;
+		default:
+			/* Should never reach here */
+			return  -EINVAL;
+		}
+
+		pdev = platform_device_alloc("dmtimer", i);
+		if (!pdev) {
+			pr_err("%s: Unable to device alloc for dmtimer%d\n",
+				__func__, i);
+			return -ENOMEM;
+		}
+
+		memset(res, 0, 2 * sizeof(struct resource));
+		res[0].start = base;
+		res[0].end = base + 0xff;
+		res[0].flags = IORESOURCE_MEM;
+		res[1].start = res[1].end = irq;
+		res[1].flags = IORESOURCE_IRQ;
+		ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
+		if (ret) {
+			pr_err("%s: Unable to add resources for %s%d\n",
+				__func__, pdev->name, pdev->id);
+			goto exit_device_put;
+		}
+
+		pdata = kzalloc(sizeof(struct omap_dm_timer_plat_info),
+				GFP_KERNEL);
+		if (!pdata) {
+			pr_err("%s: Unable to allocate pdata for %s%d\n",
+				__func__, pdev->name, pdev->id);
+			ret = -ENOMEM;
+			goto exit_device_put;
+		}
+
+		pdata->omap_dm_set_source_clk = omap1_dm_timer_set_clk;
+		ret = platform_device_add_data(pdev, pdata, sizeof(*pdata));
+		if (ret) {
+			pr_err("%s: Unable to add platform data for %s%d\n",
+				__func__, pdev->name, pdev->id);
+			goto exit_release_pdata;
+		}
+		ret = platform_device_add(pdev);
+		if (ret) {
+			pr_err("%s: Unable to add platform device for %s%d\n",
+				__func__, pdev->name, pdev->id);
+			goto exit_release_pdata;
+		}
+		continue;
+exit_release_pdata:
+		kfree(pdata);
+exit_device_put:
+		platform_device_put(pdev);
+		return ret;
+	}
+	return 0;
+}
+arch_initcall(omap1_dm_timer_init);
diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
index 20cfbcc..6b8ab9b 100644
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -183,9 +183,6 @@ static __init void omap_init_32k_timer(void)
  */
 static void __init omap_timer_init(void)
 {
-#ifdef CONFIG_OMAP_DM_TIMER
-	omap_dm_timer_init();
-#endif
 	omap_init_32k_timer();
 }
 
-- 
1.7.0.rc1.33.g07cf0f


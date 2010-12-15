From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v6 7/12] OMAP2+: dmtimer: convert to platform devices
Date: Wed, 15 Dec 2010 09:35:05 +0530
Message-ID: <1292385910-5234-8-git-send-email-tarun.kanti@ti.com>
References: <1292385910-5234-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37478 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241Ab0LNRBo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 12:01:44 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id oBEH1eYQ008823
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 14 Dec 2010 11:01:43 -0600
In-Reply-To: <1292385910-5234-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Thara Gopinath <thara@ti.com>

Add routines to converts dmtimers to platform devices. The device data
is obtained from hwmod database of respective platform and is registered
to device model after successful binding to driver. It also provides
provision to access timers during early boot when pm_runtime framework
is not completely up and running.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Thara Gopinath <thara@ti.com>
Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/mach-omap2/Makefile  |    2 +-
 arch/arm/mach-omap2/dmtimer.c |  194 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 195 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/dmtimer.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 60e51bc..7700ccd 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o \
-	 common.o
+	 common.o dmtimer.o
 
 omap-2-3-common				= irq.o sdrc.o prm2xxx_3xxx.o
 hwmod-common				= omap_hwmod.o \
diff --git a/arch/arm/mach-omap2/dmtimer.c b/arch/arm/mach-omap2/dmtimer.c
new file mode 100644
index 0000000..f251ad0
--- /dev/null
+++ b/arch/arm/mach-omap2/dmtimer.c
@@ -0,0 +1,194 @@
+/**
+ * OMAP2PLUS Dual-Mode Timers - platform device registration
+ *
+ * Contains first level initialization routines which extracts timers
+ * information from hwmod database and registers with linux device model.
+ * It also has low level function to change the timer input clock source.
+ *
+ * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
+ * Tarun Kanti DebBarma <tarun.kanti@ti.com>
+ * Thara Gopinath <thara@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+
+#include <plat/dmtimer.h>
+#include <plat/omap_device.h>
+
+/*
+ * OMAP4 IP revision has different register offsets
+ * for interrupt registers and functional registers.
+ */
+#define VERSION2_TIMER_WAKEUP_EN_REG_OFFSET	0x14
+#define VERSION2_TIMER_STAT_REG_OFFSET		0x10
+
+static int early_timer_count __initdata = 1;
+
+struct dm_timer_data {
+	struct omap_device *od;
+	struct dmtimer_platform_data *pdata;
+	struct list_head node;
+};
+
+static __initdata LIST_HEAD(dm_timer_data_list);
+
+/**
+ * omap2_dm_timer_set_src - change the timer input clock source
+ * @pdev:	timer platform device pointer
+ * @timer_clk:	current clock source
+ * @source:	array index of parent clock source
+ */
+static int omap2_dm_timer_set_src(struct platform_device *pdev, int source)
+{
+	int ret;
+	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
+	struct clk *fclk = clk_get(&pdev->dev, "fck");
+	struct clk *new_fclk;
+	char *fclk_name = "32k_ck"; /* default name */
+
+	switch (source) {
+	case OMAP_TIMER_SRC_SYS_CLK:
+		fclk_name = "sys_ck";
+		break;
+
+	case OMAP_TIMER_SRC_32_KHZ:
+		fclk_name = "32k_ck";
+		break;
+
+	case OMAP_TIMER_SRC_EXT_CLK:
+		if (pdata->timer_ip_type == OMAP_TIMER_IP_VERSION_1) {
+			fclk_name = "alt_ck";
+			break;
+		}
+		dev_dbg(&pdev->dev, "%s: %d: invalid clk src.\n",
+			__func__, __LINE__);
+		return -EINVAL;
+	}
+
+	if (IS_ERR_OR_NULL(fclk)) {
+		dev_dbg(&pdev->dev, "%s: %d: clk_get() FAILED\n",
+			__func__, __LINE__);
+		return -EINVAL;
+	}
+
+	new_fclk = clk_get(&pdev->dev, fclk_name);
+	if (IS_ERR_OR_NULL(new_fclk)) {
+		dev_dbg(&pdev->dev, "%s: %d: clk_get() %s FAILED\n",
+			__func__, __LINE__, fclk_name);
+		clk_put(fclk);
+		return -EINVAL;
+	}
+
+	ret = clk_set_parent(fclk, new_fclk);
+	if (IS_ERR_VALUE(ret)) {
+		dev_dbg(&pdev->dev, "%s: clk_set_parent() to %s FAILED\n",
+			__func__, fclk_name);
+		ret = -EINVAL;
+	}
+
+	clk_put(new_fclk);
+	clk_put(fclk);
+
+	return ret;
+}
+
+struct omap_device_pm_latency omap2_dmtimer_latency[] = {
+	{
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func   = omap_device_enable_hwmods,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+/**
+ * omap_timer_init - build and register timer device with an
+ * associated timer hwmod
+ * @oh:	timer hwmod pointer to be used to build timer device
+ * @user:	parameter that can be passed from calling hwmod API
+ *
+ * Called by omap_hwmod_for_each_by_class to register each of the timer
+ * devices present in the system. The number of timer devices is known
+ * by parsing through the hwmod database for a given class name. At the
+ * end of function call memory is allocated for timer device and it is
+ * registered to the framework ready to be proved by the driver.
+ */
+static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
+{
+	int id;
+	int ret = 0;
+	char *name = "omap_timer";
+	struct dmtimer_platform_data *pdata;
+	struct omap_device *od;
+	struct dm_timer_data *timer_data = NULL;
+
+	pr_debug("%s: %s\n", __func__, oh->name);
+
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		pr_err("%s: No memory for [%s]\n", __func__, oh->name);
+		return -ENOMEM;
+	}
+
+	pdata->is_early_init = 1;
+
+	/* hook clock set/get functions */
+	pdata->set_timer_src = omap2_dm_timer_set_src;
+
+	pdata->timer_ip_type = oh->class->rev;
+	if (pdata->timer_ip_type == OMAP_TIMER_IP_VERSION_2) {
+		pdata->func_offset = VERSION2_TIMER_WAKEUP_EN_REG_OFFSET;
+		pdata->intr_offset = VERSION2_TIMER_STAT_REG_OFFSET;
+	} else {
+		pdata->func_offset = 0;
+		pdata->intr_offset = 0;
+	}
+
+	/*
+	 * Extract the id's from name field in hwmod database
+	 * and use the same for constructing ids' for the
+	 * timer devices. In a way, we are avoiding usage of
+	 * static variable witin the function to do the same.
+	 * CAUTION: We have to be careful and make sure the
+	 * name in hwmod database does not change in which case
+	 * we might either make corresponding change here or
+	 * switch back static variable mechanism.
+	 */
+	sscanf(oh->name, "timer%2d", &id);
+
+	od = omap_device_build(name, id, oh, pdata, sizeof(*pdata),
+			omap2_dmtimer_latency,
+			ARRAY_SIZE(omap2_dmtimer_latency),
+			pdata->is_early_init);
+
+	if (IS_ERR(od)) {
+		pr_err("%s: Can't build omap_device for %s: %s.\n",
+			__func__, name, oh->name);
+		ret = -EINVAL;
+	} else if (pdata->is_early_init)
+		early_timer_count++;
+
+	timer_data = kzalloc(sizeof(*timer_data), GFP_KERNEL);
+	if (!timer_data) {
+		pr_debug("%s: no memory for dm_timer_data\n",
+				__func__);
+		return -ENOMEM;
+	}
+
+	/* store od and pdata to be used later during normal initialization */
+	timer_data->od = od;
+	timer_data->pdata = pdata;
+	list_add_tail(&timer_data->node, &dm_timer_data_list);
+
+	return ret;
+}
-- 
1.6.0.4


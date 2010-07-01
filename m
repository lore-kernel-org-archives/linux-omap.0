From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [RFC 3/6] omap: introduce OMAP4 remoteproc module
Date: Fri,  2 Jul 2010 01:23:11 +0300
Message-ID: <1278022994-28476-4-git-send-email-ohad@wizery.com>
References: <1278022994-28476-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49802 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932451Ab0GAWXi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 18:23:38 -0400
Received: by bwz1 with SMTP id 1so1212780bwz.19
        for <linux-omap@vger.kernel.org>; Thu, 01 Jul 2010 15:23:36 -0700 (PDT)
In-Reply-To: <1278022994-28476-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohadb@ti.com>

From: Hari Kanigeri <h-kanigeri2@ti.com>

Introduce OMAP4 machine-dependent module required
for starting and stopping the OMAP3 remote processors.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Ohad Ben-Cohen <ohadb@ti.com>
---
 arch/arm/mach-omap2/remoteproc44xx.c |  196 ++++++++++++++++++++++++++++++++++
 1 files changed, 196 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/remoteproc44xx.c

diff --git a/arch/arm/mach-omap2/remoteproc44xx.c b/arch/arm/mach-omap2/remoteproc44xx.c
new file mode 100644
index 0000000..e240595
--- /dev/null
+++ b/arch/arm/mach-omap2/remoteproc44xx.c
@@ -0,0 +1,196 @@
+/*
+ * Remote Processor machine-specific module for OMAP4
+ *
+ * Copyright (C) 2010 Texas Instruments Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+/* this is needed for multi-omap support */
+#ifdef CONFIG_ARCH_OMAP4
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include <plat/remoteproc.h>
+#include <mach/irqs.h>
+#include <plat/omap_device.h>
+
+#include "cm.h"
+#include "prm.h"
+
+#define RM_M3_RST1ST				0x1
+#define RM_M3_RST2ST				0x2
+#define RM_M3_RST3ST				0x4
+#define RM_M3_REL_RST1_MASK			0x2
+#define RM_M3_REL_RST2_MASK			0x0
+#define RM_M3_AST_RST1_MASK			0x3
+#define RM_M3_AST_RST2_MASK			0x2
+
+#define M3_CLK_MOD_MODE_HW_AUTO			0x1
+#define M3_CLKTRCTRL_SW_WKUP			0x2
+#define M3_CLKTRCTRL_SW_SLEEP			0x1
+#define M3_CLKACTIVITY_MPU_M3_CLK		0x100
+
+static inline int omap4_rproc_get_state(struct omap_rproc *rproc)
+{
+	return rproc->state;
+}
+
+static inline int proc44x_sysm3_start(struct device *dev, u32 start_addr)
+{
+	u32 reg;
+	int counter = 10;
+
+	/* Module is managed automatically by HW */
+	cm_write_mod_reg(M3_CLK_MOD_MODE_HW_AUTO, OMAP4430_CM2_CORE_MOD,
+					OMAP4_CM_DUCATI_DUCATI_CLKCTRL_OFFSET);
+
+	/* Enable the M3 clock */
+	cm_write_mod_reg(M3_CLKTRCTRL_SW_WKUP, OMAP4430_CM2_CORE_MOD,
+					OMAP4_CM_DUCATI_CLKSTCTRL_OFFSET);
+	do {
+		reg = cm_read_mod_reg(OMAP4430_CM2_CORE_MOD,
+					OMAP4_CM_DUCATI_CLKSTCTRL_OFFSET);
+		if (reg & M3_CLKACTIVITY_MPU_M3_CLK) {
+			dev_info(dev, "M3 clock enabled:"
+			"OMAP4430_CM_DUCATI_CLKSTCTRL = 0x%x\n", reg);
+			break;
+		}
+		msleep(1);
+	} while (--counter);
+	if (counter == 0) {
+		dev_info(dev, "FAILED TO ENABLE DUCATI M3 CLOCK !%x\n", reg);
+		return -EFAULT;
+	}
+
+	/* De-assert RST1, and clear the Reset status */
+	dev_info(dev, "De-assert RST1\n");
+	prm_write_mod_reg(RM_M3_REL_RST1_MASK, OMAP4430_PRM_CORE_MOD,
+				OMAP4_RM_DUCATI_RSTCTRL_OFFSET);
+	while (!(prm_read_mod_reg(OMAP4430_PRM_CORE_MOD,
+		OMAP4_RM_DUCATI_RSTST_OFFSET) & RM_M3_RST1ST))
+		;
+	dev_info(dev, "RST1 released!");
+
+	prm_write_mod_reg(RM_M3_RST1ST, OMAP4430_PRM_CORE_MOD,
+				OMAP4_RM_DUCATI_RSTST_OFFSET);
+
+	return 0;
+}
+
+static inline int proc44x_appm3_start(struct device *dev, u32 start_addr)
+{
+	/* De-assert RST2, and clear the Reset status */
+	dev_info(dev, "De-assert RST2\n");
+	prm_write_mod_reg(RM_M3_REL_RST2_MASK, OMAP4430_PRM_CORE_MOD,
+				OMAP4_RM_DUCATI_RSTCTRL_OFFSET);
+
+	while (!(prm_read_mod_reg(OMAP4430_PRM_CORE_MOD,
+		OMAP4_RM_DUCATI_RSTST_OFFSET) & RM_M3_RST2ST))
+		;
+	dev_info(dev, "RST2 released!");
+
+	prm_write_mod_reg(RM_M3_RST2ST, OMAP4430_PRM_CORE_MOD,
+				OMAP4_RM_DUCATI_RSTST_OFFSET);
+
+	return 0;
+}
+
+static inline int proc44x_sysm3_stop(struct device *dev)
+{
+	dev_info(dev, "assert RST1\n");
+	prm_write_mod_reg(RM_M3_AST_RST1_MASK, OMAP4430_PRM_CORE_MOD,
+				OMAP4_RM_DUCATI_RSTCTRL_OFFSET);
+	/* Disable the M3 clock */
+	cm_write_mod_reg(M3_CLKTRCTRL_SW_SLEEP, OMAP4430_CM2_CORE_MOD,
+					OMAP4_CM_DUCATI_CLKSTCTRL_OFFSET);
+
+	return 0;
+}
+
+static inline int proc44x_appm3_stop(struct device *dev)
+{
+	dev_info(dev, "assert RST2\n");
+	prm_write_mod_reg(RM_M3_AST_RST2_MASK, OMAP4430_PRM_CORE_MOD,
+				OMAP4_RM_DUCATI_RSTCTRL_OFFSET);
+
+	return 0;
+}
+
+static struct omap_rproc_ops omap4_ducati0_ops = {
+	.start = proc44x_sysm3_start,
+	.stop = proc44x_sysm3_stop,
+	.get_state = omap4_rproc_get_state,
+};
+
+static struct omap_rproc_ops omap4_ducati1_ops = {
+	.start = proc44x_appm3_start,
+	.stop = proc44x_appm3_stop,
+	.get_state = omap4_rproc_get_state,
+};
+
+static struct omap_rproc_ops omap4_tesla_ops = {
+	.start = NULL,
+	.stop = NULL,
+	.get_state = NULL,
+};
+
+static struct omap_rproc_platform_data omap4_rproc_data[] = {
+	{
+		.name = "tesla",
+		.ops = &omap4_tesla_ops,
+		.oh_name = "tesla_hwmod",
+	},
+	{
+		.name = "ducati-proc0",
+		.ops = &omap4_ducati0_ops,
+		.oh_name = "ducati_hwmod0",
+	},
+	{
+		.name = "ducati-proc1",
+		.ops = &omap4_ducati1_ops,
+		.oh_name = "ducati_hwmod1",
+	},
+};
+
+struct omap_rproc_platform_data *omap4_get_rproc_data(void)
+{
+       return omap4_rproc_data;
+}
+
+int omap4_get_rproc_data_size(void)
+{
+       return ARRAY_SIZE(omap4_rproc_data);
+}
+#else
+struct omap_rproc_platform_data *omap4_get_rproc_data(void)
+{
+       return NULL;
+}
+
+int omap4_get_rproc_data_size(void)
+{
+       return 0;
+}
+#endif
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("OMAP4 Remote Processor module");
+MODULE_AUTHOR("Hari Kanigeri <h-kanigeri2@ti.com>");
+MODULE_AUTHOR("Ohad Ben-Cohen <ohad@wizery.com>");
-- 
1.7.0.4


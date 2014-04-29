From: Dan Murphy <dmurphy@ti.com>
Subject: [RFC 03/11] drivers: reset: omap5: Add reset data for omap5
Date: Tue, 29 Apr 2014 15:19:42 -0500
Message-ID: <1398802790-29287-4-git-send-email-dmurphy@ti.com>
References: <1398802790-29287-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44066 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758340AbaD2UU2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Apr 2014 16:20:28 -0400
In-Reply-To: <1398802790-29287-1-git-send-email-dmurphy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, devicetree@vger.kernel.org
Cc: t-kristo@ti.com, s-anna@ti.com, p.zabel@pengutronix.de, Dan Murphy <dmurphy@ti.com>

Add the reset register data for the omap5 SoC.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/reset/ti/Makefile         |    1 +
 drivers/reset/ti/reset-ti-data.h  |    2 ++
 drivers/reset/ti/reset-ti-omap5.c |   61 +++++++++++++++++++++++++++++++++++++
 drivers/reset/ti/reset-ti.c       |    3 ++
 4 files changed, 67 insertions(+)
 create mode 100644 drivers/reset/ti/reset-ti-omap5.c

diff --git a/drivers/reset/ti/Makefile b/drivers/reset/ti/Makefile
index 622eb3b..4d2d06c 100644
--- a/drivers/reset/ti/Makefile
+++ b/drivers/reset/ti/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_RESET_TI) += reset-ti.o
 obj-$(CONFIG_SOC_DRA7XX) += reset-ti-dra7xx.o
+obj-$(CONFIG_SOC_OMAP5) += reset-ti-omap5.o
diff --git a/drivers/reset/ti/reset-ti-data.h b/drivers/reset/ti/reset-ti-data.h
index 5812ed5..d3c6d42 100644
--- a/drivers/reset/ti/reset-ti-data.h
+++ b/drivers/reset/ti/reset-ti-data.h
@@ -56,4 +56,6 @@ struct ti_reset_data {
 };
 
 extern struct ti_reset_data dra7_reset_data;
+extern struct ti_reset_data omap5_reset_data;
+
 #endif
diff --git a/drivers/reset/ti/reset-ti-omap5.c b/drivers/reset/ti/reset-ti-omap5.c
new file mode 100644
index 0000000..3e7529c
--- /dev/null
+++ b/drivers/reset/ti/reset-ti-omap5.c
@@ -0,0 +1,61 @@
+/*
+ * OMAP5 reset data for PRCM Module
+ *
+ * Copyright 2014 Texas Instruments Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "reset-ti-data.h"
+
+static struct ti_reset_reg_data omap5_reset_reg_data[] = {
+	{
+		.rstctrl_offs = 0x1c00,
+		.rstctrl_bit = 0x0,
+		.rstst_offs	= 0x1c04,
+		.rstst_bit = 0x0,
+	},
+	{
+		.rstctrl_offs = 0x410,
+		.rstctrl_bit = 0x0,
+		.rstst_offs	= 0x414,
+		.rstst_bit = 0x0,
+	}, /* DSP_RESET */
+	{
+		.rstctrl_offs = 0x410,
+		.rstctrl_bit = 0x1,
+		.rstst_offs	= 0x414,
+		.rstst_bit = 0x1,
+	}, /* DSP_MMU_CACHE */
+	{
+		.rstctrl_offs = 0x910,
+		.rstctrl_bit = 0x0,
+		.rstst_offs	= 0x914,
+		.rstst_bit = 0x0,
+	}, /* IPU_CPU0 */
+	{
+		.rstctrl_offs = 0x910,
+		.rstctrl_bit = 0x1,
+		.rstst_offs	= 0x914,
+		.rstst_bit = 0x1,
+	}, /* IPU_CPU1 */
+	{
+		.rstctrl_offs = 0x910,
+		.rstctrl_bit = 0x2,
+		.rstst_offs	= 0x914,
+		.rstst_bit = 0x2,
+	}, /* IPU_MMU_CACHE */
+	{
+		.rstctrl_offs = 0x1210,
+		.rstctrl_bit = 0,
+		.rstst_offs	= 0x1214,
+		.rstst_bit	= 0,
+	},
+};
+
+struct ti_reset_data omap5_reset_data = {
+	.reg_data	= omap5_reset_reg_data,
+	.nr_resets	= ARRAY_SIZE(omap5_reset_reg_data),
+};
diff --git a/drivers/reset/ti/reset-ti.c b/drivers/reset/ti/reset-ti.c
index 486b77c..7310827 100644
--- a/drivers/reset/ti/reset-ti.c
+++ b/drivers/reset/ti/reset-ti.c
@@ -135,6 +135,9 @@ static const struct of_device_id ti_reset_of_match[] = {
 #ifdef CONFIG_SOC_DRA7XX
 	{ .compatible = "ti,dra7-resets", .data = &dra7_reset_data,},
 #endif
+#ifdef CONFIG_SOC_OMAP5
+	{ .compatible = "ti,omap5-resets", .data = &omap5_reset_data,},
+#endif
 	{},
 };
 
-- 
1.7.9.5


From: Dan Murphy <dmurphy@ti.com>
Subject: [RFC 02/11] drivers: reset: dra7: Add reset data for dra7xx
Date: Tue, 29 Apr 2014 15:19:41 -0500
Message-ID: <1398802790-29287-3-git-send-email-dmurphy@ti.com>
References: <1398802790-29287-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44064 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756660AbaD2UU0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Apr 2014 16:20:26 -0400
In-Reply-To: <1398802790-29287-1-git-send-email-dmurphy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, devicetree@vger.kernel.org
Cc: t-kristo@ti.com, s-anna@ti.com, p.zabel@pengutronix.de, Dan Murphy <dmurphy@ti.com>

Add the reset register data for the dra7xx SoC.
Include the dt-bindings header to properly index
the right reset node.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/reset/ti/Makefile          |    1 +
 drivers/reset/ti/reset-ti-data.h   |    1 +
 drivers/reset/ti/reset-ti-dra7xx.c |   61 ++++++++++++++++++++++++++++++++++++
 drivers/reset/ti/reset-ti.c        |    3 ++
 4 files changed, 66 insertions(+)
 create mode 100644 drivers/reset/ti/reset-ti-dra7xx.c

diff --git a/drivers/reset/ti/Makefile b/drivers/reset/ti/Makefile
index 55ab3f5..622eb3b 100644
--- a/drivers/reset/ti/Makefile
+++ b/drivers/reset/ti/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_RESET_TI) += reset-ti.o
+obj-$(CONFIG_SOC_DRA7XX) += reset-ti-dra7xx.o
diff --git a/drivers/reset/ti/reset-ti-data.h b/drivers/reset/ti/reset-ti-data.h
index 6afdf37..5812ed5 100644
--- a/drivers/reset/ti/reset-ti-data.h
+++ b/drivers/reset/ti/reset-ti-data.h
@@ -55,4 +55,5 @@ struct ti_reset_data {
 	u8	nr_resets;
 };
 
+extern struct ti_reset_data dra7_reset_data;
 #endif
diff --git a/drivers/reset/ti/reset-ti-dra7xx.c b/drivers/reset/ti/reset-ti-dra7xx.c
new file mode 100644
index 0000000..764f83e
--- /dev/null
+++ b/drivers/reset/ti/reset-ti-dra7xx.c
@@ -0,0 +1,61 @@
+/*
+ * dra7xx reset data for PRCM Module
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
+static struct ti_reset_reg_data dra7_reset_reg_data[] = {
+	{
+		.rstctrl_offs = 0x1D00,
+		.rstctrl_bit = 0x0,
+		.rstst_offs	= 0x1D04,
+		.rstst_bit = 0x0,
+	},
+	{
+		.rstctrl_offs = 0x410,
+		.rstctrl_bit = 0x0,
+		.rstst_offs	= 0x414,
+		.rstst_bit = 0x0,
+	},
+	{
+		.rstctrl_offs = 0x510,
+		.rstctrl_bit = 0x0,
+		.rstst_offs	= 0x514,
+		.rstst_bit = 0x0,
+	}, /* IPU_CPU0 */
+	{
+		.rstctrl_offs = 0x510,
+		.rstctrl_bit = 0x1,
+		.rstst_offs	= 0x514,
+		.rstst_bit = 0x1,
+	}, /* IPU_CPU1 */
+	{
+		.rstctrl_offs = 0x510,
+		.rstctrl_bit = 0x2,
+		.rstst_offs	= 0x514,
+		.rstst_bit = 0x2,
+	}, /* IPU_MMU_CACHE */
+	{
+		.rstctrl_offs = 0xf10,
+		.rstctrl_bit = 0,
+		.rstst_offs	= 0xf14,
+		.rstst_bit	= 0,
+	},
+	{
+		.rstctrl_offs = 0x1310,
+		.rstctrl_bit = 0,
+		.rstst_offs	= 0x1314,
+		.rstst_bit	= 0,
+	},
+};
+
+struct ti_reset_data dra7_reset_data = {
+	.reg_data	= dra7_reset_reg_data,
+	.nr_resets	= ARRAY_SIZE(dra7_reset_reg_data),
+};
diff --git a/drivers/reset/ti/reset-ti.c b/drivers/reset/ti/reset-ti.c
index 1d38069..486b77c 100644
--- a/drivers/reset/ti/reset-ti.c
+++ b/drivers/reset/ti/reset-ti.c
@@ -132,6 +132,9 @@ static struct reset_control_ops ti_reset_ops = {
 };
 
 static const struct of_device_id ti_reset_of_match[] = {
+#ifdef CONFIG_SOC_DRA7XX
+	{ .compatible = "ti,dra7-resets", .data = &dra7_reset_data,},
+#endif
 	{},
 };
 
-- 
1.7.9.5


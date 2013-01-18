From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 09/10] ARM: OMAP5: voltagedomain data: Add OMAP5 voltage domain data
Date: Fri, 18 Jan 2013 20:57:35 +0530
Message-ID: <1358522856-12180-10-git-send-email-santosh.shilimkar@ti.com>
References: <1358522856-12180-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32928 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898Ab3ARP1N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jan 2013 10:27:13 -0500
In-Reply-To: <1358522856-12180-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, mturquette@linaro.org, tony@atomide.com, rnayak@ti.com, b-cousson@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>

Add voltagedomain related data for OMAP54XX SOCs.

Cc: Paul Walmsley <paul@pwsan.com>

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/voltage.h                 |    1 +
 arch/arm/mach-omap2/voltagedomains54xx_data.c |  102 +++++++++++++++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 arch/arm/mach-omap2/voltagedomains54xx_data.c

diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index a0ce4f1..5998eed 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -171,6 +171,7 @@ extern void omap2xxx_voltagedomains_init(void);
 extern void omap3xxx_voltagedomains_init(void);
 extern void am33xx_voltagedomains_init(void);
 extern void omap44xx_voltagedomains_init(void);
+extern void omap54xx_voltagedomains_init(void);
 
 struct voltagedomain *voltdm_lookup(const char *name);
 void voltdm_init(struct voltagedomain **voltdm_list);
diff --git a/arch/arm/mach-omap2/voltagedomains54xx_data.c b/arch/arm/mach-omap2/voltagedomains54xx_data.c
new file mode 100644
index 0000000..72b8971
--- /dev/null
+++ b/arch/arm/mach-omap2/voltagedomains54xx_data.c
@@ -0,0 +1,102 @@
+/*
+ * OMAP5 Voltage Management Routines
+ *
+ * Based on voltagedomains44xx_data.c
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/init.h>
+
+#include "common.h"
+
+#include "prm54xx.h"
+#include "voltage.h"
+#include "omap_opp_data.h"
+#include "vc.h"
+#include "vp.h"
+
+static const struct omap_vfsm_instance omap5_vdd_mpu_vfsm = {
+	.voltsetup_reg = OMAP54XX_PRM_VOLTSETUP_MPU_RET_SLEEP_OFFSET,
+};
+
+static const struct omap_vfsm_instance omap5_vdd_mm_vfsm = {
+	.voltsetup_reg = OMAP54XX_PRM_VOLTSETUP_MM_RET_SLEEP_OFFSET,
+};
+
+static const struct omap_vfsm_instance omap5_vdd_core_vfsm = {
+	.voltsetup_reg = OMAP54XX_PRM_VOLTSETUP_CORE_RET_SLEEP_OFFSET,
+};
+
+static struct voltagedomain omap5_voltdm_mpu = {
+	.name = "mpu",
+	.scalable = true,
+	.read = omap4_prm_vcvp_read,
+	.write = omap4_prm_vcvp_write,
+	.rmw = omap4_prm_vcvp_rmw,
+	.vc = &omap4_vc_mpu,
+	.vfsm = &omap5_vdd_mpu_vfsm,
+	.vp = &omap4_vp_mpu,
+};
+
+static struct voltagedomain omap5_voltdm_mm = {
+	.name = "mm",
+	.scalable = true,
+	.read = omap4_prm_vcvp_read,
+	.write = omap4_prm_vcvp_write,
+	.rmw = omap4_prm_vcvp_rmw,
+	.vc = &omap4_vc_iva,
+	.vfsm = &omap5_vdd_mm_vfsm,
+	.vp = &omap4_vp_iva,
+};
+
+static struct voltagedomain omap5_voltdm_core = {
+	.name = "core",
+	.scalable = true,
+	.read = omap4_prm_vcvp_read,
+	.write = omap4_prm_vcvp_write,
+	.rmw = omap4_prm_vcvp_rmw,
+	.vc = &omap4_vc_core,
+	.vfsm = &omap5_vdd_core_vfsm,
+	.vp = &omap4_vp_core,
+};
+
+static struct voltagedomain omap5_voltdm_wkup = {
+	.name = "wkup",
+};
+
+static struct voltagedomain *voltagedomains_omap5[] __initdata = {
+	&omap5_voltdm_mpu,
+	&omap5_voltdm_mm,
+	&omap5_voltdm_core,
+	&omap5_voltdm_wkup,
+	NULL,
+};
+
+static const char *sys_clk_name __initdata = "sys_clkin";
+
+void __init omap54xx_voltagedomains_init(void)
+{
+	struct voltagedomain *voltdm;
+	int i;
+
+	/*
+	 * XXX Will depend on the process, validation, and binning
+	 * for the currently-running IC. Use OMAP4 data for time being.
+	 */
+#ifdef CONFIG_PM_OPP
+	omap5_voltdm_mpu.volt_data = omap446x_vdd_mpu_volt_data;
+	omap5_voltdm_mm.volt_data = omap446x_vdd_iva_volt_data;
+	omap5_voltdm_core.volt_data = omap446x_vdd_core_volt_data;
+#endif
+
+	for (i = 0; voltdm = voltagedomains_omap5[i], voltdm; i++)
+		voltdm->sys_clk.name = sys_clk_name;
+
+	voltdm_init(voltagedomains_omap5);
+};
-- 
1.7.9.5


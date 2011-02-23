From: Sanjeev Premi <premi@ti.com>
Subject: [RFC 3/3] am35xx: pm: Hook-up with TPS65023
Date: Wed, 23 Feb 2011 23:28:33 +0530
Message-ID: <1298483913-20344-4-git-send-email-premi@ti.com>
References: <1298483913-20344-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41220 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932304Ab1BWR6r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 12:58:47 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1NHwi24024463
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 11:58:46 -0600
In-Reply-To: <1298483913-20344-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Add glue logic to hook-up AM35x processors
with TPS65023.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/am3517_tps.c |   96 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 96 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/am3517_tps.c

diff --git a/arch/arm/mach-omap2/am3517_tps.c b/arch/arm/mach-omap2/am3517_tps.c
new file mode 100644
index 0000000..cddd7eb
--- /dev/null
+++ b/arch/arm/mach-omap2/am3517_tps.c
@@ -0,0 +1,96 @@
+/**
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * Based on omap_twl.c
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as 
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/i2c/twl.h>
+
+#include <plat/voltage.h>
+
+#include "pm.h"
+
+/*
+ * TODO: Copy of OMAP3 definitions to get thru compilation.
+ *       May not be needed in final implementation. Need to
+ *       relook at the the need again.
+ */
+#define OMAP3_SRI2C_SLAVE_ADDR		0x12
+#define OMAP3_VDD_MPU_SR_CONTROL_REG	0x00
+#define OMAP3_VDD_CORE_SR_CONTROL_REG	0x01
+#define OMAP3_VP_CONFIG_ERROROFFSET	0x00
+#define OMAP3_VP_VSTEPMIN_VSTEPMIN	0x1
+#define OMAP3_VP_VSTEPMAX_VSTEPMAX	0x04
+#define OMAP3_VP_VLIMITTO_TIMEOUT_US	200
+
+#define OMAP3430_VP2_VLIMITTO_VDDMIN 0x18
+#define OMAP3430_VP2_VLIMITTO_VDDMAX 0x2c
+
+/**
+ * TBD: Update the formula below.
+ *      Needs to be derived from a table.
+ */
+static unsigned long tps65023_vsel_to_uv(const u8 vsel)
+{
+	return (((vsel * 250) + 6000)) * 100;
+}
+
+/**
+ * TBD: Update the formula below.
+ *      Needs to be derived from a table.
+ */
+static u8 tps65023_uv_to_vsel(unsigned long uv)
+{
+	return DIV_ROUND_UP(uv - 600000, 25000);
+}
+
+/**
+ * TBD: Just a copy of OMAP3 PMIC info.
+ *      Many fields below don't make much sense for AM3517,
+ *      but keeping them as is for now.
+ */
+static struct omap_volt_pmic_info am3517_volt_info = {
+	.slew_rate		= 4000,
+	.step_size		= 25000,
+	.on_volt                = 1200000,
+	.onlp_volt              = 1000000,
+	.ret_volt               = 975000,
+	.off_volt               = 600000,
+	.volt_setup_time        = 0xfff,
+	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
+	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
+	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
+	.vp_vddmin		= OMAP3430_VP2_VLIMITTO_VDDMIN,
+	.vp_vddmax		= OMAP3430_VP2_VLIMITTO_VDDMAX,
+	.vp_timeout_us		= OMAP3_VP_VLIMITTO_TIMEOUT_US,
+	.i2c_slave_addr		= OMAP3_SRI2C_SLAVE_ADDR,
+	.pmic_reg		= OMAP3_VDD_CORE_SR_CONTROL_REG,
+	.vsel_to_uv		= tps65023_vsel_to_uv,
+	.uv_to_vsel		= tps65023_uv_to_vsel,
+};
+
+int __init am3517_tps_init(void)
+{
+	struct voltagedomain *voltdm;
+
+	if (!cpu_is_omap3505() && !cpu_is_omap3517())
+		return -ENODEV;
+
+	voltdm = omap_voltage_domain_lookup("mpu");
+	omap_voltage_register_pmic(voltdm, &am3517_volt_info);
+
+	return 0;
+}
+
-- 
1.7.2.2


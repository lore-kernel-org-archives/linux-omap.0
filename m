From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 3/6 V3] OMAP4460: Temperature sensor data
Date: Wed, 24 Aug 2011 20:07:09 +0530
Message-ID: <1314196632-8207-4-git-send-email-j-keerthy@ti.com>
References: <1314196632-8207-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48362 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752602Ab1HXOh3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Aug 2011 10:37:29 -0400
In-Reply-To: <1314196632-8207-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Keerthy <j-keerthy@ti.com>, tony@atomide.com

The register set and the
bit fields might vary across OMAP versions. Hence
creating a structure comprising of all the registers
and bit fields to make the driver uniform for all the
versions with different register sets. The data file
contains the structure populated with register offsets
and bit fields corresponding to OMAP4460 on die sensor.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com
---
 arch/arm/mach-omap2/Makefile                       |    2 +-
 arch/arm/mach-omap2/temp_sensor4460_data.c         |   63 +++++++++++++
 .../plat-omap/include/plat/temperature_sensor.h    |   93 ++++++++++++++++++++
 3 files changed, 157 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/temp_sensor4460_data.c
 create mode 100644 arch/arm/plat-omap/include/plat/temperature_sensor.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index fb02937..2d5d981 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -86,7 +86,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o \
 obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cm2xxx_3xxx.o cminst44xx.o \
 					   cm44xx.o prcm_mpu44xx.o \
 					   prminst44xx.o vc44xx_data.o \
-					   vp44xx_data.o
+					   vp44xx_data.o temp_sensor4460_data.o
 
 # OMAP voltage domains
 ifeq ($(CONFIG_PM),y)
diff --git a/arch/arm/mach-omap2/temp_sensor4460_data.c b/arch/arm/mach-omap2/temp_sensor4460_data.c
new file mode 100644
index 0000000..294963d
--- /dev/null
+++ b/arch/arm/mach-omap2/temp_sensor4460_data.c
@@ -0,0 +1,63 @@
+/*
+ * OMAP4460 on die Temperature sensor data file
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Author: J Keerthy <j-keerthy@ti.com>
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
+
+#include <linux/slab.h>
+#include "control.h"
+#include <plat/temperature_sensor.h>
+
+/*
+ * OMAP4460 has one instance of thermal sensor for MPU
+ * need to describe the individual bit fields
+ */
+struct omap_temp_sensor_registers omap_mpu_temp_sensor_registers = {
+	.temp_sensor_ctrl		= OMAP4460_TEMP_SENSOR_CTRL_OFFSET,
+	.bgap_tempsoff_mask		= OMAP4460_BGAP_TEMPSOFF_MASK,
+	.bgap_soc_mask			= OMAP4460_BGAP_TEMP_SENSOR_SOC_MASK,
+	.bgap_eocz_mask			= OMAP4460_BGAP_TEMP_SENSOR_EOCZ_MASK,
+	.bgap_dtemp_mask		= OMAP4460_BGAP_TEMP_SENSOR_DTEMP_MASK,
+
+	.bgap_mask_ctrl			= OMAP4460_BGAP_CTRL_OFFSET,
+	.mask_hot_mask			= OMAP4460_MASK_HOT_MASK,
+	.mask_cold_mask			= OMAP4460_MASK_COLD_MASK,
+
+	.bgap_mode_ctrl			= OMAP4460_BGAP_CTRL_OFFSET,
+	.mode_ctrl_mask			= OMAP4460_SINGLE_MODE_MASK,
+
+	.bgap_counter			= OMAP4460_BGAP_COUNTER_OFFSET,
+	.counter_mask			= OMAP4460_COUNTER_MASK,
+
+	.bgap_threshold			= OMAP4460_BGAP_THRESHOLD_OFFSET,
+	.threshold_thot_mask		= OMAP4460_T_HOT_MASK,
+	.threshold_tcold_mask		= OMAP4460_T_COLD_MASK,
+
+	.thsut_threshold		= OMAP4460_BGAP_TSHUT_OFFSET,
+	.tshut_hot_mask			= OMAP4460_TSHUT_HOT_MASK,
+	.tshut_cold_mask		= OMAP4460_TSHUT_COLD_MASK,
+
+	.bgap_status			= OMAP4460_BGAP_STATUS_OFFSET,
+	.status_clean_stop_mask		= OMAP4460_CLEAN_STOP_MASK,
+	.status_bgap_alert_mask		= OMAP4460_BGAP_ALERT_MASK,
+	.status_hot_mask		= OMAP4460_HOT_FLAG_MASK,
+	.status_cold_mask		= OMAP4460_COLD_FLAG_MASK,
+
+	.bgap_efuse			= OMAP4460_FUSE_OPP_BGAP,
+};
diff --git a/arch/arm/plat-omap/include/plat/temperature_sensor.h b/arch/arm/plat-omap/include/plat/temperature_sensor.h
new file mode 100644
index 0000000..9302ea8
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/temperature_sensor.h
@@ -0,0 +1,93 @@
+/*
+ * OMAP Temperature sensor header file
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Author: J Keerthy <j-keerthy@ti.com>
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
+
+#ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_TEMPERATURE_SENSOR_H
+#define __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_TEMPERATURE_SENSOR_H
+
+/* Offsets from the base of temperature sensor registers */
+
+#define OMAP4460_TEMP_SENSOR_CTRL_OFFSET	0x00
+#define OMAP4460_BGAP_CTRL_OFFSET		0x4c
+#define OMAP4460_BGAP_COUNTER_OFFSET		0x50
+#define OMAP4460_BGAP_THRESHOLD_OFFSET		0x54
+#define OMAP4460_BGAP_TSHUT_OFFSET		0x58
+#define OMAP4460_BGAP_STATUS_OFFSET		0x5c
+#define OMAP4460_FUSE_OPP_BGAP			-0xcc
+
+/*
+ * The register offsets and but fields might change across
+ * OMAP versions hence populating them in this structure.
+ */
+struct omap_temp_sensor_registers {
+	u32	temp_sensor_ctrl;
+	u32	bgap_tempsoff_mask;
+	u32	bgap_soc_mask;
+	u32	bgap_eocz_mask;
+	u32	bgap_dtemp_mask;
+
+	u32	bgap_mask_ctrl;
+	u32	mask_hot_mask;
+	u32	mask_cold_mask;
+
+	u32	bgap_mode_ctrl;
+	u32	mode_ctrl_mask;
+
+	u32	bgap_counter;
+	u32	counter_mask;
+
+	u32	bgap_threshold;
+	u32	threshold_thot_mask;
+	u32	threshold_tcold_mask;
+
+	u32	thsut_threshold;
+	u32	tshut_hot_mask;
+	u32	tshut_cold_mask;
+
+	u32	bgap_status;
+	u32	status_clean_stop_mask;
+	u32	status_bgap_alert_mask;
+	u32	status_hot_mask;
+	u32	status_cold_mask;
+
+	u32	bgap_efuse;
+};
+
+/* @name: Name of the domain of the temperature sensor */
+struct omap_temp_sensor_dev_attr {
+	const char *name;
+};
+
+extern struct omap_temp_sensor_registers omap_mpu_temp_sensor_registers;
+
+/*
+ * omap_temp_sensor platform data
+ * @registers - pointer to register set and thier bit fields information
+ * @min_freq - The minimum frequency for temp sensor to be operational
+ * @max_freq - The maximum frequency at which temp sensor is operational
+ */
+struct omap_temp_sensor_pdata {
+	struct omap_temp_sensor_registers *registers;
+	u32 min_freq;
+	u32 max_freq;
+};
+
+#endif
-- 
1.7.0.4


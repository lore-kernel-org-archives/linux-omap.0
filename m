From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 3/6] OMAP4460: Temperature sensor data
Date: Thu, 22 Sep 2011 20:59:18 +0530
Message-ID: <1316705361-12175-4-git-send-email-j-keerthy@ti.com>
References: <1316705361-12175-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53954 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874Ab1IVP31 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 11:29:27 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8MFTN15013205
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 10:29:26 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8MFTNRI025725
	for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 20:59:23 +0530 (IST)
In-Reply-To: <1316705361-12175-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: j-keerthy@ti.com

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
 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/temp_sensor4460_data.c |  115 ++++++++++++++++++
 arch/arm/plat-omap/include/plat/scm.h      |  175 ++++++++++++++++++++++++++++
 3 files changed, 291 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/temp_sensor4460_data.c
 create mode 100644 arch/arm/plat-omap/include/plat/scm.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 46a3497..e6f8d36 100644
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
index 0000000..2804615
--- /dev/null
+++ b/arch/arm/mach-omap2/temp_sensor4460_data.c
@@ -0,0 +1,115 @@
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
+#include <plat/scm.h>
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
+
+/*
+ * Temperature values in milli degree celsius
+ * ADC code values from 530 to 923
+ */
+int adc_to_temp[OMAP_ADC_END_VALUE - OMAP_ADC_START_VALUE + 1] = {
+	-40000, -40000, -40000, -40000, -39800, -39400, -39000, -38600, -38200,
+	-37800, -37300, -36800, -36400, -36000, -35600, -35200, -34800,
+	-34300, -33800, -33400, -33000, -32600, -32200, -31800, -31300,
+	-30800, -30400, -30000, -29600, -29200, -28700, -28200, -27800,
+	-27400, -27000, -26600, -26200, -25700, -25200, -24800, -24400,
+	-24000, -23600, -23200, -22700, -22200, -21800, -21400, -21000,
+	-20600, -20200, -19700, -19200, -18800, -18400, -18000, -17600,
+	-17200, -16700, -16200, -15800, -15400, -15000, -14600, -14200,
+	-13700, -13200, -12800, -12400, -12000, -11600, -11200, -10700,
+	-10200, -9800, -9400, -9000, -8600, -8200, -7700, -7200, -6800,
+	-6400, -6000, -5600, -5200, -4800, -4300, -3800, -3400, -3000,
+	-2600, -2200, -1800, -1300, -800, -400, 0, 400, 800, 1200, 1600,
+	2100, 2600, 3000, 3400, 3800, 4200, 4600, 5100, 5600, 6000, 6400,
+	6800, 7200, 7600, 8000, 8500, 9000, 9400, 9800, 10200, 10600, 11000,
+	11400, 11900, 12400, 12800, 13200, 13600, 14000, 14400, 14800,
+	15300, 15800, 16200, 16600, 17000, 17400, 17800, 18200, 18700,
+	19200, 19600, 20000, 20400, 20800, 21200, 21600, 22100, 22600,
+	23000, 23400, 23800, 24200, 24600, 25000, 25400, 25900, 26400,
+	26800, 27200, 27600, 28000, 28400, 28800, 29300, 29800, 30200,
+	30600, 31000, 31400, 31800, 32200, 32600, 33100, 33600, 34000,
+	34400, 34800, 35200, 35600, 36000, 36400, 36800, 37300, 37800,
+	38200, 38600, 39000, 39400, 39800, 40200, 40600, 41100, 41600,
+	42000, 42400, 42800, 43200, 43600, 44000, 44400, 44800, 45300,
+	45800, 46200, 46600, 47000, 47400, 47800, 48200, 48600, 49000,
+	49500, 50000, 50400, 50800, 51200, 51600, 52000, 52400, 52800,
+	53200, 53700, 54200, 54600, 55000, 55400, 55800, 56200, 56600,
+	57000, 57400, 57800, 58200, 58700, 59200, 59600, 60000, 60400,
+	60800, 61200, 61600, 62000, 62400, 62800, 63300, 63800, 64200,
+	64600, 65000, 65400, 65800, 66200, 66600, 67000, 67400, 67800,
+	68200, 68700, 69200, 69600, 70000, 70400, 70800, 71200, 71600,
+	72000, 72400, 72800, 73200, 73600, 74100, 74600, 75000, 75400,
+	75800, 76200, 76600, 77000, 77400, 77800, 78200, 78600, 79000,
+	79400, 79800, 80300, 80800, 81200, 81600, 82000, 82400, 82800,
+	83200, 83600, 84000, 84400, 84800, 85200, 85600, 86000, 86400,
+	86800, 87300, 87800, 88200, 88600, 89000, 89400, 89800, 90200,
+	90600, 91000, 91400, 91800, 92200, 92600, 93000, 93400, 93800,
+	94200, 94600, 95000, 95500, 96000, 96400, 96800, 97200, 97600,
+	98000, 98400, 98800, 99200, 99600, 100000, 100400, 100800, 101200,
+	101600, 102000, 102400, 102800, 103200, 103600, 104000, 104400,
+	104800, 105200, 105600, 106100, 106600, 107000, 107400, 107800,
+	108200, 108600, 109000, 109400, 109800, 110200, 110600, 111000,
+	111400, 111800, 112200, 112600, 113000, 113400, 113800, 114200,
+	114600, 115000, 115400, 115800, 116200, 116600, 117000, 117400,
+	117800, 118200, 118600, 119000, 119400, 119800, 120200, 120600,
+	121000, 121400, 121800, 122200, 122600, 123000
+};
diff --git a/arch/arm/plat-omap/include/plat/scm.h b/arch/arm/plat-omap/include/plat/scm.h
new file mode 100644
index 0000000..47aa38f
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/scm.h
@@ -0,0 +1,175 @@
+/*
+ * OMAP system control module header file
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
+#define OMAP4460_TEMP_SENSOR_CTRL_OFFSET	0x32C
+#define OMAP4460_BGAP_CTRL_OFFSET		0x378
+#define OMAP4460_BGAP_COUNTER_OFFSET		0x37C
+#define OMAP4460_BGAP_THRESHOLD_OFFSET		0x380
+#define OMAP4460_BGAP_TSHUT_OFFSET		0x384
+#define OMAP4460_BGAP_STATUS_OFFSET		0x388
+#define OMAP4460_FUSE_OPP_BGAP			-0x260
+
+#define OMAP_ADC_START_VALUE    530
+#define OMAP_ADC_END_VALUE      923
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
+/**
+ * struct omap4460plus_scm_dev_attr - device attributes for scm
+ * @cnt - Number of temperature sensors
+ * @list - array of pointers to register sets of temp sensors
+ * @name - array of pointers to names of the temp sensors
+ * @t_shut - Thermal shutdown interrupt handling required
+ */
+struct omap4460plus_scm_dev_attr {
+	int cnt;
+	struct omap_temp_sensor_registers *list[10];
+	const char *name[10];
+	bool t_shut;
+};
+
+/* forward declaration */
+struct scm;
+
+/**
+ * struct temp_sensor_hwmon - temperature sensor hwmon device structure
+ * @scm_ptr - pointer to system control module structure
+ * @pdev - platform device pointer for hwmon device
+ * @name - Name of the hwmon temp sensor device
+ */
+struct temp_sensor_hwmon {
+	struct scm		*scm_ptr;
+	struct platform_device	*pdev;
+	const char		*name;
+};
+
+/**
+ * struct system control module - scm device structure
+ * @dev - device pointer
+ * @registers - Pointer to the list of register offsets and bitfields
+ * @fclock - pointer to functional clock of temperature sensor
+ * @div_clk - pointer to parent clock of temperature sensor fclk
+ * @tsh_ptr - pointer to temperature sesnor hwmon struct
+ * @name - pointer to list of temperature sensor instance names is scm
+ * @scm_mutex - Mutex for sysfs, irq and PM
+ * @irq - MPU Irq number for thermal alert
+ * @phy_base - Physical base of the temp I/O
+ * @clk_rate - Holds current clock rate
+ * @temp_sensor_ctrl - temp sensor control register value
+ * @bg_ctrl - bandgap ctrl register value
+ * @bg_counter - bandgap counter value
+ * @bg_threshold - bandgap threshold register value
+ * @temp_sensor_tshut_threshold - bandgap tshut register value
+ * @cnt - count of temperature sensor device in scm
+ */
+struct scm {
+	struct device			*dev;
+	struct omap_temp_sensor_registers **registers;
+	struct clk		*fclock;
+	struct clk		*div_clk;
+	struct temp_sensor_hwmon *tsh_ptr;
+	const char		**name;
+	struct mutex		scm_mutex; /* Mutex for sysfs, irq and PM */
+	unsigned int		irq;
+	void __iomem		*phy_base;
+	u32			clk_rate;
+	u32			temp_sensor_ctrl;
+	u32			bg_ctrl;
+	u32			bg_counter;
+	u32			bg_threshold;
+	u32			temp_sensor_tshut_threshold;
+	u32			cnt;
+};
+
+extern struct omap_temp_sensor_registers omap_mpu_temp_sensor_registers;
+extern int adc_to_temp[394];
+
+/*
+ * struct omap4460plus_scm_pdata - omap4460plus_scm platform data
+ * @registers -  pointer to list of register sets of temp sensors
+ * @name - pointer to list of names of temp sensors
+ * @cnt	- Number of temperature sensors
+ * @min_freq - The minimum frequency for temp sensor to be operational
+ * @max_freq - The maximum frequency at which temp sensor is operational
+ * @t_shut - Thermal shutdown interrupt handling required
+ */
+struct omap4460plus_scm_pdata {
+	struct omap_temp_sensor_registers **registers;
+	const char **name;
+	int cnt;
+	u32 min_freq;
+	u32 max_freq;
+	bool t_shut;
+};
+
+int omap4460plus_scm_show_temp_max(struct scm *scm_ptr, int id);
+int omap4460plus_scm_show_temp_max_hyst(struct scm *scm_ptr, int id);
+int omap4460plus_scm_set_temp_max(struct scm *scm_ptr, int id, int val);
+int omap4460plus_scm_set_temp_max_hyst(struct scm *scm_ptr,
+							int id, int val);
+int omap4460plus_scm_show_update_interval(struct scm *scm_ptr, int id);
+void omap4460plus_scm_set_update_interval(struct scm *scm_ptr,
+						u32 interval, int id);
+int omap4460plus_scm_read_temp(struct scm *scm_ptr, int id);
+
+#endif
-- 
1.7.0.4


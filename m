From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 1/2] ti-soc-thermal: implement omap3 support
Date: Tue, 29 Sep 2015 14:19:11 -0700
Message-ID: <1443561552-23254-2-git-send-email-edubezval@gmail.com>
References: <1443561552-23254-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443561552-23254-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: pavel@ucw.cz
Cc: linux-omap@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-omap@vger.kernel.org

From: Pavel Machek <pavel@ucw.cz>

This adds support for OMAP3 chips to ti-soc-thermal. As requested by
TI people, it is marked unreliable and warning is printed.

Signed-off-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 .../devicetree/bindings/thermal/ti_soc_thermal.txt |   7 ++
 drivers/thermal/ti-soc-thermal/Kconfig             |  15 +++
 drivers/thermal/ti-soc-thermal/Makefile            |   1 +
 .../thermal/ti-soc-thermal/omap3-thermal-data.c    | 103 +++++++++++++++++++++
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |  10 ++
 drivers/thermal/ti-soc-thermal/ti-bandgap.h        |   9 ++
 6 files changed, 145 insertions(+)
 create mode 100644 drivers/thermal/ti-soc-thermal/omap3-thermal-data.c

diff --git a/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt b/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt
index 0c9222d..d9a1b54 100644
--- a/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt
@@ -10,6 +10,7 @@ to the silicon temperature.
 
 Required properties:
 - compatible : Should be:
+  - "ti,omap34xx-bandgap" : for OMAP34xx bandgap
   - "ti,omap4430-bandgap" : for OMAP4430 bandgap
   - "ti,omap4460-bandgap" : for OMAP4460 bandgap
   - "ti,omap4470-bandgap" : for OMAP4470 bandgap
@@ -25,6 +26,12 @@ to each bandgap version, because the mapping may change from
 soc to soc, apart of depending on available features.
 
 Example:
+OMAP34xx:
+bandgap {
+	reg = <0x48002524 0x4>;
+	compatible = "ti,omap34xx-bandgap";
+};
+
 OMAP4430:
 bandgap {
 	reg = <0x4a002260 0x4 0x4a00232C 0x4>;
diff --git a/drivers/thermal/ti-soc-thermal/Kconfig b/drivers/thermal/ti-soc-thermal/Kconfig
index cb6686f..ea8283f 100644
--- a/drivers/thermal/ti-soc-thermal/Kconfig
+++ b/drivers/thermal/ti-soc-thermal/Kconfig
@@ -19,6 +19,21 @@ config TI_THERMAL
 	  This includes trip points definitions, extrapolation rules and
 	  CPU cooling device bindings.
 
+config OMAP3_THERMAL
+	bool "Texas Instruments OMAP3 thermal support"
+	depends on TI_SOC_THERMAL
+	depends on ARCH_OMAP3 || COMPILE_TEST
+	help
+	  If you say yes here you get thermal support for the Texas Instruments
+	  OMAP3 SoC family. The current chips supported are:
+	   - OMAP3430
+
+	  OMAP3 chips normally don't need thermal management, and sensors in
+	  this generation are not accurate, nor they are very close to
+	  the important hotspots.
+
+	  Say 'N' here.
+
 config OMAP4_THERMAL
 	bool "Texas Instruments OMAP4 thermal support"
 	depends on TI_SOC_THERMAL
diff --git a/drivers/thermal/ti-soc-thermal/Makefile b/drivers/thermal/ti-soc-thermal/Makefile
index 1226b24..0f89bdf 100644
--- a/drivers/thermal/ti-soc-thermal/Makefile
+++ b/drivers/thermal/ti-soc-thermal/Makefile
@@ -2,5 +2,6 @@ obj-$(CONFIG_TI_SOC_THERMAL)		+= ti-soc-thermal.o
 ti-soc-thermal-y			:= ti-bandgap.o
 ti-soc-thermal-$(CONFIG_TI_THERMAL)	+= ti-thermal-common.o
 ti-soc-thermal-$(CONFIG_DRA752_THERMAL)	+= dra752-thermal-data.o
+ti-soc-thermal-$(CONFIG_OMAP3_THERMAL)	+= omap3-thermal-data.o
 ti-soc-thermal-$(CONFIG_OMAP4_THERMAL)	+= omap4-thermal-data.o
 ti-soc-thermal-$(CONFIG_OMAP5_THERMAL)	+= omap5-thermal-data.o
diff --git a/drivers/thermal/ti-soc-thermal/omap3-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap3-thermal-data.c
new file mode 100644
index 0000000..8470225
--- /dev/null
+++ b/drivers/thermal/ti-soc-thermal/omap3-thermal-data.c
@@ -0,0 +1,103 @@
+/*
+ * OMAP3 thermal driver.
+ *
+ * Copyright (C) 2011-2012 Texas Instruments Inc.
+ * Copyright (C) 2014 Pavel Machek <pavel@ucw.cz>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * Note
+ * http://www.ti.com/lit/er/sprz278f/sprz278f.pdf "Advisory
+ * 3.1.1.186 MMC OCP Clock Not Gated When Thermal Sensor Is Used"
+ *
+ * Also TI says:
+ * Just be careful when you try to make thermal policy like decisions
+ * based on this sensor. Placement of the sensor w.r.t the actual logic
+ * generating heat has to be a factor as well. If you are just looking
+ * for an approximation temperature (thermometerish kind), you might be
+ * ok with this. I am not sure we'd find any TI data around this.. just a
+ * heads up.
+ */
+
+#include "ti-thermal.h"
+#include "ti-bandgap.h"
+
+/*
+ * OMAP34XX has one instance of thermal sensor for MPU
+ * need to describe the individual bit fields
+ */
+static struct temp_sensor_registers
+omap34xx_mpu_temp_sensor_registers = {
+	.temp_sensor_ctrl = 0,
+	.bgap_soc_mask = BIT(8),
+	.bgap_eocz_mask = BIT(7),
+	.bgap_dtemp_mask = 0x7f,
+
+	.bgap_mode_ctrl = 0,
+	.mode_ctrl_mask = BIT(9),
+};
+
+/* Thresholds and limits for OMAP34XX MPU temperature sensor */
+static struct temp_sensor_data omap34xx_mpu_temp_sensor_data = {
+	.min_freq = 32768,
+	.max_freq = 32768,
+	.max_temp = 125000,
+	.min_temp = -40000,
+	.hyst_val = 5000,
+};
+
+/*
+ * Temperature values in milli degree celsius
+ */
+static const int
+omap34xx_adc_to_temp[128] = {
+	-40000, -40000, -40000, -40000, -40000, -39000, -38000, -36000,
+	-34000, -32000, -31000,	-29000, -28000, -26000, -25000, -24000,
+	-22000, -21000, -19000, -18000, -17000, -15000,	-14000, -12000,
+	-11000, -9000, -8000, -7000, -5000, -4000, -2000, -1000, 0000,
+	1000, 3000, 4000, 5000, 7000, 8000, 10000, 11000, 13000, 14000,
+	15000, 17000, 18000, 20000, 21000, 22000, 24000, 25000, 27000,
+	28000, 30000, 31000, 32000, 34000, 35000, 37000, 38000, 39000,
+	41000, 42000, 44000, 45000, 47000, 48000, 49000, 51000, 52000,
+	53000, 55000, 56000, 58000, 59000, 60000, 62000, 63000, 65000,
+	66000, 67000, 69000, 70000, 72000, 73000, 74000, 76000, 77000,
+	79000, 80000, 81000, 83000, 84000, 85000, 87000, 88000, 89000,
+	91000, 92000, 94000, 95000, 96000, 98000, 99000, 100000,
+	102000, 103000, 105000, 106000, 107000, 109000, 110000, 111000,
+	113000, 114000, 116000, 117000, 118000, 120000, 121000, 122000,
+	124000, 124000, 125000, 125000, 125000, 125000,	125000
+};
+
+/* OMAP34XX data */
+const struct ti_bandgap_data omap34xx_data = {
+	.features = TI_BANDGAP_FEATURE_CLK_CTRL | TI_BANDGAP_FEATURE_UNRELIABLE,
+	.fclock_name = "ts_fck",
+	.div_ck_name = "ts_fck",
+	.conv_table = omap34xx_adc_to_temp,
+	.adc_start_val = 0,
+	.adc_end_val = 127,
+	.expose_sensor = ti_thermal_expose_sensor,
+	.remove_sensor = ti_thermal_remove_sensor,
+
+	.sensors = {
+		{
+		.registers = &omap34xx_mpu_temp_sensor_registers,
+		.ts_data = &omap34xx_mpu_temp_sensor_data,
+		.domain = "cpu",
+		.slope = 0,
+		.constant = 20000,
+		.slope_pcb = 0,
+		.constant_pcb = 20000,
+		.register_cooling = NULL,
+		.unregister_cooling = NULL,
+		},
+	},
+	.sensor_count = 1,
+};
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 10c47c0..9f9ed72 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -1274,6 +1274,10 @@ int ti_bandgap_probe(struct platform_device *pdev)
 	}
 	bgp->dev = &pdev->dev;
 
+	if (TI_BANDGAP_HAS(bgp, UNRELIABLE))
+		dev_warn(&pdev->dev,
+			 "This OMAP thermal sensor is unreliable. You've been warned\n");
+
 	if (TI_BANDGAP_HAS(bgp, TSHUT)) {
 		ret = ti_bandgap_tshut_init(bgp, pdev);
 		if (ret) {
@@ -1579,6 +1583,12 @@ static SIMPLE_DEV_PM_OPS(ti_bandgap_dev_pm_ops, ti_bandgap_suspend,
 #endif
 
 static const struct of_device_id of_ti_bandgap_match[] = {
+#ifdef CONFIG_OMAP3_THERMAL
+	{
+		.compatible = "ti,omap34xx-bandgap",
+		.data = (void *)&omap34xx_data,
+	},
+#endif
 #ifdef CONFIG_OMAP4_THERMAL
 	{
 		.compatible = "ti,omap4430-bandgap",
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
index 0c52f7a..045f642 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
@@ -322,6 +322,8 @@ struct ti_temp_sensor {
  *	has Errata 814
  * TI_BANDGAP_FEATURE_ERRATA_813 - used to workaorund when the bandgap device
  *	has Errata 813
+ * TI_BANDGAP_FEATURE_UNRELIABLE - used when the sensor readings are too
+ *	inaccurate.
  * TI_BANDGAP_HAS(b, f) - macro to check if a bandgap device is capable of a
  *      specific feature (above) or not. Return non-zero, if yes.
  */
@@ -337,6 +339,7 @@ struct ti_temp_sensor {
 #define TI_BANDGAP_FEATURE_HISTORY_BUFFER	BIT(9)
 #define TI_BANDGAP_FEATURE_ERRATA_814		BIT(10)
 #define TI_BANDGAP_FEATURE_ERRATA_813		BIT(11)
+#define TI_BANDGAP_FEATURE_UNRELIABLE		BIT(12)
 #define TI_BANDGAP_HAS(b, f)			\
 			((b)->conf->features & TI_BANDGAP_FEATURE_ ## f)
 
@@ -390,6 +393,12 @@ int ti_bandgap_set_sensor_data(struct ti_bandgap *bgp, int id, void *data);
 void *ti_bandgap_get_sensor_data(struct ti_bandgap *bgp, int id);
 int ti_bandgap_get_trend(struct ti_bandgap *bgp, int id, int *trend);
 
+#ifdef CONFIG_OMAP3_THERMAL
+extern const struct ti_bandgap_data omap34xx_data;
+#else
+#define omap34xx_data					NULL
+#endif
+
 #ifdef CONFIG_OMAP4_THERMAL
 extern const struct ti_bandgap_data omap4430_data;
 extern const struct ti_bandgap_data omap4460_data;
-- 
2.5.0

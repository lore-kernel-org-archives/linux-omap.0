From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCHv2] ti-soc-thermal: implement omap3 support
Date: Thu, 2 Apr 2015 16:49:07 +0200
Message-ID: <20150402144907.GB11687@amd>
References: <20150103114632.GA21883@amd>
 <20150118202447.GA29014@amd>
 <20150331084234.GA11712@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150331084234.GA11712@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, edubezval@gmail.com, rui.zhang@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



This adds support for OMAP3 chips to ti-soc-thermal. As requested by
TI people, it is marked unreliable and warning is printed.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

---

Patch is against thermal linus tree, please apply so that it has
chance for 4.1.

v2: fixed min/max temp

diff --git a/drivers/thermal/ti-soc-thermal/Kconfig b/drivers/thermal/ti-soc-thermal/Kconfig
index bd4c7be..d414c2d 100644
--- a/drivers/thermal/ti-soc-thermal/Kconfig
+++ b/drivers/thermal/ti-soc-thermal/Kconfig
@@ -21,6 +21,21 @@ config TI_THERMAL
 	  This includes trip points definitions, extrapolation rules and
 	  CPU cooling device bindings.
 
+config OMAP3_THERMAL
+	bool "Texas Instruments OMAP3 thermal support"
+	depends on TI_SOC_THERMAL
+	depends on ARCH_OMAP3
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
index 0000000..86a4e2d
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
index 63e2f5c..a58610d 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -1200,6 +1195,10 @@ int ti_bandgap_probe(struct platform_device *pdev)
 	}
 	bgp->dev = &pdev->dev;
 
+	if (TI_BANDGAP_HAS(bgp, UNRELIABLE))
+		dev_warn(&pdev->dev,
+			 "OMAP3 thermal sensor is unreliable and normally unneccessary\n");
+
 	if (TI_BANDGAP_HAS(bgp, TSHUT)) {
 		ret = ti_bandgap_tshut_init(bgp, pdev);
 		if (ret) {
@@ -1505,6 +1504,12 @@ static SIMPLE_DEV_PM_OPS(ti_bandgap_dev_pm_ops, ti_bandgap_suspend,
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
index b3adf72..15878a1 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
@@ -331,6 +331,7 @@ struct ti_temp_sensor {
 #define TI_BANDGAP_FEATURE_FREEZE_BIT		BIT(7)
 #define TI_BANDGAP_FEATURE_COUNTER_DELAY	BIT(8)
 #define TI_BANDGAP_FEATURE_HISTORY_BUFFER	BIT(9)
+#define TI_BANDGAP_FEATURE_UNRELIABLE		BIT(10)
 #define TI_BANDGAP_HAS(b, f)			\
 			((b)->conf->features & TI_BANDGAP_FEATURE_ ## f)
 
@@ -384,6 +385,12 @@ int ti_bandgap_set_sensor_data(struct ti_bandgap *bgp, int id, void *data);
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
diff --git a/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt b/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt
index 0c9222d..3cf8a3b 100644
--- a/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt
@@ -10,6 +10,7 @@ to the silicon temperature.
 
 Required properties:
 - compatible : Should be:
+  - "ti,omap34xx-bandgap" : for OMAP34xx bandgap
   - "ti,omap4430-bandgap" : for OMAP4430 bandgap
   - "ti,omap4460-bandgap" : for OMAP4460 bandgap
   - "ti,omap4470-bandgap" : for OMAP4470 bandgap


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

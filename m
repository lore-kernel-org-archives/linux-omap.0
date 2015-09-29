From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 2/2] thermal: ti-soc-thermal: add OMAP36xx support
Date: Tue, 29 Sep 2015 14:19:12 -0700
Message-ID: <1443561552-23254-3-git-send-email-edubezval@gmail.com>
References: <1443561552-23254-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443561552-23254-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: pavel@ucw.cz
Cc: linux-omap@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Eduardo Valentin <edubezva@gmail.com>
List-Id: linux-omap@vger.kernel.org

Add OMAP36xx support to ti-soc-thermal driver. This
chip is also unreliable. The data provided here is
based on OMAP36xx TRM:
http://www.ti.com/lit/ug/swpu177aa/swpu177aa.pdf

Signed-off-by: Eduardo Valentin <edubezva@gmail.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 .../devicetree/bindings/thermal/ti_soc_thermal.txt |  7 +++
 .../thermal/ti-soc-thermal/omap3-thermal-data.c    | 73 ++++++++++++++++++++++
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |  4 ++
 drivers/thermal/ti-soc-thermal/ti-bandgap.h        |  2 +
 4 files changed, 86 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt b/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt
index d9a1b54..6299dd8 100644
--- a/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt
@@ -11,6 +11,7 @@ to the silicon temperature.
 Required properties:
 - compatible : Should be:
   - "ti,omap34xx-bandgap" : for OMAP34xx bandgap
+  - "ti,omap36xx-bandgap" : for OMAP36xx bandgap
   - "ti,omap4430-bandgap" : for OMAP4430 bandgap
   - "ti,omap4460-bandgap" : for OMAP4460 bandgap
   - "ti,omap4470-bandgap" : for OMAP4470 bandgap
@@ -32,6 +33,12 @@ bandgap {
 	compatible = "ti,omap34xx-bandgap";
 };
 
+OMAP36xx:
+bandgap {
+	reg = <0x48002524 0x4>;
+	compatible = "ti,omap36xx-bandgap";
+};
+
 OMAP4430:
 bandgap {
 	reg = <0x4a002260 0x4 0x4a00232C 0x4>;
diff --git a/drivers/thermal/ti-soc-thermal/omap3-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap3-thermal-data.c
index 8470225..3ee3434 100644
--- a/drivers/thermal/ti-soc-thermal/omap3-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap3-thermal-data.c
@@ -101,3 +101,76 @@ const struct ti_bandgap_data omap34xx_data = {
 	},
 	.sensor_count = 1,
 };
+
+/*
+ * OMAP36XX has one instance of thermal sensor for MPU
+ * need to describe the individual bit fields
+ */
+static struct temp_sensor_registers
+omap36xx_mpu_temp_sensor_registers = {
+	.temp_sensor_ctrl = 0,
+	.bgap_soc_mask = BIT(9),
+	.bgap_eocz_mask = BIT(8),
+	.bgap_dtemp_mask = 0xFF,
+
+	.bgap_mode_ctrl = 0,
+	.mode_ctrl_mask = BIT(10),
+};
+
+/* Thresholds and limits for OMAP36XX MPU temperature sensor */
+static struct temp_sensor_data omap36xx_mpu_temp_sensor_data = {
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
+omap36xx_adc_to_temp[128] = {
+	-40000, -40000, -40000, -40000, -40000, -40000, -40000, -40000,
+	-40000, -40000, -40000,	-40000, -40000, -38000, -35000, -34000,
+	-32000, -30000, -28000, -26000, -24000, -22000,	-20000, -18500,
+	-17000, -15000, -13500, -12000, -10000, -8000, -6500, -5000, -3500,
+	-1500, 0, 2000, 3500, 5000, 6500, 8500, 10000, 12000, 13500,
+	15000, 17000, 19000, 21000, 23000, 25000, 27000, 28500, 30000,
+	32000, 33500, 35000, 37000, 38500, 40000, 42000, 43500, 45000,
+	47000, 48500, 50000, 52000, 53500, 55000, 57000, 58500, 60000,
+	62000, 64000, 66000, 68000, 70000, 71500, 73500, 75000, 77000,
+	78500, 80000, 82000, 83500, 85000, 87000, 88500, 90000, 92000,
+	93500, 95000, 97000, 98500, 100000, 102000, 103500, 105000, 107000,
+	109000, 111000, 113000, 115000, 117000, 118500, 120000, 122000,
+	123500, 125000, 125000, 125000, 125000, 125000, 125000, 125000,
+	125000, 125000, 125000, 125000, 125000, 125000, 125000, 125000,
+	125000, 125000, 125000, 125000, 125000, 125000,	125000
+};
+
+/* OMAP36XX data */
+const struct ti_bandgap_data omap36xx_data = {
+	.features = TI_BANDGAP_FEATURE_CLK_CTRL | TI_BANDGAP_FEATURE_UNRELIABLE,
+	.fclock_name = "ts_fck",
+	.div_ck_name = "ts_fck",
+	.conv_table = omap36xx_adc_to_temp,
+	.adc_start_val = 0,
+	.adc_end_val = 127,
+	.expose_sensor = ti_thermal_expose_sensor,
+	.remove_sensor = ti_thermal_remove_sensor,
+
+	.sensors = {
+		{
+		.registers = &omap36xx_mpu_temp_sensor_registers,
+		.ts_data = &omap36xx_mpu_temp_sensor_data,
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
index 9f9ed72..1e34a1e 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -1588,6 +1588,10 @@ static const struct of_device_id of_ti_bandgap_match[] = {
 		.compatible = "ti,omap34xx-bandgap",
 		.data = (void *)&omap34xx_data,
 	},
+	{
+		.compatible = "ti,omap36xx-bandgap",
+		.data = (void *)&omap36xx_data,
+	},
 #endif
 #ifdef CONFIG_OMAP4_THERMAL
 	{
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
index 045f642..fe0adb8 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
@@ -395,8 +395,10 @@ int ti_bandgap_get_trend(struct ti_bandgap *bgp, int id, int *trend);
 
 #ifdef CONFIG_OMAP3_THERMAL
 extern const struct ti_bandgap_data omap34xx_data;
+extern const struct ti_bandgap_data omap36xx_data;
 #else
 #define omap34xx_data					NULL
+#define omap36xx_data					NULL
 #endif
 
 #ifdef CONFIG_OMAP4_THERMAL
-- 
2.5.0

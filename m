From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 12/14] thermal: ti-soc-thermal: add ->adc_to_mcelsius method
Date: Mon, 14 May 2018 13:42:19 +0200
Message-ID: <1526298141-14045-13-git-send-email-b.zolnierkie@samsung.com>
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180514114350epcas1p2d29cfa8de6b19096d91362c91feb2dc5@epcas1p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-omap@vger.kernel.org

* Add ->adc_to_mcelsius method to struct ti_bandgap_data and
  use it if present in ti_bandgap_adc_to_mcelsius().

* Implement ->adc_to_mcelsius for DRA752 and remove no longer
  needed dra752_adc_to_temp[].

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/ti-soc-thermal/dra752-bandgap.h    |   3 +
 .../thermal/ti-soc-thermal/dra752-thermal-data.c   | 157 ++++-----------------
 .../thermal/ti-soc-thermal/omap5-thermal-data.c    |   5 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |   3 +
 drivers/thermal/ti-soc-thermal/ti-bandgap.h        |   2 +
 5 files changed, 38 insertions(+), 132 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/dra752-bandgap.h b/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
index c39af38..8eb155a 100644
--- a/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
@@ -88,4 +88,7 @@
 extern struct temp_sensor_registers omap5430_gpu_temp_sensor_registers;
 extern struct temp_sensor_registers omap5430_core_temp_sensor_registers;
 
+extern int
+omap5430_adc_to_temp[OMAP5430_ADC_END_VALUE - OMAP5430_ADC_START_VALUE + 1];
+
 #endif /* __DRA752_BANDGAP_H */
diff --git a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
index dcc0b10..87b4d97 100644
--- a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
@@ -84,135 +84,31 @@
 	.max_freq = OMAP5430_MAX_FREQ,
 };
 
-/*
- * DRA752 : Temperature values in milli degree celsius
- * ADC code values from 540 to 945
- */
-static int
-dra752_adc_to_temp[OMAP5430_ADC_END_VALUE - OMAP5430_ADC_START_VALUE + 1] = {
-	/* Index 540 - 549 */
-	-40000, -40000, -40000, -40000, -39800, -39400, -39000, -38600, -38200,
-	-37800,
-	/* Index 550 - 559 */
-	-37400, -37000, -36600, -36200, -35800, -35300, -34700, -34200, -33800,
-	-33400,
-	/* Index 560 - 569 */
-	-33000, -32600, -32200, -31800, -31400, -31000, -30600, -30200, -29800,
-	-29400,
-	/* Index 570 - 579 */
-	-29000, -28600, -28200, -27700, -27100, -26600, -26200, -25800, -25400,
-	-25000,
-	/* Index 580 - 589 */
-	-24600, -24200, -23800, -23400, -23000, -22600, -22200, -21800, -21400,
-	-21000,
-	/* Index 590 - 599 */
-	-20500, -19900, -19400, -19000, -18600, -18200, -17800, -17400, -17000,
-	-16600,
-	/* Index 600 - 609 */
-	-16200, -15800, -15400, -15000, -14600, -14200, -13800, -13400, -13000,
-	-12500,
-	/* Index 610 - 619 */
-	-11900, -11400, -11000, -10600, -10200, -9800, -9400, -9000, -8600,
-	-8200,
-	/* Index 620 - 629 */
-	-7800, -7400, -7000, -6600, -6200, -5800, -5400, -5000, -4500,
-	-3900,
-	/* Index 630 - 639 */
-	-3400, -3000, -2600, -2200, -1800, -1400, -1000, -600, -200,
-	200,
-	/* Index 640 - 649 */
-	600, 1000, 1400, 1800, 2200, 2600, 3000, 3400, 3900,
-	4500,
-	/* Index 650 - 659 */
-	5000, 5400, 5800, 6200, 6600, 7000, 7400, 7800, 8200,
-	8600,
-	/* Index 660 - 669 */
-	9000, 9400, 9800, 10200, 10600, 11000, 11400, 11800, 12200,
-	12700,
-	/* Index 670 - 679 */
-	13300, 13800, 14200, 14600, 15000, 15400, 15800, 16200, 16600,
-	17000,
-	/* Index 680 - 689 */
-	17400, 17800, 18200, 18600, 19000, 19400, 19800, 20200, 20600,
-	21000,
-	/* Index 690 - 699 */
-	21400, 21900, 22500, 23000, 23400, 23800, 24200, 24600, 25000,
-	25400,
-	/* Index 700 - 709 */
-	25800, 26200, 26600, 27000, 27400, 27800, 28200, 28600, 29000,
-	29400,
-	/* Index 710 - 719 */
-	29800, 30200, 30600, 31000, 31400, 31900, 32500, 33000, 33400,
-	33800,
-	/* Index 720 - 729 */
-	34200, 34600, 35000, 35400, 35800, 36200, 36600, 37000, 37400,
-	37800,
-	/* Index 730 - 739 */
-	38200, 38600, 39000, 39400, 39800, 40200, 40600, 41000, 41400,
-	41800,
-	/* Index 740 - 749 */
-	42200, 42600, 43100, 43700, 44200, 44600, 45000, 45400, 45800,
-	46200,
-	/* Index 750 - 759 */
-	46600, 47000, 47400, 47800, 48200, 48600, 49000, 49400, 49800,
-	50200,
-	/* Index 760 - 769 */
-	50600, 51000, 51400, 51800, 52200, 52600, 53000, 53400, 53800,
-	54200,
-	/* Index 770 - 779 */
-	54600, 55000, 55400, 55900, 56500, 57000, 57400, 57800, 58200,
-	58600,
-	/* Index 780 - 789 */
-	59000, 59400, 59800, 60200, 60600, 61000, 61400, 61800, 62200,
-	62600,
-	/* Index 790 - 799 */
-	63000, 63400, 63800, 64200, 64600, 65000, 65400, 65800, 66200,
-	66600,
-	/* Index 800 - 809 */
-	67000, 67400, 67800, 68200, 68600, 69000, 69400, 69800, 70200,
-	70600,
-	/* Index 810 - 819 */
-	71000, 71500, 72100, 72600, 73000, 73400, 73800, 74200, 74600,
-	75000,
-	/* Index 820 - 829 */
-	75400, 75800, 76200, 76600, 77000, 77400, 77800, 78200, 78600,
-	79000,
-	/* Index 830 - 839 */
-	79400, 79800, 80200, 80600, 81000, 81400, 81800, 82200, 82600,
-	83000,
-	/* Index 840 - 849 */
-	83400, 83800, 84200, 84600, 85000, 85400, 85800, 86200, 86600,
-	87000,
-	/* Index 850 - 859 */
-	87400, 87800, 88200, 88600, 89000, 89400, 89800, 90200, 90600,
-	91000,
-	/* Index 860 - 869 */
-	91400, 91800, 92200, 92600, 93000, 93400, 93800, 94200, 94600,
-	95000,
-	/* Index 870 - 879 */
-	95400, 95800, 96200, 96600, 97000, 97500, 98100, 98600, 99000,
-	99400,
-	/* Index 880 - 889 */
-	99800, 100200, 100600, 101000, 101400, 101800, 102200, 102600, 103000,
-	103400,
-	/* Index 890 - 899 */
-	103800, 104200, 104600, 105000, 105400, 105800, 106200, 106600, 107000,
-	107400,
-	/* Index 900 - 909 */
-	107800, 108200, 108600, 109000, 109400, 109800, 110200, 110600, 111000,
-	111400,
-	/* Index 910 - 919 */
-	111800, 112200, 112600, 113000, 113400, 113800, 114200, 114600, 115000,
-	115400,
-	/* Index 920 - 929 */
-	115800, 116200, 116600, 117000, 117400, 117800, 118200, 118600, 119000,
-	119400,
-	/* Index 930 - 939 */
-	119800, 120200, 120600, 121000, 121400, 121800, 122200, 122600, 123000,
-	123400,
-	/* Index 940 - 945 */
-	123800, 124200, 124600, 124900, 125000, 125000,
-};
+static int dra752_adc_to_mcelsius(struct ti_bandgap *bgp, int adc_val, int *t)
+{
+	const struct ti_bandgap_data *conf = bgp->conf;
+
+	/* look up for temperature in the table and return the temperature */
+	if (adc_val < conf->adc_start_val || adc_val > conf->adc_end_val)
+		return -ERANGE;
+
+	switch (adc_val) {
+	case 588:
+		*t = -21800;	/* -21600 */
+		break;
+	case 689:
+		*t = 21000;	/* 21100 */
+		break;
+	case 937:
+		*t = 122200;	/* 122400 */
+		break;
+	default:
+		*t = bgp->conf->conv_table[adc_val - conf->adc_start_val];
+		break;
+	}
+
+	return 0;
+}
 
 /* DRA752 data */
 const struct ti_bandgap_data dra752_data = {
@@ -223,9 +119,10 @@
 			TI_BANDGAP_FEATURE_ERRATA_814,
 	.fclock_name = "l3instr_ts_gclk_div",
 	.div_ck_name = "l3instr_ts_gclk_div",
-	.conv_table = dra752_adc_to_temp,
+	.conv_table = omap5430_adc_to_temp,
 	.adc_start_val = OMAP5430_ADC_START_VALUE,
 	.adc_end_val = OMAP5430_ADC_END_VALUE,
+	.adc_to_mcelsius = dra752_adc_to_mcelsius,
 	.sensors = {
 		{
 		.registers = &omap5430_mpu_temp_sensor_registers,
diff --git a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
index fce6e30..63e95df 100644
--- a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
@@ -124,13 +124,13 @@ struct temp_sensor_registers
 	.min_freq = OMAP5430_MIN_FREQ,
 	.max_freq = OMAP5430_MAX_FREQ,
 };
+#endif /* CONFIG_OMAP5_THERMAL */
 
 /*
  * OMAP54xx ES2.0 : Temperature values in milli degree celsius
  * ADC code values from 540 to 945
  */
-static int
-omap5430_adc_to_temp[
+int omap5430_adc_to_temp[
 	OMAP5430_ADC_END_VALUE - OMAP5430_ADC_START_VALUE + 1] = {
 	/* Index 540 - 549 */
 	-40000, -40000, -40000, -40000, -39800, -39400, -39000, -38600, -38200,
@@ -230,6 +230,7 @@ struct temp_sensor_registers
 	123800, 124200, 124600, 124900, 125000, 125000,
 };
 
+#ifdef CONFIG_OMAP5_THERMAL
 /* OMAP54xx ES2.0 data */
 const struct ti_bandgap_data omap5430_data = {
 	.features = TI_BANDGAP_FEATURE_TSHUT_CONFIG |
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 4d45160..e483792 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -309,6 +309,9 @@ int ti_bandgap_adc_to_mcelsius(struct ti_bandgap *bgp, int adc_val, int *t)
 {
 	const struct ti_bandgap_data *conf = bgp->conf;
 
+	if (conf->adc_to_mcelsius)
+		return conf->adc_to_mcelsius(bgp, adc_val, t);
+
 	/* look up for temperature in the table and return the temperature */
 	if (adc_val < conf->adc_start_val || adc_val > conf->adc_end_val)
 		return -ERANGE;
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
index 4d5b54a..76c3361 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
@@ -330,6 +330,8 @@ struct ti_bandgap_data {
 	char				*div_ck_name;
 	int				sensor_count;
 
+	int (*adc_to_mcelsius)(struct ti_bandgap *bgp, int adc_val, int *t);
+
 	/* this needs to be at the end */
 	struct ti_temp_sensor		sensors[];
 };
-- 
1.9.1

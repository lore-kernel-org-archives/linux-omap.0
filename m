From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/4] regulator: twl6030: add support for vdd1,
	vdd2 and vdd3 regulators
Date: Tue, 28 Feb 2012 15:09:10 +0530
Message-ID: <1330421953-29517-2-git-send-email-rnayak@ti.com>
References: <1330421953-29517-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1330421953-29517-1-git-send-email-rnayak-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>

vdd1 and vdd2 are now common regulators for twl4030 and twl6030. Also
added vdd3 as a new regulator for twl6030. twl6030 vdd1...vdd3 smps
regulator voltages can only be controlled through the smartreflex
voltage channel, thus the support for the voltage_get and set is
minimal and requires external controller.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/twl-core.c            |   15 ++++++++++++++
 drivers/regulator/twl-regulator.c |   39 +++++++++++++++++++++++++++++++++++++
 include/linux/i2c/twl.h           |    5 ++-
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 6c13d9f..e1d3a64 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -951,6 +951,21 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 	/* twl6030 regulators */
 	if (twl_has_regulator() && twl_class_is_6030() &&
 			!(features & TWL6025_SUBCLASS)) {
+		child = add_regulator(TWL6030_REG_VDD1, pdata->vdd1,
+					features);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL6030_REG_VDD2, pdata->vdd2,
+					features);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL6030_REG_VDD3, pdata->vdd3,
+					features);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
 		child = add_regulator(TWL6030_REG_VMMC, pdata->vmmc,
 					features);
 		if (IS_ERR(child))
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 7ff8bb2..8611282 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -561,6 +561,32 @@ static struct regulator_ops twl4030smps_ops = {
 	.get_voltage	= twl4030smps_get_voltage,
 };
 
+static int twl6030coresmps_set_voltage(struct regulator_dev *rdev, int min_uV,
+	int max_uV, unsigned *selector)
+{
+	struct twlreg_info *info = rdev_get_drvdata(rdev);
+
+	if (info->set_voltage)
+		return info->set_voltage(info->data, min_uV);
+
+	return -ENODEV;
+}
+
+static int twl6030coresmps_get_voltage(struct regulator_dev *rdev)
+{
+	struct twlreg_info *info = rdev_get_drvdata(rdev);
+
+	if (info->get_voltage)
+		return info->get_voltage(info->data);
+
+	return -ENODEV;
+}
+
+static struct regulator_ops twl6030coresmps_ops = {
+	.set_voltage	= twl6030coresmps_set_voltage,
+	.get_voltage	= twl6030coresmps_get_voltage,
+};
+
 static int twl6030ldo_list_voltage(struct regulator_dev *rdev, unsigned index)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
@@ -926,6 +952,16 @@ static struct regulator_ops twlsmps_ops = {
 		}, \
 	}
 
+#define TWL6030_ADJUSTABLE_SMPS(label) { \
+	.desc = { \
+		.name = #label, \
+		.id = TWL6030_REG_##label, \
+		.ops = &twl6030coresmps_ops, \
+		.type = REGULATOR_VOLTAGE, \
+		.owner = THIS_MODULE, \
+		}, \
+	}
+
 #define TWL6030_ADJUSTABLE_LDO(label, offset, min_mVolts, max_mVolts) { \
 	.base = offset, \
 	.min_mV = min_mVolts, \
@@ -1027,6 +1063,9 @@ static struct twlreg_info twl_regs[] = {
 	/* 6030 REG with base as PMC Slave Misc : 0x0030 */
 	/* Turnon-delay and remap configuration values for 6030 are not
 	   verified since the specification is not public */
+	TWL6030_ADJUSTABLE_SMPS(VDD1),
+	TWL6030_ADJUSTABLE_SMPS(VDD2),
+	TWL6030_ADJUSTABLE_SMPS(VDD3),
 	TWL6030_ADJUSTABLE_LDO(VAUX1_6030, 0x54, 1000, 3300),
 	TWL6030_ADJUSTABLE_LDO(VAUX2_6030, 0x58, 1000, 3300),
 	TWL6030_ADJUSTABLE_LDO(VAUX3_6030, 0x5c, 1000, 3300),
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 08a82d3..f66c031 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -712,6 +712,9 @@ struct twl4030_platform_data {
 	struct regulator_init_data		*vaux1;
 	struct regulator_init_data		*vaux2;
 	struct regulator_init_data		*vaux3;
+	struct regulator_init_data		*vdd1;
+	struct regulator_init_data		*vdd2;
+	struct regulator_init_data		*vdd3;
 	/* TWL4030 LDO regulators */
 	struct regulator_init_data		*vpll1;
 	struct regulator_init_data		*vpll2;
@@ -720,8 +723,6 @@ struct twl4030_platform_data {
 	struct regulator_init_data		*vsim;
 	struct regulator_init_data		*vaux4;
 	struct regulator_init_data		*vio;
-	struct regulator_init_data		*vdd1;
-	struct regulator_init_data		*vdd2;
 	struct regulator_init_data		*vintana1;
 	struct regulator_init_data		*vintana2;
 	struct regulator_init_data		*vintdig;
-- 
1.7.1

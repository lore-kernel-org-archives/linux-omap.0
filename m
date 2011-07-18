From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 4/6] omap3: pmic: add API to get common SMPS regulators
Date: Mon, 18 Jul 2011 20:35:20 +0300
Message-ID: <1311010522-5868-5-git-send-email-t-kristo@ti.com>
References: <1311010522-5868-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34876 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754507Ab1GRRgI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jul 2011 13:36:08 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1311010522-5868-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, toddpoynor@google.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com

omap3_pmic_get_smps_config can now be used to get regulator configuration
for MPU and CORE SMPS regulators. This should be expanded later to add IVA
SMPS regulator for OMAP4.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/twl-common.c |   62 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/twl-common.h |   14 ++++++++
 2 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 2543342..dc36053 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -23,8 +23,10 @@
 #include <linux/i2c.h>
 #include <linux/i2c/twl.h>
 #include <linux/gpio.h>
+#include <linux/slab.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
+#include <linux/regulator/omap-smps.h>
 
 #include <plat/i2c.h>
 #include <plat/usb.h>
@@ -302,3 +304,63 @@ void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
 	if (regulators_flags & TWL_COMMON_REGULATOR_VPLL2 && !pmic_data->vpll2)
 		pmic_data->vpll2 = &omap3_vpll2_idata;
 }
+
+static struct regulator_consumer_supply omap_smps_mpu_iva_supply[] = {
+	REGULATOR_SUPPLY("vcc", "mpu_iva"),
+};
+
+static struct regulator_consumer_supply omap_smps_core_supply[] = {
+	REGULATOR_SUPPLY("vcc", "core"),
+};
+
+static struct regulator_init_data omap_smps_mpu_iva = {
+	.constraints = {
+		.min_uV			= 600000,
+		.max_uV			= 1450000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(omap_smps_mpu_iva_supply),
+	.consumer_supplies	= omap_smps_mpu_iva_supply,
+};
+
+static struct regulator_init_data omap_smps_core = {
+	.constraints = {
+		.min_uV			= 600000,
+		.max_uV			= 1450000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(omap_smps_core_supply),
+	.consumer_supplies	= omap_smps_core_supply,
+};
+
+void omap_pmic_get_smps_config(struct platform_device *smps_dev,
+				u32 smps_flags)
+{
+	struct omap_smps_platform_data *info;
+	struct regulator_init_data **reg_list;
+	int num_reg = 0;
+
+	reg_list = kmalloc(sizeof(void *) * hweight32(smps_flags), GFP_KERNEL);
+	info = kzalloc(sizeof(struct omap_smps_platform_data), GFP_KERNEL);
+
+	if (!reg_list || !info)
+		return;
+
+	if (smps_flags & SMPS_COMMON_REGULATOR_MPU_IVA) {
+		reg_list[num_reg] = &omap_smps_mpu_iva;
+		num_reg++;
+	}
+	if (smps_flags & SMPS_COMMON_REGULATOR_CORE) {
+		reg_list[num_reg] = &omap_smps_core;
+		num_reg++;
+	}
+
+	info->regulators = reg_list;
+	info->num_regulators = num_reg;
+
+	smps_dev->name = "omap-smps";
+	smps_dev->id = -1;
+	smps_dev->dev.platform_data = info;
+}
diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/twl-common.h
index 5e83a5b..fde8467 100644
--- a/arch/arm/mach-omap2/twl-common.h
+++ b/arch/arm/mach-omap2/twl-common.h
@@ -25,6 +25,11 @@
 #define TWL_COMMON_REGULATOR_VPLL1	(1 << 4)
 #define TWL_COMMON_REGULATOR_VPLL2	(1 << 5)
 
+/* TWLxxxx SMPS regulators */
+#define SMPS_COMMON_REGULATOR_MPU	(1 << 0)
+#define SMPS_COMMON_REGULATOR_CORE	(1 << 1)
+#define SMPS_COMMON_REGULATOR_IVA	(1 << 2)
+#define SMPS_COMMON_REGULATOR_MPU_IVA	(1 << 3)
 
 struct twl4030_platform_data;
 
@@ -56,4 +61,13 @@ void omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
 void omap4_pmic_get_config(struct twl4030_platform_data *pmic_data,
 			   u32 pdata_flags, u32 regulators_flags);
 
+void omap_pmic_get_smps_config(struct platform_device *smps_dev,
+				u32 smps_flags);
+
+static inline void omap3_pmic_get_smps_config(struct platform_device *smps_dev)
+{
+	omap_pmic_get_smps_config(smps_dev, SMPS_COMMON_REGULATOR_MPU_IVA |
+		SMPS_COMMON_REGULATOR_CORE);
+}
+
 #endif /* __OMAP_PMIC_COMMON__ */
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 


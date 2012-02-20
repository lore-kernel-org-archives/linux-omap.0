From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv10 3/4] omap3: add common twl configurations for vdd1 and vdd2
Date: Mon, 20 Feb 2012 12:26:07 +0200
Message-ID: <1329733568-26676-4-git-send-email-t-kristo@ti.com>
References: <1329733568-26676-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50109 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229Ab2BTK0d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Feb 2012 05:26:33 -0500
In-Reply-To: <1329733568-26676-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

VDD1 and VDD2 are the core voltage regulators on OMAP3. VDD1 is used
to control MPU/IVA voltage, and VDD2 is used for CORE. These regulators
are needed by DVFS.

Voltage ranges for VDD1 and VDD2 are taken from twl4030/twl5030 data manuals:
- SWCS019L : TWL4030 ES3.1 Data Manual rev L
- SWCS030E : TWL5030 ES1.2 Data Manual rev E

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/twl-common.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 10b20c6..5f62e51 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -126,6 +126,38 @@ static struct regulator_init_data omap3_vpll2_idata = {
 	.consumer_supplies		= omap3_vpll2_supplies,
 };
 
+static struct regulator_consumer_supply omap3_vdd1_supply[] = {
+	REGULATOR_SUPPLY("vcc", "mpu.0"),
+};
+
+static struct regulator_consumer_supply omap3_vdd2_supply[] = {
+	REGULATOR_SUPPLY("vcc", "l3_main.0"),
+};
+
+static struct regulator_init_data omap3_vdd1 = {
+	.constraints = {
+		.name			= "vdd_mpu_iva",
+		.min_uV			= 600000,
+		.max_uV			= 1450000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE,
+	},
+	.num_consumer_supplies		= ARRAY_SIZE(omap3_vdd1_supply),
+	.consumer_supplies		= omap3_vdd1_supply,
+};
+
+static struct regulator_init_data omap3_vdd2 = {
+	.constraints = {
+		.name			= "vdd_core",
+		.min_uV			= 600000,
+		.max_uV			= 1450000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE,
+	},
+	.num_consumer_supplies		= ARRAY_SIZE(omap3_vdd2_supply),
+	.consumer_supplies		= omap3_vdd2_supply,
+};
+
 void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
 				  u32 pdata_flags, u32 regulators_flags)
 {
@@ -133,6 +165,10 @@ void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
 		pmic_data->irq_base = TWL4030_IRQ_BASE;
 	if (!pmic_data->irq_end)
 		pmic_data->irq_end = TWL4030_IRQ_END;
+	if (!pmic_data->vdd1)
+		pmic_data->vdd1 = &omap3_vdd1;
+	if (!pmic_data->vdd2)
+		pmic_data->vdd2 = &omap3_vdd2;
 
 	/* Common platform data configurations */
 	if (pdata_flags & TWL_COMMON_PDATA_USB && !pmic_data->usb)
-- 
1.7.4.1


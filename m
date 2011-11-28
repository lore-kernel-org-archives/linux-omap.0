From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 4/7] omap3: add common twl configurations for vdd1 and vdd2
Date: Mon, 28 Nov 2011 16:53:22 +0200
Message-ID: <1322492005-27741-5-git-send-email-t-kristo@ti.com>
References: <1322492005-27741-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38535 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751814Ab1K1OyX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Nov 2011 09:54:23 -0500
In-Reply-To: <1322492005-27741-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, khilman@ti.com, b-cousson@ti.com, rnayak@ti.com, gg@slimlogic.co.uk

VDD1 and VDD2 are the core voltage regulators on OMAP3. VDD1 is used
to control MPU/IVA voltage, and VDD2 is used for CORE. These regulators
are needed by DVFS.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/twl-common.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index daa056e..7cf5347 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -115,6 +115,38 @@ static struct regulator_init_data omap3_vpll2_idata = {
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
+		.name			= "VDD1",
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
+		.name			= "VDD2",
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
@@ -122,6 +154,10 @@ void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
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


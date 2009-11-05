From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 4/5] Regulator: Adding OMAP3EVM/TWL4030 specific code in board-omap35x-pmic.c
Date: Thu,  5 Nov 2009 22:09:41 +0530
Message-ID: <1257439181-29257-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47084 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757543AbZKEQjn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Nov 2009 11:39:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Anuj Aggarwal <anuj.aggarwal@ti.com>

Adding various regulator-consumers for OMAP3EVM-TWL4030 combination
in board-omap35x-pmic.c. Also, populating the respective fields
for omap3evm_twldata structure.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 arch/arm/mach-omap2/board-omap35x-pmic.c |   81 +++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/board-omap3evm.c     |    2 +-
 2 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap35x-pmic.c b/arch/arm/mach-omap2/board-omap35x-pmic.c
index aae07ab..2ef4932 100644
--- a/arch/arm/mach-omap2/board-omap35x-pmic.c
+++ b/arch/arm/mach-omap2/board-omap35x-pmic.c
@@ -24,10 +24,87 @@
  * Definitions specific to TWL4030/TPS65950
  */
 #if defined(CONFIG_PMIC_TWL4030)
-static inline void pmic_twl4030_init(void)
+#if defined(CONFIG_MACH_OMAP3EVM)
+#include <linux/i2c/twl4030.h>
+
+extern struct twl4030_platform_data omap3evm_twldata;
+
+/* VDAC */
+static struct regulator_consumer_supply vdac_consumers[] = {
+	{
+		.supply	= "dac",
+	},
+};
+
+static struct regulator_init_data vdac_data = {
+	.constraints = {
+		.name = "VDAC",
+		.min_uV	= 1800000,
+		.max_uV	= 1800000,
+		.apply_uV = true,
+		.valid_modes_mask = REGULATOR_MODE_NORMAL
+			| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask	= REGULATOR_CHANGE_MODE
+			| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(vdac_consumers),
+	.consumer_supplies = vdac_consumers,
+};
+
+/* VPLL2 */
+static struct regulator_consumer_supply vpll2_consumers[] = {
+	{
+		.supply	= "lcd",
+	},
+	{
+		.supply	= "sdi",
+	},
+};
+
+static struct regulator_init_data vpll2_data = {
+	.constraints = {
+		.name = "VPLL2",
+		.min_uV	= 1800000,
+		.max_uV	= 1800000,
+		.apply_uV = true,
+		.valid_modes_mask = REGULATOR_MODE_NORMAL
+			| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask = REGULATOR_CHANGE_MODE
+			| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(vpll2_consumers),
+	.consumer_supplies = vpll2_consumers,
+};
+
+/* VMMC1 */
+struct regulator_consumer_supply vmmc1_consumers[] = {
+	{
+		.supply	= "mmc",
+	},
+};
+
+static struct regulator_init_data vmmc1_data = {
+	.constraints = {
+		.name = "VMMC1",
+		.min_uV	= 1850000,
+		.max_uV	= 3150000,
+		.valid_modes_mask = REGULATOR_MODE_NORMAL
+			| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE
+			| REGULATOR_CHANGE_MODE	| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(vmmc1_consumers),
+	.consumer_supplies = vmmc1_consumers,
+};
+
+static void __init pmic_twl4030_init(void)
 {
-	/* TWL4030 specific init code */
+	/* Initialize the regulator specific fields here */
+	omap3evm_twldata.vdac = &vdac_data;
+	omap3evm_twldata.vpll2 = &vpll2_data;
+	omap3evm_twldata.vmmc1 = &vmmc1_data;
 }
+#endif	/* CONFIG_MACH_OMAP3EVM */
 #else
 static inline void pmic_twl4030_init(void)
 {
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index dbdf062..10ac0d2 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -197,7 +197,7 @@ static struct twl4030_madc_platform_data omap3evm_madc_data = {
 	.irq_line	= 1,
 };
 
-static struct twl4030_platform_data omap3evm_twldata = {
+struct twl4030_platform_data omap3evm_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 
-- 
1.6.2.4


From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/7] OMAP4: twl-common: Add twl6030 V1V8,
 V2V1 SMPS common configuration
Date: Fri, 10 Feb 2012 12:05:13 +0200
Message-ID: <1328868316-24749-5-git-send-email-peter.ujfalusi@ti.com>
References: <1328868316-24749-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1328868316-24749-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

V1V8 supply from twl6030 commonly used as VIO for the machine.
V2V1 is adviced to supply the twl6040, and also to feed the twl6030's
VCXIO_IN, and VDAC_IN inputs.
Create the common regulator configurations for these regulators:
Make the V2V1 as supply_regulator for VCXIO, VDAC.
Add twl6040 (1-004b) as consumer for V1V8, and V2V1.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/twl-common.c |   43 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/twl-common.h |    2 +
 2 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index bc03154..cc9ede3 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -201,6 +201,7 @@ static struct regulator_init_data omap4_vdac_idata = {
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
+	.supply_regulator	= "V2V1",
 };
 
 static struct regulator_init_data omap4_vaux2_idata = {
@@ -291,6 +292,7 @@ static struct regulator_init_data omap4_vcxio_idata = {
 	},
 	.num_consumer_supplies	= ARRAY_SIZE(omap4_vcxio_supply),
 	.consumer_supplies	= omap4_vcxio_supply,
+	.supply_regulator	= "V2V1",
 };
 
 static struct regulator_init_data omap4_vusb_idata = {
@@ -311,6 +313,41 @@ static struct regulator_init_data omap4_clk32kg_idata = {
 	},
 };
 
+static struct regulator_consumer_supply omap4_v1v8_supply[] = {
+	REGULATOR_SUPPLY("vio", "1-004b"),
+};
+
+static struct regulator_init_data omap4_v1v8_idata = {
+	.constraints = {
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+		.always_on		= true,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(omap4_v1v8_supply),
+	.consumer_supplies	= omap4_v1v8_supply,
+};
+
+static struct regulator_consumer_supply omap4_v2v1_supply[] = {
+	REGULATOR_SUPPLY("v2v1", "1-004b"),
+};
+
+static struct regulator_init_data omap4_v2v1_idata = {
+	.constraints = {
+		.min_uV			= 2100000,
+		.max_uV			= 2100000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(omap4_v2v1_supply),
+	.consumer_supplies	= omap4_v2v1_supply,
+};
+
 void __init omap4_pmic_get_config(struct twl4030_platform_data *pmic_data,
 				  u32 pdata_flags, u32 regulators_flags)
 {
@@ -351,5 +388,11 @@ void __init omap4_pmic_get_config(struct twl4030_platform_data *pmic_data,
 	if (regulators_flags & TWL_COMMON_REGULATOR_CLK32KG &&
 	    !pmic_data->clk32kg)
 		pmic_data->clk32kg = &omap4_clk32kg_idata;
+
+	if (regulators_flags & TWL_COMMON_REGULATOR_V1V8 && !pmic_data->v1v8)
+		pmic_data->v1v8 = &omap4_v1v8_idata;
+
+	if (regulators_flags & TWL_COMMON_REGULATOR_V2V1 && !pmic_data->v2v1)
+		pmic_data->v2v1 = &omap4_v2v1_idata;
 }
 #endif /* CONFIG_ARCH_OMAP4 */
diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/twl-common.h
index 0962748..8fe71cf 100644
--- a/arch/arm/mach-omap2/twl-common.h
+++ b/arch/arm/mach-omap2/twl-common.h
@@ -22,6 +22,8 @@
 #define TWL_COMMON_REGULATOR_VCXIO	(1 << 8)
 #define TWL_COMMON_REGULATOR_VUSB	(1 << 9)
 #define TWL_COMMON_REGULATOR_CLK32KG	(1 << 10)
+#define TWL_COMMON_REGULATOR_V1V8	(1 << 11)
+#define TWL_COMMON_REGULATOR_V2V1	(1 << 12)
 
 /* TWL4030 LDO regulators */
 #define TWL_COMMON_REGULATOR_VPLL1	(1 << 4)
-- 
1.7.8.4

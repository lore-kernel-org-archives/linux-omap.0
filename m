From: Shweta Gulati <shweta.gulati@ti.com>
Subject: [PATCH V3] OMAP3+: SR Layer Cleanup
Date: Wed, 11 May 2011 14:42:46 +0530
Message-ID: <1305105166-26109-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Shweta Gulati <shweta.gulati@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

To set sr ntarget values  for all volt_domain,
volt_table is retrieved by doing a look_up of 'vdd_name'
field from omap_hwmod but voltage domain pointer does not
belong to omap_hwmod and is not used anywhere else.
As a part of voltage layer and SR Layer clean up volt
pointer is removed from omap_hwmod and added in dev
attributes of SR.

Tested on OMAP3630 SDP and OMAP4430 SDP Board

Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
Cc: Nishanth Menon <nm@ti.com>
---
V3:
   Changed the Subject and Rephrased Commit log as reviewed
   by Nishanth Menon.
 V2:
   Rebased on latest 'pm-wip/voltdm_a' branch.

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |   17 +++++++++++++----
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   19 ++++++++++++++++---
 arch/arm/mach-omap2/smartreflex.h            |   10 ++++++++++
 arch/arm/mach-omap2/sr_device.c              |   11 +++++++----
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 -
 5 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 3cd91ac..6a704bd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -29,6 +29,7 @@
 
 #include "omap_hwmod_common_data.h"
 
+#include "smartreflex.h"
 #include "prm-regbits-34xx.h"
 #include "cm-regbits-34xx.h"
 #include "wd_timer.h"
@@ -2904,6 +2905,10 @@ static struct omap_hwmod_class omap36xx_smartreflex_hwmod_class = {
 };
 
 /* SR1 */
+static struct omap_sr_dev_attr sr1_dev_attr = {
+	.voltdm_name   = "mpu_iva",
+};
+
 static struct omap_hwmod_ocp_if *omap3_sr1_slaves[] = {
 	&omap3_l4_core__sr1,
 };
@@ -2912,7 +2917,6 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
 	.name		= "sr1_hwmod",
 	.class		= &omap34xx_smartreflex_hwmod_class,
 	.main_clk	= "sr1_fck",
-	.vdd_name	= "mpu_iva",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -2924,6 +2928,7 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
 	},
 	.slaves		= omap3_sr1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
+	.dev_attr       = &sr1_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2 |
 					CHIP_IS_OMAP3430ES3_0 |
 					CHIP_IS_OMAP3430ES3_1),
@@ -2934,7 +2939,6 @@ static struct omap_hwmod omap36xx_sr1_hwmod = {
 	.name		= "sr1_hwmod",
 	.class		= &omap36xx_smartreflex_hwmod_class,
 	.main_clk	= "sr1_fck",
-	.vdd_name	= "mpu_iva",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -2946,10 +2950,15 @@ static struct omap_hwmod omap36xx_sr1_hwmod = {
 	},
 	.slaves		= omap3_sr1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
+	.dev_attr       = &sr1_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
 };
 
 /* SR2 */
+static struct omap_sr_dev_attr sr2_dev_attr = {
+	.voltdm_name    = "core",
+};
+
 static struct omap_hwmod_ocp_if *omap3_sr2_slaves[] = {
 	&omap3_l4_core__sr2,
 };
@@ -2958,7 +2967,6 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
 	.name		= "sr2_hwmod",
 	.class		= &omap34xx_smartreflex_hwmod_class,
 	.main_clk	= "sr2_fck",
-	.vdd_name	= "core",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -2970,6 +2978,7 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
 	},
 	.slaves		= omap3_sr2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
+	.dev_attr       = &sr2_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2 |
 					CHIP_IS_OMAP3430ES3_0 |
 					CHIP_IS_OMAP3430ES3_1),
@@ -2980,7 +2989,6 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
 	.name		= "sr2_hwmod",
 	.class		= &omap36xx_smartreflex_hwmod_class,
 	.main_clk	= "sr2_fck",
-	.vdd_name	= "core",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -2992,6 +3000,7 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
 	},
 	.slaves		= omap3_sr2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
+	.dev_attr       = &sr2_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 3e88dd3..1331b39 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -30,6 +30,7 @@
 
 #include "omap_hwmod_common_data.h"
 
+#include "smartreflex.h"
 #include "cm1_44xx.h"
 #include "cm2_44xx.h"
 #include "prm44xx.h"
@@ -3775,6 +3776,10 @@ static struct omap_hwmod_class omap44xx_smartreflex_hwmod_class = {
 };
 
 /* smartreflex_core */
+static struct omap_sr_dev_attr sr_core_dev_attr = {
+	.voltdm_name   = "core",
+};
+
 static struct omap_hwmod omap44xx_smartreflex_core_hwmod;
 static struct omap_hwmod_irq_info omap44xx_smartreflex_core_irqs[] = {
 	{ .irq = 19 + OMAP44XX_IRQ_GIC_START },
@@ -3809,7 +3814,6 @@ static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
 	.mpu_irqs	= omap44xx_smartreflex_core_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_smartreflex_core_irqs),
 	.main_clk	= "smartreflex_core_fck",
-	.vdd_name	= "core",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_ALWON_SR_CORE_CLKCTRL,
@@ -3817,10 +3821,15 @@ static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
 	},
 	.slaves		= omap44xx_smartreflex_core_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_core_slaves),
+	.dev_attr       = &sr_core_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* smartreflex_iva */
+static struct omap_sr_dev_attr sr_iva_dev_attr = {
+	.voltdm_name   = "iva",
+};
+
 static struct omap_hwmod omap44xx_smartreflex_iva_hwmod;
 static struct omap_hwmod_irq_info omap44xx_smartreflex_iva_irqs[] = {
 	{ .irq = 102 + OMAP44XX_IRQ_GIC_START },
@@ -3855,7 +3864,6 @@ static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
 	.mpu_irqs	= omap44xx_smartreflex_iva_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_smartreflex_iva_irqs),
 	.main_clk	= "smartreflex_iva_fck",
-	.vdd_name	= "iva",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_ALWON_SR_IVA_CLKCTRL,
@@ -3863,10 +3871,15 @@ static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
 	},
 	.slaves		= omap44xx_smartreflex_iva_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_iva_slaves),
+	.dev_attr       = &sr_iva_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 /* smartreflex_mpu */
+static struct omap_sr_dev_attr sr_mpu_dev_attr = {
+	.voltdm_name   = "mpu",
+};
+
 static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod;
 static struct omap_hwmod_irq_info omap44xx_smartreflex_mpu_irqs[] = {
 	{ .irq = 18 + OMAP44XX_IRQ_GIC_START },
@@ -3901,7 +3914,6 @@ static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
 	.mpu_irqs	= omap44xx_smartreflex_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_smartreflex_mpu_irqs),
 	.main_clk	= "smartreflex_mpu_fck",
-	.vdd_name	= "mpu",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_reg = OMAP4430_CM_ALWON_SR_MPU_CLKCTRL,
@@ -3909,6 +3921,7 @@ static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
 	},
 	.slaves		= omap44xx_smartreflex_mpu_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_mpu_slaves),
+	.dev_attr       = &sr_mpu_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 5f35b9e..9a7f770 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -197,6 +197,16 @@ struct omap_sr_nvalue_table {
 };
 
 /**
+ * struct omap_sr_dev_attr - Smartreflex Device attribute.
+ *
+ * @voltdm_name:       Name of voltdomain of SR instance
+ */
+
+struct omap_sr_dev_attr {
+	const char      *voltdm_name;
+};
+
+/**
  * struct omap_sr_data - Smartreflex platform data.
  *
  * @ip_type:		Smartreflex IP type.
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 2782d3f..65b2aae 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -82,6 +82,7 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 	struct omap_sr_data *sr_data;
 	struct omap_device *od;
 	struct omap_volt_data *volt_data;
+	struct omap_sr_dev_attr *sr_dev_attr;
 	char *name = "smartreflex";
 	static int i;
 
@@ -92,9 +93,11 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 		return -ENOMEM;
 	}
 
-	if (!oh->vdd_name) {
+	sr_dev_attr = (struct omap_sr_dev_attr *)oh->dev_attr;
+	if (!sr_dev_attr->voltdm_name) {
 		pr_err("%s: No voltage domain specified for %s."
-			"Cannot initialize\n", __func__, oh->name);
+				"Cannot initialize\n", __func__,
+					sr_dev_attr->voltdm_name);
 		goto exit;
 	}
 
@@ -102,10 +105,10 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 	sr_data->senn_mod = 0x1;
 	sr_data->senp_mod = 0x1;
 
-	sr_data->voltdm = voltdm_lookup(oh->vdd_name);
+	sr_data->voltdm = voltdm_lookup(sr_dev_attr->voltdm_name);
 	if (IS_ERR(sr_data->voltdm)) {
 		pr_err("%s: Unable to get voltage domain pointer for VDD %s\n",
-			__func__, oh->vdd_name);
+			__func__, sr_dev_attr->voltdm_name);
 		goto exit;
 	}
 
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index a5fa7c1..39d809a 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -519,7 +519,6 @@ struct omap_hwmod {
 	const char			*main_clk;
 	struct clk			*_clk;
 	struct omap_hwmod_opt_clk	*opt_clks;
-	char				*vdd_name;
 	struct omap_hwmod_ocp_if	**masters; /* connect to *_IA */
 	struct omap_hwmod_ocp_if	**slaves;  /* connect to *_TA */
 	void				*dev_attr;
-- 
1.7.0.4

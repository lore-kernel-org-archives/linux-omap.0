From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH] mfd: Constify regmap and irq configuration data
Date: Mon, 27 Apr 2015 21:54:13 +0900
Message-ID: <1430139253-4276-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Support Opensource <support.opensource@diasemi.com>, Milo Kim <milo.kim@ti.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@opensource.wolfsonmicro.com, linux-omap@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: linux-omap@vger.kernel.org

Constify in various drivers configuration data which is not modified:
 - regmap_irq_chip,
 - individual regmap_irq's in array,
 - regmap_config,
 - irq_domain_ops,

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/mfd/88pm860x-core.c       | 2 +-
 drivers/mfd/ab8500-core.c         | 2 +-
 drivers/mfd/arizona-irq.c         | 2 +-
 drivers/mfd/da9052-irq.c          | 4 ++--
 drivers/mfd/da9055-core.c         | 6 +++---
 drivers/mfd/da9063-irq.c          | 4 ++--
 drivers/mfd/da9150-core.c         | 4 ++--
 drivers/mfd/db8500-prcmu.c        | 2 +-
 drivers/mfd/intel_soc_pmic_core.h | 2 +-
 drivers/mfd/intel_soc_pmic_crc.c  | 2 +-
 drivers/mfd/lp8788-irq.c          | 2 +-
 drivers/mfd/max8925-core.c        | 2 +-
 drivers/mfd/max8997-irq.c         | 2 +-
 drivers/mfd/max8998-irq.c         | 2 +-
 drivers/mfd/mt6397-core.c         | 2 +-
 drivers/mfd/stmpe.c               | 2 +-
 drivers/mfd/tc3589x.c             | 2 +-
 drivers/mfd/tps6586x.c            | 2 +-
 drivers/mfd/twl6030-irq.c         | 2 +-
 drivers/mfd/wm831x-irq.c          | 2 +-
 drivers/mfd/wm8994-irq.c          | 6 +++---
 include/linux/mfd/da9055/core.h   | 2 +-
 22 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index d2a85cde68da..e03b7f45b8f7 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -566,7 +566,7 @@ static int pm860x_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	return 0;
 }
 
-static struct irq_domain_ops pm860x_irq_domain_ops = {
+static const struct irq_domain_ops pm860x_irq_domain_ops = {
 	.map	= pm860x_irq_domain_map,
 	.xlate	= irq_domain_xlate_onetwocell,
 };
diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index c80a2925f8e5..000da72a0ae9 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -574,7 +574,7 @@ static int ab8500_irq_map(struct irq_domain *d, unsigned int virq,
 	return 0;
 }
 
-static struct irq_domain_ops ab8500_irq_ops = {
+static const struct irq_domain_ops ab8500_irq_ops = {
 	.map    = ab8500_irq_map,
 	.xlate  = irq_domain_xlate_twocell,
 };
diff --git a/drivers/mfd/arizona-irq.c b/drivers/mfd/arizona-irq.c
index d063b94b94b5..2b9965d53e4e 100644
--- a/drivers/mfd/arizona-irq.c
+++ b/drivers/mfd/arizona-irq.c
@@ -186,7 +186,7 @@ static int arizona_irq_map(struct irq_domain *h, unsigned int virq,
 	return 0;
 }
 
-static struct irq_domain_ops arizona_domain_ops = {
+static const struct irq_domain_ops arizona_domain_ops = {
 	.map	= arizona_irq_map,
 	.xlate	= irq_domain_xlate_twocell,
 };
diff --git a/drivers/mfd/da9052-irq.c b/drivers/mfd/da9052-irq.c
index e65ca194fa98..f4cb4613140b 100644
--- a/drivers/mfd/da9052-irq.c
+++ b/drivers/mfd/da9052-irq.c
@@ -35,7 +35,7 @@
 #define DA9052_IRQ_MASK_POS_7		0x40
 #define DA9052_IRQ_MASK_POS_8		0x80
 
-static struct regmap_irq da9052_irqs[] = {
+static const struct regmap_irq da9052_irqs[] = {
 	[DA9052_IRQ_DCIN] = {
 		.reg_offset = 0,
 		.mask = DA9052_IRQ_MASK_POS_1,
@@ -166,7 +166,7 @@ static struct regmap_irq da9052_irqs[] = {
 	},
 };
 
-static struct regmap_irq_chip da9052_regmap_irq_chip = {
+static const struct regmap_irq_chip da9052_regmap_irq_chip = {
 	.name = "da9052_irq",
 	.status_base = DA9052_EVENT_A_REG,
 	.mask_base = DA9052_IRQ_MASK_A_REG,
diff --git a/drivers/mfd/da9055-core.c b/drivers/mfd/da9055-core.c
index b4d920c1ead1..177e65a12c12 100644
--- a/drivers/mfd/da9055-core.c
+++ b/drivers/mfd/da9055-core.c
@@ -222,7 +222,7 @@ static bool da9055_register_volatile(struct device *dev, unsigned int reg)
 	}
 }
 
-static struct regmap_irq da9055_irqs[] = {
+static const struct regmap_irq da9055_irqs[] = {
 	[DA9055_IRQ_NONKEY] = {
 		.reg_offset = 0,
 		.mask = DA9055_IRQ_NONKEY_MASK,
@@ -245,7 +245,7 @@ static struct regmap_irq da9055_irqs[] = {
 	},
 };
 
-struct regmap_config da9055_regmap_config = {
+const struct regmap_config da9055_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
@@ -367,7 +367,7 @@ static const struct mfd_cell da9055_devs[] = {
 	},
 };
 
-static struct regmap_irq_chip da9055_regmap_irq_chip = {
+static const struct regmap_irq_chip da9055_regmap_irq_chip = {
 	.name = "da9055_irq",
 	.status_base = DA9055_REG_EVENT_A,
 	.mask_base = DA9055_REG_IRQ_MASK_A,
diff --git a/drivers/mfd/da9063-irq.c b/drivers/mfd/da9063-irq.c
index 822922602ce9..eaf1ec9208b2 100644
--- a/drivers/mfd/da9063-irq.c
+++ b/drivers/mfd/da9063-irq.c
@@ -34,7 +34,7 @@ struct da9063_irq_data {
 	u8 mask;
 };
 
-static struct regmap_irq da9063_irqs[] = {
+static const struct regmap_irq da9063_irqs[] = {
 	/* DA9063 event A register */
 	[DA9063_IRQ_ONKEY] = {
 		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
@@ -153,7 +153,7 @@ static struct regmap_irq da9063_irqs[] = {
 	},
 };
 
-static struct regmap_irq_chip da9063_irq_chip = {
+static const struct regmap_irq_chip da9063_irq_chip = {
 	.name = "da9063-irq",
 	.irqs = da9063_irqs,
 	.num_irqs = DA9063_NUM_IRQ,
diff --git a/drivers/mfd/da9150-core.c b/drivers/mfd/da9150-core.c
index 5549817df32e..94b9bbd1a69b 100644
--- a/drivers/mfd/da9150-core.c
+++ b/drivers/mfd/da9150-core.c
@@ -164,7 +164,7 @@ void da9150_bulk_write(struct da9150 *da9150, u16 reg, int count, const u8 *buf)
 }
 EXPORT_SYMBOL_GPL(da9150_bulk_write);
 
-static struct regmap_irq da9150_irqs[] = {
+static const struct regmap_irq da9150_irqs[] = {
 	[DA9150_IRQ_VBUS] = {
 		.reg_offset = 0,
 		.mask = DA9150_E_VBUS_MASK,
@@ -251,7 +251,7 @@ static struct regmap_irq da9150_irqs[] = {
 	},
 };
 
-static struct regmap_irq_chip da9150_regmap_irq_chip = {
+static const struct regmap_irq_chip da9150_regmap_irq_chip = {
 	.name = "da9150_irq",
 	.status_base = DA9150_EVENT_E,
 	.mask_base = DA9150_IRQ_MASK_E,
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index cc1a404328c2..8b14740f9fca 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2659,7 +2659,7 @@ static int db8500_irq_map(struct irq_domain *d, unsigned int virq,
 	return 0;
 }
 
-static struct irq_domain_ops db8500_irq_ops = {
+static const struct irq_domain_ops db8500_irq_ops = {
 	.map    = db8500_irq_map,
 	.xlate  = irq_domain_xlate_twocell,
 };
diff --git a/drivers/mfd/intel_soc_pmic_core.h b/drivers/mfd/intel_soc_pmic_core.h
index 9498d6719847..ff2464bc172f 100644
--- a/drivers/mfd/intel_soc_pmic_core.h
+++ b/drivers/mfd/intel_soc_pmic_core.h
@@ -24,7 +24,7 @@ struct intel_soc_pmic_config {
 	struct mfd_cell *cell_dev;
 	int n_cell_devs;
 	const struct regmap_config *regmap_config;
-	struct regmap_irq_chip *irq_chip;
+	const struct regmap_irq_chip *irq_chip;
 };
 
 extern struct intel_soc_pmic_config intel_soc_pmic_config_crc;
diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index 4cc1b324e971..7436075e8983 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -143,7 +143,7 @@ static const struct regmap_irq crystal_cove_irqs[] = {
 	},
 };
 
-static struct regmap_irq_chip crystal_cove_irq_chip = {
+static const struct regmap_irq_chip crystal_cove_irq_chip = {
 	.name = "Crystal Cove",
 	.irqs = crystal_cove_irqs,
 	.num_irqs = ARRAY_SIZE(crystal_cove_irqs),
diff --git a/drivers/mfd/lp8788-irq.c b/drivers/mfd/lp8788-irq.c
index 23982dbf014d..a87f2b548f71 100644
--- a/drivers/mfd/lp8788-irq.c
+++ b/drivers/mfd/lp8788-irq.c
@@ -151,7 +151,7 @@ static int lp8788_irq_map(struct irq_domain *d, unsigned int virq,
 	return 0;
 }
 
-static struct irq_domain_ops lp8788_domain_ops = {
+static const struct irq_domain_ops lp8788_domain_ops = {
 	.map = lp8788_irq_map,
 };
 
diff --git a/drivers/mfd/max8925-core.c b/drivers/mfd/max8925-core.c
index 97a787ab3d51..8520bd68c1ff 100644
--- a/drivers/mfd/max8925-core.c
+++ b/drivers/mfd/max8925-core.c
@@ -658,7 +658,7 @@ static int max8925_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	return 0;
 }
 
-static struct irq_domain_ops max8925_irq_domain_ops = {
+static const struct irq_domain_ops max8925_irq_domain_ops = {
 	.map	= max8925_irq_domain_map,
 	.xlate	= irq_domain_xlate_onetwocell,
 };
diff --git a/drivers/mfd/max8997-irq.c b/drivers/mfd/max8997-irq.c
index 43fa61413e93..d3025be57f39 100644
--- a/drivers/mfd/max8997-irq.c
+++ b/drivers/mfd/max8997-irq.c
@@ -303,7 +303,7 @@ static int max8997_irq_domain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
-static struct irq_domain_ops max8997_irq_domain_ops = {
+static const struct irq_domain_ops max8997_irq_domain_ops = {
 	.map = max8997_irq_domain_map,
 };
 
diff --git a/drivers/mfd/max8998-irq.c b/drivers/mfd/max8998-irq.c
index c469477eb778..3702056628a8 100644
--- a/drivers/mfd/max8998-irq.c
+++ b/drivers/mfd/max8998-irq.c
@@ -214,7 +214,7 @@ static int max8998_irq_domain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
-static struct irq_domain_ops max8998_irq_domain_ops = {
+static const struct irq_domain_ops max8998_irq_domain_ops = {
 	.map = max8998_irq_domain_map,
 };
 
diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 09bc7804952a..32775ebbce18 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -130,7 +130,7 @@ static int mt6397_irq_domain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
-static struct irq_domain_ops mt6397_irq_domain_ops = {
+static const struct irq_domain_ops mt6397_irq_domain_ops = {
 	.map = mt6397_irq_domain_map,
 };
 
diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 2d7fae94c861..18c4d72d1d2a 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -989,7 +989,7 @@ static void stmpe_irq_unmap(struct irq_domain *d, unsigned int virq)
 		irq_set_chip_data(virq, NULL);
 }
 
-static struct irq_domain_ops stmpe_irq_ops = {
+static const struct irq_domain_ops stmpe_irq_ops = {
         .map    = stmpe_irq_map,
         .unmap  = stmpe_irq_unmap,
         .xlate  = irq_domain_xlate_twocell,
diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
index cf356395c9e9..96d420dfc15d 100644
--- a/drivers/mfd/tc3589x.c
+++ b/drivers/mfd/tc3589x.c
@@ -233,7 +233,7 @@ static void tc3589x_irq_unmap(struct irq_domain *d, unsigned int virq)
 	irq_set_chip_data(virq, NULL);
 }
 
-static struct irq_domain_ops tc3589x_irq_ops = {
+static const struct irq_domain_ops tc3589x_irq_ops = {
 	.map    = tc3589x_irq_map,
 	.unmap  = tc3589x_irq_unmap,
 	.xlate  = irq_domain_xlate_onecell,
diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index 8e1dbc469580..e0a2583916ce 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -311,7 +311,7 @@ static int tps6586x_irq_map(struct irq_domain *h, unsigned int virq,
 	return 0;
 }
 
-static struct irq_domain_ops tps6586x_domain_ops = {
+static const struct irq_domain_ops tps6586x_domain_ops = {
 	.map    = tps6586x_irq_map,
 	.xlate  = irq_domain_xlate_twocell,
 };
diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index 2807e1a95663..20fb58179ada 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -376,7 +376,7 @@ static void twl6030_irq_unmap(struct irq_domain *d, unsigned int virq)
 	irq_set_chip_data(virq, NULL);
 }
 
-static struct irq_domain_ops twl6030_irq_domain_ops = {
+static const struct irq_domain_ops twl6030_irq_domain_ops = {
 	.map	= twl6030_irq_map,
 	.unmap	= twl6030_irq_unmap,
 	.xlate	= irq_domain_xlate_onetwocell,
diff --git a/drivers/mfd/wm831x-irq.c b/drivers/mfd/wm831x-irq.c
index 64e512eadf17..3da81263c764 100644
--- a/drivers/mfd/wm831x-irq.c
+++ b/drivers/mfd/wm831x-irq.c
@@ -564,7 +564,7 @@ static int wm831x_irq_map(struct irq_domain *h, unsigned int virq,
 	return 0;
 }
 
-static struct irq_domain_ops wm831x_irq_domain_ops = {
+static const struct irq_domain_ops wm831x_irq_domain_ops = {
 	.map	= wm831x_irq_map,
 	.xlate	= irq_domain_xlate_twocell,
 };
diff --git a/drivers/mfd/wm8994-irq.c b/drivers/mfd/wm8994-irq.c
index a14407edbd89..55c380a67686 100644
--- a/drivers/mfd/wm8994-irq.c
+++ b/drivers/mfd/wm8994-irq.c
@@ -28,7 +28,7 @@
 
 #include <linux/delay.h>
 
-static struct regmap_irq wm8994_irqs[] = {
+static const struct regmap_irq wm8994_irqs[] = {
 	[WM8994_IRQ_TEMP_SHUT] = {
 		.reg_offset = 1,
 		.mask = WM8994_TEMP_SHUT_EINT,
@@ -128,7 +128,7 @@ static struct regmap_irq wm8994_irqs[] = {
 	},
 };
 
-static struct regmap_irq_chip wm8994_irq_chip = {
+static const struct regmap_irq_chip wm8994_irq_chip = {
 	.name = "wm8994",
 	.irqs = wm8994_irqs,
 	.num_irqs = ARRAY_SIZE(wm8994_irqs),
@@ -184,7 +184,7 @@ static int wm8994_edge_irq_map(struct irq_domain *h, unsigned int virq,
 	return 0;
 }
 
-static struct irq_domain_ops wm8994_edge_irq_ops = {
+static const struct irq_domain_ops wm8994_edge_irq_ops = {
 	.map	= wm8994_edge_irq_map,
 	.xlate	= irq_domain_xlate_twocell,
 };
diff --git a/include/linux/mfd/da9055/core.h b/include/linux/mfd/da9055/core.h
index 956afa445998..5dc743fd63a6 100644
--- a/include/linux/mfd/da9055/core.h
+++ b/include/linux/mfd/da9055/core.h
@@ -89,6 +89,6 @@ static inline int da9055_reg_update(struct da9055 *da9055, unsigned char reg,
 int da9055_device_init(struct da9055 *da9055);
 void da9055_device_exit(struct da9055 *da9055);
 
-extern struct regmap_config da9055_regmap_config;
+extern const struct regmap_config da9055_regmap_config;
 
 #endif /* __DA9055_CORE_H */
-- 
2.1.0

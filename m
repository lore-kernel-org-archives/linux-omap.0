From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 1/2] mfd: make regmap_irq_chip const
Date: Sat, 12 Aug 2017 11:39:08 +0530
Message-ID: <1502518149-11663-2-git-send-email-bhumirks@gmail.com>
References: <1502518149-11663-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502518149-11663-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, linus.walleij@linaro.org, marek.vasut+renesas@gmail.com, lee.jones@linaro.org, tony@atomide.com, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-omap@vger.kernel.org

Make these const as they are either passed to the function
devm_regmap_add_irq_chip or regmap_add_irq_chip having the corresponding
arguments as const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/mfd/bd9571mwv.c            | 2 +-
 drivers/mfd/intel_soc_pmic_bxtwc.c | 2 +-
 drivers/mfd/tps65086.c             | 2 +-
 drivers/mfd/tps65090.c             | 2 +-
 drivers/mfd/tps65218.c             | 2 +-
 drivers/mfd/tps65912-core.c        | 2 +-
 drivers/mfd/tps80031.c             | 2 +-
 drivers/mfd/twl6040.c              | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/bd9571mwv.c b/drivers/mfd/bd9571mwv.c
index 64e088d..6c1668c 100644
--- a/drivers/mfd/bd9571mwv.c
+++ b/drivers/mfd/bd9571mwv.c
@@ -96,7 +96,7 @@
 		       BD9571MWV_INT_INTREQ_BKUP_TRG_INT),
 };
 
-static struct regmap_irq_chip bd9571mwv_irq_chip = {
+static const struct regmap_irq_chip bd9571mwv_irq_chip = {
 	.name		= "bd9571mwv",
 	.status_base	= BD9571MWV_INT_INTREQ,
 	.mask_base	= BD9571MWV_INT_INTMASK,
diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 15bc052..7396d8a 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -138,7 +138,7 @@ enum bxtwc_irqs_crit {
 	REGMAP_IRQ_REG(BXTWC_CRIT_IRQ, 0, 0x03),
 };
 
-static struct regmap_irq_chip bxtwc_regmap_irq_chip = {
+static const struct regmap_irq_chip bxtwc_regmap_irq_chip = {
 	.name = "bxtwc_irq_chip",
 	.status_base = BXTWC_IRQLVL1,
 	.mask_base = BXTWC_MIRQLVL1,
diff --git a/drivers/mfd/tps65086.c b/drivers/mfd/tps65086.c
index 43119a6..24b5999 100644
--- a/drivers/mfd/tps65086.c
+++ b/drivers/mfd/tps65086.c
@@ -51,7 +51,7 @@
 	REGMAP_IRQ_REG(TPS65086_IRQ_FAULT, 0, TPS65086_IRQ_FAULT_MASK),
 };
 
-static struct regmap_irq_chip tps65086_irq_chip = {
+static const struct regmap_irq_chip tps65086_irq_chip = {
 	.name = "tps65086",
 	.status_base = TPS65086_IRQ,
 	.mask_base = TPS65086_IRQ_MASK,
diff --git a/drivers/mfd/tps65090.c b/drivers/mfd/tps65090.c
index d7ec318..48d93b2 100644
--- a/drivers/mfd/tps65090.c
+++ b/drivers/mfd/tps65090.c
@@ -130,7 +130,7 @@ enum tps65090_cells {
 	},
 };
 
-static struct regmap_irq_chip tps65090_irq_chip = {
+static const struct regmap_irq_chip tps65090_irq_chip = {
 	.name = "tps65090",
 	.irqs = tps65090_irqs,
 	.num_irqs = ARRAY_SIZE(tps65090_irqs),
diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index 13834a0..269f90ce 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -195,7 +195,7 @@ int tps65218_clear_bits(struct tps65218 *tps, unsigned int reg,
 	},
 };
 
-static struct regmap_irq_chip tps65218_irq_chip = {
+static const struct regmap_irq_chip tps65218_irq_chip = {
 	.name = "tps65218",
 	.irqs = tps65218_irqs,
 	.num_irqs = ARRAY_SIZE(tps65218_irqs),
diff --git a/drivers/mfd/tps65912-core.c b/drivers/mfd/tps65912-core.c
index f33567b..dbc71f0 100644
--- a/drivers/mfd/tps65912-core.c
+++ b/drivers/mfd/tps65912-core.c
@@ -65,7 +65,7 @@
 	REGMAP_IRQ_REG(TPS65912_IRQ_PGOOD_LDO10, 3, TPS65912_INT_STS4_PGOOD_LDO10),
 };
 
-static struct regmap_irq_chip tps65912_irq_chip = {
+static const struct regmap_irq_chip tps65912_irq_chip = {
 	.name = "tps65912",
 	.irqs = tps65912_irqs,
 	.num_irqs = ARRAY_SIZE(tps65912_irqs),
diff --git a/drivers/mfd/tps80031.c b/drivers/mfd/tps80031.c
index 0812df3..7ce4bc8 100644
--- a/drivers/mfd/tps80031.c
+++ b/drivers/mfd/tps80031.c
@@ -114,7 +114,7 @@ struct tps80031_pupd_data {
 	[TPS80031_INT_RES2]		= TPS80031_IRQ(C, 7),
 };
 
-static struct regmap_irq_chip tps80031_irq_chip = {
+static const struct regmap_irq_chip tps80031_irq_chip = {
 	.name = "tps80031",
 	.irqs = tps80031_main_irqs,
 	.num_irqs = ARRAY_SIZE(tps80031_main_irqs),
diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index d66502d..a1b6521 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -621,7 +621,7 @@ static bool twl6040_writeable_reg(struct device *dev, unsigned int reg)
 	{ .reg_offset = 0, .mask = TWL6040_READYINT, },
 };
 
-static struct regmap_irq_chip twl6040_irq_chip = {
+static const struct regmap_irq_chip twl6040_irq_chip = {
 	.name = "twl6040",
 	.irqs = twl6040_irqs,
 	.num_irqs = ARRAY_SIZE(twl6040_irqs),
-- 
1.9.1

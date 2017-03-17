From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] regmap: irq: Fix lost interrupts by introducing handle_reread
Date: Thu, 16 Mar 2017 17:36:30 -0700
Message-ID: <20170317003633.7361-2-tony@atomide.com>
References: <20170317003633.7361-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170317003633.7361-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

At least Motorola CPCAP PMIC needs it's device interrupts re-read
until there are no more interrupts. Otherwise the PMIC interrupt to
the SoC will eventually stop toggling.

Let's allow doing that by introducing a flag for handle_reread
and by splitting regmap_irq_thread() into two separate functions
for regmap_read_irq_status() and regmap_irq_handle_pending().

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Michael Scott <michael.scott@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/base/regmap/regmap-irq.c | 77 ++++++++++++++++++++++++++++------------
 include/linux/regmap.h           |  2 ++
 2 files changed, 56 insertions(+), 23 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -259,27 +259,11 @@ static const struct irq_chip regmap_irq_chip = {
 	.irq_set_wake		= regmap_irq_set_wake,
 };
 
-static irqreturn_t regmap_irq_thread(int irq, void *d)
+static int regmap_read_irq_status(struct regmap_irq_chip_data *data)
 {
-	struct regmap_irq_chip_data *data = d;
 	const struct regmap_irq_chip *chip = data->chip;
 	struct regmap *map = data->map;
 	int ret, i;
-	bool handled = false;
-	u32 reg;
-
-	if (chip->handle_pre_irq)
-		chip->handle_pre_irq(chip->irq_drv_data);
-
-	if (chip->runtime_pm) {
-		ret = pm_runtime_get_sync(map->dev);
-		if (ret < 0) {
-			dev_err(map->dev, "IRQ thread failed to resume: %d\n",
-				ret);
-			pm_runtime_put(map->dev);
-			goto exit;
-		}
-	}
 
 	/*
 	 * Read in the statuses, using a single bulk read if possible
@@ -299,7 +283,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 		if (ret != 0) {
 			dev_err(map->dev, "Failed to read IRQ status: %d\n",
 				ret);
-			goto exit;
+			return ret;
 		}
 
 		for (i = 0; i < data->chip->num_regs; i++) {
@@ -315,7 +299,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 				break;
 			default:
 				BUG();
-				goto exit;
+				return ret;
 			}
 		}
 
@@ -330,13 +314,21 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 				dev_err(map->dev,
 					"Failed to read IRQ status: %d\n",
 					ret);
-				if (chip->runtime_pm)
-					pm_runtime_put(map->dev);
-				goto exit;
+				return ret;
 			}
 		}
 	}
 
+	return 0;
+}
+
+static int regmap_irq_handle_pending(struct regmap_irq_chip_data *data)
+{
+	const struct regmap_irq_chip *chip = data->chip;
+	struct regmap *map = data->map;
+	int ret, i, handled = 0;
+	u32 reg;
+
 	/*
 	 * Ignore masked IRQs and ack if we need to; we ack early so
 	 * there is no race between handling and acknowleding the
@@ -361,10 +353,49 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 		if (data->status_buf[chip->irqs[i].reg_offset /
 				     map->reg_stride] & chip->irqs[i].mask) {
 			handle_nested_irq(irq_find_mapping(data->domain, i));
-			handled = true;
+			handled++;
 		}
 	}
 
+	return handled;
+}
+
+static irqreturn_t regmap_irq_thread(int irq, void *d)
+{
+	struct regmap_irq_chip_data *data = d;
+	const struct regmap_irq_chip *chip = data->chip;
+	struct regmap *map = data->map;
+	int ret, handled = 0;
+
+	if (chip->handle_pre_irq)
+		chip->handle_pre_irq(chip->irq_drv_data);
+
+	if (chip->runtime_pm) {
+		ret = pm_runtime_get_sync(map->dev);
+		if (ret < 0) {
+			dev_err(map->dev, "IRQ thread failed to resume: %d\n",
+				ret);
+			pm_runtime_put(map->dev);
+			goto exit;
+		}
+	}
+
+	do {
+		ret = regmap_read_irq_status(data);
+		if (ret)
+			goto out_runtime_put;
+
+		ret = regmap_irq_handle_pending(data);
+		if (ret < 0)
+			goto out_runtime_put;
+
+		if (!ret)
+			break;
+
+		handled += ret;
+	} while (chip->handle_reread);
+
+out_runtime_put:
 	if (chip->runtime_pm)
 		pm_runtime_put(map->dev);
 
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -897,6 +897,7 @@ struct regmap_irq {
  * @ack_invert:  Inverted ack register: cleared bits for ack.
  * @wake_invert: Inverted wake register: cleared bits are wake enabled.
  * @type_invert: Invert the type flags.
+ * @handle_reread: Read interrupt status until no more interrupts are seen.
  * @runtime_pm:  Hold a runtime PM lock on the device when accessing it.
  *
  * @num_regs:    Number of registers in each control bank.
@@ -934,6 +935,7 @@ struct regmap_irq_chip {
 	bool wake_invert:1;
 	bool runtime_pm:1;
 	bool type_invert:1;
+	bool handle_reread:1;
 
 	int num_regs;
 
-- 
2.11.1

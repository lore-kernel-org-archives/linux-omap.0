From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v7 1/5] mfd: tps65218: Remove redundant read wrapper
Date: Wed, 10 Aug 2016 18:22:21 +0530
Message-ID: <1470833545-29462-2-git-send-email-j-keerthy@ti.com>
References: <1470833545-29462-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1470833545-29462-1-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: broonie@kernel.org, lee.jones@linaro.org, tony@atomide.com
Cc: gnurou@gmail.com, d-gerlach@ti.com, devicetree@vger.kernel.org, j-keerthy@ti.com, linus.walleij@linaro.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux-gpio@vger.kernel.org, robh+dt@kernel.org, russ.dill@ti.com, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Currently read directly calls the repmap read function. Hence
remove the redundant wrapper and use regmap read wherever
needed.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpio/gpio-tps65218.c            |  3 ++-
 drivers/input/misc/tps65218-pwrbutton.c |  3 ++-
 drivers/mfd/tps65218.c                  | 18 ++----------------
 drivers/regulator/tps65218-regulator.c  |  5 +++--
 include/linux/mfd/tps65218.h            |  2 --
 5 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/gpio/gpio-tps65218.c b/drivers/gpio/gpio-tps65218.c
index 1c09a19..0961f3a 100644
--- a/drivers/gpio/gpio-tps65218.c
+++ b/drivers/gpio/gpio-tps65218.c
@@ -16,6 +16,7 @@
 #include <linux/errno.h>
 #include <linux/gpio/driver.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/mfd/tps65218.h>
 
 struct tps65218_gpio {
@@ -30,7 +31,7 @@ static int tps65218_gpio_get(struct gpio_chip *gc, unsigned offset)
 	unsigned int val;
 	int ret;
 
-	ret = tps65218_reg_read(tps65218, TPS65218_REG_ENABLE2, &val);
+	ret = regmap_read(tps65218->regmap, TPS65218_REG_ENABLE2, &val);
 	if (ret)
 		return ret;
 
diff --git a/drivers/input/misc/tps65218-pwrbutton.c b/drivers/input/misc/tps65218-pwrbutton.c
index a39b626..2bba8de 100644
--- a/drivers/input/misc/tps65218-pwrbutton.c
+++ b/drivers/input/misc/tps65218-pwrbutton.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
 struct tps65218_pwrbutton {
@@ -36,7 +37,7 @@ static irqreturn_t tps65218_pwr_irq(int irq, void *_pwr)
 	unsigned int reg;
 	int error;
 
-	error = tps65218_reg_read(pwr->tps, TPS65218_REG_STATUS, &reg);
+	error = regmap_read(pwr->tps->regmap, TPS65218_REG_STATUS, &reg);
 	if (error) {
 		dev_err(pwr->dev, "can't read register: %d\n", error);
 		goto out;
diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index ba610ad..9bca1b1 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -34,20 +34,6 @@
 #define TPS65218_PASSWORD_REGS_UNLOCK   0x7D
 
 /**
- * tps65218_reg_read: Read a single tps65218 register.
- *
- * @tps: Device to read from.
- * @reg: Register to read.
- * @val: Contians the value
- */
-int tps65218_reg_read(struct tps65218 *tps, unsigned int reg,
-			unsigned int *val)
-{
-	return regmap_read(tps->regmap, reg, val);
-}
-EXPORT_SYMBOL_GPL(tps65218_reg_read);
-
-/**
  * tps65218_reg_write: Write a single tps65218 register.
  *
  * @tps65218: Device to write to.
@@ -93,7 +79,7 @@ static int tps65218_update_bits(struct tps65218 *tps, unsigned int reg,
 	int ret;
 	unsigned int data;
 
-	ret = tps65218_reg_read(tps, reg, &data);
+	ret = regmap_read(tps->regmap, reg, &data);
 	if (ret) {
 		dev_err(tps->dev, "Read from reg 0x%x failed\n", reg);
 		return ret;
@@ -251,7 +237,7 @@ static int tps65218_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	ret = tps65218_reg_read(tps, TPS65218_REG_CHIPID, &chipid);
+	ret = regmap_read(tps->regmap, TPS65218_REG_CHIPID, &chipid);
 	if (ret) {
 		dev_err(tps->dev, "Failed to read chipid: %d\n", ret);
 		return ret;
diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index eb0f5b1..ae16caf 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -22,6 +22,7 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/of_device.h>
+#include <linux/regmap.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
@@ -272,7 +273,7 @@ static int tps65218_pmic_get_current_limit(struct regulator_dev *dev)
 	unsigned int index;
 	struct tps65218 *tps = rdev_get_drvdata(dev);
 
-	retval = tps65218_reg_read(tps, dev->desc->csel_reg, &index);
+	retval = regmap_read(tps->regmap, dev->desc->csel_reg, &index);
 	if (retval < 0)
 		return retval;
 
@@ -383,7 +384,7 @@ static int tps65218_regulator_probe(struct platform_device *pdev)
 		return PTR_ERR(rdev);
 	}
 
-	ret = tps65218_reg_read(tps, regulators[id].bypass_reg, &val);
+	ret = regmap_read(tps->regmap, regulators[id].bypass_reg, &val);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/mfd/tps65218.h b/include/linux/mfd/tps65218.h
index d1db952..51bef53 100644
--- a/include/linux/mfd/tps65218.h
+++ b/include/linux/mfd/tps65218.h
@@ -284,8 +284,6 @@ struct tps65218 {
 	struct regmap *regmap;
 };
 
-int tps65218_reg_read(struct tps65218 *tps, unsigned int reg,
-					unsigned int *val);
 int tps65218_reg_write(struct tps65218 *tps, unsigned int reg,
 			unsigned int val, unsigned int level);
 int tps65218_set_bits(struct tps65218 *tps, unsigned int reg,
-- 
1.9.1

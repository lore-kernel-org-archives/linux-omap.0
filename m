From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] memory: omap-gpmc: Move gpio functions out of #ifdef CONFIG_OF
Date: Fri, 17 Jun 2016 10:58:07 +0300
Message-ID: <1466150287-8158-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The gpio related functions were mistakenly built only if CONFIG_OF
is defined. They are needed even otherwise and will cause build
failures if CONFIG_OF is not defined. Move the gpio functions
outside #ifdef CONFIG_OF.

Fixes: d2d00862dfbb ("memory: omap-gpmc: Support general purpose input for WAITPINs")

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/memory/omap-gpmc.c | 126 ++++++++++++++++++++++-----------------------
 1 file changed, 63 insertions(+), 63 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 827832a..2182988 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2153,68 +2153,6 @@ err:
 	return ret;
 }
 
-static int gpmc_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
-{
-	return 1;	/* we're input only */
-}
-
-static int gpmc_gpio_direction_input(struct gpio_chip *chip,
-				     unsigned int offset)
-{
-	return 0;	/* we're input only */
-}
-
-static int gpmc_gpio_direction_output(struct gpio_chip *chip,
-				      unsigned int offset, int value)
-{
-	return -EINVAL;	/* we're input only */
-}
-
-static void gpmc_gpio_set(struct gpio_chip *chip, unsigned int offset,
-			  int value)
-{
-}
-
-static int gpmc_gpio_get(struct gpio_chip *chip, unsigned int offset)
-{
-	u32 reg;
-
-	offset += 8;
-
-	reg = gpmc_read_reg(GPMC_STATUS) & BIT(offset);
-
-	return !!reg;
-}
-
-static int gpmc_gpio_init(struct gpmc_device *gpmc)
-{
-	int ret;
-
-	gpmc->gpio_chip.parent = gpmc->dev;
-	gpmc->gpio_chip.owner = THIS_MODULE;
-	gpmc->gpio_chip.label = DEVICE_NAME;
-	gpmc->gpio_chip.ngpio = gpmc_nr_waitpins;
-	gpmc->gpio_chip.get_direction = gpmc_gpio_get_direction;
-	gpmc->gpio_chip.direction_input = gpmc_gpio_direction_input;
-	gpmc->gpio_chip.direction_output = gpmc_gpio_direction_output;
-	gpmc->gpio_chip.set = gpmc_gpio_set;
-	gpmc->gpio_chip.get = gpmc_gpio_get;
-	gpmc->gpio_chip.base = -1;
-
-	ret = gpiochip_add(&gpmc->gpio_chip);
-	if (ret < 0) {
-		dev_err(gpmc->dev, "could not register gpio chip: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-static void gpmc_gpio_exit(struct gpmc_device *gpmc)
-{
-	gpiochip_remove(&gpmc->gpio_chip);
-}
-
 static int gpmc_probe_dt(struct platform_device *pdev)
 {
 	int ret;
@@ -2279,7 +2217,69 @@ static int gpmc_probe_dt_children(struct platform_device *pdev)
 {
 	return 0;
 }
-#endif
+#endif /* CONFIG_OF */
+
+static int gpmc_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	return 1;	/* we're input only */
+}
+
+static int gpmc_gpio_direction_input(struct gpio_chip *chip,
+				     unsigned int offset)
+{
+	return 0;	/* we're input only */
+}
+
+static int gpmc_gpio_direction_output(struct gpio_chip *chip,
+				      unsigned int offset, int value)
+{
+	return -EINVAL;	/* we're input only */
+}
+
+static void gpmc_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			  int value)
+{
+}
+
+static int gpmc_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	u32 reg;
+
+	offset += 8;
+
+	reg = gpmc_read_reg(GPMC_STATUS) & BIT(offset);
+
+	return !!reg;
+}
+
+static int gpmc_gpio_init(struct gpmc_device *gpmc)
+{
+	int ret;
+
+	gpmc->gpio_chip.parent = gpmc->dev;
+	gpmc->gpio_chip.owner = THIS_MODULE;
+	gpmc->gpio_chip.label = DEVICE_NAME;
+	gpmc->gpio_chip.ngpio = gpmc_nr_waitpins;
+	gpmc->gpio_chip.get_direction = gpmc_gpio_get_direction;
+	gpmc->gpio_chip.direction_input = gpmc_gpio_direction_input;
+	gpmc->gpio_chip.direction_output = gpmc_gpio_direction_output;
+	gpmc->gpio_chip.set = gpmc_gpio_set;
+	gpmc->gpio_chip.get = gpmc_gpio_get;
+	gpmc->gpio_chip.base = -1;
+
+	ret = gpiochip_add(&gpmc->gpio_chip);
+	if (ret < 0) {
+		dev_err(gpmc->dev, "could not register gpio chip: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void gpmc_gpio_exit(struct gpmc_device *gpmc)
+{
+	gpiochip_remove(&gpmc->gpio_chip);
+}
 
 static int gpmc_probe(struct platform_device *pdev)
 {
-- 
2.7.4

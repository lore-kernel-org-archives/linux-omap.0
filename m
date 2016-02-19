From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 13/26] memory: omap-gpmc: Support general purpose input for WAITPINs
Date: Fri, 19 Feb 2016 23:15:35 +0200
Message-ID: <1455916548-3441-14-git-send-email-rogerq@ti.com>
References: <1455916548-3441-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455916548-3441-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, computersforpeace@gmail.com
Cc: dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

OMAPs can have 2 to 4 WAITPINs that can be used as general purpose
input if not used for memory wait state insertion.

The first user will be the OMAP NAND chip to get the NAND
read/busy status using gpiolib.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 .../bindings/memory-controllers/omap-gpmc.txt      |   3 +
 drivers/memory/Kconfig                             |   1 +
 drivers/memory/omap-gpmc.c                         | 115 ++++++++++++++++++---
 3 files changed, 107 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt b/Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt
index 704be93..8113a52 100644
--- a/Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt
@@ -32,6 +32,9 @@ Required properties:
 			bootloader) are used for the physical address decoding.
 			As this will change in the future, filling correct
 			values here is a requirement.
+ - gpio-controller:	The GPMC driver implements a GPIO controller for the
+			GPMC WAIT pins that can be used as general purpose inputs.
+			0 maps to GPMC_WAIT0 pin.
 
 Timing properties for child nodes. All are optional and default to 0.
 
diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 6f31546..bca24c6 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -51,6 +51,7 @@ config TI_EMIF
 
 config OMAP_GPMC
 	bool
+	select GPIOLIB
 	help
 	  This driver is for the General Purpose Memory Controller (GPMC)
 	  present on Texas Instruments SoCs (e.g. OMAP2+). GPMC allows
diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 6c8d85e..f67e5695 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -21,6 +21,7 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/platform_device.h>
@@ -237,6 +238,7 @@ struct gpmc_device {
 	struct device *dev;
 	int irq;
 	struct irq_chip irq_chip;
+	struct gpio_chip gpio_chip;
 };
 
 static struct irq_domain *gpmc_irq_domain;
@@ -2034,10 +2036,69 @@ err:
 	return ret;
 }
 
+static int gpmc_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
+{
+	return 1;	/* we're input only */
+}
+
+static int gpmc_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	return 0;	/* we're input only */
+}
+
+static int gpmc_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
+				      int value)
+{
+	return -EINVAL;	/* we're input only */
+}
+
+static void gpmc_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+}
+
+static int gpmc_gpio_get(struct gpio_chip *chip, unsigned offset)
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
+
 static int gpmc_probe_dt(struct platform_device *pdev)
 {
 	int ret;
-	struct device_node *child;
 	const struct of_device_id *of_id =
 		of_match_device(gpmc_dt_ids, &pdev->dev);
 
@@ -2065,6 +2126,14 @@ static int gpmc_probe_dt(struct platform_device *pdev)
 		return ret;
 	}
 
+	return 0;
+}
+
+static int gpmc_probe_dt_children(struct platform_device *pdev)
+{
+	int ret;
+	struct device_node *child;
+
 	for_each_available_child_of_node(pdev->dev.of_node, child) {
 
 		if (!child->name)
@@ -2074,6 +2143,9 @@ static int gpmc_probe_dt(struct platform_device *pdev)
 			ret = gpmc_probe_onenand_child(pdev, child);
 		else
 			ret = gpmc_probe_generic_child(pdev, child);
+
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -2083,6 +2155,11 @@ static int gpmc_probe_dt(struct platform_device *pdev)
 {
 	return 0;
 }
+
+static int gpmc_probe_dt_children(struct platform_device *pdev)
+{
+	return 0;
+}
 #endif
 
 static int gpmc_probe(struct platform_device *pdev)
@@ -2129,6 +2206,15 @@ static int gpmc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (pdev->dev.of_node) {
+		rc = gpmc_probe_dt(pdev);
+		if (rc)
+			return rc;
+	} else {
+		gpmc_cs_num = GPMC_CS_NUM;
+		gpmc_nr_waitpins = GPMC_NR_WAITPINS;
+	}
+
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
@@ -2154,29 +2240,33 @@ static int gpmc_probe(struct platform_device *pdev)
 		 GPMC_REVISION_MINOR(l));
 
 	gpmc_mem_init();
+	rc = gpmc_gpio_init(gpmc);
+	if (rc)
+		goto gpio_init_failed;
 
 	rc = gpmc_setup_irq(gpmc);
 	if (rc) {
 		dev_err(gpmc->dev, "gpmc_setup_irq failed\n");
-		goto fail;
+		goto setup_irq_failed;
 	}
 
-	if (!pdev->dev.of_node) {
-		gpmc_cs_num	 = GPMC_CS_NUM;
-		gpmc_nr_waitpins = GPMC_NR_WAITPINS;
-	}
-
-	rc = gpmc_probe_dt(pdev);
+	rc = gpmc_probe_dt_children(pdev);
 	if (rc < 0) {
-		dev_err(gpmc->dev, "failed to probe DT parameters\n");
-		gpmc_free_irq(gpmc);
-		goto fail;
+		dev_err(gpmc->dev, "failed to probe DT children\n");
+		goto dt_children_failed;
 	}
 
 	return 0;
 
-fail:
+dt_children_failed:
+	gpmc_free_irq(gpmc);
+setup_irq_failed:
+	gpmc_gpio_exit(gpmc);
+gpio_init_failed:
+	gpmc_mem_exit();
 	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
 	return rc;
 }
 
@@ -2185,6 +2275,7 @@ static int gpmc_remove(struct platform_device *pdev)
 	struct gpmc_device *gpmc = platform_get_drvdata(pdev);
 
 	gpmc_free_irq(gpmc);
+	gpmc_gpio_exit(gpmc);
 	gpmc_mem_exit();
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.1.4

From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 16/22] memory: omap-gpmc: Support general purpose input for
 WAITPINs
Date: Fri, 7 Aug 2015 12:12:26 +0300
Message-ID: <1438938752-31010-17-git-send-email-rogerq@ti.com>
References: <1438938752-31010-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1438938752-31010-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, computersforpeace@gmail.com, dwmw2@infradead.org, fcooper@ti.com, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

OMAPs can have 2 to 4 WAITPINs that can be used as general purpose
input if not used for memory wait state insertion.

The first user will be the OMAP NAND chip to get the NAND
read/busy status using gpiolib.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/memory/omap-gpmc.c | 122 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 117 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 30d9c21..264009d 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -21,6 +21,7 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
@@ -223,6 +224,11 @@ struct omap3_gpmc_regs {
 	struct gpmc_cs_config cs_context[GPMC_CS_NUM];
 };
 
+struct gpmc_device {
+	struct device *dev;
+	struct gpio_chip gpio_chip;
+};
+
 static struct resource	gpmc_mem_root;
 static struct gpmc_cs_data gpmc_cs[GPMC_CS_NUM];
 static DEFINE_SPINLOCK(gpmc_mem_lock);
@@ -1919,10 +1925,69 @@ err:
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
+	gpmc->gpio_chip.dev = gpmc->dev;
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
 
@@ -1950,6 +2015,17 @@ static int gpmc_probe_dt(struct platform_device *pdev)
 		return ret;
 	}
 
+	dev_info(&pdev->dev, "num-cs %d, num-wait %d\n",
+		 gpmc_cs_num, gpmc_nr_waitpins);
+
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
@@ -1959,6 +2035,9 @@ static int gpmc_probe_dt(struct platform_device *pdev)
 			ret = gpmc_probe_onenand_child(pdev, child);
 		else
 			ret = gpmc_probe_generic_child(pdev, child);
+
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -1968,6 +2047,11 @@ static int gpmc_probe_dt(struct platform_device *pdev)
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
@@ -1975,6 +2059,7 @@ static int gpmc_probe(struct platform_device *pdev)
 	int rc;
 	u32 l;
 	struct resource *res;
+	struct gpmc_device *gpmc;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL)
@@ -2005,6 +2090,17 @@ static int gpmc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	rc = gpmc_probe_dt(pdev);
+	if (rc)
+		return rc;
+
+	gpmc = devm_kzalloc(&pdev->dev, sizeof(*gpmc), GFP_KERNEL);
+	if (!gpmc)
+		return -ENOMEM;
+
+	gpmc->dev = &pdev->dev;
+	platform_set_drvdata(pdev, gpmc);
+
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
@@ -2032,24 +2128,40 @@ static int gpmc_probe(struct platform_device *pdev)
 		 GPMC_REVISION_MINOR(l));
 
 	gpmc_mem_init();
+	rc = gpmc_gpio_init(gpmc);
+	if (rc)
+		goto gpio_init_failed;
+
 
 	if (!pdev->dev.of_node) {
 		gpmc_cs_num	 = GPMC_CS_NUM;
 		gpmc_nr_waitpins = GPMC_NR_WAITPINS;
 	}
 
-	rc = gpmc_probe_dt(pdev);
+	rc = gpmc_probe_dt_children(pdev);
 	if (rc < 0) {
-		pm_runtime_put_sync(&pdev->dev);
-		dev_err(gpmc_dev, "failed to probe DT parameters\n");
-		return rc;
+		dev_err(gpmc_dev, "failed to probe DT children\n");
+		goto dt_children_failed;
 	}
 
 	return 0;
+
+dt_children_failed:
+	gpmc_gpio_exit(gpmc);
+gpio_init_failed:
+	gpmc_mem_exit();
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	gpmc_dev = NULL;
+
+	return rc;
 }
 
 static int gpmc_remove(struct platform_device *pdev)
 {
+	struct gpmc_device *gpmc = platform_get_drvdata(pdev);
+
+	gpmc_gpio_exit(gpmc);
 	gpmc_mem_exit();
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.1.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

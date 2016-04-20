From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 14/14] irqchip/gic: Add support for tegra AGIC interrupt controller
Date: Wed, 20 Apr 2016 12:03:57 +0100
Message-ID: <1461150237-15580-15-git-send-email-jonathanh@nvidia.com>
References: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-omap@vger.kernel.org

Add a driver for the Tegra-AGIC interrupt controller which is compatible
with the ARM GIC-400 interrupt controller.

The Tegra AGIC (Audio GIC) is part of the Audio Processing Engine (APE) on
Tegra210 and can route interrupts to either the GIC for the CPU subsystem
or the Audio DSP (ADSP) within the APE. The AGIC uses CPU interface 0 to
route interrupts to the CPU GIC and CPU interface 1 to route interrupts to
the ADSP.

The APE is located within its own power domain on the chip and so the
AGIC needs to manage both the power domain and its clocks. Commit
afbbd2338176 ("irqchip/gic: Document optional Clock and Power Domain
properties") has already added clock and power-domain properties to the
GIC binding and so we can make use of these for the AGIC.

With the AGIC being located in a different power domain to the main CPU
cluster this means that:
1. The interrupt controller cannot be registered via IRQCHIP_DECLARE()
   because it needs to be registered as a platform device so that the
   generic PM domain core will ensure that the power domain is available
   before probing.
2. The interrupt controller cannot be suspended/restored based upon
   changes in the CPU power state and needs to use runtime-pm instead.

The GIC platform driver has been implemented by making the following
changes to the core GIC driver:
1. Remove the dependency on CONFIG_CPU_PM from PM specific variables and
   functions so that they can be used by the platform driver even when
   CONFIG_CPU_PM is not selected.
2. Move the code that maps the GIC registers and parses the device-tree
   blob into a new function called gic_of_setup() that can be used by
   both the platform driver as well as the existing driver.
3. Add and register platform driver for the GIC. The platform driver
   uses the PM_CLK framework for managing the clocks used by the GIC
   and so select CONFIG_PM_CLK.

Finally, a couple other notes on the implementation are:
1. Currently the GIC platform driver only supports non-root GICs and
   assumes that the GIC has a parent interrupt. It is assumed that
   root interrupt controllers need to be initialised early.
2. There is no specific suspend handling for GICs registered as platform
   devices. Non-wakeup interrupts will be disabled by the kernel during
   late suspend, however, this alone will not power down the GIC if
   interrupts have been requested and not freed. Therefore, requestors
   of non-wakeup interrupts will need to free them on entering suspend
   in order to power-down the GIC.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---

Please note that so far I have not added all the clock names for the
various GIC versions (as described by the DT documentation). I thought
we could add these as they are needed.

 drivers/irqchip/Kconfig   |   1 +
 drivers/irqchip/irq-gic.c | 225 +++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 203 insertions(+), 23 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 3e124793e224..d3b05426eb38 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -7,6 +7,7 @@ config ARM_GIC
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	select MULTI_IRQ_HANDLER
+	select PM_CLK
 
 config ARM_GIC_MAX_NR
 	int
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 056c420d0960..1876097613c9 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -26,17 +26,22 @@
 #include <linux/module.h>
 #include <linux/list.h>
 #include <linux/smp.h>
+#include <linux/clk.h>
 #include <linux/cpu.h>
 #include <linux/cpu_pm.h>
 #include <linux/cpumask.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/acpi.h>
 #include <linux/irqdomain.h>
 #include <linux/interrupt.h>
 #include <linux/percpu.h>
+#include <linux/platform_device.h>
+#include <linux/pm_clock.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
@@ -68,11 +73,15 @@ union gic_base {
 	void __percpu * __iomem *percpu_base;
 };
 
+struct gic_clk_data {
+	unsigned int num_clocks;
+	const char *const *clocks;
+};
+
 struct gic_chip_data {
 	struct irq_chip chip;
 	union gic_base dist_base;
 	union gic_base cpu_base;
-#ifdef CONFIG_CPU_PM
 	u32 saved_spi_enable[DIV_ROUND_UP(1020, 32)];
 	u32 saved_spi_active[DIV_ROUND_UP(1020, 32)];
 	u32 saved_spi_conf[DIV_ROUND_UP(1020, 16)];
@@ -80,7 +89,6 @@ struct gic_chip_data {
 	u32 __percpu *saved_ppi_enable;
 	u32 __percpu *saved_ppi_active;
 	u32 __percpu *saved_ppi_conf;
-#endif
 	struct irq_domain *domain;
 	unsigned int gic_irqs;
 #ifdef CONFIG_GIC_NON_BANKED
@@ -510,7 +518,6 @@ int gic_cpu_if_down(unsigned int gic_nr)
 	return 0;
 }
 
-#ifdef CONFIG_CPU_PM
 /*
  * Saves the GIC distributor registers during suspend or idle.  Must be called
  * with interrupts disabled but before powering down the GIC.  After calling
@@ -726,11 +733,6 @@ static void gic_pm_init(struct gic_chip_data *gic)
 	if (gic == &gic_data[0])
 		cpu_pm_register_notifier(&gic_notifier_block);
 }
-#else
-static void gic_pm_init(struct gic_chip_data *gic)
-{
-}
-#endif
 
 #ifdef CONFIG_SMP
 static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
@@ -1225,27 +1227,42 @@ static bool gic_check_eoimode(struct device_node *node, void __iomem **base)
 	return true;
 }
 
-int __init
-gic_of_init(struct device_node *node, struct device_node *parent)
+static int gic_of_setup(struct device_node *node, void __iomem **dist_base,
+			void __iomem **cpu_base, u32 *percpu_offset)
 {
-	void __iomem *cpu_base;
-	void __iomem *dist_base;
-	u32 percpu_offset;
-	int irq, ret;
-
 	if (WARN_ON(!node))
 		return -ENODEV;
 
-	dist_base = of_iomap(node, 0);
-	if (WARN(!dist_base, "unable to map gic dist registers\n"))
+	*dist_base = of_iomap(node, 0);
+	if (WARN(!*dist_base, "unable to map gic dist registers\n"))
 		return -ENOMEM;
 
-	cpu_base = of_iomap(node, 1);
-	if (WARN(!cpu_base, "unable to map gic cpu registers\n")) {
-		iounmap(dist_base);
+	*cpu_base = of_iomap(node, 1);
+	if (WARN(!*cpu_base, "unable to map gic cpu registers\n")) {
+		iounmap(*dist_base);
 		return -ENOMEM;
 	}
 
+	if (of_property_read_u32(node, "cpu-offset", percpu_offset))
+		*percpu_offset = 0;
+
+	return 0;
+}
+
+int __init gic_of_init(struct device_node *node, struct device_node *parent)
+{
+	void __iomem *cpu_base;
+	void __iomem *dist_base;
+	u32 percpu_offset;
+	int irq, ret;
+
+	if (WARN_ON(gic_cnt >= CONFIG_ARM_GIC_MAX_NR))
+		return -EINVAL;
+
+	ret = gic_of_setup(node, &dist_base, &cpu_base, &percpu_offset);
+	if (ret)
+		return ret;
+
 	/*
 	 * Disable split EOI/Deactivate if either HYP is not available
 	 * or the CPU interface is too small.
@@ -1253,9 +1270,6 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 	if (gic_cnt == 0 && !gic_check_eoimode(node, &cpu_base))
 		static_key_slow_dec(&supports_deactivate);
 
-	if (of_property_read_u32(node, "cpu-offset", &percpu_offset))
-		percpu_offset = 0;
-
 	ret = __gic_init_bases(gic_cnt, -1, dist_base, cpu_base, percpu_offset,
 			 &node->fwnode);
 	if (ret) {
@@ -1288,6 +1302,171 @@ IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
 IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
 IRQCHIP_DECLARE(pl390, "arm,pl390", gic_of_init);
 
+static int gic_runtime_resume(struct device *dev)
+{
+	struct gic_chip_data *gic = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_clk_resume(dev);
+	if (ret)
+		return ret;
+
+	gic_dist_restore(gic);
+	gic_cpu_restore(gic);
+
+	return 0;
+}
+
+static int gic_runtime_suspend(struct device *dev)
+{
+	struct gic_chip_data *gic = dev_get_drvdata(dev);
+
+	gic_dist_save(gic);
+	gic_cpu_save(gic);
+
+	return pm_clk_suspend(dev);
+}
+
+static int gic_get_clocks(struct device *dev, const struct gic_clk_data *data)
+{
+	struct clk *clk;
+	unsigned int i;
+	int ret;
+
+	if (!dev || !data)
+		return -EINVAL;
+
+	ret = pm_clk_create(dev);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < data->num_clocks; i++) {
+		clk = of_clk_get_by_name(dev->of_node, data->clocks[i]);
+		if (IS_ERR(clk)) {
+			dev_err(dev, "failed to get clock %s\n",
+				data->clocks[i]);
+			ret = PTR_ERR(clk);
+			goto error;
+		}
+
+		ret = pm_clk_add_clk(dev, clk);
+		if (ret) {
+			dev_err(dev, "failed to add clock at index %d\n", i);
+			clk_put(clk);
+			goto error;
+		}
+	}
+
+	return 0;
+
+error:
+	pm_clk_destroy(dev);
+
+	return ret;
+}
+
+static int gic_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct gic_clk_data *data;
+	struct gic_chip_data *gic;
+	void __iomem *dist_base;
+	void __iomem *cpu_base;
+	u32 percpu_offset;
+	int ret, irq;
+
+	data = of_device_get_match_data(&pdev->dev);
+	if (!data) {
+		dev_err(&pdev->dev, "no device match found\n");
+		return -ENODEV;
+	}
+
+	gic = devm_kzalloc(dev, sizeof(*gic), GFP_KERNEL);
+	if (!gic)
+		return -ENOMEM;
+
+	ret = gic_get_clocks(dev, data);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, gic);
+
+	pm_runtime_enable(dev);
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		goto rpm_disable;
+
+	irq = irq_of_parse_and_map(dev->of_node, 0);
+	if (!irq) {
+		ret = -EINVAL;
+		goto rpm_put;
+	}
+
+	ret = gic_of_setup(dev->of_node, &dist_base, &cpu_base, &percpu_offset);
+	if (ret)
+		goto irq_dispose;
+
+	ret = gic_init_bases(gic, -1, dist_base, cpu_base,
+			     percpu_offset, &dev->of_node->fwnode,
+			     dev->of_node->name);
+	if (ret)
+		goto gic_unmap;
+
+	gic->chip.parent_device = dev;
+
+	irq_set_chained_handler_and_data(irq, gic_handle_cascade_irq, gic);
+
+	pm_runtime_put(dev);
+
+	dev_info(dev, "GIC IRQ controller registered\n");
+
+	return 0;
+
+gic_unmap:
+	iounmap(dist_base);
+	iounmap(cpu_base);
+irq_dispose:
+	irq_dispose_mapping(irq);
+rpm_put:
+	pm_runtime_put_sync(dev);
+rpm_disable:
+	pm_runtime_disable(dev);
+	pm_clk_destroy(dev);
+
+	return ret;
+}
+
+static const struct dev_pm_ops gic_pm_ops = {
+	SET_RUNTIME_PM_OPS(gic_runtime_suspend,
+			   gic_runtime_resume, NULL)
+};
+
+static const char * const tegra210_agic_clocks[] = {
+	"ape", "apb2ape",
+};
+
+static const struct gic_clk_data tegra210_agic_data = {
+	.num_clocks = ARRAY_SIZE(tegra210_agic_clocks),
+	.clocks = tegra210_agic_clocks,
+};
+
+static const struct of_device_id gic_match[] = {
+	{ .compatible = "nvidia,tegra210-agic", .data = &tegra210_agic_data },
+	{},
+};
+MODULE_DEVICE_TABLE(of, gic_match);
+
+static struct platform_driver gic_driver = {
+	.probe		= gic_probe,
+	.driver		= {
+		.name	= "gic",
+		.of_match_table	= gic_match,
+		.pm	= &gic_pm_ops,
+	}
+};
+
+builtin_platform_driver(gic_driver);
 #endif
 
 #ifdef CONFIG_ACPI
-- 
2.1.4

From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 17/17] irqchip/gic: Add platform driver for non-root GICs that require RPM
Date: Wed, 4 May 2016 17:25:30 +0100
Message-ID: <1462379130-11742-18-git-send-email-jonathanh@nvidia.com>
References: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-omap@vger.kernel.org

Add a platform driver to support non-root GICs that require runtime
power-management. Currently, only non-root GICs are supported because
the functions, smp_cross_call() and set_handle_irq(), that need to
be called for a root controller are located in the __init section and
so cannot be called by the platform driver.

The GIC platform driver re-uses many functions from the existing GIC
driver including some functions to save and restore the GIC context
during power transitions. The functions for saving and restoring the
GIC context are currently only defined if CONFIG_CPU_PM is enabled and
to ensure that these functions are always defined when the platform
driver is enabled, a dependency on CONFIG_ARM_GIC_PM (which selects the
platform driver) has been added.

There is no specific suspend handling for GICs registered as platform
devices. Non-wakeup interrupts will be disabled by the kernel during
late suspend, however, this alone will not power down the GIC if
interrupts have been requested and not freed. Therefore, requestors of
non-wakeup interrupts will need to free them on entering suspend in
order to power-down the GIC.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/irqchip/Kconfig      |   6 ++
 drivers/irqchip/Makefile     |   1 +
 drivers/irqchip/irq-gic-pm.c | 241 +++++++++++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-gic.c    |   2 +-
 drivers/irqchip/irq-gic.h    |   2 +-
 5 files changed, 250 insertions(+), 2 deletions(-)
 create mode 100644 drivers/irqchip/irq-gic-pm.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 1ab632a94db3..58d2cd197fff 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -8,6 +8,12 @@ config ARM_GIC
 	select IRQ_DOMAIN_HIERARCHY
 	select MULTI_IRQ_HANDLER
 
+config ARM_GIC_PM
+	bool
+	depends on PM
+	select ARM_GIC
+	select PM_CLK
+
 config ARM_GIC_MAX_NR
 	int
 	default 2 if ARCH_REALVIEW
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 9d54d53fe223..3803fdc9366d 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_ARCH_SUNXI)		+= irq-sun4i.o
 obj-$(CONFIG_ARCH_SUNXI)		+= irq-sunxi-nmi.o
 obj-$(CONFIG_ARCH_SPEAR3XX)		+= spear-shirq.o
 obj-$(CONFIG_ARM_GIC)			+= irq-gic.o irq-gic-common.o
+obj-$(CONFIG_ARM_GIC_PM)		+= irq-gic-pm.o
 obj-$(CONFIG_REALVIEW_DT)		+= irq-gic-realview.o
 obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-common.o
diff --git a/drivers/irqchip/irq-gic-pm.c b/drivers/irqchip/irq-gic-pm.c
new file mode 100644
index 000000000000..0a86da6c5afd
--- /dev/null
+++ b/drivers/irqchip/irq-gic-pm.c
@@ -0,0 +1,241 @@
+/*
+ * Copyright (C) 2016 NVIDIA CORPORATION, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/pm_clock.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+
+#include "irq-gic.h"
+
+struct gic_clk_data {
+	unsigned int num_clocks;
+	const char *const *clocks;
+};
+
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
+		dev_err(dev, "no parent interrupt found!\n");
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
+	gic_dist_init(gic);
+	gic_cpu_init(gic);
+	gic_pm_init(gic);
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
+static const char * const arm11mp_gic_clocks[] = {
+	"ic_clk",
+};
+
+static const struct gic_clk_data arm11mp_gic_data = {
+	.num_clocks = ARRAY_SIZE(arm11mp_gic_clocks),
+	.clocks = arm11mp_gic_clocks,
+};
+
+static const char * const cortexa15_gic_clocks[] = {
+	"PERIPHCLKEN",
+};
+
+static const struct gic_clk_data cortexa15_gic_data = {
+	.num_clocks = ARRAY_SIZE(cortexa15_gic_clocks),
+	.clocks = cortexa15_gic_clocks,
+};
+
+static const char * const cortexa9_gic_clocks[] = {
+	"PERIPHCLK", "PERIPHCLKEN",
+};
+
+static const struct gic_clk_data cortexa9_gic_data = {
+	.num_clocks = ARRAY_SIZE(cortexa9_gic_clocks),
+	.clocks = cortexa15_gic_clocks,
+};
+
+static const char * const gic400_clocks[] = {
+	"clk",
+};
+
+static const struct gic_clk_data gic400_data = {
+	.num_clocks = ARRAY_SIZE(gic400_clocks),
+	.clocks = gic400_clocks,
+};
+
+static const char * const pl390_clocks[] = {
+	"gclk",
+};
+
+static const struct gic_clk_data pl390_data = {
+	.num_clocks = ARRAY_SIZE(pl390_clocks),
+	.clocks = pl390_clocks,
+};
+
+static const struct of_device_id gic_match[] = {
+	{ .compatible = "arm,arm11mp-gic",	.data = &arm11mp_gic_data   },
+	{ .compatible = "arm,cortex-a15-gic",	.data = &cortexa15_gic_data },
+	{ .compatible = "arm,cortex-a9-gic",	.data = &cortexa9_gic_data  },
+	{ .compatible = "arm,gic-400",		.data = &gic400_data	    },
+	{ .compatible = "arm,pl390",		.data = &pl390_data	    },
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
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index bf9a256a1269..6059daf4f4c8 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -487,7 +487,7 @@ int gic_cpu_if_down(unsigned int gic_nr)
 	return 0;
 }
 
-#ifdef CONFIG_CPU_PM
+#if defined(CONFIG_CPU_PM) || defined(ARM_GIC_PM)
 /*
  * Saves the GIC distributor registers during suspend or idle.  Must be called
  * with interrupts disabled but before powering down the GIC.  After calling
diff --git a/drivers/irqchip/irq-gic.h b/drivers/irqchip/irq-gic.h
index 59198d5e7175..31e77338a798 100644
--- a/drivers/irqchip/irq-gic.h
+++ b/drivers/irqchip/irq-gic.h
@@ -26,7 +26,7 @@ struct gic_chip_data {
 	struct irq_chip chip;
 	union gic_base dist_base;
 	union gic_base cpu_base;
-#ifdef CONFIG_CPU_PM
+#if defined(CONFIG_CPU_PM) || defined(ARM_GIC_PM)
 	u32 saved_spi_enable[DIV_ROUND_UP(1020, 32)];
 	u32 saved_spi_active[DIV_ROUND_UP(1020, 32)];
 	u32 saved_spi_conf[DIV_ROUND_UP(1020, 16)];
-- 
2.1.4

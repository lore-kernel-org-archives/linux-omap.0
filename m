From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 11/14] irqchip/gic: Pass GIC pointer to save/restore functions
Date: Wed, 20 Apr 2016 12:03:54 +0100
Message-ID: <1461150237-15580-12-git-send-email-jonathanh@nvidia.com>
References: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-omap@vger.kernel.org

Instead of passing the GIC index to the save/restore functions pass a
pointer to the GIC chip data. This will allow these save/restore
functions to be re-used by a platform driver where the GIC chip data
structure is allocated dynamically and so there is no applicable index
for identifying the GIC.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c | 74 +++++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index d327cb5cbc65..8fe1e9cd9a36 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -517,34 +517,35 @@ int gic_cpu_if_down(unsigned int gic_nr)
  * this function, no interrupts will be delivered by the GIC, and another
  * platform-specific wakeup source must be enabled.
  */
-static void gic_dist_save(unsigned int gic_nr)
+static void gic_dist_save(struct gic_chip_data *gic)
 {
 	unsigned int gic_irqs;
 	void __iomem *dist_base;
 	int i;
 
-	BUG_ON(gic_nr >= CONFIG_ARM_GIC_MAX_NR);
+	if (WARN_ON(!gic))
+		return;
 
-	gic_irqs = gic_data[gic_nr].gic_irqs;
-	dist_base = gic_data_dist_base(&gic_data[gic_nr]);
+	gic_irqs = gic->gic_irqs;
+	dist_base = gic_data_dist_base(gic);
 
 	if (!dist_base)
 		return;
 
 	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 16); i++)
-		gic_data[gic_nr].saved_spi_conf[i] =
+		gic->saved_spi_conf[i] =
 			readl_relaxed(dist_base + GIC_DIST_CONFIG + i * 4);
 
 	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 4); i++)
-		gic_data[gic_nr].saved_spi_target[i] =
+		gic->saved_spi_target[i] =
 			readl_relaxed(dist_base + GIC_DIST_TARGET + i * 4);
 
 	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 32); i++)
-		gic_data[gic_nr].saved_spi_enable[i] =
+		gic->saved_spi_enable[i] =
 			readl_relaxed(dist_base + GIC_DIST_ENABLE_SET + i * 4);
 
 	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 32); i++)
-		gic_data[gic_nr].saved_spi_active[i] =
+		gic->saved_spi_active[i] =
 			readl_relaxed(dist_base + GIC_DIST_ACTIVE_SET + i * 4);
 }
 
@@ -555,16 +556,17 @@ static void gic_dist_save(unsigned int gic_nr)
  * handled normally, but any edge interrupts that occured will not be seen by
  * the GIC and need to be handled by the platform-specific wakeup source.
  */
-static void gic_dist_restore(unsigned int gic_nr)
+static void gic_dist_restore(struct gic_chip_data *gic)
 {
 	unsigned int gic_irqs;
 	unsigned int i;
 	void __iomem *dist_base;
 
-	BUG_ON(gic_nr >= CONFIG_ARM_GIC_MAX_NR);
+	if (WARN_ON(!gic))
+		return;
 
-	gic_irqs = gic_data[gic_nr].gic_irqs;
-	dist_base = gic_data_dist_base(&gic_data[gic_nr]);
+	gic_irqs = gic->gic_irqs;
+	dist_base = gic_data_dist_base(gic);
 
 	if (!dist_base)
 		return;
@@ -572,7 +574,7 @@ static void gic_dist_restore(unsigned int gic_nr)
 	writel_relaxed(GICD_DISABLE, dist_base + GIC_DIST_CTRL);
 
 	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 16); i++)
-		writel_relaxed(gic_data[gic_nr].saved_spi_conf[i],
+		writel_relaxed(gic->saved_spi_conf[i],
 			dist_base + GIC_DIST_CONFIG + i * 4);
 
 	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 4); i++)
@@ -580,85 +582,87 @@ static void gic_dist_restore(unsigned int gic_nr)
 			dist_base + GIC_DIST_PRI + i * 4);
 
 	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 4); i++)
-		writel_relaxed(gic_data[gic_nr].saved_spi_target[i],
+		writel_relaxed(gic->saved_spi_target[i],
 			dist_base + GIC_DIST_TARGET + i * 4);
 
 	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 32); i++) {
 		writel_relaxed(GICD_INT_EN_CLR_X32,
 			dist_base + GIC_DIST_ENABLE_CLEAR + i * 4);
-		writel_relaxed(gic_data[gic_nr].saved_spi_enable[i],
+		writel_relaxed(gic->saved_spi_enable[i],
 			dist_base + GIC_DIST_ENABLE_SET + i * 4);
 	}
 
 	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 32); i++) {
 		writel_relaxed(GICD_INT_EN_CLR_X32,
 			dist_base + GIC_DIST_ACTIVE_CLEAR + i * 4);
-		writel_relaxed(gic_data[gic_nr].saved_spi_active[i],
+		writel_relaxed(gic->saved_spi_active[i],
 			dist_base + GIC_DIST_ACTIVE_SET + i * 4);
 	}
 
 	writel_relaxed(GICD_ENABLE, dist_base + GIC_DIST_CTRL);
 }
 
-static void gic_cpu_save(unsigned int gic_nr)
+static void gic_cpu_save(struct gic_chip_data *gic)
 {
 	int i;
 	u32 *ptr;
 	void __iomem *dist_base;
 	void __iomem *cpu_base;
 
-	BUG_ON(gic_nr >= CONFIG_ARM_GIC_MAX_NR);
+	if (WARN_ON(!gic))
+		return;
 
-	dist_base = gic_data_dist_base(&gic_data[gic_nr]);
-	cpu_base = gic_data_cpu_base(&gic_data[gic_nr]);
+	dist_base = gic_data_dist_base(gic);
+	cpu_base = gic_data_cpu_base(gic);
 
 	if (!dist_base || !cpu_base)
 		return;
 
-	ptr = raw_cpu_ptr(gic_data[gic_nr].saved_ppi_enable);
+	ptr = raw_cpu_ptr(gic->saved_ppi_enable);
 	for (i = 0; i < DIV_ROUND_UP(32, 32); i++)
 		ptr[i] = readl_relaxed(dist_base + GIC_DIST_ENABLE_SET + i * 4);
 
-	ptr = raw_cpu_ptr(gic_data[gic_nr].saved_ppi_active);
+	ptr = raw_cpu_ptr(gic->saved_ppi_active);
 	for (i = 0; i < DIV_ROUND_UP(32, 32); i++)
 		ptr[i] = readl_relaxed(dist_base + GIC_DIST_ACTIVE_SET + i * 4);
 
-	ptr = raw_cpu_ptr(gic_data[gic_nr].saved_ppi_conf);
+	ptr = raw_cpu_ptr(gic->saved_ppi_conf);
 	for (i = 0; i < DIV_ROUND_UP(32, 16); i++)
 		ptr[i] = readl_relaxed(dist_base + GIC_DIST_CONFIG + i * 4);
 
 }
 
-static void gic_cpu_restore(unsigned int gic_nr)
+static void gic_cpu_restore(struct gic_chip_data *gic)
 {
 	int i;
 	u32 *ptr;
 	void __iomem *dist_base;
 	void __iomem *cpu_base;
 
-	BUG_ON(gic_nr >= CONFIG_ARM_GIC_MAX_NR);
+	if (WARN_ON(!gic))
+		return;
 
-	dist_base = gic_data_dist_base(&gic_data[gic_nr]);
-	cpu_base = gic_data_cpu_base(&gic_data[gic_nr]);
+	dist_base = gic_data_dist_base(gic);
+	cpu_base = gic_data_cpu_base(gic);
 
 	if (!dist_base || !cpu_base)
 		return;
 
-	ptr = raw_cpu_ptr(gic_data[gic_nr].saved_ppi_enable);
+	ptr = raw_cpu_ptr(gic->saved_ppi_enable);
 	for (i = 0; i < DIV_ROUND_UP(32, 32); i++) {
 		writel_relaxed(GICD_INT_EN_CLR_X32,
 			       dist_base + GIC_DIST_ENABLE_CLEAR + i * 4);
 		writel_relaxed(ptr[i], dist_base + GIC_DIST_ENABLE_SET + i * 4);
 	}
 
-	ptr = raw_cpu_ptr(gic_data[gic_nr].saved_ppi_active);
+	ptr = raw_cpu_ptr(gic->saved_ppi_active);
 	for (i = 0; i < DIV_ROUND_UP(32, 32); i++) {
 		writel_relaxed(GICD_INT_EN_CLR_X32,
 			       dist_base + GIC_DIST_ACTIVE_CLEAR + i * 4);
 		writel_relaxed(ptr[i], dist_base + GIC_DIST_ACTIVE_SET + i * 4);
 	}
 
-	ptr = raw_cpu_ptr(gic_data[gic_nr].saved_ppi_conf);
+	ptr = raw_cpu_ptr(gic->saved_ppi_conf);
 	for (i = 0; i < DIV_ROUND_UP(32, 16); i++)
 		writel_relaxed(ptr[i], dist_base + GIC_DIST_CONFIG + i * 4);
 
@@ -667,7 +671,7 @@ static void gic_cpu_restore(unsigned int gic_nr)
 					dist_base + GIC_DIST_PRI + i * 4);
 
 	writel_relaxed(GICC_INT_PRI_THRESHOLD, cpu_base + GIC_CPU_PRIMASK);
-	gic_cpu_if_up(&gic_data[gic_nr]);
+	gic_cpu_if_up(gic);
 }
 
 static int gic_notifier(struct notifier_block *self, unsigned long cmd,	void *v)
@@ -682,18 +686,18 @@ static int gic_notifier(struct notifier_block *self, unsigned long cmd,	void *v)
 #endif
 		switch (cmd) {
 		case CPU_PM_ENTER:
-			gic_cpu_save(i);
+			gic_cpu_save(&gic_data[i]);
 			break;
 		case CPU_PM_ENTER_FAILED:
 		case CPU_PM_EXIT:
-			gic_cpu_restore(i);
+			gic_cpu_restore(&gic_data[i]);
 			break;
 		case CPU_CLUSTER_PM_ENTER:
-			gic_dist_save(i);
+			gic_dist_save(&gic_data[i]);
 			break;
 		case CPU_CLUSTER_PM_ENTER_FAILED:
 		case CPU_CLUSTER_PM_EXIT:
-			gic_dist_restore(i);
+			gic_dist_restore(&gic_data[i]);
 			break;
 		}
 	}
-- 
2.1.4

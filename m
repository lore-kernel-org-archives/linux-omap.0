From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 10/14] irqchip/gic: Return an error if GIC initialisation fails
Date: Wed, 20 Apr 2016 12:03:53 +0100
Message-ID: <1461150237-15580-11-git-send-email-jonathanh@nvidia.com>
References: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-omap@vger.kernel.org

If the GIC initialisation fails, then currently we do not return an error
or clean-up afterwards. Although for root controllers, this failure may be
fatal anyway, for secondary controllers, it may not be fatal and so return
an error on failure and clean-up.

For non-banked GIC controllers, make sure that we free any memory
allocated if we fail to initialise the IRQ domain. Please note that
free_percpu() only frees memory if the pointer passed to it is not NULL
and so it is unnecessary to check if both pointers are valid or not.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/irqchip/irq-gic.c | 59 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index f1b51317267f..d327cb5cbc65 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -997,13 +997,13 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 	.unmap = gic_irq_domain_unmap,
 };
 
-static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
+static int __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 			   void __iomem *dist_base, void __iomem *cpu_base,
 			   u32 percpu_offset, struct fwnode_handle *handle)
 {
 	irq_hw_number_t hwirq_base;
 	struct gic_chip_data *gic;
-	int gic_irqs, irq_base, i;
+	int gic_irqs, irq_base, i, ret;
 
 	BUG_ON(gic_nr >= CONFIG_ARM_GIC_MAX_NR);
 
@@ -1018,7 +1018,7 @@ static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 		gic->chip.irq_mask = gic_eoimode1_mask_irq;
 		gic->chip.irq_eoi = gic_eoimode1_eoi_irq;
 		gic->chip.irq_set_vcpu_affinity = gic_irq_set_vcpu_affinity;
-		gic->chip.name = "GICv2";
+		gic->chip.name = kasprintf(GFP_KERNEL, "GICv2");
 	} else {
 		gic->chip.name = kasprintf(GFP_KERNEL, "GIC-%d", gic_nr);
 	}
@@ -1028,17 +1028,16 @@ static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 		gic->chip.irq_set_affinity = gic_set_affinity;
 #endif
 
-#ifdef CONFIG_GIC_NON_BANKED
-	if (percpu_offset) { /* Frankein-GIC without banked registers... */
+	if (IS_ENABLED(CONFIG_GIC_NON_BANKED) && percpu_offset) {
+		/* Frankein-GIC without banked registers... */
 		unsigned int cpu;
 
 		gic->dist_base.percpu_base = alloc_percpu(void __iomem *);
 		gic->cpu_base.percpu_base = alloc_percpu(void __iomem *);
 		if (WARN_ON(!gic->dist_base.percpu_base ||
 			    !gic->cpu_base.percpu_base)) {
-			free_percpu(gic->dist_base.percpu_base);
-			free_percpu(gic->cpu_base.percpu_base);
-			return;
+			ret = -ENOMEM;
+			goto error;
 		}
 
 		for_each_possible_cpu(cpu) {
@@ -1050,9 +1049,8 @@ static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 		}
 
 		gic_set_base_accessor(gic, gic_get_percpu_base);
-	} else
-#endif
-	{			/* Normal, sane GIC... */
+	} else {
+		/* Normal, sane GIC... */
 		WARN(percpu_offset,
 		     "GIC_NON_BANKED not enabled, ignoring %08x offset!",
 		     percpu_offset);
@@ -1102,8 +1100,10 @@ static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 					hwirq_base, &gic_irq_domain_ops, gic);
 	}
 
-	if (WARN_ON(!gic->domain))
-		return;
+	if (WARN_ON(!gic->domain)) {
+		ret = -ENODEV;
+		goto error;
+	}
 
 	if (gic_nr == 0) {
 		/*
@@ -1125,6 +1125,18 @@ static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 	gic_dist_init(gic);
 	gic_cpu_init(gic);
 	gic_pm_init(gic);
+
+	return 0;
+
+error:
+	if (IS_ENABLED(CONFIG_GIC_NON_BANKED) && percpu_offset) {
+		free_percpu(gic->dist_base.percpu_base);
+		free_percpu(gic->cpu_base.percpu_base);
+	}
+
+	kfree(gic->chip.name);
+
+	return ret;
 }
 
 void __init gic_init(unsigned int gic_nr, int irq_start,
@@ -1185,7 +1197,7 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 	void __iomem *cpu_base;
 	void __iomem *dist_base;
 	u32 percpu_offset;
-	int irq;
+	int irq, ret;
 
 	if (WARN_ON(!node))
 		return -ENODEV;
@@ -1210,8 +1222,14 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 	if (of_property_read_u32(node, "cpu-offset", &percpu_offset))
 		percpu_offset = 0;
 
-	__gic_init_bases(gic_cnt, -1, dist_base, cpu_base, percpu_offset,
+	ret = __gic_init_bases(gic_cnt, -1, dist_base, cpu_base, percpu_offset,
 			 &node->fwnode);
+	if (ret) {
+		iounmap(dist_base);
+		iounmap(cpu_base);
+		return ret;
+	}
+
 	if (!gic_cnt)
 		gic_init_physaddr(node);
 
@@ -1300,7 +1318,7 @@ static int __init gic_v2_acpi_init(struct acpi_subtable_header *header,
 	struct acpi_madt_generic_distributor *dist;
 	void __iomem *cpu_base, *dist_base;
 	struct fwnode_handle *domain_handle;
-	int count;
+	int count, ret;
 
 	/* Collect CPU base addresses */
 	count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT,
@@ -1343,7 +1361,14 @@ static int __init gic_v2_acpi_init(struct acpi_subtable_header *header,
 		return -ENOMEM;
 	}
 
-	__gic_init_bases(0, -1, dist_base, cpu_base, 0, domain_handle);
+	ret = __gic_init_bases(0, -1, dist_base, cpu_base, 0, domain_handle);
+	if (ret) {
+		pr_err("Failed to initialise GIC\n");
+		irq_domain_free_fwnode(domain_handle);
+		iounmap(cpu_base);
+		iounmap(dist_base);
+		return ret;
+	}
 
 	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, domain_handle);
 
-- 
2.1.4

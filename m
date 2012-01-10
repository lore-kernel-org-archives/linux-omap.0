From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: [PATCH v2] irqdomain: Initialize number of IRQs for simple domains
Date: Tue, 10 Jan 2012 11:24:11 +0100
Message-ID: <1326191059-26411-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Daniel Walker <dwalker-zu3NM2574RrQT0dZR+AlfA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "open list:ARM/QUALCOMM MSM..." <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "open list:OMAP SUPPORT" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Victor <linux-PelNFVqkFnVyf+4FbqDuWQ@public.gmane.org>, "open list:ARM/ATMEL AT91RM9..." <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bryan Huntsman <bryanh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The irq_domain_add() function needs the number of interrupts in the
domain to properly initialize them. In addition the allocated domain
is now returned by the irq_domain_{add,generate}_simple() helpers.

Signed-off-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Acked-by: David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
Note: This patch should not be applied yet. There is a conflict with a
      pending patch[0] by Benoit Cousson that will obsolete the OMAP2
      hunk in this patch.

      [0]: http://www.spinics.net/lists/linux-omap/msg62124.html

Changes in v2:
 - Don't use ERR_PTR, keep the WARN_ON(1) and return NULL as requested
   by Grant Likely.
 - Integrate i.MX cleanup patch by Shawn Guo.

 arch/arm/mach-at91/board-dt.c         |    2 +-
 arch/arm/mach-imx/imx51-dt.c          |   13 +++++++++++--
 arch/arm/mach-imx/imx53-dt.c          |   13 +++++++++++--
 arch/arm/mach-imx/mach-imx6q.c        |    6 +++++-
 arch/arm/mach-msm/board-msm8x60.c     |    2 +-
 arch/arm/mach-omap2/board-generic.c   |    2 +-
 arch/arm/mach-prima2/irq.c            |    2 +-
 arch/arm/mach-versatile/core.c        |    6 ++++--
 arch/arm/plat-mxc/include/mach/irqs.h |   13 +++++++------
 arch/arm/plat-mxc/tzic.c              |    2 --
 include/linux/irqdomain.h             |   27 ++++++++++++++++++++++-----
 kernel/irq/irqdomain.c                |   26 ++++++++++++++++++--------
 12 files changed, 82 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-at91/board-dt.c b/arch/arm/mach-at91/board-dt.c
index bb6b434..40e5b6c 100644
--- a/arch/arm/mach-at91/board-dt.c
+++ b/arch/arm/mach-at91/board-dt.c
@@ -95,7 +95,7 @@ static const struct of_device_id aic_of_match[] __initconst = {
 
 static void __init at91_dt_init_irq(void)
 {
-	irq_domain_generate_simple(aic_of_match, 0xfffff000, 0);
+	irq_domain_generate_simple(aic_of_match, 0xfffff000, 0, NR_AIC_IRQS);
 	at91_init_irq_default();
 }
 
diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/imx51-dt.c
index e6bad17..811ce88 100644
--- a/arch/arm/mach-imx/imx51-dt.c
+++ b/arch/arm/mach-imx/imx51-dt.c
@@ -47,7 +47,12 @@ static const struct of_dev_auxdata imx51_auxdata_lookup[] __initconst = {
 static int __init imx51_tzic_add_irq_domain(struct device_node *np,
 				struct device_node *interrupt_parent)
 {
-	irq_domain_add_simple(np, 0);
+	struct irq_domain *domain;
+
+	domain = irq_domain_add_simple(np, 0, TZIC_NUM_IRQS);
+	if (!domain)
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -55,9 +60,13 @@ static int __init imx51_gpio_add_irq_domain(struct device_node *np,
 				struct device_node *interrupt_parent)
 {
 	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
+	struct irq_domain *domain;
 
 	gpio_irq_base -= 32;
-	irq_domain_add_simple(np, gpio_irq_base);
+
+	domain = irq_domain_add_simple(np, gpio_irq_base, 32);
+	if (!domain)
+		return -ENOMEM;
 
 	return 0;
 }
diff --git a/arch/arm/mach-imx/imx53-dt.c b/arch/arm/mach-imx/imx53-dt.c
index 05ebb3e..458ec03 100644
--- a/arch/arm/mach-imx/imx53-dt.c
+++ b/arch/arm/mach-imx/imx53-dt.c
@@ -51,7 +51,12 @@ static const struct of_dev_auxdata imx53_auxdata_lookup[] __initconst = {
 static int __init imx53_tzic_add_irq_domain(struct device_node *np,
 				struct device_node *interrupt_parent)
 {
-	irq_domain_add_simple(np, 0);
+	struct irq_domain *domain;
+
+	domain = irq_domain_add_simple(np, 0, TZIC_NUM_IRQS);
+	if (!domain)
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -59,9 +64,13 @@ static int __init imx53_gpio_add_irq_domain(struct device_node *np,
 				struct device_node *interrupt_parent)
 {
 	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
+	struct irq_domain *domain;
 
 	gpio_irq_base -= 32;
-	irq_domain_add_simple(np, gpio_irq_base);
+
+	domain = irq_domain_add_simple(np, gpio_irq_base, 32);
+	if (!domain)
+		return -ENOMEM;
 
 	return 0;
 }
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index c257281..4955920 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -95,9 +95,13 @@ static int __init imx6q_gpio_add_irq_domain(struct device_node *np,
 				struct device_node *interrupt_parent)
 {
 	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
+	struct irq_domain *domain;
 
 	gpio_irq_base -= 32;
-	irq_domain_add_simple(np, gpio_irq_base);
+
+	domain = irq_domain_add_simple(np, gpio_irq_base, 32);
+	if (!domain)
+		return -ENOMEM;
 
 	return 0;
 }
diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
index 0a11342..4d26707 100644
--- a/arch/arm/mach-msm/board-msm8x60.c
+++ b/arch/arm/mach-msm/board-msm8x60.c
@@ -85,7 +85,7 @@ static void __init msm8x60_dt_init(void)
 	node = of_find_matching_node_by_address(NULL, msm_dt_gic_match,
 			MSM8X60_QGIC_DIST_PHYS);
 	if (node)
-		irq_domain_add_simple(node, GIC_SPI_START);
+		irq_domain_add_simple(node, GIC_SPI_START, NR_MSM_IRQS);
 
 	if (of_machine_is_compatible("qcom,msm8660-surf")) {
 		printk(KERN_INFO "Init surf UART registers\n");
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index d587560..32f5d9b 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -67,7 +67,7 @@ static void __init omap_generic_init(void)
 {
 	struct device_node *node = of_find_matching_node(NULL, intc_match);
 	if (node)
-		irq_domain_add_simple(node, 0);
+		irq_domain_add_simple(node, 0, INTCPS_NR_IRQS);
 
 	omap_sdrc_init(NULL, NULL);
 
diff --git a/arch/arm/mach-prima2/irq.c b/arch/arm/mach-prima2/irq.c
index d93ceef..da0c1df 100644
--- a/arch/arm/mach-prima2/irq.c
+++ b/arch/arm/mach-prima2/irq.c
@@ -68,7 +68,7 @@ void __init sirfsoc_of_irq_init(void)
 	if (!sirfsoc_intc_base)
 		panic("unable to map intc cpu registers\n");
 
-	irq_domain_add_simple(np, 0);
+	irq_domain_add_simple(np, 0, NR_IRQS);
 
 	of_node_put(np);
 
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 02b7b93..df7266a 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -99,12 +99,14 @@ static const struct of_device_id sic_of_match[] __initconst = {
 void __init versatile_init_irq(void)
 {
 	vic_init(VA_VIC_BASE, IRQ_VIC_START, ~0, 0);
-	irq_domain_generate_simple(vic_of_match, VERSATILE_VIC_BASE, IRQ_VIC_START);
+	irq_domain_generate_simple(vic_of_match, VERSATILE_VIC_BASE,
+			IRQ_VIC_START, IRQ_VIC_END - IRQ_VIC_START + 1);
 
 	writel(~0, VA_SIC_BASE + SIC_IRQ_ENABLE_CLEAR);
 
 	fpga_irq_init(IRQ_VICSOURCE31, ~PIC_MASK, &sic_irq);
-	irq_domain_generate_simple(sic_of_match, VERSATILE_SIC_BASE, IRQ_SIC_START);
+	irq_domain_generate_simple(sic_of_match, VERSATILE_SIC_BASE,
+			IRQ_SIC_START, IRQ_SIC_END - IRQ_SIC_START + 1);
 
 	/*
 	 * Interrupts on secondary controller from 0 to 8 are routed to
diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
index fd9efb0..70376e0 100644
--- a/arch/arm/plat-mxc/include/mach/irqs.h
+++ b/arch/arm/plat-mxc/include/mach/irqs.h
@@ -13,19 +13,20 @@
 
 #include <asm-generic/gpio.h>
 
+#define GIC_NUM_IRQS		160
+#define TZIC_NUM_IRQS		128
+#define AVIC_NUM_IRQS		64
+
 /*
- * SoCs with GIC interrupt controller have 160 IRQs, those with TZIC
- * have 128 IRQs, and those with AVIC have 64.
- *
  * To support single image, the biggest number should be defined on
  * top of the list.
  */
 #if defined CONFIG_ARM_GIC
-#define MXC_INTERNAL_IRQS	160
+#define MXC_INTERNAL_IRQS	GIC_NUM_IRQS
 #elif defined CONFIG_MXC_TZIC
-#define MXC_INTERNAL_IRQS	128
+#define MXC_INTERNAL_IRQS	TZIC_NUM_IRQS
 #else
-#define MXC_INTERNAL_IRQS	64
+#define MXC_INTERNAL_IRQS	AVIC_NUM_IRQS
 #endif
 
 #define MXC_GPIO_IRQ_START	MXC_INTERNAL_IRQS
diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
index 98308ec..98b23b8 100644
--- a/arch/arm/plat-mxc/tzic.c
+++ b/arch/arm/plat-mxc/tzic.c
@@ -50,8 +50,6 @@
 
 void __iomem *tzic_base; /* Used as irq controller base in entry-macro.S */
 
-#define TZIC_NUM_IRQS 128
-
 #ifdef CONFIG_FIQ
 static int tzic_set_irq_fiq(unsigned int irq, unsigned int type)
 {
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index bd4272b..6bf9a1c 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -15,6 +15,7 @@
 #ifndef _LINUX_IRQDOMAIN_H
 #define _LINUX_IRQDOMAIN_H
 
+#include <linux/err.h>
 #include <linux/irq.h>
 #include <linux/mod_devicetable.h>
 
@@ -96,12 +97,28 @@ extern struct irq_domain_ops irq_domain_simple_ops;
 #endif /* CONFIG_IRQ_DOMAIN */
 
 #if defined(CONFIG_IRQ_DOMAIN) && defined(CONFIG_OF_IRQ)
-extern void irq_domain_add_simple(struct device_node *controller, int irq_base);
-extern void irq_domain_generate_simple(const struct of_device_id *match,
-					u64 phys_base, unsigned int irq_start);
+extern struct irq_domain *irq_domain_add_simple(struct device_node *controller,
+						unsigned int irq_base,
+						unsigned int nr_irq);
+extern struct irq_domain *irq_domain_generate_simple(const struct of_device_id *match,
+						     u64 phys_base,
+						     unsigned int irq_start,
+						     unsigned int nr_irq);
 #else /* CONFIG_IRQ_DOMAIN && CONFIG_OF_IRQ */
-static inline void irq_domain_generate_simple(const struct of_device_id *match,
-					u64 phys_base, unsigned int irq_start) { }
+static inline struct irq_domain *irq_domain_add_simple(struct device_node *controller,
+						       int irq_base,
+						       unsigned int nr_irq)
+{
+	return NULL;
+}
+
+static inline struct irq_domain *irq_domain_generate_simple(const struct of_device_id *match,
+							    u64 phys_base,
+							    unsigned int irq_start,
+							    unsigned int nr_irq)
+{
+	return NULL;
+}
 #endif /* CONFIG_IRQ_DOMAIN && CONFIG_OF_IRQ */
 
 #endif /* _LINUX_IRQDOMAIN_H */
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 1f9e265..133d28b 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -147,36 +147,46 @@ int irq_domain_simple_dt_translate(struct irq_domain *d,
 }
 
 /**
- * irq_domain_create_simple() - Set up a 'simple' translation range
+ * irq_domain_add_simple() - Set up a 'simple' translation range
  */
-void irq_domain_add_simple(struct device_node *controller, int irq_base)
+struct irq_domain *irq_domain_add_simple(struct device_node *controller,
+					 unsigned int irq_base,
+					 unsigned int nr_irq)
 {
 	struct irq_domain *domain;
 
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain) {
 		WARN_ON(1);
-		return;
+		return NULL;
 	}
 
 	domain->irq_base = irq_base;
+	domain->nr_irq = nr_irq;
 	domain->of_node = of_node_get(controller);
 	domain->ops = &irq_domain_simple_ops;
 	irq_domain_add(domain);
+
+	return domain;
 }
 EXPORT_SYMBOL_GPL(irq_domain_add_simple);
 
-void irq_domain_generate_simple(const struct of_device_id *match,
-				u64 phys_base, unsigned int irq_start)
+struct irq_domain *irq_domain_generate_simple(const struct of_device_id *match,
+					      u64 phys_base,
+					      unsigned int irq_start,
+					      unsigned int nr_irq)
 {
+	struct irq_domain *domain = NULL;
 	struct device_node *node;
-	pr_info("looking for phys_base=%llx, irq_start=%i\n",
-		(unsigned long long) phys_base, (int) irq_start);
+	pr_info("looking for phys_base=%llx, irq_start=%u, nr_irq=%u\n",
+		(unsigned long long) phys_base, irq_start, nr_irq);
 	node = of_find_matching_node_by_address(NULL, match, phys_base);
 	if (node)
-		irq_domain_add_simple(node, irq_start);
+		domain = irq_domain_add_simple(node, irq_start, nr_irq);
 	else
 		pr_info("no node found\n");
+
+	return domain;
 }
 EXPORT_SYMBOL_GPL(irq_domain_generate_simple);
 #endif /* CONFIG_OF_IRQ */
-- 
1.7.8.3

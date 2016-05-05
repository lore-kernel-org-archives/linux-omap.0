From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V3 16/17] irqchip/gic: Prepare for adding platform driver
Date: Thu, 5 May 2016 15:13:08 +0100
Message-ID: <572B54F4.2080103@arm.com>
References: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
 <1462379130-11742-17-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462379130-11742-17-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 04/05/16 17:25, Jon Hunter wrote:
> To support GICs that require runtime-pm, it is necessary to add a
> platform driver, so that the probing of the chip can be deferred if
> resources, such as a power-domain, is not yet available.
> 
> To prepare for adding a platform driver:
>  1. Drop the __init section from the gic_dist_config(), gic_dist_init()
>     and gic_pm_init() so these can be re-used by the platform driver.
>  2. Move the definitions for gic_base and gic_chip_data structures to a
>     local header files along with prototypes for functions required by
>     the platform driver.
> 
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/irqchip/irq-gic-common.c |  4 +--
>  drivers/irqchip/irq-gic.c        | 57 +++++++++++-------------------------
>  drivers/irqchip/irq-gic.h        | 63 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 82 insertions(+), 42 deletions(-)
>  create mode 100644 drivers/irqchip/irq-gic.h
> 
> diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
> index 9fa92a17225c..083c30390aa3 100644
> --- a/drivers/irqchip/irq-gic-common.c
> +++ b/drivers/irqchip/irq-gic-common.c
> @@ -72,8 +72,8 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
>  	return ret;
>  }
>  
> -void __init gic_dist_config(void __iomem *base, int gic_irqs,
> -			    void (*sync_access)(void))
> +void gic_dist_config(void __iomem *base, int gic_irqs,
> +		     void (*sync_access)(void))
>  {
>  	unsigned int i;
>  
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 15e8a12813cc..bf9a256a1269 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -48,6 +48,7 @@
>  #include <asm/smp_plat.h>
>  #include <asm/virt.h>
>  
> +#include "irq-gic.h"
>  #include "irq-gic-common.h"
>  
>  #ifdef CONFIG_ARM64
> @@ -63,31 +64,6 @@ static void gic_check_cpu_features(void)
>  #define gic_check_cpu_features()	do { } while(0)
>  #endif
>  
> -union gic_base {
> -	void __iomem *common_base;
> -	void __percpu * __iomem *percpu_base;
> -};
> -
> -struct gic_chip_data {
> -	struct irq_chip chip;
> -	union gic_base dist_base;
> -	union gic_base cpu_base;
> -#ifdef CONFIG_CPU_PM
> -	u32 saved_spi_enable[DIV_ROUND_UP(1020, 32)];
> -	u32 saved_spi_active[DIV_ROUND_UP(1020, 32)];
> -	u32 saved_spi_conf[DIV_ROUND_UP(1020, 16)];
> -	u32 saved_spi_target[DIV_ROUND_UP(1020, 4)];
> -	u32 __percpu *saved_ppi_enable;
> -	u32 __percpu *saved_ppi_active;
> -	u32 __percpu *saved_ppi_conf;
> -#endif
> -	struct irq_domain *domain;
> -	unsigned int gic_irqs;
> -#ifdef CONFIG_GIC_NON_BANKED
> -	void __iomem *(*get_base)(union gic_base *);
> -#endif
> -};
> -
>  static DEFINE_RAW_SPINLOCK(irq_controller_lock);
>  
>  /*
> @@ -352,7 +328,7 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
>  	} while (1);
>  }
>  
> -static void gic_handle_cascade_irq(struct irq_desc *desc)
> +void gic_handle_cascade_irq(struct irq_desc *desc)
>  {
>  	struct gic_chip_data *chip_data = irq_desc_get_handler_data(desc);
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> @@ -436,7 +412,7 @@ static void gic_cpu_if_up(struct gic_chip_data *gic)
>  }
>  
>  
> -static void __init gic_dist_init(struct gic_chip_data *gic)
> +void gic_dist_init(struct gic_chip_data *gic)
>  {
>  	unsigned int i;
>  	u32 cpumask;
> @@ -459,7 +435,7 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
>  	writel_relaxed(GICD_ENABLE, base + GIC_DIST_CTRL);
>  }
>  
> -static void gic_cpu_init(struct gic_chip_data *gic)
> +void gic_cpu_init(struct gic_chip_data *gic)
>  {
>  	void __iomem *dist_base = gic_data_dist_base(gic);
>  	void __iomem *base = gic_data_cpu_base(gic);
> @@ -518,7 +494,7 @@ int gic_cpu_if_down(unsigned int gic_nr)
>   * this function, no interrupts will be delivered by the GIC, and another
>   * platform-specific wakeup source must be enabled.
>   */
> -static void gic_dist_save(struct gic_chip_data *gic)
> +void gic_dist_save(struct gic_chip_data *gic)
>  {
>  	unsigned int gic_irqs;
>  	void __iomem *dist_base;
> @@ -557,7 +533,7 @@ static void gic_dist_save(struct gic_chip_data *gic)
>   * handled normally, but any edge interrupts that occured will not be seen by
>   * the GIC and need to be handled by the platform-specific wakeup source.
>   */
> -static void gic_dist_restore(struct gic_chip_data *gic)
> +void gic_dist_restore(struct gic_chip_data *gic)
>  {
>  	unsigned int gic_irqs;
>  	unsigned int i;
> @@ -603,7 +579,7 @@ static void gic_dist_restore(struct gic_chip_data *gic)
>  	writel_relaxed(GICD_ENABLE, dist_base + GIC_DIST_CTRL);
>  }
>  
> -static void gic_cpu_save(struct gic_chip_data *gic)
> +void gic_cpu_save(struct gic_chip_data *gic)
>  {
>  	int i;
>  	u32 *ptr;
> @@ -633,7 +609,7 @@ static void gic_cpu_save(struct gic_chip_data *gic)
>  
>  }
>  
> -static void gic_cpu_restore(struct gic_chip_data *gic)
> +void gic_cpu_restore(struct gic_chip_data *gic)
>  {
>  	int i;
>  	u32 *ptr;
> @@ -710,7 +686,7 @@ static struct notifier_block gic_notifier_block = {
>  	.notifier_call = gic_notifier,
>  };
>  
> -static void __init gic_pm_init(struct gic_chip_data *gic)
> +void gic_pm_init(struct gic_chip_data *gic)
>  {
>  	gic->saved_ppi_enable = __alloc_percpu(DIV_ROUND_UP(32, 32) * 4,
>  		sizeof(u32));
> @@ -728,7 +704,7 @@ static void __init gic_pm_init(struct gic_chip_data *gic)
>  		cpu_pm_register_notifier(&gic_notifier_block);
>  }
>  #else
> -static void __init gic_pm_init(struct gic_chip_data *gic)
> +void gic_pm_init(struct gic_chip_data *gic)
>  {
>  }
>  #endif
> @@ -1002,10 +978,10 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
>  	.unmap = gic_irq_domain_unmap,
>  };
>  
> -static int gic_init_bases(struct gic_chip_data *gic, int irq_start,
> -			  void __iomem *dist_base, void __iomem *cpu_base,
> -			  u32 percpu_offset, struct fwnode_handle *handle,
> -			  const char *name)
> +int gic_init_bases(struct gic_chip_data *gic, int irq_start,
> +		   void __iomem *dist_base, void __iomem *cpu_base,
> +		   u32 percpu_offset, struct fwnode_handle *handle,
> +		   const char *name)
>  {
>  	irq_hw_number_t hwirq_base;
>  	int gic_irqs, irq_base, ret;
> @@ -1153,6 +1129,7 @@ static int __init __gic_init_bases(unsigned int gic_nr, int irq_start,
>  		set_smp_cross_call(gic_raise_softirq);
>  		register_cpu_notifier(&gic_cpu_notifier);
>  #endif
> +
>  		set_handle_irq(gic_handle_irq);
>  		if (static_key_true(&supports_deactivate))
>  			pr_info("GIC: Using split EOI/Deactivate mode\n");
> @@ -1217,8 +1194,8 @@ static bool gic_check_eoimode(struct device_node *node, void __iomem **base)
>  	return true;
>  }
>  
> -static int gic_of_setup(struct device_node *node, void __iomem **dist_base,
> -			void __iomem **cpu_base, u32 *percpu_offset)
> +int gic_of_setup(struct device_node *node, void __iomem **dist_base,
> +		 void __iomem **cpu_base, u32 *percpu_offset)
>  {
>  	if (!node || !dist_base || !cpu_base || !percpu_offset)
>  		return -EINVAL;
> diff --git a/drivers/irqchip/irq-gic.h b/drivers/irqchip/irq-gic.h
> new file mode 100644
> index 000000000000..59198d5e7175
> --- /dev/null
> +++ b/drivers/irqchip/irq-gic.h
> @@ -0,0 +1,63 @@
> +/*
> + * Copyright (C) 2016 NVIDIA CORPORATION, All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef _IRQ_GIC_H
> +#define _IRQ_GIC_H
> +
> +union gic_base {
> +	void __iomem *common_base;
> +	void __percpu * __iomem *percpu_base;
> +};
> +
> +struct gic_chip_data {
> +	struct irq_chip chip;
> +	union gic_base dist_base;
> +	union gic_base cpu_base;
> +#ifdef CONFIG_CPU_PM
> +	u32 saved_spi_enable[DIV_ROUND_UP(1020, 32)];
> +	u32 saved_spi_active[DIV_ROUND_UP(1020, 32)];
> +	u32 saved_spi_conf[DIV_ROUND_UP(1020, 16)];
> +	u32 saved_spi_target[DIV_ROUND_UP(1020, 4)];
> +	u32 __percpu *saved_ppi_enable;
> +	u32 __percpu *saved_ppi_active;
> +	u32 __percpu *saved_ppi_conf;
> +#endif
> +	struct irq_domain *domain;
> +	unsigned int gic_irqs;
> +#ifdef CONFIG_GIC_NON_BANKED
> +	void __iomem *(*get_base)(union gic_base *);
> +#endif
> +};

Gahhh. No. Please. Last time we did that, it took 6 months to untangle
the mess people made by adding their own hacks in this structure, 
so I definitely want to keep it completely private, forever. Same goes
for the gic_{dist,cpu.pm}_init() functions.

I've had a go at this, and came up with the following patch. I've only
briefly tested it on a host and a VM, so it is likely to break some stuff
somewhere, but you'll get the idea: The gic_chip_data struct is entirely
opaque, allocated by the GIC driver itself, with a few new fields in
it so that it becomes self-contained. This applies on top of your series.

It should also make it easy to switch to a model where we allocate
the structure dynamically instead of the old static crap.

Thoughts?

	M.

diff --git a/drivers/irqchip/irq-gic-pm.c b/drivers/irqchip/irq-gic-pm.c
index 0a86da6..c4d0621 100644
--- a/drivers/irqchip/irq-gic-pm.c
+++ b/drivers/irqchip/irq-gic-pm.c
@@ -97,9 +97,6 @@ static int gic_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const struct gic_clk_data *data;
 	struct gic_chip_data *gic;
-	void __iomem *dist_base;
-	void __iomem *cpu_base;
-	u32 percpu_offset;
 	int ret, irq;
 
 	data = of_device_get_match_data(&pdev->dev);
@@ -108,16 +105,10 @@ static int gic_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	gic = devm_kzalloc(dev, sizeof(*gic), GFP_KERNEL);
-	if (!gic)
-		return -ENOMEM;
-
 	ret = gic_get_clocks(dev, data);
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, gic);
-
 	pm_runtime_enable(dev);
 
 	ret = pm_runtime_get_sync(dev);
@@ -131,21 +122,16 @@ static int gic_probe(struct platform_device *pdev)
 		goto rpm_put;
 	}
 
-	ret = gic_of_setup(dev->of_node, &dist_base, &cpu_base, &percpu_offset);
+	ret = gic_of_setup(dev->of_node, dev, &gic);
 	if (ret)
 		goto irq_dispose;
 
-	ret = gic_init_bases(gic, -1, dist_base, cpu_base,
-			     percpu_offset, &dev->of_node->fwnode,
+	ret = gic_init_bases(gic, -1, gic, &dev->of_node->fwnode,
 			     dev->of_node->name);
 	if (ret)
 		goto gic_unmap;
 
-	gic_dist_init(gic);
-	gic_cpu_init(gic);
-	gic_pm_init(gic);
-
-	gic->chip.parent_device = dev;
+	platform_set_drvdata(pdev, gic);
 
 	irq_set_chained_handler_and_data(irq, gic_handle_cascade_irq, gic);
 
@@ -156,8 +142,7 @@ static int gic_probe(struct platform_device *pdev)
 	return 0;
 
 gic_unmap:
-	iounmap(dist_base);
-	iounmap(cpu_base);
+	gic_of_teardown(gic);
 irq_dispose:
 	irq_dispose_mapping(irq);
 rpm_put:
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 5108a85..e779c5d 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -51,6 +51,34 @@
 #include "irq-gic.h"
 #include "irq-gic-common.h"
 
+union gic_base {
+	void __iomem *common_base;
+	void __percpu * __iomem *percpu_base;
+};
+
+struct gic_chip_data {
+	struct irq_chip chip;
+	union gic_base dist_base;
+	union gic_base cpu_base;
+	void __iomem *raw_dist_base;
+	void __iomem *raw_cpu_base;
+	u32 percpu_offset;
+#if defined(CONFIG_CPU_PM) || defined(ARM_GIC_PM)
+	u32 saved_spi_enable[DIV_ROUND_UP(1020, 32)];
+	u32 saved_spi_active[DIV_ROUND_UP(1020, 32)];
+	u32 saved_spi_conf[DIV_ROUND_UP(1020, 16)];
+	u32 saved_spi_target[DIV_ROUND_UP(1020, 4)];
+	u32 __percpu *saved_ppi_enable;
+	u32 __percpu *saved_ppi_active;
+	u32 __percpu *saved_ppi_conf;
+#endif
+	struct irq_domain *domain;
+	unsigned int gic_irqs;
+#ifdef CONFIG_GIC_NON_BANKED
+	void __iomem *(*get_base)(union gic_base *);
+#endif
+};
+
 #ifdef CONFIG_ARM64
 #include <asm/cpufeature.h>
 
@@ -420,7 +448,7 @@ static void gic_cpu_if_up(struct gic_chip_data *gic)
 }
 
 
-void gic_dist_init(struct gic_chip_data *gic)
+static void gic_dist_init(struct gic_chip_data *gic)
 {
 	unsigned int i;
 	u32 cpumask;
@@ -443,7 +471,7 @@ void gic_dist_init(struct gic_chip_data *gic)
 	writel_relaxed(GICD_ENABLE, base + GIC_DIST_CTRL);
 }
 
-void gic_cpu_init(struct gic_chip_data *gic)
+static void gic_cpu_init(struct gic_chip_data *gic)
 {
 	void __iomem *dist_base = gic_data_dist_base(gic);
 	void __iomem *base = gic_data_cpu_base(gic);
@@ -693,7 +721,7 @@ static struct notifier_block gic_notifier_block = {
 	.notifier_call = gic_notifier,
 };
 
-void gic_pm_init(struct gic_chip_data *gic)
+static void gic_pm_init(struct gic_chip_data *gic)
 {
 	gic->saved_ppi_enable = __alloc_percpu(DIV_ROUND_UP(32, 32) * 4,
 		sizeof(u32));
@@ -711,7 +739,7 @@ void gic_pm_init(struct gic_chip_data *gic)
 		cpu_pm_register_notifier(&gic_notifier_block);
 }
 #else
-void gic_pm_init(struct gic_chip_data *gic)
+static void gic_pm_init(struct gic_chip_data *gic)
 {
 }
 #endif
@@ -986,9 +1014,7 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 };
 
 int gic_init_bases(struct gic_chip_data *gic, int irq_start,
-		   void __iomem *dist_base, void __iomem *cpu_base,
-		   u32 percpu_offset, struct fwnode_handle *handle,
-		   const char *name)
+		   struct fwnode_handle *handle, const char *name)
 {
 	irq_hw_number_t hwirq_base;
 	int gic_irqs, irq_base, ret;
@@ -1013,7 +1039,7 @@ int gic_init_bases(struct gic_chip_data *gic, int irq_start,
 		gic->chip.irq_set_affinity = gic_set_affinity;
 #endif
 
-	if (IS_ENABLED(CONFIG_GIC_NON_BANKED) && percpu_offset) {
+	if (IS_ENABLED(CONFIG_GIC_NON_BANKED) && gic->percpu_offset) {
 		/* Frankein-GIC without banked registers... */
 		unsigned int cpu;
 
@@ -1028,19 +1054,19 @@ int gic_init_bases(struct gic_chip_data *gic, int irq_start,
 		for_each_possible_cpu(cpu) {
 			u32 mpidr = cpu_logical_map(cpu);
 			u32 core_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-			unsigned long offset = percpu_offset * core_id;
-			*per_cpu_ptr(gic->dist_base.percpu_base, cpu) = dist_base + offset;
-			*per_cpu_ptr(gic->cpu_base.percpu_base, cpu) = cpu_base + offset;
+			unsigned long offset = gic->percpu_offset * core_id;
+			*per_cpu_ptr(gic->dist_base.percpu_base, cpu) = gic->raw_dist_base + offset;
+			*per_cpu_ptr(gic->cpu_base.percpu_base, cpu) = gic->raw_cpu_base + offset;
 		}
 
 		gic_set_base_accessor(gic, gic_get_percpu_base);
 	} else {
 		/* Normal, sane GIC... */
-		WARN(percpu_offset,
+		WARN(gic->percpu_offset,
 		     "GIC_NON_BANKED not enabled, ignoring %08x offset!",
-		     percpu_offset);
-		gic->dist_base.common_base = dist_base;
-		gic->cpu_base.common_base = cpu_base;
+		     gic->percpu_offset);
+		gic->dist_base.common_base = gic->raw_dist_base;
+		gic->cpu_base.common_base = gic->raw_cpu_base;
 		gic_set_base_accessor(gic, gic_get_common_base);
 	}
 
@@ -1090,10 +1116,14 @@ int gic_init_bases(struct gic_chip_data *gic, int irq_start,
 		goto error;
 	}
 
+	gic_dist_init(gic);
+	gic_cpu_init(gic);
+	gic_pm_init(gic);
+
 	return 0;
 
 error:
-	if (IS_ENABLED(CONFIG_GIC_NON_BANKED) && percpu_offset) {
+	if (IS_ENABLED(CONFIG_GIC_NON_BANKED) && gic->percpu_offset) {
 		free_percpu(gic->dist_base.percpu_base);
 		free_percpu(gic->cpu_base.percpu_base);
 	}
@@ -1101,37 +1131,24 @@ error:
 	return ret;
 }
 
-static int __init __gic_init_bases(unsigned int gic_nr, int irq_start,
-			   void __iomem *dist_base, void __iomem *cpu_base,
-			   u32 percpu_offset, struct fwnode_handle *handle)
+static int __init __gic_init_bases(struct gic_chip_data *gic, int irq_start,
+				   struct fwnode_handle *handle)
 {
-	struct gic_chip_data *gic;
 	char *name;
-	int i, ret;
-
-	if (WARN_ON(gic_nr >= CONFIG_ARM_GIC_MAX_NR))
-		return -EINVAL;
-
-	gic = &gic_data[gic_nr];
+	int ret;
 
-	if (static_key_true(&supports_deactivate) && gic_nr == 0)
+	if (static_key_true(&supports_deactivate) && gic == &gic_data[0])
 		name = kasprintf(GFP_KERNEL, "GICv2");
 	else
-		name = kasprintf(GFP_KERNEL, "GIC-%d", gic_nr);
+		name = kasprintf(GFP_KERNEL, "GIC-%d", (int)(gic - &gic_data[0]));
 
-	ret = gic_init_bases(gic, irq_start, dist_base, cpu_base, percpu_offset,
-			     handle, name);
-	if (ret) {
-		kfree(name);
-		return ret;
-	}
-
-	if (gic_nr == 0) {
+	if (gic == &gic_data[0]) {
 		/*
 		 * Initialize the CPU interface map to all CPUs.
 		 * It will be refined as each CPU probes its ID.
 		 * This is only necessary for the primary GIC.
 		 */
+		int i;
 		for (i = 0; i < NR_GIC_CPU_IF; i++)
 			gic_cpu_map[i] = 0xff;
 #ifdef CONFIG_SMP
@@ -1144,22 +1161,26 @@ static int __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 			pr_info("GIC: Using split EOI/Deactivate mode\n");
 	}
 
-	gic_dist_init(gic);
-	gic_cpu_init(gic);
-	gic_pm_init(gic);
+	ret = gic_init_bases(gic, irq_start, handle, name);
+	if (ret)
+		kfree(name);
 
-	return 0;
+	return ret;
 }
 
 void __init gic_init(unsigned int gic_nr, int irq_start,
 		     void __iomem *dist_base, void __iomem *cpu_base)
 {
+	struct gic_chip_data *gic = &gic_data[gic_nr];
+
 	/*
 	 * Non-DT/ACPI systems won't run a hypervisor, so let's not
 	 * bother with these...
 	 */
 	static_key_slow_dec(&supports_deactivate);
-	__gic_init_bases(gic_nr, irq_start, dist_base, cpu_base, 0, NULL);
+	gic->raw_dist_base = dist_base;
+	gic->raw_cpu_base = cpu_base;
+	__gic_init_bases(gic, irq_start, NULL);
 }
 
 #ifdef CONFIG_OF
@@ -1203,34 +1224,52 @@ static bool gic_check_eoimode(struct device_node *node, void __iomem **base)
 	return true;
 }
 
-int gic_of_setup(struct device_node *node, void __iomem **dist_base,
-		 void __iomem **cpu_base, u32 *percpu_offset)
+void gic_of_teardown(struct gic_chip_data *gic)
 {
-	if (!node || !dist_base || !cpu_base || !percpu_offset)
-		return -EINVAL;
+	if (gic->raw_dist_base)
+		iounmap(gic->raw_dist_base);
+	if (gic->raw_cpu_base)
+		iounmap(gic->raw_cpu_base);
+}
 
-	*dist_base = of_iomap(node, 0);
-	if (WARN(!*dist_base, "unable to map gic dist registers\n"))
-		return -ENOMEM;
+int gic_of_setup(struct device_node *node, struct device *dev,
+		 struct gic_chip_data **gicp)
+{
+	struct gic_chip_data *gic;
 
-	*cpu_base = of_iomap(node, 1);
-	if (WARN(!*cpu_base, "unable to map gic cpu registers\n")) {
-		iounmap(*dist_base);
-		return -ENOMEM;
+	if (!node || !gicp)
+		return -EINVAL;
+
+	if (dev) {
+		*gicp = devm_kzalloc(dev, sizeof(*gic), GFP_KERNEL);
+		if (!*gicp)
+			return -ENOMEM;
 	}
 
-	if (of_property_read_u32(node, "cpu-offset", percpu_offset))
-		*percpu_offset = 0;
+	gic = *gicp;
+
+	gic->raw_dist_base = of_iomap(node, 0);
+	if (WARN(!gic->raw_dist_base, "unable to map gic dist registers\n"))
+		goto err;
+
+	gic->raw_cpu_base = of_iomap(node, 1);
+	if (WARN(!gic->raw_cpu_base, "unable to map gic cpu registers\n"))
+		goto err;
+
+	if (of_property_read_u32(node, "cpu-offset", &gic->percpu_offset))
+		gic->percpu_offset = 0;
 
+	gic->chip.parent_device = dev;
 	return 0;
+err:
+	gic_of_teardown(gic);
+	return -ENOMEM;
 }
 
 int __init
 gic_of_init(struct device_node *node, struct device_node *parent)
 {
-	void __iomem *cpu_base;
-	void __iomem *dist_base;
-	u32 percpu_offset;
+	struct gic_chip_data *gic;
 	int irq, ret;
 
 	if (WARN_ON(!node))
@@ -1245,7 +1284,8 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 	    of_property_read_bool(node, "power-domains"))
 		return 0;
 
-	ret = gic_of_setup(node, &dist_base, &cpu_base, &percpu_offset);
+	gic = &gic_data[gic_cnt];
+	ret = gic_of_setup(node, NULL, &gic);
 	if (ret)
 		return ret;
 
@@ -1253,14 +1293,13 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 	 * Disable split EOI/Deactivate if either HYP is not available
 	 * or the CPU interface is too small.
 	 */
-	if (gic_cnt == 0 && !gic_check_eoimode(node, &cpu_base))
+	if (gic_cnt == 0 && !gic_check_eoimode(node, &gic->raw_cpu_base))
 		static_key_slow_dec(&supports_deactivate);
 
-	ret = __gic_init_bases(gic_cnt, -1, dist_base, cpu_base, percpu_offset,
-			 &node->fwnode);
+	ret = __gic_init_bases(gic, -1, &node->fwnode);
 	if (ret) {
-		iounmap(dist_base);
-		iounmap(cpu_base);
+		iounmap(gic->raw_dist_base);
+		iounmap(gic->raw_cpu_base);
 		return ret;
 	}
 
@@ -1395,7 +1434,9 @@ static int __init gic_v2_acpi_init(struct acpi_subtable_header *header,
 		return -ENOMEM;
 	}
 
-	ret = __gic_init_bases(0, -1, dist_base, cpu_base, 0, domain_handle);
+	gic_data[0].raw_dist_base = dist_base;
+	gic_data[0].raw_cpu_base = cpu_base;
+	ret = __gic_init_bases(&gic_data[0], -1, domain_handle);
 	if (ret) {
 		pr_err("Failed to initialise GIC\n");
 		irq_domain_free_fwnode(domain_handle);
diff --git a/drivers/irqchip/irq-gic.h b/drivers/irqchip/irq-gic.h
index 31e7733..77d4001 100644
--- a/drivers/irqchip/irq-gic.h
+++ b/drivers/irqchip/irq-gic.h
@@ -17,46 +17,18 @@
 #ifndef _IRQ_GIC_H
 #define _IRQ_GIC_H
 
-union gic_base {
-	void __iomem *common_base;
-	void __percpu * __iomem *percpu_base;
-};
+struct gic_chip_data;
 
-struct gic_chip_data {
-	struct irq_chip chip;
-	union gic_base dist_base;
-	union gic_base cpu_base;
-#if defined(CONFIG_CPU_PM) || defined(ARM_GIC_PM)
-	u32 saved_spi_enable[DIV_ROUND_UP(1020, 32)];
-	u32 saved_spi_active[DIV_ROUND_UP(1020, 32)];
-	u32 saved_spi_conf[DIV_ROUND_UP(1020, 16)];
-	u32 saved_spi_target[DIV_ROUND_UP(1020, 4)];
-	u32 __percpu *saved_ppi_enable;
-	u32 __percpu *saved_ppi_active;
-	u32 __percpu *saved_ppi_conf;
-#endif
-	struct irq_domain *domain;
-	unsigned int gic_irqs;
-#ifdef CONFIG_GIC_NON_BANKED
-	void __iomem *(*get_base)(union gic_base *);
-#endif
-};
-
-void gic_cpu_init(struct gic_chip_data *gic);
 void gic_cpu_save(struct gic_chip_data *gic);
 void gic_cpu_restore(struct gic_chip_data *gic);
-void gic_dist_init(struct gic_chip_data *gic);
 void gic_dist_save(struct gic_chip_data *gic);
 void gic_dist_restore(struct gic_chip_data *gic);
-void gic_pm_init(struct gic_chip_data *gic);
-
-int gic_of_setup(struct device_node *node, void __iomem **dist_base,
-		 void __iomem **cpu_base, u32 *percpu_offset);
 
+int gic_of_setup(struct device_node *node, struct device *dev,
+		 struct gic_chip_data **gic);
+void gic_of_teardown(struct gic_chip_data *gic);
 int gic_init_bases(struct gic_chip_data *gic, int irq_start,
-		   void __iomem *dist_base, void __iomem *cpu_base,
-		   u32 percpu_offset, struct fwnode_handle *handle,
-		   const char *name);
+		   struct fwnode_handle *handle, const char *name);
 
 void gic_handle_cascade_irq(struct irq_desc *desc);
 

-- 
Jazz is not dead. It just smells funny...
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

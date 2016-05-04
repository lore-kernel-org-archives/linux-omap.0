From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 06/17] irqdomain: Don't set type when mapping an IRQ
Date: Wed, 4 May 2016 17:25:19 +0100
Message-ID: <1462379130-11742-7-git-send-email-jonathanh@nvidia.com>
References: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-omap@vger.kernel.org

Some IRQ chips, such as GPIO controllers or secondary level interrupt
controllers, may require require additional runtime power management
control to ensure they are accessible. For such IRQ chips, it makes sense
to enable the IRQ chip when interrupts are requested and disabled them
again once all interrupts have been freed.

When mapping an IRQ, the IRQ type settings are read and then programmed.
The mapping of the IRQ happens before the IRQ is requested and so the
programming of the type settings occurs before the IRQ is requested. This
is a problem for IRQ chips that require additional power management
control because they may not be accessible yet. Therefore, when mapping
the IRQ, don't program the type settings, just save them and then program
these saved settings when the IRQ is requested (so long as if they are not
overridden via the call to request the IRQ).

Add a stub function for irq_domain_free_irqs() to avoid any compilation
errors when CONFIG_IRQ_DOMAIN_HIERARCHY is not selected.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 include/linux/irqdomain.h |  3 +++
 kernel/irq/irqdomain.c    | 23 ++++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 2aed04396210..fc66876d1965 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -440,6 +440,9 @@ static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 	return -1;
 }
 
+static inline void irq_domain_free_irqs(unsigned int virq,
+					unsigned int nr_irqs) { }
+
 static inline bool irq_domain_is_hierarchy(struct irq_domain *domain)
 {
 	return false;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index d68371213fc9..bbf5b9b8ac3d 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -564,6 +564,7 @@ static void of_phandle_args_to_fwspec(struct of_phandle_args *irq_data,
 unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 {
 	struct irq_domain *domain;
+	struct irq_data *irq_data;
 	irq_hw_number_t hwirq;
 	unsigned int type = IRQ_TYPE_NONE;
 	int virq;
@@ -613,7 +614,11 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 		 * it now and return the interrupt number.
 		 */
 		if (irq_get_trigger_type(virq) == IRQ_TYPE_NONE) {
-			irq_set_irq_type(virq, type);
+			irq_data = irq_get_irq_data(virq);
+			if (!irq_data)
+				return 0;
+
+			irqd_set_trigger_type(irq_data, type);
 			return virq;
 		}
 
@@ -633,10 +638,18 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 			return virq;
 	}
 
-	/* Set type if specified and different than the current one */
-	if (type != IRQ_TYPE_NONE &&
-	    type != irq_get_trigger_type(virq))
-		irq_set_irq_type(virq, type);
+	irq_data = irq_get_irq_data(virq);
+	if (!irq_data) {
+		if (irq_domain_is_hierarchy(domain))
+			irq_domain_free_irqs(virq, 1);
+		else
+			irq_dispose_mapping(virq);
+		return 0;
+	}
+
+	/* Store trigger type */
+	irqd_set_trigger_type(irq_data, type);
+
 	return virq;
 }
 EXPORT_SYMBOL_GPL(irq_create_fwspec_mapping);
-- 
2.1.4

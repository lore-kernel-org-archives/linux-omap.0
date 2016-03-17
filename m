From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 10/15] irqchip/gic: Remove static irq_chip definition for eoimode1
Date: Thu, 17 Mar 2016 14:19:14 +0000
Message-ID: <1458224359-32665-11-git-send-email-jonathanh@nvidia.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-omap@vger.kernel.org

There are only 3 differences (not including the name) in the definitions
of the gic_chip and gic_eoimode1_chip structures. Instead of statically
defining the gic_eoimode1_chip structure, remove it and populate the
eoimode1 functions dynamically for the appropriate GIC irqchips.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/irqchip/irq-gic.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index a4a13ef35c1b..b0a781f8c450 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -393,20 +393,6 @@ static struct irq_chip gic_chip = {
 				  IRQCHIP_MASK_ON_SUSPEND,
 };
 
-static struct irq_chip gic_eoimode1_chip = {
-	.name			= "GICv2",
-	.irq_mask		= gic_eoimode1_mask_irq,
-	.irq_unmask		= gic_unmask_irq,
-	.irq_eoi		= gic_eoimode1_eoi_irq,
-	.irq_set_type		= gic_set_type,
-	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
-	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
-	.irq_set_vcpu_affinity	= gic_irq_set_vcpu_affinity,
-	.flags			= IRQCHIP_SET_TYPE_MASKED |
-				  IRQCHIP_SKIP_SET_WAKE |
-				  IRQCHIP_MASK_ON_SUSPEND,
-};
-
 void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
 {
 	BUG_ON(gic_nr >= CONFIG_ARM_GIC_MAX_NR);
@@ -1028,10 +1014,14 @@ static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
 	gic = &gic_data[gic_nr];
 
 	/* Initialize irq_chip */
+	gic->chip = gic_chip;
+
 	if (static_key_true(&supports_deactivate) && gic_nr == 0) {
-		gic->chip = gic_eoimode1_chip;
+		gic->chip.irq_mask = gic_eoimode1_mask_irq;
+		gic->chip.irq_eoi = gic_eoimode1_eoi_irq;
+		gic->chip.irq_set_vcpu_affinity = gic_irq_set_vcpu_affinity;
+		gic->chip.name = kasprintf(GFP_KERNEL, "GICv2");
 	} else {
-		gic->chip = gic_chip;
 		gic->chip.name = kasprintf(GFP_KERNEL, "GIC-%d", gic_nr);
 	}
 
-- 
2.1.4

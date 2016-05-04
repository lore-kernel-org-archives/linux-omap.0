From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 14/17] irqchip/gic: Add helper function for configuring a GIC via device-tree
Date: Wed, 4 May 2016 17:25:27 +0100
Message-ID: <1462379130-11742-15-git-send-email-jonathanh@nvidia.com>
References: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-omap@vger.kernel.org

Move the code that configures a GIC via device-tree into it's own
function. This will allow us to re-use this function when adding a
platform driver to support GICs that require power-management.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/irqchip/irq-gic.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index a10274926690..2fc5018d6eb9 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1194,6 +1194,28 @@ static bool gic_check_eoimode(struct device_node *node, void __iomem **base)
 	return true;
 }
 
+static int gic_of_setup(struct device_node *node, void __iomem **dist_base,
+			void __iomem **cpu_base, u32 *percpu_offset)
+{
+	if (!node || !dist_base || !cpu_base || !percpu_offset)
+		return -EINVAL;
+
+	*dist_base = of_iomap(node, 0);
+	if (WARN(!*dist_base, "unable to map gic dist registers\n"))
+		return -ENOMEM;
+
+	*cpu_base = of_iomap(node, 1);
+	if (WARN(!*cpu_base, "unable to map gic cpu registers\n")) {
+		iounmap(*dist_base);
+		return -ENOMEM;
+	}
+
+	if (of_property_read_u32(node, "cpu-offset", percpu_offset))
+		*percpu_offset = 0;
+
+	return 0;
+}
+
 int __init
 gic_of_init(struct device_node *node, struct device_node *parent)
 {
@@ -1214,15 +1236,9 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 	    of_property_read_bool(node, "power-domains"))
 		return 0;
 
-	dist_base = of_iomap(node, 0);
-	if (WARN(!dist_base, "unable to map gic dist registers\n"))
-		return -ENOMEM;
-
-	cpu_base = of_iomap(node, 1);
-	if (WARN(!cpu_base, "unable to map gic cpu registers\n")) {
-		iounmap(dist_base);
-		return -ENOMEM;
-	}
+	ret = gic_of_setup(node, &dist_base, &cpu_base, &percpu_offset);
+	if (ret)
+		return ret;
 
 	/*
 	 * Disable split EOI/Deactivate if either HYP is not available
@@ -1231,9 +1247,6 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 	if (gic_cnt == 0 && !gic_check_eoimode(node, &cpu_base))
 		static_key_slow_dec(&supports_deactivate);
 
-	if (of_property_read_u32(node, "cpu-offset", &percpu_offset))
-		percpu_offset = 0;
-
 	ret = __gic_init_bases(gic_cnt, -1, dist_base, cpu_base, percpu_offset,
 			 &node->fwnode);
 	if (ret) {
-- 
2.1.4

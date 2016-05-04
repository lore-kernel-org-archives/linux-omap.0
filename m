From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 01/17] irqchip/gic: Don't unnecessarily write the IRQ configuration
Date: Wed, 4 May 2016 17:25:14 +0100
Message-ID: <1462379130-11742-2-git-send-email-jonathanh@nvidia.com>
References: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-omap@vger.kernel.org

If the interrupt configuration matches the current configuration, then
don't bother writing the configuration again.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-common.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index f174ce0ca361..ffff5a45f1e3 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -50,13 +50,17 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 	else if (type & IRQ_TYPE_EDGE_BOTH)
 		val |= confmask;
 
+	/* If the current configuration is the same, then we are done */
+	if (val == oldval)
+		return 0;
+
 	/*
 	 * Write back the new configuration, and possibly re-enable
-	 * the interrupt. If we tried to write a new configuration and failed,
+	 * the interrupt. If we fail to write a new configuration,
 	 * return an error.
 	 */
 	writel_relaxed(val, base + GIC_DIST_CONFIG + confoff);
-	if (readl_relaxed(base + GIC_DIST_CONFIG + confoff) != val && val != oldval)
+	if (readl_relaxed(base + GIC_DIST_CONFIG + confoff) != val)
 		ret = -EINVAL;
 
 	if (sync_access)
-- 
2.1.4

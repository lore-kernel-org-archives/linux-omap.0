From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 02/17] irqchip/gic: WARN if setting the interrupt type for a PPI fails
Date: Wed, 4 May 2016 17:25:15 +0100
Message-ID: <1462379130-11742-3-git-send-email-jonathanh@nvidia.com>
References: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-omap@vger.kernel.org

Setting the interrupt type for private peripheral interrupts (PPIs) may
not be supported by a given GIC because it is IMPLEMENTATION DEFINED
whether this is allowed. There is no way to know if setting the type is
supported for a given GIC and so the value written is read back to
verify it matches the desired configuration. If it does not match then
an error is return.

There are cases where the interrupt configuration read from firmware
(such as a device-tree blob), has been incorrect and hence
gic_configure_irq() has returned an error. This error has gone
undetected because the error code returned was ignored but the interrupt
still worked fine because the configuration for the interrupt could not
be overwritten.

Given that this has done undetected and that failing to set the
configuration for a PPI may not be a catastrophic, don't return an error
but WARN if we fail to configure a PPI. This will allows us to fix up
any places in the kernel where we should be checking the return status
and maintain backward compatibility with firmware images that may have
incorrect PPI configurations.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-common.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index ffff5a45f1e3..9fa92a17225c 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -56,12 +56,15 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 
 	/*
 	 * Write back the new configuration, and possibly re-enable
-	 * the interrupt. If we fail to write a new configuration,
-	 * return an error.
+	 * the interrupt. WARN if we fail to write a new configuration
+	 * and return an error if we failed to write the configuration
+	 * for an SPI. If we fail to write the configuration for a PPI
+	 * this is most likely because the GIC does not allow us to set
+	 * the configuration and so it is not a catastrophic failure.
 	 */
 	writel_relaxed(val, base + GIC_DIST_CONFIG + confoff);
-	if (readl_relaxed(base + GIC_DIST_CONFIG + confoff) != val)
-		ret = -EINVAL;
+	if (WARN_ON(readl_relaxed(base + GIC_DIST_CONFIG + confoff) != val))
+		ret = irq < 32 ? 0 : -EINVAL;
 
 	if (sync_access)
 		sync_access();
-- 
2.1.4

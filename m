From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 13/17] irqchip/gic: Don't allow early initialisation if GIC requires RPM
Date: Wed, 4 May 2016 17:25:26 +0100
Message-ID: <1462379130-11742-14-git-send-email-jonathanh@nvidia.com>
References: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-omap@vger.kernel.org

Commit afbbd2338176 ("irqchip/gic: Document optional Clock and Power
Domain properties") updated the device-tree binding documentation for
the GIC to add optional clock and power domain information. Currently,
the GIC driver does support these optional properties and there do not
appear to be any GIC instances that define these.

To support GICs that require runtime power management and hence, define
the clock and/or power-domain properties, a platform driver for GICs
using power management will be added. However, this presents a problem
because by adding a platform driver in addition to the current GIC
driver, we will have two places where we can match the GIC compatibility
string to initialise the GIC and these are:
 1. By the IRQCHIP_DECLARE macro for early initialisation of GICs.
 2. By the platform driver's device-tree match table.

To prevent a GIC which requires power management from being initialised
early (by matching the compatibility string specified by
IRQCHIP_DECLARE), during early inialisation, if we detect the GIC has
either the 'clocks' or 'power-domains' property present bail out of the
early initialisation and allow the platform driver to initialise the
device.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/irqchip/irq-gic.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 30666f349649..a10274926690 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1205,6 +1205,15 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 	if (WARN_ON(!node))
 		return -ENODEV;
 
+	/*
+	 * If the GIC device has either a 'clocks' node or a 'power-domains'
+	 * node populated, then bail out now because this driver is currently
+	 * unable to support devices which require power management.
+	 */
+	if (of_property_read_bool(node, "clocks") ||
+	    of_property_read_bool(node, "power-domains"))
+		return 0;
+
 	dist_base = of_iomap(node, 0);
 	if (WARN(!dist_base, "unable to map gic dist registers\n"))
 		return -ENOMEM;
-- 
2.1.4

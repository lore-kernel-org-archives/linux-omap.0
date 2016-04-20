From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 08/14] irqchip/gic: Don't initialise chip if mapping IO space fails
Date: Wed, 20 Apr 2016 12:03:51 +0100
Message-ID: <1461150237-15580-9-git-send-email-jonathanh@nvidia.com>
References: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-omap@vger.kernel.org

If we fail to map the address space for the GIC distributor or CPU
interface, then don't attempt to initialise the chip, just WARN and
return.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 282344b95ec2..48ed3cd215df 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1201,10 +1201,14 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 		return -ENODEV;
 
 	dist_base = of_iomap(node, 0);
-	WARN(!dist_base, "unable to map gic dist registers\n");
+	if (WARN(!dist_base, "unable to map gic dist registers\n"))
+		return -ENOMEM;
 
 	cpu_base = of_iomap(node, 1);
-	WARN(!cpu_base, "unable to map gic cpu registers\n");
+	if (WARN(!cpu_base, "unable to map gic cpu registers\n")) {
+		iounmap(dist_base);
+		return -ENOMEM;
+	}
 
 	/*
 	 * Disable split EOI/Deactivate if either HYP is not available
-- 
2.1.4

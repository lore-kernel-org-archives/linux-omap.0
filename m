From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 05/14] genirq: Look-up trigger type if not specified by caller
Date: Wed, 20 Apr 2016 12:03:48 +0100
Message-ID: <1461150237-15580-6-git-send-email-jonathanh@nvidia.com>
References: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-omap@vger.kernel.org

For some devices the IRQ trigger type for a device is read from
firmware, such as device-tree. The IRQ trigger type is typically read
when the mapping for IRQ is created, which is before the IRQ is
requested. Hence, the IRQ trigger type is programmed when mapping the
IRQ and not when requesting the IRQ.

Although this works for most cases, in order to support IRQ chips which
require runtime power management, which may not be accessible prior
to requesting the IRQ, it is desirable to look-up the IRQ trigger type
when it is requested. Therefore, if the IRQ trigger type is not
specified when __setup_irq() is called, look-up the saved IRQ trigger
type. This will allow us to defer the programming of the trigger type
from when the IRQ is mapped to when it is actually requested.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 kernel/irq/manage.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index cc1cc641d653..b2a93a37f772 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1117,6 +1117,13 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	new->irq = irq;
 
 	/*
+	 * If the trigger type is not specified by the caller,
+	 * then use the default for this interrupt.
+	 */
+	if (!(new->flags & IRQF_TRIGGER_MASK))
+		new->flags |= irqd_get_trigger_type(&desc->irq_data);
+
+	/*
 	 * Check whether the interrupt nests into another interrupt
 	 * thread.
 	 */
-- 
2.1.4

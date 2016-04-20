From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 03/14] irqchip: Mask the non-type/sense bits when translating an IRQ
Date: Wed, 20 Apr 2016 12:03:46 +0100
Message-ID: <1461150237-15580-4-git-send-email-jonathanh@nvidia.com>
References: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-omap@vger.kernel.org

The firmware parameter that contains the IRQ sense bits may also contain
other data. When return the IRQ type, bits outside of these sense bits
should be masked. If these bits are not masked and
irq_create_fwspec_mapping() is called to map an IRQ, then the comparison
of the type returned from irq_domain_translate() will never match
that returned by irq_get_trigger_type() (because this function masks the
none sense bits) and so we will always call irq_set_irq_type() to program
the type even if it was not really necessary.

Currently, the downside to this is unnecessarily re-programmming the type
but nevertheless this should be avoided.

The Tegra LIC and TI Crossbar irqchips all have client instances (from
reviewing the device-tree sources) where bits outside the IRQ sense bits
are set, but do not mask these bits. Therefore, ensure these bits are
masked for these irqchips.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/irqchip/irq-crossbar.c | 2 +-
 drivers/irqchip/irq-tegra.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 75573fa431ba..1eef56a89b1f 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -183,7 +183,7 @@ static int crossbar_domain_translate(struct irq_domain *d,
 			return -EINVAL;
 
 		*hwirq = fwspec->param[1];
-		*type = fwspec->param[2];
+		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
 		return 0;
 	}
 
diff --git a/drivers/irqchip/irq-tegra.c b/drivers/irqchip/irq-tegra.c
index 50be9639e27e..e902f081e16c 100644
--- a/drivers/irqchip/irq-tegra.c
+++ b/drivers/irqchip/irq-tegra.c
@@ -235,7 +235,7 @@ static int tegra_ictlr_domain_translate(struct irq_domain *d,
 			return -EINVAL;
 
 		*hwirq = fwspec->param[1];
-		*type = fwspec->param[2];
+		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
 		return 0;
 	}
 
-- 
2.1.4

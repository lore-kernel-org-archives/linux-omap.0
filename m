From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH] irqchip: irq-omap-intc: Do not statically initialize
 variables
Date: Mon, 16 Oct 2017 18:13:03 +0200
Message-ID: <20171016161303.veumgcd3xom5c54r@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

omap_nr_pending and omap_nr_irqs variables are initialized
right at the beginning of intc_of_init function, so there's
no need to statically initialize them.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/irqchip/irq-omap-intc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index 05f7f06dd711..d360a6eddd6d 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -66,8 +66,8 @@ static struct omap_intc_regs intc_context;
 
 static struct irq_domain *domain;
 static void __iomem *omap_irq_base;
-static int omap_nr_pending = 3;
-static int omap_nr_irqs = 96;
+static int omap_nr_pending;
+static int omap_nr_irqs;
 
 static void intc_writel(u32 reg, u32 val)
 {

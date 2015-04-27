From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH] ARM: OMAP: Constify irq_domain_ops
Date: Mon, 27 Apr 2015 21:49:44 +0900
Message-ID: <1430138984-3523-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: linux-omap@vger.kernel.org

The irq_domain_ops are not modified by the driver and the irqdomain core
code accepts pointer to a const data.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/mach-omap2/omap-wakeupgen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 3b56722dfd8a..8e52621b5a6b 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -444,7 +444,7 @@ static int wakeupgen_domain_alloc(struct irq_domain *domain,
 	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_args);
 }
 
-static struct irq_domain_ops wakeupgen_domain_ops = {
+static const struct irq_domain_ops wakeupgen_domain_ops = {
 	.xlate	= wakeupgen_domain_xlate,
 	.alloc	= wakeupgen_domain_alloc,
 	.free	= irq_domain_free_irqs_common,
-- 
2.1.0

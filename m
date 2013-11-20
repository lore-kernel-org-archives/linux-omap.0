From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 04/31] arm: omap: irq: add a global omap_nr_irqs variable
Date: Wed, 20 Nov 2013 12:08:51 -0600
Message-ID: <1384970958-4118-5-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52564 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754593Ab3KTSKL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Nov 2013 13:10:11 -0500
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

this will cache number of irqs. Also in preparation
for removal of irq_banks array.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 18637e9..f6d0d38 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -70,6 +70,7 @@ static struct omap_irq_bank {
 
 static struct irq_domain *domain;
 static void __iomem *omap_irq_base;
+static int omap_nr_irqs = 96;
 
 /* Structure to save interrupt controller context */
 struct omap3_intc_regs {
@@ -170,6 +171,8 @@ static void __init omap_init_irq(u32 base, int nr_irqs,
 	if (WARN_ON(!omap_irq_base))
 		return;
 
+	omap_nr_irqs = nr_irqs;
+
 	irq_base = irq_alloc_descs(-1, 0, nr_irqs, 0);
 	if (irq_base < 0) {
 		pr_warn("Couldn't allocate IRQ numbers\n");
-- 
1.8.4.GIT


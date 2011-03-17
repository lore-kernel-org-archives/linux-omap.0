From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 2/3] ARM: OMAP2+: GPMC set dummy irq chip
Date: Thu, 17 Mar 2011 21:30:05 +0530
Message-ID: <1300377606-16616-3-git-send-email-balajitk@ti.com>
References: <1300377606-16616-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50582 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754736Ab1CQP4s (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 11:56:48 -0400
In-Reply-To: <1300377606-16616-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Balaji T K <balajitk@ti.com>

Resolve following warning messages in boot when irq chip is not set
[    0.429229] Trying to install interrupt handler for IRQ402
[    0.429229] Trying to install interrupt handler for IRQ403
[    0.429229] Trying to install interrupt handler for IRQ404
[    0.429260] Trying to install interrupt handler for IRQ405
[    0.429260] Trying to install interrupt handler for IRQ406
[    0.429260] Trying to install interrupt handler for IRQ407
[    0.429290] Trying to install interrupt handler for IRQ408

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 6741743..d81d536 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -739,7 +739,8 @@ static int __init gpmc_init(void)
 	/* initalize the irq_chained */
 	irq = OMAP_GPMC_IRQ_BASE;
 	for (cs = 0; cs < GPMC_CS_NUM; cs++) {
-		set_irq_handler(irq, handle_simple_irq);
+		set_irq_chip_and_handler(irq, &dummy_irq_chip,
+						handle_simple_irq);
 		set_irq_flags(irq, IRQF_VALID);
 		irq++;
 	}
-- 
1.7.0.4


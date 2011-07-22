From: Tapani Utriainen <tapani@technexion.com>
Subject: [PATCH] OMAP: irq: loop counter fix in omap_init_irq()
Date: Fri, 22 Jul 2011 11:58:10 +0800
Message-ID: <20110722115810.34f963ad@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from technexion.com ([72.51.46.185]:36195 "EHLO technexion.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750695Ab1GVEDe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jul 2011 00:03:34 -0400
Received: from myhost (114-32-98-169.HINET-IP.hinet.net [114.32.98.169])
	by technexion.com (Postfix) with ESMTPA id EA0308780E1
	for <linux-omap@vger.kernel.org>; Fri, 22 Jul 2011 11:53:59 +0800 (CST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tapani Utriainen <tapani@technexion.com>

Fixes bug where variable i was redundantly used for counting two nested loops.

Signed-off-by: Tapani Utriainen <tapani@technexion.com>
--- 
 irq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -165,8 +165,8 @@ static void __init omap_init_irq(u32 base, int nr_irqs)
 
 		omap_irq_bank_init_one(bank);
 
-		for (i = 0, j = 0; i < bank->nr_irqs; i += 32, j += 0x20)
-			omap_alloc_gc(bank->base_reg + j, i, 32);
+		for (j = 0; j < bank->nr_irqs; j += 32)
+			omap_alloc_gc(bank->base_reg + j, j, 32);
 
 		nr_of_irqs += bank->nr_irqs;
 		nr_banks++;

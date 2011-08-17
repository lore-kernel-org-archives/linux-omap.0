From: Tapani <tapani@technexion.com>
Subject: [PATCH] OMAP: irq: fix bug with a reused loop counter
Date: Wed, 17 Aug 2011 15:37:21 +0800
Message-ID: <20110817153721.2f950585@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from technexion.com ([72.51.46.185]:49772 "EHLO technexion.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187Ab1HQHgF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Aug 2011 03:36:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org


Bugfix: Two nested for-loops were both using "i" as loop counter.

Signed-off-by: Tapani Utriainen <tapani@technexion.com>
---
 arch/arm/mach-omap2/irq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -165,8 +165,8 @@
 
 		omap_irq_bank_init_one(bank);
 
-		for (i = 0, j = 0; i < bank->nr_irqs; i += 32, j += 0x20)
-			omap_alloc_gc(bank->base_reg + j, i, 32);
+		for (j = 0; j < bank->nr_irqs; j += 32)
+			omap_alloc_gc(bank->base_reg + j, j, 32);
 
 		nr_of_irqs += bank->nr_irqs;
 		nr_banks++;
---

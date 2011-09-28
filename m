From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] ARM: OMAP: irq: loop counter fix in omap_init_irq()
Date: Wed, 28 Sep 2011 14:48:23 -0700
Message-ID: <20110928214823.29263.53645.stgit@kaulin.local>
References: <20110928214707.29263.58095.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:29954 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab1I1VsY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Sep 2011 17:48:24 -0400
In-Reply-To: <20110928214707.29263.58095.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Tapani Utriainen <tapani@technexion.com>

From: Tapani Utriainen <tapani@technexion.com>

Fixes bug where variable i was redundantly used for counting two nested loops.

Signed-off-by: Tapani Utriainen <tapani@technexion.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/irq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 3a12f75..65f1be6 100644
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


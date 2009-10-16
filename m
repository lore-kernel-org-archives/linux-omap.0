From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/14] omap: Use ioremap in irq.c
Date: Fri, 16 Oct 2009 16:40:30 -0700
Message-ID: <20091016234030.2463.74004.stgit@localhost>
References: <20091016233624.2463.26653.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49982 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbZJPXk1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 19:40:27 -0400
In-Reply-To: <20091016233624.2463.26653.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Use ioremap in irq.c

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/irq.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index b828638..1db121f 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -178,12 +178,20 @@ void __init omap_init_irq(void)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(irq_banks); i++) {
+		unsigned long base;
 		struct omap_irq_bank *bank = irq_banks + i;
 
 		if (cpu_is_omap24xx())
-			bank->base_reg = OMAP2_IO_ADDRESS(OMAP24XX_IC_BASE);
+			base = OMAP24XX_IC_BASE;
 		else if (cpu_is_omap34xx())
-			bank->base_reg = OMAP2_IO_ADDRESS(OMAP34XX_IC_BASE);
+			base = OMAP34XX_IC_BASE;
+
+		/* Static mapping, never released */
+		bank->base_reg = ioremap(base, SZ_4K);
+		if (!bank->base_reg) {
+			printk(KERN_ERR "Could not ioremap irq bank%i\n", i);
+			continue;
+		}
 
 		omap_irq_bank_init_one(bank);
 


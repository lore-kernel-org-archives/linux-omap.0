From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 13/59] omap: namespace cleanup to arch/arm/mach-omap1/irq.c
Date: Wed, 12 Nov 2008 00:56:32 +0200
Message-ID: <1226444238-14614-14-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
 <1226444238-14614-4-git-send-email-me@felipebalbi.com>
 <1226444238-14614-5-git-send-email-me@felipebalbi.com>
 <1226444238-14614-6-git-send-email-me@felipebalbi.com>
 <1226444238-14614-7-git-send-email-me@felipebalbi.com>
 <1226444238-14614-8-git-send-email-me@felipebalbi.com>
 <1226444238-14614-9-git-send-email-me@felipebalbi.com>
 <1226444238-14614-10-git-send-email-me@felipebalbi.com>
 <1226444238-14614-11-git-send-email-me@felipebalbi.com>
 <1226444238-14614-12-git-send-email-me@felipebalbi.com>
 <1226444238-14614-13-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40001 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbYKKXBB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:01:01 -0500
In-Reply-To: <1226444238-14614-13-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap1/irq.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
index 9ad5197..a606d76 100644
--- a/arch/arm/mach-omap1/irq.c
+++ b/arch/arm/mach-omap1/irq.c
@@ -62,20 +62,20 @@ static struct omap_irq_bank *irq_banks;
 
 static inline unsigned int irq_bank_readl(int bank, int offset)
 {
-	return omap_readl(irq_banks[bank].base_reg + offset);
+	return __raw_readl(irq_banks[bank].base_reg + offset);
 }
 
 static inline void irq_bank_writel(unsigned long value, int bank, int offset)
 {
-	omap_writel(value, irq_banks[bank].base_reg + offset);
+	__raw_writel(value, irq_banks[bank].base_reg + offset);
 }
 
 static void omap_ack_irq(unsigned int irq)
 {
 	if (irq > 31)
-		omap_writel(0x1, OMAP_IH2_BASE + IRQ_CONTROL_REG_OFFSET);
+		__raw_writel(0x1, OMAP_IH2_BASE + IRQ_CONTROL_REG_OFFSET);
 
-	omap_writel(0x1, OMAP_IH1_BASE + IRQ_CONTROL_REG_OFFSET);
+	__raw_writel(0x1, OMAP_IH1_BASE + IRQ_CONTROL_REG_OFFSET);
 }
 
 static void omap_mask_irq(unsigned int irq)
@@ -83,9 +83,9 @@ static void omap_mask_irq(unsigned int irq)
 	int bank = IRQ_BANK(irq);
 	u32 l;
 
-	l = omap_readl(irq_banks[bank].base_reg + IRQ_MIR_REG_OFFSET);
+	l = __raw_readl(irq_banks[bank].base_reg + IRQ_MIR_REG_OFFSET);
 	l |= 1 << IRQ_BIT(irq);
-	omap_writel(l, irq_banks[bank].base_reg + IRQ_MIR_REG_OFFSET);
+	__raw_writel(l, irq_banks[bank].base_reg + IRQ_MIR_REG_OFFSET);
 }
 
 static void omap_unmask_irq(unsigned int irq)
@@ -93,9 +93,9 @@ static void omap_unmask_irq(unsigned int irq)
 	int bank = IRQ_BANK(irq);
 	u32 l;
 
-	l = omap_readl(irq_banks[bank].base_reg + IRQ_MIR_REG_OFFSET);
+	l = __raw_readl(irq_banks[bank].base_reg + IRQ_MIR_REG_OFFSET);
 	l &= ~(1 << IRQ_BIT(irq));
-	omap_writel(l, irq_banks[bank].base_reg + IRQ_MIR_REG_OFFSET);
+	__raw_writel(l, irq_banks[bank].base_reg + IRQ_MIR_REG_OFFSET);
 }
 
 static void omap_mask_ack_irq(unsigned int irq)
-- 
1.6.0.2.307.gc427


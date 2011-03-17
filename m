From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 3/3] ARM: OMAP4: correct GPMC IRQ number
Date: Thu, 17 Mar 2011 21:30:06 +0530
Message-ID: <1300377606-16616-4-git-send-email-balajitk@ti.com>
References: <1300377606-16616-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39542 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754774Ab1CQP4s (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 11:56:48 -0400
In-Reply-To: <1300377606-16616-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Balaji T K <balajitk@ti.com>

OMAP4 GPMC IRQ is not same as OMAP3 IRQ. Fix it.

Resolve following warning in OMAP4
[    0.429290] gpmc: irq-20 could not claim: err -22

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index d81d536..493505c 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -693,6 +693,7 @@ static int __init gpmc_init(void)
 {
 	u32 l, irq;
 	int cs, ret = -EINVAL;
+	int gpmc_irq;
 	char *ck = NULL;
 
 	if (cpu_is_omap24xx()) {
@@ -701,12 +702,15 @@ static int __init gpmc_init(void)
 			l = OMAP2420_GPMC_BASE;
 		else
 			l = OMAP34XX_GPMC_BASE;
+		gpmc_irq = INT_34XX_GPMC_IRQ;
 	} else if (cpu_is_omap34xx()) {
 		ck = "gpmc_fck";
 		l = OMAP34XX_GPMC_BASE;
+		gpmc_irq = INT_34XX_GPMC_IRQ;
 	} else if (cpu_is_omap44xx()) {
 		ck = "gpmc_ck";
 		l = OMAP44XX_GPMC_BASE;
+		gpmc_irq = OMAP44XX_IRQ_GPMC;
 	}
 
 	if (WARN_ON(!ck))
@@ -745,11 +749,11 @@ static int __init gpmc_init(void)
 		irq++;
 	}
 
-	ret = request_irq(INT_34XX_GPMC_IRQ,
+	ret = request_irq(gpmc_irq,
 			gpmc_handle_irq, IRQF_SHARED, "gpmc", gpmc_base);
 	if (ret)
 		pr_err("gpmc: irq-%d could not claim: err %d\n",
-						INT_34XX_GPMC_IRQ, ret);
+						gpmc_irq, ret);
 	return ret;
 }
 postcore_initcall(gpmc_init);
@@ -758,8 +762,6 @@ static irqreturn_t gpmc_handle_irq(int irq, void *dev)
 {
 	u8 cs;
 
-	if (irq != INT_34XX_GPMC_IRQ)
-		return IRQ_HANDLED;
 	/* check cs to invoke the irq */
 	cs = ((gpmc_read_reg(GPMC_PREFETCH_CONFIG1)) >> CS_NUM_SHIFT) & 0x7;
 	if (OMAP_GPMC_IRQ_BASE+cs <= OMAP_GPMC_IRQ_END)
-- 
1.7.0.4


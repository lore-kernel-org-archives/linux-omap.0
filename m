From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 06/12] mfd: twl4030-irq: micro-optimization on IRQ handler
Date: Fri, 2 Mar 2012 17:50:18 +0100
Message-ID: <1330707024-23730-7-git-send-email-b-cousson@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59596 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758877Ab2CBQvd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Mar 2012 11:51:33 -0500
In-Reply-To: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sameo@linux.intel.com, tony@atomide.com, grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>

From: Felipe Balbi <balbi@ti.com>

__ffs() will be far faster than the for loop used.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/mfd/twl4030-irq.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index faf3318..e6dc8f9 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -293,7 +293,6 @@ static unsigned twl4030_irq_base;
  */
 static irqreturn_t handle_twl4030_pih(int irq, void *devid)
 {
-	int		module_irq;
 	irqreturn_t	ret;
 	u8		pih_isr;
 
@@ -304,12 +303,13 @@ static irqreturn_t handle_twl4030_pih(int irq, void *devid)
 		return IRQ_NONE;
 	}
 
-	/* these handlers deal with the relevant SIH irq status */
-	for (module_irq = twl4030_irq_base;
-			pih_isr;
-			pih_isr >>= 1, module_irq++) {
-		if (pih_isr & 0x1)
-			handle_nested_irq(module_irq);
+	while (pih_isr) {
+		unsigned long	pending = __ffs(pih_isr);
+		unsigned int	irq;
+
+		pih_isr &= ~BIT(pending);
+		irq = pending + twl4030_irq_base;
+		handle_nested_irq(irq);
 	}
 
 	return IRQ_HANDLED;
-- 
1.7.0.4


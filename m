From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 3/5] OMAP3: l3: minor cleanup for error message, parenthesis and extra lines
Date: Tue, 29 Mar 2011 11:20:17 -0600
Message-ID: <1301419219-30547-4-git-send-email-omar.ramirez@ti.com>
References: <1301419219-30547-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39661 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753694Ab1C2Rbu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Mar 2011 13:31:50 -0400
In-Reply-To: <1301419219-30547-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, l-o <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, sricharan <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, Benoit Cousson <b-cousson@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Removing extra lines and unneeded parenthesis.

While at it collapsing an if statement to detect the type of error
based on the irq received; also fixing the message printed on error.

So now: 				looks like:
"No Error Error seen..."		"No Error seen..."
"In-Band Error Error seen..."	"In-Band Error seen..."

Other messages are self explanatory, no "Error" added to them.
(E.g.: "Address Hole seen...")

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/omap_l3_smx.c |   19 +++++--------------
 1 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_l3_smx.c b/arch/arm/mach-omap2/omap_l3_smx.c
index 32961b1..873c0e3 100644
--- a/arch/arm/mach-omap2/omap_l3_smx.c
+++ b/arch/arm/mach-omap2/omap_l3_smx.c
@@ -155,7 +155,7 @@ static irqreturn_t omap3_l3_block_irq(struct omap3_l3 *l3,
 	u8                      multi = error & L3_ERROR_LOG_MULTI;
 	u32			address = omap3_l3_decode_addr(error_addr);
 
-	WARN(true, "%s Error seen by %s %s at address %x\n",
+	WARN(true, "%s seen by %s %s at address %x\n",
 				 omap3_l3_code_string(code),
 			  omap3_l3_initiator_string(initid),
 			     multi ? "Multiple Errors" : "",
@@ -167,21 +167,15 @@ static irqreturn_t omap3_l3_block_irq(struct omap3_l3 *l3,
 static irqreturn_t omap3_l3_app_irq(int irq, void *_l3)
 {
 	struct omap3_l3         *l3 = _l3;
-
 	u64                     status, clear;
 	u64                     error;
 	u64			error_addr;
 	u64			err_source = 0;
 	void			__iomem *base;
 	int			int_type;
-
 	irqreturn_t             ret = IRQ_NONE;
 
-	if (irq == l3->app_irq)
-		int_type = L3_APPLICATION_ERROR;
-	else
-		int_type = L3_DEBUG_ERROR;
-
+	int_type = irq == l3->app_irq ? L3_APPLICATION_ERROR : L3_DEBUG_ERROR;
 	if (!int_type) {
 		status = omap3_l3_readll(l3->rt, L3_SI_FLAG_STATUS_0);
 		/*
@@ -202,7 +196,6 @@ static irqreturn_t omap3_l3_app_irq(int irq, void *_l3)
 
 	base = l3->rt + *(omap3_l3_bases[int_type] + err_source);
 	error = omap3_l3_readll(base, L3_ERROR_LOG);
-
 	if (error) {
 		error_addr = omap3_l3_readll(base, L3_ERROR_LOG_ADDR);
 
@@ -210,9 +203,8 @@ static irqreturn_t omap3_l3_app_irq(int irq, void *_l3)
 	}
 
 	/* Clear the status register */
-	clear = ((L3_AGENT_STATUS_CLEAR_IA << int_type) |
-		 (L3_AGENT_STATUS_CLEAR_TA));
-
+	clear = (L3_AGENT_STATUS_CLEAR_IA << int_type) |
+		L3_AGENT_STATUS_CLEAR_TA;
 	omap3_l3_writell(base, L3_AGENT_STATUS, clear);
 
 	/* clear the error log register */
@@ -240,7 +232,7 @@ static int __init omap3_l3_probe(struct platform_device *pdev)
 		goto err0;
 	}
 	l3->rt = ioremap(res->start, resource_size(res));
-	if (!(l3->rt)) {
+	if (!l3->rt) {
 		dev_err(&pdev->dev, "ioremap failed\n");
 		ret = -ENOMEM;
 		goto err0;
@@ -259,7 +251,6 @@ static int __init omap3_l3_probe(struct platform_device *pdev)
 	ret = request_irq(l3->app_irq, omap3_l3_app_irq,
 		IRQF_DISABLED | IRQF_TRIGGER_RISING,
 		"l3-app-irq", l3);
-
 	if (ret) {
 		dev_err(&pdev->dev, "couldn't request app irq\n");
 		goto err2;
-- 
1.7.1


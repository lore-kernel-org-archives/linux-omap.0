From: ext-eero.nurkkala@nokia.com
Subject: [PATCH 2/2] OMAP: McBSP: Do not enable or disable clocks on failed path
Date: Mon,  9 Mar 2009 09:05:12 +0200
Message-ID: <1236582316453-git-send-email-ext-eero.nurkkala@nokia.com>
References: <12365823123402-git-send-email-ext-eero.nurkkala@nokia.com>
 <12365823142066-git-send-email-ext-eero.nurkkala@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23315 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897AbZCIHIo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2009 03:08:44 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n2978Tne032037
	for <linux-omap@vger.kernel.org>; Mon, 9 Mar 2009 09:08:40 +0200
In-Reply-To: <12365823142066-git-send-email-ext-eero.nurkkala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

McBSP clocks are being double enabled in the event the
McBSP is already active. Also, they are unnecessarily
disabled when there's no active McBSP in use. Fix this
phenomenom by enabling and disabling the clocks at a
proper location.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 arch/arm/plat-omap/mcbsp.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 59850c2..e7755b9 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -226,9 +226,6 @@ int omap_mcbsp_request(unsigned int id)
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->request)
 		mcbsp->pdata->ops->request(id);
 
-	for (i = 0; i < mcbsp->num_clks; i++)
-		clk_enable(mcbsp->clks[i]);
-
 	spin_lock(&mcbsp->lock);
 	if (!mcbsp->free) {
 		dev_err(mcbsp->dev, "McBSP%d is currently in use\n",
@@ -240,6 +237,9 @@ int omap_mcbsp_request(unsigned int id)
 	mcbsp->free = 0;
 	spin_unlock(&mcbsp->lock);
 
+	for (i = 0; i < mcbsp->num_clks; i++)
+		clk_enable(mcbsp->clks[i]);
+
 	/*
 	 * Enable wakup behavior, smart idle and all wakeups
 	 * REVISIT: some wakeups may be unnecessary
@@ -319,9 +319,6 @@ void omap_mcbsp_free(unsigned int id)
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
 		mcbsp->pdata->ops->free(id);
 
-	for (i = mcbsp->num_clks - 1; i >= 0; i--)
-		clk_disable(mcbsp->clks[i]);
-
 	spin_lock(&mcbsp->lock);
 	if (mcbsp->free) {
 		dev_err(mcbsp->dev, "McBSP%d was not reserved\n",
@@ -333,6 +330,9 @@ void omap_mcbsp_free(unsigned int id)
 	mcbsp->free = 1;
 	spin_unlock(&mcbsp->lock);
 
+	for (i = mcbsp->num_clks - 1; i >= 0; i--)
+		clk_disable(mcbsp->clks[i]);
+
 	if (mcbsp->io_type == OMAP_MCBSP_IRQ_IO) {
 		/* Free IRQs */
 		free_irq(mcbsp->rx_irq, (void *)mcbsp);
-- 
1.5.2


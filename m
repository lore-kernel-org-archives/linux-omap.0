From: ext-eero.nurkkala@nokia.com
Subject: [PATCHv2] OMAP: McBSP: Do not enable or disable clocks on failed path
Date: Wed, 18 Mar 2009 13:41:25 +0200
Message-ID: <1237376485324-git-send-email-ext-eero.nurkkala@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:54914 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbZCRLpp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2009 07:45:45 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n2IBjPpd014508
	for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2009 06:45:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

McBSP clocks are being double enabled in the event the
McBSP is already active. Also, they are unnecessarily
disabled when there's no active McBSP in use. Fix this
phenomenom by enabling and disabling the clocks at the
proper location.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 arch/arm/plat-omap/mcbsp.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 02b3f2d..e2e8b76 100644
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
@@ -329,7 +326,12 @@ void omap_mcbsp_free(unsigned int id)
 		spin_unlock(&mcbsp->lock);
 		return;
 	}
+	spin_unlock(&mcbsp->lock);
 
+	for (i = mcbsp->num_clks - 1; i >= 0; i--)
+		clk_disable(mcbsp->clks[i]);
+
+	spin_lock(&mcbsp->lock);
 	mcbsp->free = 1;
 	spin_unlock(&mcbsp->lock);
 
-- 
1.5.2


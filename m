From: shubhrajyoti@ti.com
Subject: [PATCH ] McBSP:Make the free variable update more readable
Date: Wed,  3 Nov 2010 15:28:57 +0530
Message-ID: <1288778337-18815-1-git-send-email-shubhrajyoti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54056 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751840Ab0KCJ7D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Nov 2010 05:59:03 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id oA39wxXl010155
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 3 Nov 2010 04:59:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>

From: Shubhrajyoti D <shubhrajyoti@ti.com>

Using true/false instead of 1/0 to update the free variable.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/plat-omap/mcbsp.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index eac4b97..07c0525 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -755,7 +755,7 @@ int omap_mcbsp_request(unsigned int id)
 		goto err_kfree;
 	}
 
-	mcbsp->free = 0;
+	mcbsp->free = false;
 	mcbsp->reg_cache = reg_cache;
 	spin_unlock(&mcbsp->lock);
 
@@ -815,7 +815,7 @@ err_clk_disable:
 	clk_disable(mcbsp->iclk);
 
 	spin_lock(&mcbsp->lock);
-	mcbsp->free = 1;
+	mcbsp->free = true;
 	mcbsp->reg_cache = NULL;
 err_kfree:
 	spin_unlock(&mcbsp->lock);
@@ -858,7 +858,7 @@ void omap_mcbsp_free(unsigned int id)
 	if (mcbsp->free)
 		dev_err(mcbsp->dev, "McBSP%d was not reserved\n", mcbsp->id);
 	else
-		mcbsp->free = 1;
+		mcbsp->free = true;
 	mcbsp->reg_cache = NULL;
 	spin_unlock(&mcbsp->lock);
 
@@ -1771,7 +1771,7 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 
 	spin_lock_init(&mcbsp->lock);
 	mcbsp->id = id + 1;
-	mcbsp->free = 1;
+	mcbsp->free = true;
 	mcbsp->dma_tx_lch = -1;
 	mcbsp->dma_rx_lch = -1;
 
-- 
1.7.0.4


From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] OMAPDSS: pll: NULL dereference in error handling
Date: Wed, 17 Dec 2014 02:54:42 +0300
Message-ID: <20141216235442.GE31467@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:36908 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbaLPXy6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2014 18:54:58 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org

The regulator_disable() doesn't accept NULL pointers.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/fbdev/omap2/dss/pll.c b/drivers/video/fbdev/omap2/dss/pll.c
index 50bc62c5..335ffac 100644
--- a/drivers/video/fbdev/omap2/dss/pll.c
+++ b/drivers/video/fbdev/omap2/dss/pll.c
@@ -97,7 +97,8 @@ int dss_pll_enable(struct dss_pll *pll)
 	return 0;
 
 err_enable:
-	regulator_disable(pll->regulator);
+	if (pll->regulator)
+		regulator_disable(pll->regulator);
 err_reg:
 	clk_disable_unprepare(pll->clkin);
 	return r;

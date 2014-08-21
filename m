From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v4 2/7] net: cpsw: Add missing return value
Date: Thu, 21 Aug 2014 07:51:49 +0200
Message-ID: <1408600314-19824-3-git-send-email-mpa@pengutronix.de>
References: <1408600314-19824-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51577 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbaHUFyC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2014 01:54:02 -0400
In-Reply-To: <1408600314-19824-1-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Rostedt <rostedt@goodmis.org>, Mugunthan V N <mugunthanvnm@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

ret is set 0 at this point, so jumping to that error label would result
in a return value of 0. Set ret to -ENOMEM to return a proper error
value.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Reviewed-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/net/ethernet/ti/cpsw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 999fb72688d2..f09b4639ad31 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -2063,6 +2063,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	priv->irq_enabled = true;
 	if (!priv->cpts) {
 		dev_err(&pdev->dev, "error allocating cpts\n");
+		ret = -ENOMEM;
 		goto clean_ndev_ret;
 	}
 
-- 
2.1.0.rc1


From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v4 4/7] net: cpsw: Replace pr_err by dev_err
Date: Thu, 21 Aug 2014 07:51:51 +0200
Message-ID: <1408600314-19824-5-git-send-email-mpa@pengutronix.de>
References: <1408600314-19824-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51528 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbaHUFxs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2014 01:53:48 -0400
In-Reply-To: <1408600314-19824-1-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Rostedt <rostedt@goodmis.org>, Mugunthan V N <mugunthanvnm@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

Use dev_err instead of pr_err.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Reviewed-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/net/ethernet/ti/cpsw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index f09b4639ad31..0bc2c2a2c236 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1921,7 +1921,7 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
 		mdio = of_find_device_by_node(mdio_node);
 		of_node_put(mdio_node);
 		if (!mdio) {
-			pr_err("Missing mdio platform device\n");
+			dev_err(&pdev->dev, "Missing mdio platform device\n");
 			return -EINVAL;
 		}
 		snprintf(slave_data->phy_id, sizeof(slave_data->phy_id),
-- 
2.1.0.rc1


From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/6] net: davinci_emac: Free clock after checking the frequency
Date: Thu, 15 Jan 2015 14:45:11 -0800
Message-ID: <1421361914-4612-4-git-send-email-tony@atomide.com>
References: <1421361914-4612-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33046 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932223AbbAOWtE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2015 17:49:04 -0500
In-Reply-To: <1421361914-4612-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, Felipe Balbi <balbi@ti.com>

We only use clk_get() to get the frequency, the rest is done by
the runtime PM calls. Let's free the clock too.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/net/ethernet/ti/davinci_emac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 5df339e..59fdcdd 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1894,6 +1894,7 @@ static int davinci_emac_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 	emac_bus_frequency = clk_get_rate(emac_clk);
+	devm_clk_put(&pdev->dev, emac_clk);
 
 	/* TODO: Probe PHY here if possible */
 
-- 
2.1.4


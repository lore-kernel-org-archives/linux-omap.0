From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [net PATCH 1/1] drivers: net: ethernet: ti: davinci_emac: fix usage of cpdma_check_free_tx_desc()
Date: Fri, 15 Mar 2013 19:40:16 +0530
Message-ID: <1363356616-32480-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53416 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753551Ab3COOLo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Mar 2013 10:11:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-omap@vger.kernel.org, Mugunthan V N <mugunthanvnm@ti.com>

Fix which was done in the following commit in cpsw driver has
to be taken forward to davinci emac driver as well.

commit d35162f89b8f00537d7b240b76d2d0e8b8d29aa0
Author: Daniel Mack <zonque@gmail.com>
Date:   Tue Mar 12 06:31:19 2013 +0000

    net: ethernet: cpsw: fix usage of cpdma_check_free_tx_desc()

    Commit fae50823d0 ("net: ethernet: davinci_cpdma: Add boundary for rx
    and tx descriptors") introduced a function to check the current
    allocation state of tx packets. The return value is taken into account
    to stop the netqork queue on the adapter in case there are no free
    slots.

    However, cpdma_check_free_tx_desc() returns 'true' if there is room in
    the bitmap, not 'false', so the usage of the function is wrong.

Reported-by: Prabhakar Lad <prabhakar.csengg@gmail.com>
Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 drivers/net/ethernet/ti/davinci_emac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 52c0536..ae1b77a 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1102,7 +1102,7 @@ static int emac_dev_xmit(struct sk_buff *skb, struct net_device *ndev)
 	/* If there is no more tx desc left free then we need to
 	 * tell the kernel to stop sending us tx frames.
 	 */
-	if (unlikely(cpdma_check_free_tx_desc(priv->txchan)))
+	if (unlikely(!cpdma_check_free_tx_desc(priv->txchan)))
 		netif_stop_queue(ndev);
 
 	return NETDEV_TX_OK;
-- 
1.7.9.5


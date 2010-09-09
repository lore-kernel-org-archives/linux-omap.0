From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 7/7] KS8851: Correct RX packet allocation
Date: Thu,  9 Sep 2010 16:53:15 +0530
Message-ID: <1284031395-25988-8-git-send-email-santosh.shilimkar@ti.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-2-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-3-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-4-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-5-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-6-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-7-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53102 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753620Ab0IILX1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Sep 2010 07:23:27 -0400
In-Reply-To: <1284031395-25988-7-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, Eric Dumazet <eric.dumazet@gmail.com>, Abraham Arce <x0066660@ti.com>

From: Eric Dumazet <eric.dumazet@gmail.com>

Use netdev_alloc_skb_ip_align() helper and do correct allocation

Tested-by: Abraham Arce <x0066660@ti.com>
Signed-off-by: Abraham Arce <x0066660@ti.com>
---
 drivers/net/ks8851.c |   39 +++++++++++++++++++++------------------
 1 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ks8851.c b/drivers/net/ks8851.c
index b4fb07a..51919fc 100644
--- a/drivers/net/ks8851.c
+++ b/drivers/net/ks8851.c
@@ -503,30 +503,33 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
 		ks8851_wrreg16(ks, KS_RXQCR,
 			       ks->rc_rxqcr | RXQCR_SDA | RXQCR_ADRFE);
 
-		if (rxlen > 0) {
-			skb = netdev_alloc_skb(ks->netdev, rxlen + 2 + 8);
-			if (!skb) {
-				/* todo - dump frame and move on */
-			}
+		if (rxlen > 4) {
+			unsigned int rxalign;
+
+			rxlen -= 4;
+			rxalign = ALIGN(rxlen, 4);
+			skb = netdev_alloc_skb_ip_align(ks->netdev, rxalign);
+			if (skb) {
 
-			/* two bytes to ensure ip is aligned, and four bytes
-			 * for the status header and 4 bytes of garbage */
-			skb_reserve(skb, 2 + 4 + 4);
+				/* 4 bytes of status header + 4 bytes of
+				 * garbage: we put them before ethernet
+				 * header, so that they are copied,
+				 * but ignored.
+				 */
 
-			rxpkt = skb_put(skb, rxlen - 4) - 8;
+				rxpkt = skb_put(skb, rxlen) - 8;
 
-			/* align the packet length to 4 bytes, and add 4 bytes
-			 * as we're getting the rx status header as well */
-			ks8851_rdfifo(ks, rxpkt, ALIGN(rxlen, 4) + 8);
+				ks8851_rdfifo(ks, rxpkt, rxalign + 8);
 
-			if (netif_msg_pktdata(ks))
-				ks8851_dbg_dumpkkt(ks, rxpkt);
+				if (netif_msg_pktdata(ks))
+					ks8851_dbg_dumpkkt(ks, rxpkt);
 
-			skb->protocol = eth_type_trans(skb, ks->netdev);
-			netif_rx(skb);
+				skb->protocol = eth_type_trans(skb, ks->netdev);
+				netif_rx(skb);
 
-			ks->netdev->stats.rx_packets++;
-			ks->netdev->stats.rx_bytes += rxlen - 4;
+				ks->netdev->stats.rx_packets++;
+				ks->netdev->stats.rx_bytes += rxlen;
+			}
 		}
 
 		ks8851_wrreg16(ks, KS_RXQCR, ks->rc_rxqcr);
-- 
1.6.0.4


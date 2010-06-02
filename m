From: "Arce, Abraham" <x0066660@ti.com>
Subject: [FOR TESTING] [PATCH] KS8851: Fix RX skbuff NULL pointer
Date: Wed, 2 Jun 2010 05:48:55 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E538A5F@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39905 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610Ab0FBKs7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 06:48:59 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


From: Eric Dumazet <eric.dumazet@gmail.com>

Fix the allocation length of rx skbuff.
Based on discussion http://lkml.org/lkml/2010/5/26/501

Signed-off-by: Abraham Arce <x0066660@ti.com>
---
 drivers/net/ks8851.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ks8851.c b/drivers/net/ks8851.c
index b4fb07a..05bd312 100644
--- a/drivers/net/ks8851.c
+++ b/drivers/net/ks8851.c
@@ -503,8 +503,9 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
 		ks8851_wrreg16(ks, KS_RXQCR,
 			       ks->rc_rxqcr | RXQCR_SDA | RXQCR_ADRFE);
 
-		if (rxlen > 0) {
-			skb = netdev_alloc_skb(ks->netdev, rxlen + 2 + 8);
+		if (rxlen > 4) {
+			rxlen -= 4;
+			skb = netdev_alloc_skb(ks->netdev, 2 + 8 + ALIGN(rxlen, 4));
 			if (!skb) {
 				/* todo - dump frame and move on */
 			}
@@ -513,7 +514,7 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
 			 * for the status header and 4 bytes of garbage */
 			skb_reserve(skb, 2 + 4 + 4);
 
-			rxpkt = skb_put(skb, rxlen - 4) - 8;
+			rxpkt = skb_put(skb, rxlen) - 8;
 
 			/* align the packet length to 4 bytes, and add 4 bytes
 			 * as we're getting the rx status header as well */
@@ -526,7 +527,7 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
 			netif_rx(skb);
 
 			ks->netdev->stats.rx_packets++;
-			ks->netdev->stats.rx_bytes += rxlen - 4;
+			ks->netdev->stats.rx_bytes += rxlen;
 		}
 
 		ks8851_wrreg16(ks, KS_RXQCR, ks->rc_rxqcr);
-- 
1.5.4.3


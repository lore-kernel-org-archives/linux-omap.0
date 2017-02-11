From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH] net: ethernet: ti: cpsw: return NET_XMIT_DROP if skb_padto failed
Date: Sat, 11 Feb 2017 03:49:57 +0200
Message-ID: <1486777797-28143-1-git-send-email-ivan.khoronzhuk@linaro.org>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: mugunthanvnm@ti.com
Cc: grygorii.strashko@ti.com, netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

If skb_padto failed the skb has been dropped already, so it was
consumed, but it doesn't mean it was sent, thus no need to update
queue tx time, etc. So, return NET_XMIT_DROP as more appropriate.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
Based on net-next/master

 drivers/net/ethernet/ti/cpsw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 4d1c0c3..503fa8a 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1604,7 +1604,7 @@ static netdev_tx_t cpsw_ndo_start_xmit(struct sk_buff *skb,
 	if (skb_padto(skb, CPSW_MIN_PACKET_SIZE)) {
 		cpsw_err(priv, tx_err, "packet pad failed\n");
 		ndev->stats.tx_dropped++;
-		return NETDEV_TX_OK;
+		return NET_XMIT_DROP;
 	}
 
 	if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
-- 
2.7.4

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next] net: ethernet: ti: cpsw: add missed RX_CTAG feature for second slave
Date: Fri, 27 Jul 2018 19:54:39 +0300
Message-ID: <20180727165439.16933-1-ivan.khoronzhuk@linaro.org>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

Seems it was missed while adding for first net dev in dual-emac mode.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
Based on net-next/master

 drivers/net/ethernet/ti/cpsw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 171abcfb6184..1b54c26c2bec 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -3287,7 +3287,7 @@ static int cpsw_probe_dual_emac(struct cpsw_priv *priv)
 
 	priv_sl2->emac_port = 1;
 	cpsw->slaves[1].ndev = ndev;
-	ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+	ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_CTAG_RX;
 
 	ndev->netdev_ops = &cpsw_netdev_ops;
 	ndev->ethtool_ops = &cpsw_ethtool_ops;
-- 
2.17.1

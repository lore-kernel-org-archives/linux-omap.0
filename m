From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next] net: ethernet: ti: cpsw: unsync mcast entries while switch promisc mode
Date: Fri, 19 Oct 2018 23:25:41 +0300
Message-ID: <20181019202541.10278-1-ivan.khoronzhuk@linaro.org>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

After flushing all mcast entries from the table, the ones contained in
mc list of ndev are not restored when promisc mode is toggled off,
because they are considered as synched with ALE, thus, in order to
restore them after promisc mode - reset syncing info. This fix
touches only switch mode devices, including single port boards
like Beagle Bone.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---

Based on net-nex/master
and is logical continuation of the
https://lore.kernel.org/patchwork/patch/1001633/

 drivers/net/ethernet/ti/cpsw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 226be2a56c1f..f7753b240ced 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -640,6 +640,7 @@ static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
 
 			/* Clear all mcast from ALE */
 			cpsw_ale_flush_multicast(ale, ALE_ALL_PORTS, -1);
+			__dev_mc_unsync(ndev, NULL);
 
 			/* Flood All Unicast Packets to Host port */
 			cpsw_ale_control_set(ale, 0, ALE_P0_UNI_FLOOD, 1);
-- 
2.17.1

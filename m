From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next 10/22] net: ti: fix return type of ndo_start_xmit
 function
Date: Thu, 20 Sep 2018 20:32:54 +0800
Message-ID: <20180920123306.14772-11-yuehaibing@huawei.com>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180920123306.14772-1-yuehaibing@huawei.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: davem@davemloft.net, dmitry.tarnyagin@lockless.no, wg@grandegger.com, mkl@pengutronix.de, michal.simek@xilinx.com, hsweeten@visionengravers.com, madalin.bucur@nxp.com, pantelis.antoniou@gmail.com, claudiu.manoil@nxp.com, leoyang.li@nxp.com, linux@armlinux.org.uk, sammy@sammy.net, ralf@linux-mips.org, nico@fluxnic.net, steve.glendinning@shawell.net, f.fainelli@gmail.com, grygorii.strashko@ti.com, w-kwok2@ti.com, m-karicheri2@ti.com, t.sailer@alumni.ethz.ch, jreuter@yaina.de, kys@microsoft.com, haiyangz@microsoft.com, wei.liu2@citrix.com, paul.durrant@citrix.com, arvid.brodin@alten.se, pshelar@ovn.org
Cc: dev@openvswitch.org, linux-mips@linux-mips.org, xen-devel@lists.xenproject.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, devel@linuxdriverproject.org, linux-hams@vger.kernel.org, linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/ti/cpmac.c        | 2 +-
 drivers/net/ethernet/ti/davinci_emac.c | 2 +-
 drivers/net/ethernet/ti/netcp_core.c   | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpmac.c b/drivers/net/ethernet/ti/cpmac.c
index 9b8a30b..64c45eb 100644
--- a/drivers/net/ethernet/ti/cpmac.c
+++ b/drivers/net/ethernet/ti/cpmac.c
@@ -544,7 +544,7 @@ static int cpmac_poll(struct napi_struct *napi, int budget)
 
 }
 
-static int cpmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t cpmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	int queue;
 	unsigned int len;
diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index f270bee..b83f32d 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -943,7 +943,7 @@ static void emac_tx_handler(void *token, int len, int status)
  *
  * Returns success(NETDEV_TX_OK) or error code (typically out of desc's)
  */
-static int emac_dev_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t emac_dev_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct device *emac_dev = &ndev->dev;
 	int ret_code;
diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index 1f61226..2d8cfe8 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -1270,7 +1270,8 @@ static int netcp_tx_submit_skb(struct netcp_intf *netcp,
 }
 
 /* Submit the packet */
-static int netcp_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t
+netcp_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct netcp_intf *netcp = netdev_priv(ndev);
 	struct netcp_stats *tx_stats = &netcp->stats;
@@ -1290,7 +1291,7 @@ static int netcp_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 			dev_warn(netcp->ndev_dev, "padding failed (%d), packet dropped\n",
 				 ret);
 			tx_stats->tx_dropped++;
-			return ret;
+			return NETDEV_TX_BUSY;
 		}
 		skb->len = NETCP_MIN_PACKET_SIZE;
 	}
@@ -1298,7 +1299,6 @@ static int netcp_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	desc = netcp_tx_map_skb(skb, netcp);
 	if (unlikely(!desc)) {
 		netif_stop_subqueue(ndev, subqueue);
-		ret = -ENOBUFS;
 		goto drop;
 	}
 
@@ -1319,7 +1319,7 @@ static int netcp_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	if (desc)
 		netcp_free_tx_desc_chain(netcp, desc, sizeof(*desc));
 	dev_kfree_skb(skb);
-	return ret;
+	return NETDEV_TX_BUSY;
 }
 
 int netcp_txpipe_close(struct netcp_tx_pipe *tx_pipe)
-- 
1.8.3.1

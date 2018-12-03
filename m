From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [RFC PATCH net-next 4/5] net: ethernet: add default vid len for all ehternet kind devices
Date: Mon,  3 Dec 2018 20:40:22 +0200
Message-ID: <20181203184023.3430-5-ivan.khoronzhuk@linaro.org>
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, grygorii.strashko@ti.com
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

By default every ethernet netdev needs vid len = 2 bytes to be able to
hold up to 4096 vids. So set it for every eth device to be correct,
except vlan devs.

In order to shrink all addresses of devices above vlan, the vid_len
for vlan dev = 0, as result all suckers sync their addresses to common
base not taking in to account vid part (vid_len of "to" devices is
important only). And only vlan device is the source of addresses with
actual its vid set, propagating it to parent devices while rx_mode().

Also, don't bother those devices that at this moment not moved to vlan
addressing scheme, so while end ethernet device is created - set
vid_len to 0, thus, while syncing, its address space is concatenated
to one dimensional like usual, and who needs vlan addresses to be
separate - set it to VLAN_VID_TYPE_SIZE. When number of devices
supporting new vlan addressing scheme becomes more than simple ones,
it can be reversed, disabling it for those who don't need.

This vid_len should be placed under smth like CONFIG_8021Q_ADDR_FLT.

There is another decision - is to inherit vid_len or some feature flag
from end root device in order to all upper devices have vlan extended
address space only if exact end real device have such capability. But
I didn't, because it requires more changes and probably I'm not
familiar with all places where it should be inherited, I would
appreciate if someone can guid where it's applicable, then it could
become a little bit more limited.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 net/8021q/vlan_dev.c |  1 +
 net/ethernet/eth.c   | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index f6bcd847509e..c2d934251e77 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -896,6 +896,7 @@ void vlan_setup(struct net_device *dev)
 
 	dev->min_mtu		= 0;
 	dev->max_mtu		= ETH_MAX_MTU;
+	dev->vid_len		= 0;
 
 	eth_zero_addr(dev->broadcast);
 }
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 58933fa50bb5..52f90cefb6de 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -363,6 +363,7 @@ void ether_setup(struct net_device *dev)
 	dev->min_mtu		= ETH_MIN_MTU;
 	dev->max_mtu		= ETH_DATA_LEN;
 	dev->addr_len		= ETH_ALEN;
+	dev->vid_len		= NET_802Q_VID_TSIZE;
 	dev->tx_queue_len	= DEFAULT_TX_QUEUE_LEN;
 	dev->flags		= IFF_BROADCAST|IFF_MULTICAST;
 	dev->priv_flags		|= IFF_TX_SKB_SHARING;
@@ -390,8 +391,18 @@ EXPORT_SYMBOL(ether_setup);
 struct net_device *alloc_etherdev_mqs(int sizeof_priv, unsigned int txqs,
 				      unsigned int rxqs)
 {
-	return alloc_netdev_mqs(sizeof_priv, "eth%d", NET_NAME_UNKNOWN,
-				ether_setup, txqs, rxqs);
+	struct net_device *dev;
+
+	dev = alloc_netdev_mqs(sizeof_priv, "eth%d", NET_NAME_UNKNOWN,
+			       ether_setup, txqs, rxqs);
+
+	/* TODO: When number of real ehternet devices supporting vlan
+	 * addressing scheme becomes more than simple ones, it should
+	 * be removed, disabling it (by dev->vid_len = 0) for those
+	 * who doesn't support it
+	 */
+	dev->vid_len = 0;
+	return dev;
 }
 EXPORT_SYMBOL(alloc_etherdev_mqs);
 
-- 
2.17.1

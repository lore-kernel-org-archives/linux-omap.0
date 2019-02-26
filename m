From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 4/6] ethernet: eth: add default vid len for all ehternet kind devices
Date: Tue, 26 Feb 2019 20:45:54 +0200
Message-ID: <20190226184556.16082-5-ivan.khoronzhuk@linaro.org>
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, grygorii.strashko@ti.com, f.fainelli@gmail.com
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, ilias.apalodimas@linaro.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

IVDF - individual virtual device filtering. Allows to set per vlan
l2 address filters on end real network device (for unicast and for
multicast) and drop redundant not expected packet income.

If CONFIG_VLAN_8021Q_IVDF is enabled the following changes are
applied, and only for ethernet network devices.

By default every ethernet netdev needs vid len = 2 bytes to be able to
hold up to 4096 vids. So set it for every eth device to be correct,
except vlan devs.

In order to shrink all addresses of devices above vlan, the vid_len
for vlan dev = 0, as result all suckers sync their addresses to common
base not taking in to account vid part (vid_len of "to" devices is
important only). And only vlan device is the source of addresses with
actual its vid set, propagating it to parent devices while rx_mode().

Also, don't bother those ethernet devices that at this moment are not
moved to vlan addressing scheme, so while end ethernet device is
created - set vid_len to 0, thus, while syncing, its address space is
concatenated to one dimensional like usual, and who needs IVDF - set
it to NET_8021Q_VID_TSIZE.

There is another decision - is to inherit vid_len or some feature flag
from end root device in order to all upper devices have vlan extended
address space only if exact end real device have such capability. But
I didn't, because it requires more changes and probably I'm not
familiar with all places where it should be inherited, I would
appreciate if someone can guid where it's applicable, then it could
become a little bit more limited.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 include/linux/if_vlan.h |  1 +
 net/8021q/Kconfig       | 12 ++++++++++++
 net/8021q/vlan_core.c   | 12 ++++++++++++
 net/8021q/vlan_dev.c    |  1 +
 net/ethernet/eth.c      | 10 ++++++++--
 5 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 94657f3c483a..9c914b31d208 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -137,6 +137,7 @@ extern int vlan_for_each(struct net_device *dev,
 			 int (*action)(struct net_device *dev, int vid,
 				       void *arg), void *arg);
 extern u16 vlan_dev_get_addr_vid(struct net_device *dev, const u8 *addr);
+extern void vlan_dev_ivdf_set(struct net_device *dev, int enable);
 extern struct net_device *vlan_dev_real_dev(const struct net_device *dev);
 extern u16 vlan_dev_vlan_id(const struct net_device *dev);
 extern __be16 vlan_dev_vlan_proto(const struct net_device *dev);
diff --git a/net/8021q/Kconfig b/net/8021q/Kconfig
index 42320180967f..3e843045739c 100644
--- a/net/8021q/Kconfig
+++ b/net/8021q/Kconfig
@@ -38,3 +38,15 @@ config VLAN_8021Q_MVRP
 	  supersedes GVRP and is not backwards-compatible.
 
 	  If unsure, say N.
+
+config VLAN_8021Q_IVDF
+	bool "IVDF (Individual Virtual Device Filtering) support"
+	depends on VLAN_8021Q
+	help
+	  Select this to enable IVDF addressing scheme support. IVDF is used
+	  for automatic propagation of registered VLANs addresses to real end
+	  devices. If no device supporting IVDF then disable this as it can
+	  consume some memory in configuration with complex network device
+	  structures to hold vlan addresses.
+
+	  If unsure, say N.
diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index fe2ac64c13f8..310b6cd39f22 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -454,6 +454,18 @@ bool vlan_uses_dev(const struct net_device *dev)
 }
 EXPORT_SYMBOL(vlan_uses_dev);
 
+void vlan_dev_ivdf_set(struct net_device *dev, int enable)
+{
+#ifdef CONFIG_VLAN_8021Q_IVDF
+	if (enable) {
+		dev->vid_len = NET_8021Q_VID_TSIZE;
+		return;
+	}
+#endif
+	dev->vid_len = 0;
+}
+EXPORT_SYMBOL(vlan_dev_ivdf_set);
+
 u16 vlan_dev_get_addr_vid(struct net_device *dev, const u8 *addr)
 {
 	u16 vid = 0;
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 634436e780f1..e4120aca4b9b 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -896,5 +896,6 @@ void vlan_setup(struct net_device *dev)
 	dev->min_mtu		= 0;
 	dev->max_mtu		= ETH_MAX_MTU;
 
+	vlan_dev_ivdf_set(dev, 0);
 	eth_zero_addr(dev->broadcast);
 }
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index f7a3d7a171c7..95497cac24eb 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -381,6 +381,7 @@ void ether_setup(struct net_device *dev)
 	dev->flags		= IFF_BROADCAST|IFF_MULTICAST;
 	dev->priv_flags		|= IFF_TX_SKB_SHARING;
 
+	vlan_dev_ivdf_set(dev, 1);
 	eth_broadcast_addr(dev->broadcast);
 
 }
@@ -404,8 +405,13 @@ EXPORT_SYMBOL(ether_setup);
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
+	vlan_dev_ivdf_set(dev, 0);
+	return dev;
 }
 EXPORT_SYMBOL(alloc_etherdev_mqs);
 
-- 
2.17.1

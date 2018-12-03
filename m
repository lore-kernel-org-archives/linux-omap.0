From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [RFC PATCH net-next 3/5] net: 8021q: vlan_dev: add vid tag for vlan device mac address
Date: Mon,  3 Dec 2018 20:40:21 +0200
Message-ID: <20181203184023.3430-4-ivan.khoronzhuk@linaro.org>
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, grygorii.strashko@ti.com
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

The vlan device address is hold separately from uc/mc lists and is
handled differently. With proposed change, the vlan dev address is bind
with real device address only if's inherited, in all other cases it's
separate address entry.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 include/linux/netdevice.h |  2 ++
 net/8021q/vlan.c          |  3 ++
 net/8021q/vlan_dev.c      | 76 +++++++++++++++++++++++++++++----------
 3 files changed, 62 insertions(+), 19 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1b0f9c322b01..28c6da3583cf 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -76,6 +76,8 @@ void netdev_set_default_ethtool_ops(struct net_device *dev,
 #define NET_RX_SUCCESS		0	/* keep 'em coming, baby */
 #define NET_RX_DROP		1	/* packet dropped */
 
+#define NET_802Q_VID_TSIZE	2
+
 /*
  * Transmit return codes: transmit return codes originate from three different
  * namespaces:
diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index aef1a977279c..a1eae9d61284 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -295,6 +295,9 @@ static void vlan_sync_address(struct net_device *dev,
 	if (vlan_dev_inherit_address(vlandev, dev))
 		goto out;
 
+	if (dev->vid_len)
+		goto out;
+
 	/* vlan address was different from the old address and is equal to
 	 * the new address */
 	if (!ether_addr_equal(vlandev->dev_addr, vlan->real_dev_addr) &&
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index c05b313314b7..f6bcd847509e 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -258,12 +258,61 @@ static void vlan_dev_set_addr_vid(struct net_device *vlan_dev, u8 *addr)
 	addr[vlan_dev->addr_len + 1] = (vid >> 8) & 0xf;
 }
 
+static int vlan_dev_add_addr(struct net_device *dev, u8 *addr)
+{
+	struct net_device *real_dev = vlan_dev_real_dev(dev);
+	unsigned char naddr[ETH_ALEN + NET_802Q_VID_TSIZE];
+
+	if (real_dev->vid_len) {
+		memcpy(naddr, addr, dev->addr_len);
+		vlan_dev_set_addr_vid(dev, naddr);
+		return dev_vid_uc_add(real_dev, naddr);
+	}
+
+	if (ether_addr_equal(addr, real_dev->dev_addr))
+		return 0;
+
+	return dev_uc_add(real_dev, addr);
+}
+
+static void vlan_dev_del_addr(struct net_device *dev, u8 *addr)
+{
+	struct net_device *real_dev = vlan_dev_real_dev(dev);
+	unsigned char naddr[ETH_ALEN + NET_802Q_VID_TSIZE];
+
+	if (real_dev->vid_len) {
+		memcpy(naddr, addr, dev->addr_len);
+		vlan_dev_set_addr_vid(dev, naddr);
+		dev_vid_uc_del(real_dev, naddr);
+		return;
+	}
+
+	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr))
+		dev_uc_del(real_dev, addr);
+}
+
+int vlan_dev_subs_addr(struct net_device *dev, u8 *addr)
+{
+	int err;
+
+	err = vlan_dev_add_addr(dev, addr);
+	if (err < 0)
+		return err;
+
+	vlan_dev_del_addr(dev, dev->dev_addr);
+	return err;
+}
+
 bool vlan_dev_inherit_address(struct net_device *dev,
 			      struct net_device *real_dev)
 {
 	if (dev->addr_assign_type != NET_ADDR_STOLEN)
 		return false;
 
+	if (real_dev->vid_len)
+		if (vlan_dev_subs_addr(dev, real_dev->dev_addr))
+			return false;
+
 	ether_addr_copy(dev->dev_addr, real_dev->dev_addr);
 	call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
 	return true;
@@ -279,9 +328,10 @@ static int vlan_dev_open(struct net_device *dev)
 	    !(vlan->flags & VLAN_FLAG_LOOSE_BINDING))
 		return -ENETDOWN;
 
-	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr) &&
-	    !vlan_dev_inherit_address(dev, real_dev)) {
-		err = dev_uc_add(real_dev, dev->dev_addr);
+	if (ether_addr_equal(dev->dev_addr, real_dev->dev_addr) ||
+	    (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr) &&
+	     !vlan_dev_inherit_address(dev, real_dev))) {
+		err = vlan_dev_add_addr(dev, dev->dev_addr);
 		if (err < 0)
 			goto out;
 	}
@@ -313,8 +363,7 @@ static int vlan_dev_open(struct net_device *dev)
 	if (dev->flags & IFF_ALLMULTI)
 		dev_set_allmulti(real_dev, -1);
 del_unicast:
-	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr))
-		dev_uc_del(real_dev, dev->dev_addr);
+	vlan_dev_del_addr(dev, dev->dev_addr);
 out:
 	netif_carrier_off(dev);
 	return err;
@@ -332,18 +381,14 @@ static int vlan_dev_stop(struct net_device *dev)
 	if (dev->flags & IFF_PROMISC)
 		dev_set_promiscuity(real_dev, -1);
 
-	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr))
-		dev_uc_del(real_dev, dev->dev_addr);
-
+	vlan_dev_del_addr(dev, dev->dev_addr);
 	netif_carrier_off(dev);
 	return 0;
 }
 
 static int vlan_dev_set_mac_address(struct net_device *dev, void *p)
 {
-	struct net_device *real_dev = vlan_dev_priv(dev)->real_dev;
 	struct sockaddr *addr = p;
-	int err;
 
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
@@ -351,15 +396,8 @@ static int vlan_dev_set_mac_address(struct net_device *dev, void *p)
 	if (!(dev->flags & IFF_UP))
 		goto out;
 
-	if (!ether_addr_equal(addr->sa_data, real_dev->dev_addr)) {
-		err = dev_uc_add(real_dev, addr->sa_data);
-		if (err < 0)
-			return err;
-	}
-
-	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr))
-		dev_uc_del(real_dev, dev->dev_addr);
-
+	if (vlan_dev_subs_addr(dev, addr->sa_data))
+		return true;
 out:
 	ether_addr_copy(dev->dev_addr, addr->sa_data);
 	return 0;
-- 
2.17.1

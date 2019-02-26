From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 1/6] net: core: dev_addr_lists: add VID to device address
Date: Tue, 26 Feb 2019 20:45:51 +0200
Message-ID: <20190226184556.16082-2-ivan.khoronzhuk@linaro.org>
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, grygorii.strashko@ti.com, f.fainelli@gmail.com
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, ilias.apalodimas@linaro.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

Despite this is supposed to be used for Ethernet VLANs, not Ethernet
addresses with space for VID also can reuse this, so VID is considered
as virtual ID extension, not belonging strictly to Ethernet VLAN VIDs,
and overall change can be named individual virtual device filtering
(IVDF).

This patch adds VID tag at the end of each address. The actual
reserved address size is 32 bytes. For Ethernet addresses with 6 bytes
long that's possible to add tag w/o increasing address size. Thus,
each address for the case has 32 - 6 = 26 bytes to hold additional
info, say VID for virtual device addresses.

Therefore, when addresses are synced to the address list of parent
device the address list of latter can contain separate addresses for
virtual devices. It allows to track separate address tables for
virtual devices if they present and the device can be placed on
any place of device tree as the address is propagated to to the end
real device thru *_sync()/ndo_set_rx_mode() APIs. Also it simplifies
handling VID addresses at real device when it supports IVDF.

If parent device doesn't want to have virtual addresses in its address
space the vid_len has to be 0, thus its address space is "shrunk" to
the state as before this patch. For now it's 0 for every device. It
allows two devices with and w/o IVDF to be part of same bond device
for instance.

The end real device supporting IVDF can retrieve VID tag from an
address and set it for a given virtual device only. By default, vid 0
is used for real devices to distinguish it from virtual addresses.

See next patches to see how it's used.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 include/linux/netdevice.h |   4 ++
 net/core/dev_addr_lists.c | 124 +++++++++++++++++++++++++++++++-------
 2 files changed, 105 insertions(+), 23 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 58e83bd7a861..74fef35b6bec 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1660,6 +1660,7 @@ enum netdev_priv_flags {
  * 	@perm_addr:		Permanent hw address
  * 	@addr_assign_type:	Hw address assignment type
  * 	@addr_len:		Hardware address length
+ *	@vid_len:		Virtual ID length, set in case of IVDF
  *	@neigh_priv_len:	Used in neigh_alloc()
  * 	@dev_id:		Used to differentiate devices that share
  * 				the same link layer address
@@ -1889,6 +1890,7 @@ struct net_device {
 	unsigned char		perm_addr[MAX_ADDR_LEN];
 	unsigned char		addr_assign_type;
 	unsigned char		addr_len;
+	unsigned char		vid_len;
 	unsigned short		neigh_priv_len;
 	unsigned short          dev_id;
 	unsigned short          dev_port;
@@ -4141,8 +4143,10 @@ int dev_addr_init(struct net_device *dev);
 
 /* Functions used for unicast addresses handling */
 int dev_uc_add(struct net_device *dev, const unsigned char *addr);
+int dev_vid_uc_add(struct net_device *dev, const unsigned char *addr);
 int dev_uc_add_excl(struct net_device *dev, const unsigned char *addr);
 int dev_uc_del(struct net_device *dev, const unsigned char *addr);
+int dev_vid_uc_del(struct net_device *dev, const unsigned char *addr);
 int dev_uc_sync(struct net_device *to, struct net_device *from);
 int dev_uc_sync_multiple(struct net_device *to, struct net_device *from);
 void dev_uc_unsync(struct net_device *to, struct net_device *from);
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index a6723b306717..e3c80e044b8c 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -545,6 +545,26 @@ int dev_addr_del(struct net_device *dev, const unsigned char *addr,
 }
 EXPORT_SYMBOL(dev_addr_del);
 
+static int get_addr_len(struct net_device *dev)
+{
+	return dev->addr_len + dev->vid_len;
+}
+
+static int set_vid_addr(struct net_device *dev, const unsigned char *addr,
+			unsigned char *naddr)
+{
+	int i;
+
+	if (!dev->vid_len)
+		return dev->addr_len;
+
+	memcpy(naddr, addr, dev->addr_len);
+	for (i = 0; i < dev->vid_len; i++)
+		naddr[dev->addr_len + i] = 0;
+
+	return get_addr_len(dev);
+}
+
 /*
  * Unicast list handling functions
  */
@@ -556,18 +576,22 @@ EXPORT_SYMBOL(dev_addr_del);
  */
 int dev_uc_add_excl(struct net_device *dev, const unsigned char *addr)
 {
+	unsigned char naddr[MAX_ADDR_LEN];
 	struct netdev_hw_addr *ha;
-	int err;
+	int addr_len, err;
+
+	addr_len = set_vid_addr(dev, addr, naddr);
+	addr = dev->vid_len ? naddr : addr;
 
 	netif_addr_lock_bh(dev);
 	list_for_each_entry(ha, &dev->uc.list, list) {
-		if (!memcmp(ha->addr, addr, dev->addr_len) &&
+		if (!memcmp(ha->addr, addr, addr_len) &&
 		    ha->type == NETDEV_HW_ADDR_T_UNICAST) {
 			err = -EEXIST;
 			goto out;
 		}
 	}
-	err = __hw_addr_create_ex(&dev->uc, addr, dev->addr_len,
+	err = __hw_addr_create_ex(&dev->uc, addr, addr_len,
 				  NETDEV_HW_ADDR_T_UNICAST, true, false);
 	if (!err)
 		__dev_set_rx_mode(dev);
@@ -578,47 +602,89 @@ int dev_uc_add_excl(struct net_device *dev, const unsigned char *addr)
 EXPORT_SYMBOL(dev_uc_add_excl);
 
 /**
- *	dev_uc_add - Add a secondary unicast address
+ *	dev_vid_uc_add - Add a secondary unicast address with tag
  *	@dev: device
- *	@addr: address to add
+ *	@addr: address to add, includes vid tag already
  *
  *	Add a secondary unicast address to the device or increase
  *	the reference count if it already exists.
  */
-int dev_uc_add(struct net_device *dev, const unsigned char *addr)
+int dev_vid_uc_add(struct net_device *dev, const unsigned char *addr)
 {
 	int err;
 
 	netif_addr_lock_bh(dev);
-	err = __hw_addr_add(&dev->uc, addr, dev->addr_len,
+	err = __hw_addr_add(&dev->uc, addr, get_addr_len(dev),
 			    NETDEV_HW_ADDR_T_UNICAST);
 	if (!err)
 		__dev_set_rx_mode(dev);
 	netif_addr_unlock_bh(dev);
 	return err;
 }
+EXPORT_SYMBOL(dev_vid_uc_add);
+
+/**
+ *	dev_uc_add - Add a secondary unicast address
+ *	@dev: device
+ *	@addr: address to add
+ *
+ *	Add a secondary unicast address to the device or increase
+ *	the reference count if it already exists.
+ */
+int dev_uc_add(struct net_device *dev, const unsigned char *addr)
+{
+	unsigned char naddr[MAX_ADDR_LEN];
+	int err;
+
+	set_vid_addr(dev, addr, naddr);
+	addr = dev->vid_len ? naddr : addr;
+
+	err = dev_vid_uc_add(dev, addr);
+	return err;
+}
 EXPORT_SYMBOL(dev_uc_add);
 
 /**
  *	dev_uc_del - Release secondary unicast address.
  *	@dev: device
- *	@addr: address to delete
+ *	@addr: address to delete, includes vid tag already
  *
  *	Release reference to a secondary unicast address and remove it
  *	from the device if the reference count drops to zero.
  */
-int dev_uc_del(struct net_device *dev, const unsigned char *addr)
+int dev_vid_uc_del(struct net_device *dev, const unsigned char *addr)
 {
 	int err;
 
 	netif_addr_lock_bh(dev);
-	err = __hw_addr_del(&dev->uc, addr, dev->addr_len,
+	err = __hw_addr_del(&dev->uc, addr, get_addr_len(dev),
 			    NETDEV_HW_ADDR_T_UNICAST);
 	if (!err)
 		__dev_set_rx_mode(dev);
 	netif_addr_unlock_bh(dev);
 	return err;
 }
+EXPORT_SYMBOL(dev_vid_uc_del);
+
+/**
+ *	dev_uc_del - Release secondary unicast address.
+ *	@dev: device
+ *	@addr: address to delete
+ *
+ *	Release reference to a secondary unicast address and remove it
+ *	from the device if the reference count drops to zero.
+ */
+int dev_uc_del(struct net_device *dev, const unsigned char *addr)
+{
+	unsigned char naddr[MAX_ADDR_LEN];
+	int err;
+
+	set_vid_addr(dev, addr, naddr);
+	addr = dev->vid_len ? naddr : addr;
+
+	err = dev_vid_uc_del(dev, addr);
+	return err;
+}
 EXPORT_SYMBOL(dev_uc_del);
 
 /**
@@ -642,7 +708,7 @@ int dev_uc_sync(struct net_device *to, struct net_device *from)
 		return -EINVAL;
 
 	netif_addr_lock_nested(to);
-	err = __hw_addr_sync(&to->uc, &from->uc, to->addr_len);
+	err = __hw_addr_sync(&to->uc, &from->uc, get_addr_len(to));
 	if (!err)
 		__dev_set_rx_mode(to);
 	netif_addr_unlock(to);
@@ -672,7 +738,7 @@ int dev_uc_sync_multiple(struct net_device *to, struct net_device *from)
 		return -EINVAL;
 
 	netif_addr_lock_nested(to);
-	err = __hw_addr_sync_multiple(&to->uc, &from->uc, to->addr_len);
+	err = __hw_addr_sync_multiple(&to->uc, &from->uc, get_addr_len(to));
 	if (!err)
 		__dev_set_rx_mode(to);
 	netif_addr_unlock(to);
@@ -696,7 +762,7 @@ void dev_uc_unsync(struct net_device *to, struct net_device *from)
 
 	netif_addr_lock_bh(from);
 	netif_addr_lock_nested(to);
-	__hw_addr_unsync(&to->uc, &from->uc, to->addr_len);
+	__hw_addr_unsync(&to->uc, &from->uc, get_addr_len(to));
 	__dev_set_rx_mode(to);
 	netif_addr_unlock(to);
 	netif_addr_unlock_bh(from);
@@ -740,18 +806,22 @@ EXPORT_SYMBOL(dev_uc_init);
  */
 int dev_mc_add_excl(struct net_device *dev, const unsigned char *addr)
 {
+	unsigned char naddr[MAX_ADDR_LEN];
 	struct netdev_hw_addr *ha;
-	int err;
+	int addr_len, err;
+
+	addr_len = set_vid_addr(dev, addr, naddr);
+	addr = dev->vid_len ? naddr : addr;
 
 	netif_addr_lock_bh(dev);
 	list_for_each_entry(ha, &dev->mc.list, list) {
-		if (!memcmp(ha->addr, addr, dev->addr_len) &&
+		if (!memcmp(ha->addr, addr, addr_len) &&
 		    ha->type == NETDEV_HW_ADDR_T_MULTICAST) {
 			err = -EEXIST;
 			goto out;
 		}
 	}
-	err = __hw_addr_create_ex(&dev->mc, addr, dev->addr_len,
+	err = __hw_addr_create_ex(&dev->mc, addr, addr_len,
 				  NETDEV_HW_ADDR_T_MULTICAST, true, false);
 	if (!err)
 		__dev_set_rx_mode(dev);
@@ -764,10 +834,14 @@ EXPORT_SYMBOL(dev_mc_add_excl);
 static int __dev_mc_add(struct net_device *dev, const unsigned char *addr,
 			bool global)
 {
-	int err;
+	unsigned char naddr[MAX_ADDR_LEN];
+	int addr_len, err;
+
+	addr_len = set_vid_addr(dev, addr, naddr);
+	addr = dev->vid_len ? naddr : addr;
 
 	netif_addr_lock_bh(dev);
-	err = __hw_addr_add_ex(&dev->mc, addr, dev->addr_len,
+	err = __hw_addr_add_ex(&dev->mc, addr, addr_len,
 			       NETDEV_HW_ADDR_T_MULTICAST, global, false, 0);
 	if (!err)
 		__dev_set_rx_mode(dev);
@@ -804,10 +878,14 @@ EXPORT_SYMBOL(dev_mc_add_global);
 static int __dev_mc_del(struct net_device *dev, const unsigned char *addr,
 			bool global)
 {
-	int err;
+	unsigned char naddr[MAX_ADDR_LEN];
+	int addr_len, err;
+
+	addr_len = set_vid_addr(dev, addr, naddr);
+	addr = dev->vid_len ? naddr : addr;
 
 	netif_addr_lock_bh(dev);
-	err = __hw_addr_del_ex(&dev->mc, addr, dev->addr_len,
+	err = __hw_addr_del_ex(&dev->mc, addr, addr_len,
 			       NETDEV_HW_ADDR_T_MULTICAST, global, false);
 	if (!err)
 		__dev_set_rx_mode(dev);
@@ -863,7 +941,7 @@ int dev_mc_sync(struct net_device *to, struct net_device *from)
 		return -EINVAL;
 
 	netif_addr_lock_nested(to);
-	err = __hw_addr_sync(&to->mc, &from->mc, to->addr_len);
+	err = __hw_addr_sync(&to->mc, &from->mc, get_addr_len(to));
 	if (!err)
 		__dev_set_rx_mode(to);
 	netif_addr_unlock(to);
@@ -893,7 +971,7 @@ int dev_mc_sync_multiple(struct net_device *to, struct net_device *from)
 		return -EINVAL;
 
 	netif_addr_lock_nested(to);
-	err = __hw_addr_sync_multiple(&to->mc, &from->mc, to->addr_len);
+	err = __hw_addr_sync_multiple(&to->mc, &from->mc, get_addr_len(to));
 	if (!err)
 		__dev_set_rx_mode(to);
 	netif_addr_unlock(to);
@@ -917,7 +995,7 @@ void dev_mc_unsync(struct net_device *to, struct net_device *from)
 
 	netif_addr_lock_bh(from);
 	netif_addr_lock_nested(to);
-	__hw_addr_unsync(&to->mc, &from->mc, to->addr_len);
+	__hw_addr_unsync(&to->mc, &from->mc, get_addr_len(to));
 	__dev_set_rx_mode(to);
 	netif_addr_unlock(to);
 	netif_addr_unlock_bh(from);
-- 
2.17.1

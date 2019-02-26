From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 2/6] net: 8021q: vlan_dev: add vid tag to addresses of uc and mc lists
Date: Tue, 26 Feb 2019 20:45:52 +0200
Message-ID: <20190226184556.16082-3-ivan.khoronzhuk@linaro.org>
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, grygorii.strashko@ti.com, f.fainelli@gmail.com
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, ilias.apalodimas@linaro.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

Update vlan mc and uc addresses with VID tag while propagating
addresses to lower devices, do this only if address is not synced.
It allows at end driver level to distinguish addresses belonging
to vlan devices.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 include/linux/if_vlan.h |  1 +
 net/8021q/vlan.h        |  2 ++
 net/8021q/vlan_core.c   | 13 +++++++++++++
 net/8021q/vlan_dev.c    | 26 ++++++++++++++++++++++++++
 4 files changed, 42 insertions(+)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 4cca4da7a6de..94657f3c483a 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -136,6 +136,7 @@ extern struct net_device *__vlan_find_dev_deep_rcu(struct net_device *real_dev,
 extern int vlan_for_each(struct net_device *dev,
 			 int (*action)(struct net_device *dev, int vid,
 				       void *arg), void *arg);
+extern u16 vlan_dev_get_addr_vid(struct net_device *dev, const u8 *addr);
 extern struct net_device *vlan_dev_real_dev(const struct net_device *dev);
 extern u16 vlan_dev_vlan_id(const struct net_device *dev);
 extern __be16 vlan_dev_vlan_proto(const struct net_device *dev);
diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
index c46daf09a501..f083c43c508f 100644
--- a/net/8021q/vlan.h
+++ b/net/8021q/vlan.h
@@ -6,6 +6,8 @@
 #include <linux/u64_stats_sync.h>
 #include <linux/list.h>
 
+#define NET_8021Q_VID_TSIZE	2
+
 /* if this changes, algorithm will have to be reworked because this
  * depends on completely exhausting the VLAN identifier space.  Thus
  * it gives constant time look-up, but in many cases it wastes memory.
diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index a313165e7a67..fe2ac64c13f8 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -454,6 +454,19 @@ bool vlan_uses_dev(const struct net_device *dev)
 }
 EXPORT_SYMBOL(vlan_uses_dev);
 
+u16 vlan_dev_get_addr_vid(struct net_device *dev, const u8 *addr)
+{
+	u16 vid = 0;
+
+	if (dev->vid_len != NET_8021Q_VID_TSIZE)
+		return vid;
+
+	vid = addr[dev->addr_len];
+	vid |= (addr[dev->addr_len + 1] & 0xf) << 8;
+	return vid;
+}
+EXPORT_SYMBOL(vlan_dev_get_addr_vid);
+
 static struct sk_buff *vlan_gro_receive(struct list_head *head,
 					struct sk_buff *skb)
 {
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 15293c2a5dd8..93d20b1f4916 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -249,6 +249,14 @@ void vlan_dev_get_realdev_name(const struct net_device *dev, char *result)
 	strncpy(result, vlan_dev_priv(dev)->real_dev->name, 23);
 }
 
+static void vlan_dev_set_addr_vid(struct net_device *vlan_dev, u8 *addr)
+{
+	u16 vid = vlan_dev_vlan_id(vlan_dev);
+
+	addr[vlan_dev->addr_len] = vid & 0xff;
+	addr[vlan_dev->addr_len + 1] = (vid >> 8) & 0xf;
+}
+
 bool vlan_dev_inherit_address(struct net_device *dev,
 			      struct net_device *real_dev)
 {
@@ -480,8 +488,26 @@ static void vlan_dev_change_rx_flags(struct net_device *dev, int change)
 	}
 }
 
+static void vlan_dev_align_addr_vid(struct net_device *vlan_dev)
+{
+	struct net_device *real_dev = vlan_dev_real_dev(vlan_dev);
+	struct netdev_hw_addr *ha;
+
+	if (!real_dev->vid_len)
+		return;
+
+	netdev_for_each_mc_addr(ha, vlan_dev)
+		if (!ha->sync_cnt)
+			vlan_dev_set_addr_vid(vlan_dev, ha->addr);
+
+	netdev_for_each_uc_addr(ha, vlan_dev)
+		if (!ha->sync_cnt)
+			vlan_dev_set_addr_vid(vlan_dev, ha->addr);
+}
+
 static void vlan_dev_set_rx_mode(struct net_device *vlan_dev)
 {
+	vlan_dev_align_addr_vid(vlan_dev);
 	dev_mc_sync(vlan_dev_priv(vlan_dev)->real_dev, vlan_dev);
 	dev_uc_sync(vlan_dev_priv(vlan_dev)->real_dev, vlan_dev);
 }
-- 
2.17.1

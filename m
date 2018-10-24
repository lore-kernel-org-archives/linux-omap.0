From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 1/4] net: core: dev_addr_lists: add auxiliary func to handle reference address updates
Date: Thu, 25 Oct 2018 01:10:56 +0300
Message-ID: <20181024221059.21834-2-ivan.khoronzhuk@linaro.org>
References: <20181024221059.21834-1-ivan.khoronzhuk@linaro.org>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181024221059.21834-1-ivan.khoronzhuk@linaro.org>
Sender: netdev-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com, bjorn@mork.no, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

In order to avoid all table update, and only remove or add new
address, the auxiliary function exists, named __hw_addr_sync_dev().
It allows end driver do nothing when nothing changed and add/rm when
concrete address is firstly added or lastly removed. But it doesn't
include cases when an address of real device or vlan was reused by
other vlans or vlan/macval devices.

For handaling events when address was reused/unreused the patch adds
new auxiliary routine - __hw_addr_ref_sync_dev(). It allows to do
nothing when nothing was changed and do updates only for an address
being added/reused/deleted/unreused. Thus, clone address changes for
vlans can be mirrored in the table. The function is exclusive with
__hw_addr_sync_dev(). It's responsibility of the end driver to
identify address vlan device, if it needs so.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 include/linux/netdevice.h | 10 ++++
 net/core/dev_addr_lists.c | 97 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index dc1d9ed33b31..de95f96a6352 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4048,6 +4048,16 @@ int __hw_addr_sync_dev(struct netdev_hw_addr_list *list,
 		       int (*sync)(struct net_device *, const unsigned char *),
 		       int (*unsync)(struct net_device *,
 				     const unsigned char *));
+int __hw_addr_ref_sync_dev(struct netdev_hw_addr_list *list,
+			   struct net_device *dev,
+			   int (*sync)(struct net_device *,
+				       const unsigned char *, int),
+			   int (*unsync)(struct net_device *,
+					 const unsigned char *, int));
+void __hw_addr_ref_unsync_dev(struct netdev_hw_addr_list *list,
+			      struct net_device *dev,
+			      int (*unsync)(struct net_device *,
+					    const unsigned char *, int));
 void __hw_addr_unsync_dev(struct netdev_hw_addr_list *list,
 			  struct net_device *dev,
 			  int (*unsync)(struct net_device *,
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index d884d8f5f0e5..81a8cd4ea3bd 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -277,6 +277,103 @@ int __hw_addr_sync_dev(struct netdev_hw_addr_list *list,
 }
 EXPORT_SYMBOL(__hw_addr_sync_dev);
 
+/**
+ *  __hw_addr_ref_sync_dev - Synchronize device's multicast address list taking
+ *  into account references
+ *  @list: address list to synchronize
+ *  @dev:  device to sync
+ *  @sync: function to call if address or reference on it should be added
+ *  @unsync: function to call if address or some reference on it should removed
+ *
+ *  This function is intended to be called from the ndo_set_rx_mode
+ *  function of devices that require explicit address or references on it
+ *  add/remove notifications. The unsync function may be NULL in which case
+ *  the addresses or references on it requiring removal will simply be
+ *  removed without any notification to the device. That is responsibility of
+ *  the driver to identify and distribute address or references on it between
+ *  internal address tables.
+ **/
+int __hw_addr_ref_sync_dev(struct netdev_hw_addr_list *list,
+			   struct net_device *dev,
+			   int (*sync)(struct net_device *,
+				       const unsigned char *, int),
+			   int (*unsync)(struct net_device *,
+					 const unsigned char *, int))
+{
+	struct netdev_hw_addr *ha, *tmp;
+	int err, ref_cnt;
+
+	/* first go through and flush out any unsynced/stale entries */
+	list_for_each_entry_safe(ha, tmp, &list->list, list) {
+		/* sync if address is not used */
+		if ((ha->sync_cnt << 1) <= ha->refcount)
+			continue;
+
+		/* if fails defer unsyncing address */
+		ref_cnt = ha->refcount - ha->sync_cnt;
+		if (unsync && unsync(dev, ha->addr, ref_cnt))
+			continue;
+
+		ha->refcount = (ref_cnt << 1) + 1;
+		ha->sync_cnt = ref_cnt;
+		__hw_addr_del_entry(list, ha, false, false);
+	}
+
+	/* go through and sync updated/new entries to the list */
+	list_for_each_entry_safe(ha, tmp, &list->list, list) {
+		/* sync if address added or reused */
+		if ((ha->sync_cnt << 1) >= ha->refcount)
+			continue;
+
+		ref_cnt = ha->refcount - ha->sync_cnt;
+		err = sync(dev, ha->addr, ref_cnt);
+		if (err)
+			return err;
+
+		ha->refcount = ref_cnt << 1;
+		ha->sync_cnt = ref_cnt;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(__hw_addr_ref_sync_dev);
+
+/**
+ *  __hw_addr_ref_unsync_dev - Remove synchronized addresses and references on
+ *  it from device
+ *  @list: address list to remove synchronized addresses (references on it) from
+ *  @dev:  device to sync
+ *  @unsync: function to call if address and references on it should be removed
+ *
+ *  Remove all addresses that were added to the device by
+ *  __hw_addr_ref_sync_dev(). This function is intended to be called from the
+ *  ndo_stop or ndo_open functions on devices that require explicit address (or
+ *  references on it) add/remove notifications. If the unsync function pointer
+ *  is NULL then this function can be used to just reset the sync_cnt for the
+ *  addresses in the list.
+ **/
+void __hw_addr_ref_unsync_dev(struct netdev_hw_addr_list *list,
+			      struct net_device *dev,
+			      int (*unsync)(struct net_device *,
+					    const unsigned char *, int))
+{
+	struct netdev_hw_addr *ha, *tmp;
+
+	list_for_each_entry_safe(ha, tmp, &list->list, list) {
+		if (!ha->sync_cnt)
+			continue;
+
+		/* if fails defer unsyncing address */
+		if (unsync && unsync(dev, ha->addr, ha->sync_cnt))
+			continue;
+
+		ha->refcount -= ha->sync_cnt - 1;
+		ha->sync_cnt = 0;
+		__hw_addr_del_entry(list, ha, false, false);
+	}
+}
+EXPORT_SYMBOL(__hw_addr_ref_unsync_dev);
+
 /**
  *  __hw_addr_unsync_dev - Remove synchronized addresses from device
  *  @list: address list to remove synchronized addresses from
-- 
2.17.1

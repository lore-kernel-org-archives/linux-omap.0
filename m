From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH v3 net-next 07/11] net: ethernet: ti: cpsw: introduce cpsw switch driver based on switchdev
Date: Thu, 25 Apr 2019 01:24:23 +0300
Message-ID: <1556144667-27997-8-git-send-email-grygorii.strashko@ti.com>
References: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

The new (cpsw_new.c) driver is operating in dual-emac mode by default, thus
working as 2 individual network interfaces. When the both interfaces joined
the bridge - CPSW driver will enter a switch mode and discard dual_mac
configuration. All configuration is implemented via switchdev API.

CPSW will be switched back to dual_mac mode if any port leaves the bridge.
ALE table is completely cleared and then refiled while switching between
modes - this simplifies code a lot, but introduces some limitation to
bridge setup sequence:
 ip link add name br0 type bridge
 ip link set dev br0 type bridge ageing_time 1000
 ip link set dev br0 type bridge vlan_filtering 0 <- dis
 echo 0 > /sys/class/net/br0/bridge/default_vlan <- clean

 ip link set dev sw0p1 up
 ip link set dev sw0p2 up
 ip link set dev sw0p1 master br0
 ip link set dev sw0p2 master br0

 echo 1 > /sys/class/net/br0/bridge/default_vlan <-restore
 ip link set dev br0 type bridge vlan_filtering 1 <- en
 bridge vlan add dev br0 vid 1 pvid untagged self

Introduced CPSW switchdev driver supports mostly the same set of
functionality as legacy CPSW driver in dual_mac mode - but there still few
things to do:
- allow build both TI_CPSW and TI_CPSW_SWITCHDEV drivers
- port QDISC_CBS and QDISC_MQPRIO support
- fix following usecase
     bridge vlan add dev br0 vid 100 self
     bridge vlan add dev eth1 vid 100 self
     bridge vlan add dev eth0 vid 100 pvid untagged self
 with above cfg the application running on Host will not be able to
communicate with hosts behind eth0 (fix cpsw_rx_vlan_encap())

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/Kconfig     |   20 +-
 drivers/net/ethernet/ti/Makefile    |    2 +
 drivers/net/ethernet/ti/cpsw_new.c  | 1877 +++++++++++++++++++++++++++
 drivers/net/ethernet/ti/cpsw_priv.c |    8 +-
 drivers/net/ethernet/ti/cpsw_priv.h |   35 +-
 5 files changed, 1937 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/cpsw_new.c

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index afbdc9744230..760a7f886f8b 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -56,9 +56,25 @@ config TI_CPSW
 	  To compile this driver as a module, choose M here: the module
 	  will be called cpsw.
 
+config TI_CPSW_SWITCHDEV
+	tristate "TI CPSW Switch Support with switchdev"
+	depends on !TI_CPSW
+	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS || COMPILE_TEST
+	select NET_SWITCHDEV
+	select TI_DAVINCI_MDIO
+	select MFD_SYSCON
+	select REGMAP
+	imply PHY_TI_GMII_SEL
+	default n
+	help
+	  This driver supports TI's CPSW Ethernet Switch.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called cpsw_new.
+
 config TI_CPTS
 	bool "TI Common Platform Time Sync (CPTS) Support"
-	depends on TI_CPSW || TI_KEYSTONE_NETCP || COMPILE_TEST
+	depends on TI_CPSW || TI_KEYSTONE_NETCP || COMPILE_TEST || TI_CPSW_SWITCHDEV
 	depends on POSIX_TIMERS
 	---help---
 	  This driver supports the Common Platform Time Sync unit of
@@ -69,7 +85,7 @@ config TI_CPTS
 config TI_CPTS_MOD
 	tristate
 	depends on TI_CPTS
-	default y if TI_CPSW=y || TI_KEYSTONE_NETCP=y
+	default y if TI_CPSW=y || TI_KEYSTONE_NETCP=y || TI_CPSW_SWITCHDEV=y
 	select NET_PTP_CLASSIFY
 	imply PTP_1588_CLOCK
 	default m
diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index c3f53a40b48f..2f26c546e9b5 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -15,6 +15,8 @@ obj-$(CONFIG_TI_CPSW_PHY_SEL) += cpsw-phy-sel.o
 obj-$(CONFIG_TI_CPTS_MOD) += cpts.o
 obj-$(CONFIG_TI_CPSW) += ti_cpsw.o
 ti_cpsw-y := cpsw.o davinci_cpdma.o cpsw_ale.o cpsw_priv.o cpsw_sl.o cpsw_ethtool.o
+obj-$(CONFIG_TI_CPSW_SWITCHDEV) += ti_cpsw_new.o
+ti_cpsw_new-y := cpsw_switchdev.o cpsw_new.o davinci_cpdma.o cpsw_ale.o cpsw_sl.o cpsw_priv.o cpsw_ethtool.o
 
 obj-$(CONFIG_TI_KEYSTONE_NETCP) += keystone_netcp.o
 keystone_netcp-y := netcp_core.o cpsw_ale.o
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
new file mode 100644
index 000000000000..4ea28f722136
--- /dev/null
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -0,0 +1,1877 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Texas Instruments Ethernet Switch Driver
+ *
+ * Copyright (C) 2019 Texas Instruments
+ */
+
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/timer.h>
+#include <linux/module.h>
+#include <linux/irqreturn.h>
+#include <linux/interrupt.h>
+#include <linux/if_ether.h>
+#include <linux/etherdevice.h>
+#include <linux/net_tstamp.h>
+#include <linux/phy.h>
+#include <linux/phy/phy.h>
+#include <linux/workqueue.h>
+#include <linux/delay.h>
+#include <linux/pm_runtime.h>
+#include <linux/gpio/consumer.h>
+#include <linux/of.h>
+#include <linux/of_mdio.h>
+#include <linux/of_net.h>
+#include <linux/of_device.h>
+#include <linux/if_vlan.h>
+#include <linux/kmemleak.h>
+#include <linux/sys_soc.h>
+
+#include <linux/pinctrl/consumer.h>
+#include <net/pkt_cls.h>
+
+#include "cpsw.h"
+#include "cpsw_ale.h"
+#include "cpsw_priv.h"
+#include "cpsw_sl.h"
+#include "cpsw_switchdev.h"
+#include "cpts.h"
+#include "davinci_cpdma.h"
+
+#include <net/pkt_sched.h>
+
+static int debug_level;
+module_param(debug_level, int, 0);
+MODULE_PARM_DESC(debug_level, "cpsw debug level (NETIF_MSG bits)");
+static int ale_ageout = CPSW_ALE_AGEOUT_DEFAULT;
+static int rx_packet_max = CPSW_MAX_PACKET_SIZE;
+static int descs_pool_size = CPSW_CPDMA_DESCS_POOL_SIZE_DEFAULT;
+
+struct cpsw_switchdev_event_work {
+	struct work_struct work;
+	struct switchdev_notifier_fdb_info fdb_info;
+	struct cpsw_priv *priv;
+	unsigned long event;
+};
+
+static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
+{
+	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
+	bool enable_uni = false;
+	int i;
+
+	if (cpsw->br_members)
+		return;
+
+	/* Enabling promiscuous mode for one interface will be
+	 * common for both the interface as the interface shares
+	 * the same hardware resource.
+	 */
+	for (i = 0; i < cpsw->data.slaves; i++)
+		if (cpsw->slaves[i].ndev &&
+		    (cpsw->slaves[i].ndev->flags & IFF_PROMISC))
+			enable_uni = true;
+
+	if (!enable && enable_uni) {
+		enable = enable_uni;
+		dev_err(cpsw->dev, "promiscuity not disabled as the other interface is still in promiscuity mode\n");
+	}
+
+	if (enable) {
+		/* Enable unknown unicast, reg/unreg mcast */
+		cpsw_ale_control_set(cpsw->ale, HOST_PORT_NUM,
+				     ALE_P0_UNI_FLOOD, 1);
+
+		dev_dbg(cpsw->dev, "promiscuity enabled\n");
+	} else {
+		/* Disable unknown unicast */
+		cpsw_ale_control_set(cpsw->ale, HOST_PORT_NUM,
+				     ALE_P0_UNI_FLOOD, 0);
+		dev_dbg(cpsw->dev, "promiscuity disabled\n");
+	}
+}
+
+/**
+ * cpsw_set_mc - adds multicast entry to the table if it's not added or deletes
+ * if it's not deleted
+ * @ndev: device to sync
+ * @addr: address to be added or deleted
+ * @vid: vlan id, if vid < 0 set/unset address for real device
+ * @add: add address if the flag is set or remove otherwise
+ */
+static int cpsw_set_mc(struct net_device *ndev, const u8 *addr,
+		       int vid, int add)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int slave_no = cpsw_slave_index(cpsw, priv);
+	int mask, flags, ret;
+
+	if (vid < 0)
+		vid = cpsw->slaves[slave_no].port_vlan;
+
+	mask =  ALE_PORT_HOST;
+	flags = vid ? ALE_VLAN : 0;
+
+	if (add)
+		ret = cpsw_ale_add_mcast(cpsw->ale, addr, mask, flags, vid, 0);
+	else
+		ret = cpsw_ale_del_mcast(cpsw->ale, addr, 0, flags, vid);
+
+	return ret;
+}
+
+static int cpsw_update_vlan_mc(struct net_device *vdev, int vid, void *ctx)
+{
+	struct addr_sync_ctx *sync_ctx = ctx;
+	struct netdev_hw_addr *ha;
+	int found = 0, ret = 0;
+
+	if (!vdev || !(vdev->flags & IFF_UP))
+		return 0;
+
+	/* vlan address is relevant if its sync_cnt != 0 */
+	netdev_for_each_mc_addr(ha, vdev) {
+		if (ether_addr_equal(ha->addr, sync_ctx->addr)) {
+			found = ha->sync_cnt;
+			break;
+		}
+	}
+
+	if (found)
+		sync_ctx->consumed++;
+
+	if (sync_ctx->flush) {
+		if (!found)
+			cpsw_set_mc(sync_ctx->ndev, sync_ctx->addr, vid, 0);
+		return 0;
+	}
+
+	if (found)
+		ret = cpsw_set_mc(sync_ctx->ndev, sync_ctx->addr, vid, 1);
+
+	return ret;
+}
+
+static int cpsw_add_mc_addr(struct net_device *ndev, const u8 *addr, int num)
+{
+	struct addr_sync_ctx sync_ctx;
+	int ret;
+
+	sync_ctx.consumed = 0;
+	sync_ctx.addr = addr;
+	sync_ctx.ndev = ndev;
+	sync_ctx.flush = 0;
+
+	ret = vlan_for_each(ndev, cpsw_update_vlan_mc, &sync_ctx);
+	if (sync_ctx.consumed < num && !ret)
+		ret = cpsw_set_mc(ndev, addr, -1, 1);
+
+	return ret;
+}
+
+static int cpsw_del_mc_addr(struct net_device *ndev, const u8 *addr, int num)
+{
+	struct addr_sync_ctx sync_ctx;
+
+	sync_ctx.consumed = 0;
+	sync_ctx.addr = addr;
+	sync_ctx.ndev = ndev;
+	sync_ctx.flush = 1;
+
+	vlan_for_each(ndev, cpsw_update_vlan_mc, &sync_ctx);
+	if (sync_ctx.consumed == num)
+		cpsw_set_mc(ndev, addr, -1, 0);
+
+	return 0;
+}
+
+static int cpsw_purge_vlan_mc(struct net_device *vdev, int vid, void *ctx)
+{
+	struct addr_sync_ctx *sync_ctx = ctx;
+	struct netdev_hw_addr *ha;
+	int found = 0;
+
+	if (!vdev || !(vdev->flags & IFF_UP))
+		return 0;
+
+	/* vlan address is relevant if its sync_cnt != 0 */
+	netdev_for_each_mc_addr(ha, vdev) {
+		if (ether_addr_equal(ha->addr, sync_ctx->addr)) {
+			found = ha->sync_cnt;
+			break;
+		}
+	}
+
+	if (!found)
+		return 0;
+
+	sync_ctx->consumed++;
+	cpsw_set_mc(sync_ctx->ndev, sync_ctx->addr, vid, 0);
+	return 0;
+}
+
+static int cpsw_purge_all_mc(struct net_device *ndev, const u8 *addr, int num)
+{
+	struct addr_sync_ctx sync_ctx;
+
+	sync_ctx.addr = addr;
+	sync_ctx.ndev = ndev;
+	sync_ctx.consumed = 0;
+
+	vlan_for_each(ndev, cpsw_purge_vlan_mc, &sync_ctx);
+	if (sync_ctx.consumed < num)
+		cpsw_set_mc(ndev, addr, -1, 0);
+
+	return 0;
+}
+
+static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+
+	if (ndev->flags & IFF_PROMISC) {
+		/* Enable promiscuous mode */
+		cpsw_set_promiscious(ndev, true);
+		cpsw_ale_set_allmulti(cpsw->ale, IFF_ALLMULTI, priv->emac_port);
+		return;
+	}
+
+	/* Disable promiscuous mode */
+	cpsw_set_promiscious(ndev, false);
+
+	/* Restore allmulti on vlans if necessary */
+	cpsw_ale_set_allmulti(cpsw->ale,
+			      ndev->flags & IFF_ALLMULTI, priv->emac_port);
+
+	/* add/remove mcast address either for real netdev or for vlan */
+	__hw_addr_ref_sync_dev(&ndev->mc, ndev, cpsw_add_mc_addr,
+			       cpsw_del_mc_addr);
+}
+
+static void cpsw_rx_vlan_encap(struct sk_buff *skb)
+{
+	struct cpsw_priv *priv = netdev_priv(skb->dev);
+	u32 rx_vlan_encap_hdr = *((u32 *)skb->data);
+	struct cpsw_common *cpsw = priv->cpsw;
+	u16 vtag, vid, prio, pkt_type;
+
+	/* Remove VLAN header encapsulation word */
+	skb_pull(skb, CPSW_RX_VLAN_ENCAP_HDR_SIZE);
+
+	pkt_type = (rx_vlan_encap_hdr >>
+		    CPSW_RX_VLAN_ENCAP_HDR_PKT_TYPE_SHIFT) &
+		    CPSW_RX_VLAN_ENCAP_HDR_PKT_TYPE_MSK;
+	/* Ignore unknown & Priority-tagged packets*/
+	if (pkt_type == CPSW_RX_VLAN_ENCAP_HDR_PKT_RESERV ||
+	    pkt_type == CPSW_RX_VLAN_ENCAP_HDR_PKT_PRIO_TAG)
+		return;
+
+	vid = (rx_vlan_encap_hdr >>
+	       CPSW_RX_VLAN_ENCAP_HDR_VID_SHIFT) &
+	       VLAN_VID_MASK;
+	/* Ignore vid 0 and pass packet as is */
+	if (!vid)
+		return;
+
+	/* Untag P0 packets if set for vlan */
+	if (!cpsw_ale_get_vlan_p0_untag(cpsw->ale, vid)) {
+		prio = (rx_vlan_encap_hdr >>
+			CPSW_RX_VLAN_ENCAP_HDR_PRIO_SHIFT) &
+			CPSW_RX_VLAN_ENCAP_HDR_PRIO_MSK;
+
+		vtag = (prio << VLAN_PRIO_SHIFT) | vid;
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vtag);
+	}
+
+	/* strip vlan tag for VLAN-tagged packet */
+	if (pkt_type == CPSW_RX_VLAN_ENCAP_HDR_PKT_VLAN_TAG) {
+		memmove(skb->data + VLAN_HLEN, skb->data, 2 * ETH_ALEN);
+		skb_pull(skb, VLAN_HLEN);
+	}
+}
+
+static void cpsw_rx_handler(void *token, int len, int status)
+{
+	struct sk_buff *skb = token;
+	struct cpsw_common *cpsw;
+	struct net_device *ndev;
+	struct sk_buff *new_skb;
+	struct cpsw_priv *priv;
+	struct cpdma_chan *ch;
+	int ret = 0, port;
+
+	ndev = skb->dev;
+	cpsw = ndev_to_cpsw(ndev);
+
+	port = CPDMA_RX_SOURCE_PORT(status);
+	if (port) {
+		ndev = cpsw->slaves[--port].ndev;
+		skb->dev = ndev;
+	}
+
+	if (unlikely(status < 0) || unlikely(!netif_running(ndev))) {
+		/* In dual emac mode check for all interfaces */
+		if (cpsw->usage_count && status >= 0) {
+			/* The packet received is for the interface which
+			 * is already down and the other interface is up
+			 * and running, instead of freeing which results
+			 * in reducing of the number of rx descriptor in
+			 * DMA engine, requeue skb back to cpdma.
+			 */
+			new_skb = skb;
+			goto requeue;
+		}
+
+		/* the interface is going down, skbs are purged */
+		dev_kfree_skb_any(skb);
+		return;
+	}
+
+	priv = netdev_priv(ndev);
+	if (cpsw->br_members)
+		skb->offload_fwd_mark = 1;
+
+	new_skb = netdev_alloc_skb_ip_align(ndev, cpsw->rx_packet_max);
+	if (new_skb) {
+		skb_copy_queue_mapping(new_skb, skb);
+		skb_put(skb, len);
+		if (status & CPDMA_RX_VLAN_ENCAP)
+			cpsw_rx_vlan_encap(skb);
+		if (priv->rx_ts_enabled)
+			cpts_rx_timestamp(cpsw->cpts, skb);
+		skb->protocol = eth_type_trans(skb, ndev);
+		netif_receive_skb(skb);
+		ndev->stats.rx_bytes += len;
+		ndev->stats.rx_packets++;
+		kmemleak_not_leak(new_skb);
+	} else {
+		ndev->stats.rx_dropped++;
+		new_skb = skb;
+	}
+
+requeue:
+	if (netif_dormant(ndev)) {
+		dev_kfree_skb_any(new_skb);
+		return;
+	}
+
+	ch = cpsw->rxv[skb_get_queue_mapping(new_skb)].ch;
+	ret = cpdma_chan_submit(ch, new_skb, new_skb->data,
+				skb_tailroom(new_skb), 0);
+	if (WARN_ON(ret < 0))
+		dev_kfree_skb_any(new_skb);
+}
+
+static inline int cpsw_add_vlan_ale_entry(struct cpsw_priv *priv,
+					  unsigned short vid)
+{
+	struct cpsw_common *cpsw = priv->cpsw;
+	int unreg_mcast_mask = 0;
+	int mcast_mask;
+	u32 port_mask;
+	int ret;
+
+	port_mask = (1 << priv->emac_port) | ALE_PORT_HOST;
+
+	mcast_mask = ALE_PORT_HOST;
+	if (priv->ndev->flags & IFF_ALLMULTI)
+		unreg_mcast_mask = mcast_mask;
+
+	ret = cpsw_ale_add_vlan(cpsw->ale, vid, port_mask, 0, port_mask,
+				unreg_mcast_mask);
+	if (ret != 0)
+		return ret;
+
+	ret = cpsw_ale_add_ucast(cpsw->ale, priv->mac_addr,
+				 HOST_PORT_NUM, ALE_VLAN, vid);
+	if (ret != 0)
+		goto clean_vid;
+
+	ret = cpsw_ale_add_mcast(cpsw->ale, priv->ndev->broadcast,
+				 mcast_mask, ALE_VLAN, vid, 0);
+	if (ret != 0)
+		goto clean_vlan_ucast;
+	return 0;
+
+clean_vlan_ucast:
+	cpsw_ale_del_ucast(cpsw->ale, priv->mac_addr,
+			   HOST_PORT_NUM, ALE_VLAN, vid);
+clean_vid:
+	cpsw_ale_del_vlan(cpsw->ale, vid, 0);
+	return ret;
+}
+
+static int cpsw_ndo_vlan_rx_add_vid(struct net_device *ndev,
+				    __be16 proto, u16 vid)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int ret, i;
+
+	if (cpsw->bridge_mask)
+		dev_warn(cpsw->dev, ".ndo_vlan_rx_add_vid called in switch mode\n");
+
+	if (vid == cpsw->data.default_vlan)
+		return 0;
+
+	ret = pm_runtime_get_sync(cpsw->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(cpsw->dev);
+		return ret;
+	}
+
+	/* In dual EMAC, reserved VLAN id should not be used for
+	 * creating VLAN interfaces as this can break the dual
+	 * EMAC port separation
+	 */
+	if (!cpsw->br_members)
+		for (i = 0; i < cpsw->data.slaves; i++) {
+			if (cpsw->slaves[i].ndev &&
+			    vid == cpsw->slaves[i].port_vlan) {
+				ret = -EINVAL;
+				goto err;
+			}
+		}
+
+	dev_info(priv->dev, "Adding vlanid %d to vlan filter\n", vid);
+	ret = cpsw_add_vlan_ale_entry(priv, vid);
+err:
+	pm_runtime_put(cpsw->dev);
+	return ret;
+}
+
+static int cpsw_restore_vlans(struct net_device *vdev, int vid, void *arg)
+{
+	struct cpsw_priv *priv = arg;
+
+	if (!vdev || !vid)
+		return 0;
+
+	cpsw_ndo_vlan_rx_add_vid(priv->ndev, 0, vid);
+	return 0;
+}
+
+/* restore resources after port reset */
+static void cpsw_restore(struct cpsw_priv *priv)
+{
+	/* restore vlan configurations */
+	vlan_for_each(priv->ndev, cpsw_restore_vlans, priv);
+
+	/* TODO:*/
+	/* restore MQPRIO offload */
+/*	for_each_slave(priv, cpsw_mqprio_resume, priv); */
+
+	/* restore CBS offload */
+/*	for_each_slave(priv, cpsw_cbs_resume, priv); */
+}
+
+static void cpsw_init_stp_ale_entry(struct cpsw_common *cpsw)
+{
+	char stpa[] = {0x01, 0x80, 0xc2, 0x0, 0x0, 0x0};
+
+	cpsw_ale_add_mcast(cpsw->ale, stpa,
+			   ALE_PORT_HOST, ALE_SUPER, 0,
+			   ALE_MCAST_BLOCK_LEARN_FWD);
+}
+
+static void cpsw_init_host_port_switch(struct cpsw_priv *priv)
+{
+	struct cpsw_common *cpsw = priv->cpsw;
+	int vlan = cpsw->data.default_vlan;
+
+	writel(CPSW_FIFO_NORMAL_MODE, &cpsw->host_port_regs->tx_in_ctl);
+
+	writel(vlan, &cpsw->host_port_regs->port_vlan);
+
+	cpsw_ale_add_vlan(cpsw->ale, vlan, ALE_ALL_PORTS,
+			  ALE_ALL_PORTS, ALE_ALL_PORTS,
+			  ALE_PORT_1 | ALE_PORT_2);
+
+	cpsw_ale_add_mcast(cpsw->ale, priv->ndev->broadcast,
+			   ALE_PORT_HOST, ALE_VLAN, vlan, ALE_MCAST_FWD_2);
+	cpsw_init_stp_ale_entry(cpsw);
+
+	cpsw_ale_control_set(cpsw->ale, HOST_PORT_NUM, ALE_P0_UNI_FLOOD, 1);
+	dev_dbg(cpsw->dev, "Set P0_UNI_FLOOD\n");
+}
+
+static void cpsw_init_host_port_dual_mac(struct cpsw_priv *priv)
+{
+	struct cpsw_common *cpsw = priv->cpsw;
+	int vlan = cpsw->data.default_vlan;
+
+	writel(CPSW_FIFO_DUAL_MAC_MODE, &cpsw->host_port_regs->tx_in_ctl);
+
+	cpsw_ale_control_set(cpsw->ale, HOST_PORT_NUM, ALE_P0_UNI_FLOOD, 0);
+	dev_dbg(cpsw->dev, "unset P0_UNI_FLOOD\n");
+
+	writel(vlan, &cpsw->host_port_regs->port_vlan);
+
+	cpsw_ale_add_vlan(cpsw->ale, vlan, ALE_ALL_PORTS, ALE_ALL_PORTS, 0, 0);
+
+	cpsw_init_stp_ale_entry(cpsw);
+}
+
+static void cpsw_init_host_port(struct cpsw_priv *priv)
+{
+	struct cpsw_common *cpsw = priv->cpsw;
+	u32 control_reg;
+
+	/* soft reset the controller and initialize ale */
+	soft_reset("cpsw", &cpsw->regs->soft_reset);
+	cpsw_ale_start(cpsw->ale);
+
+	/* switch to vlan unaware mode */
+	cpsw_ale_control_set(cpsw->ale, HOST_PORT_NUM, ALE_VLAN_AWARE,
+			     CPSW_ALE_VLAN_AWARE);
+	control_reg = readl(&cpsw->regs->control);
+	control_reg |= CPSW_VLAN_AWARE | CPSW_RX_VLAN_ENCAP;
+	writel(control_reg, &cpsw->regs->control);
+
+	/* setup host port priority mapping */
+	writel_relaxed(CPDMA_TX_PRIORITY_MAP,
+		       &cpsw->host_port_regs->cpdma_tx_pri_map);
+	writel_relaxed(0, &cpsw->host_port_regs->cpdma_rx_chan_map);
+
+	/* disable priority elevation */
+	writel_relaxed(0, &cpsw->regs->ptype);
+
+	/* enable statistics collection only on all ports */
+	writel_relaxed(0x7, &cpsw->regs->stat_port_en);
+
+	/* Enable internal fifo flow control */
+	writel(0x7, &cpsw->regs->flow_control);
+
+	if (cpsw->br_members)
+		cpsw_init_host_port_switch(priv);
+	else
+		cpsw_init_host_port_dual_mac(priv);
+
+	cpsw_ale_control_set(cpsw->ale, HOST_PORT_NUM,
+			     ALE_PORT_STATE, ALE_PORT_STATE_FORWARD);
+}
+
+static void cpsw_port_add_dual_emac_def_ale_entries(struct cpsw_priv *priv,
+						    struct cpsw_slave *slave)
+{
+	u32 port_mask = 1 << priv->emac_port | ALE_PORT_HOST;
+	struct cpsw_common *cpsw = priv->cpsw;
+	u32 reg;
+
+	reg = (cpsw->version == CPSW_VERSION_1) ? CPSW1_PORT_VLAN :
+	       CPSW2_PORT_VLAN;
+	slave_write(slave, slave->port_vlan, reg);
+
+	cpsw_ale_add_vlan(cpsw->ale, slave->port_vlan, port_mask,
+			  port_mask, port_mask, 0);
+	cpsw_ale_add_mcast(cpsw->ale, priv->ndev->broadcast,
+			   ALE_PORT_HOST, ALE_VLAN, slave->port_vlan,
+			   ALE_MCAST_FWD);
+	cpsw_ale_add_ucast(cpsw->ale, priv->mac_addr,
+			   HOST_PORT_NUM, ALE_VLAN |
+			   ALE_SECURE, slave->port_vlan);
+	cpsw_ale_control_set(cpsw->ale, priv->emac_port,
+			     ALE_PORT_DROP_UNKNOWN_VLAN, 1);
+}
+
+static void cpsw_port_add_switch_def_ale_entries(struct cpsw_priv *priv,
+						 struct cpsw_slave *slave)
+{
+	u32 port_mask = 1 << priv->emac_port | ALE_PORT_HOST;
+	struct cpsw_common *cpsw = priv->cpsw;
+	u32 reg;
+
+	cpsw_ale_control_set(cpsw->ale, priv->emac_port,
+			     ALE_PORT_DROP_UNKNOWN_VLAN, 0);
+	/* disabling SA_UPDATE required to make stp work, without this setting
+	 * Host MAC addresses will jump between ports.
+	 * As per TRM MAC address can be defined as unicast supervisory (super)
+	 * by setting both (ALE_BLOCKED | ALE_SECURE) which should prevent
+	 * SA_UPDATE, but HW seems works incorrectly and setting ALE_SECURE
+	 * causes STP packets to be dropped due to ingress filter
+	 *	if (source address found) and (secure) and
+	 *	   (receive port number != port_number))
+	 *	   then discard the packet
+	 */
+	cpsw_ale_control_set(cpsw->ale, priv->emac_port,
+			     ALE_PORT_NO_SA_UPDATE, 1);
+
+	cpsw_ale_add_mcast(cpsw->ale, priv->ndev->broadcast,
+			   port_mask, ALE_VLAN, slave->port_vlan,
+			   ALE_MCAST_FWD_2);
+	cpsw_ale_add_ucast(cpsw->ale, priv->mac_addr,
+			   HOST_PORT_NUM, ALE_VLAN, slave->port_vlan);
+
+	reg = (cpsw->version == CPSW_VERSION_1) ? CPSW1_PORT_VLAN :
+	       CPSW2_PORT_VLAN;
+	slave_write(slave, slave->port_vlan, reg);
+}
+
+static void cpsw_adjust_link(struct net_device *ndev)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	struct cpsw_slave *slave;
+	struct phy_device *phy;
+	bool link = false;
+	u32 mac_control = 0;
+
+	slave = &cpsw->slaves[priv->emac_port - 1];
+	phy = slave->phy;
+
+	if (!phy)
+		return;
+
+	if (phy->link) {
+		mac_control = CPSW_SL_CTL_GMII_EN;
+
+		if (phy->speed == 1000)
+			mac_control |= CPSW_SL_CTL_GIG;
+		if (phy->duplex)
+			mac_control |= CPSW_SL_CTL_FULLDUPLEX;
+
+		/* set speed_in input in case RMII mode is used in 100Mbps */
+		if (phy->speed == 100)
+			mac_control |= CPSW_SL_CTL_IFCTL_A;
+		/* in band mode only works in 10Mbps RGMII mode */
+		else if ((phy->speed == 10) && phy_interface_is_rgmii(phy))
+			mac_control |= CPSW_SL_CTL_EXT_EN; /* In Band mode */
+
+		if (priv->rx_pause)
+			mac_control |= CPSW_SL_CTL_RX_FLOW_EN;
+
+		if (priv->tx_pause)
+			mac_control |= CPSW_SL_CTL_TX_FLOW_EN;
+
+		if (mac_control != slave->mac_control)
+			cpsw_sl_ctl_set(slave->mac_sl, mac_control);
+
+		/* enable forwarding */
+		cpsw_ale_control_set(cpsw->ale, priv->emac_port,
+				     ALE_PORT_STATE, ALE_PORT_STATE_FORWARD);
+
+		link = true;
+
+		/* TODO:
+		 * if (priv->shp_cfg_speed &&
+		 *   priv->shp_cfg_speed != slave->phy->speed &&
+		 *   !cpsw_shp_is_off(priv))
+		 *	dev_warn(priv->dev,
+		 *	 "Speed was changed, CBS shaper speeds are changed!");
+		 */
+	} else {
+		mac_control = 0;
+		/* disable forwarding */
+		cpsw_ale_control_set(cpsw->ale, priv->emac_port,
+				     ALE_PORT_STATE, ALE_PORT_STATE_DISABLE);
+
+		cpsw_sl_wait_for_idle(slave->mac_sl, 100);
+
+		cpsw_sl_ctl_reset(slave->mac_sl);
+	}
+
+	if (mac_control != slave->mac_control)
+		phy_print_status(phy);
+
+	slave->mac_control = mac_control;
+
+	if (link) {
+		if (cpsw_need_resplit(cpsw))
+			cpsw_split_res(cpsw);
+
+		if (netif_running(ndev))
+			netif_tx_wake_all_queues(ndev);
+	} else {
+		netif_tx_stop_all_queues(ndev);
+	}
+}
+
+static void cpsw_slave_open(struct cpsw_slave *slave, struct cpsw_priv *priv)
+{
+	struct cpsw_common *cpsw = priv->cpsw;
+	struct phy_device *phy;
+
+	cpsw_sl_reset(slave->mac_sl, 100);
+	cpsw_sl_ctl_reset(slave->mac_sl);
+
+	/* setup priority mapping */
+	cpsw_sl_reg_write(slave->mac_sl, CPSW_SL_RX_PRI_MAP,
+			  RX_PRIORITY_MAPPING);
+
+	switch (cpsw->version) {
+	case CPSW_VERSION_1:
+		slave_write(slave, TX_PRIORITY_MAPPING, CPSW1_TX_PRI_MAP);
+		/* Increase RX FIFO size to 5 for supporting fullduplex
+		 * flow control mode
+		 */
+		slave_write(slave,
+			    (CPSW_MAX_BLKS_TX << CPSW_MAX_BLKS_TX_SHIFT) |
+			    CPSW_MAX_BLKS_RX, CPSW1_MAX_BLKS);
+		break;
+	case CPSW_VERSION_2:
+	case CPSW_VERSION_3:
+	case CPSW_VERSION_4:
+		slave_write(slave, TX_PRIORITY_MAPPING, CPSW2_TX_PRI_MAP);
+		/* Increase RX FIFO size to 5 for supporting fullduplex
+		 * flow control mode
+		 */
+		slave_write(slave,
+			    (CPSW_MAX_BLKS_TX << CPSW_MAX_BLKS_TX_SHIFT) |
+			    CPSW_MAX_BLKS_RX, CPSW2_MAX_BLKS);
+		break;
+	}
+
+	/* setup max packet size, and mac address */
+	cpsw_sl_reg_write(slave->mac_sl, CPSW_SL_RX_MAXLEN,
+			  cpsw->rx_packet_max);
+	cpsw_set_slave_mac(slave, priv);
+
+	slave->mac_control = 0;	/* no link yet */
+
+	if (cpsw->br_members)
+		cpsw_port_add_switch_def_ale_entries(priv, slave);
+	else
+		cpsw_port_add_dual_emac_def_ale_entries(priv, slave);
+
+	if (!slave->data->phy_node)
+		dev_err(priv->dev, "no phy found on slave %d\n",
+			slave->slave_num);
+	phy = of_phy_connect(priv->ndev, slave->data->phy_node,
+			     &cpsw_adjust_link, 0, slave->data->phy_if);
+	if (!phy) {
+		dev_err(priv->dev, "phy \"%pOF\" not found on slave %d\n",
+			slave->data->phy_node,
+			slave->slave_num);
+		return;
+	}
+	slave->phy = phy;
+
+	phy_attached_info(slave->phy);
+
+	phy_start(slave->phy);
+
+	/* Configure GMII_SEL register */
+	phy_set_mode_ext(slave->data->ifphy, PHY_MODE_ETHERNET,
+			 slave->data->phy_if);
+}
+
+static void cpsw_slave_stop(struct cpsw_slave *slave, struct cpsw_priv *priv)
+{
+	struct cpsw_common *cpsw = priv->cpsw;
+	u32 slave_port;
+
+	slave_port = priv->emac_port;
+
+	if (!slave->phy)
+		return;
+	phy_stop(slave->phy);
+	phy_disconnect(slave->phy);
+	slave->phy = NULL;
+	cpsw_ale_control_set(cpsw->ale, slave_port,
+			     ALE_PORT_STATE, ALE_PORT_STATE_DISABLE);
+	cpsw_sl_reset(slave->mac_sl, 100);
+	cpsw_sl_ctl_reset(slave->mac_sl);
+}
+
+static int cpsw_ndo_open(struct net_device *ndev)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int ret;
+	u32 reg;
+
+	ret = pm_runtime_get_sync(cpsw->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(cpsw->dev);
+		return ret;
+	}
+
+	netif_carrier_off(ndev);
+
+	/* Notify the stack of the actual queue counts. */
+	ret = netif_set_real_num_tx_queues(ndev, cpsw->tx_ch_num);
+	if (ret) {
+		dev_err(priv->dev, "cannot set real number of tx queues\n");
+		goto err_cleanup;
+	}
+
+	ret = netif_set_real_num_rx_queues(ndev, cpsw->rx_ch_num);
+	if (ret) {
+		dev_err(priv->dev, "cannot set real number of rx queues\n");
+		goto err_cleanup;
+	}
+
+	reg = cpsw->version;
+
+	dev_info(priv->dev, "initializing cpsw version %d.%d (%d)\n",
+		 CPSW_MAJOR_VERSION(reg), CPSW_MINOR_VERSION(reg),
+		 CPSW_RTL_VERSION(reg));
+
+	/* Initialize host and slave ports */
+	if (!cpsw->usage_count)
+		cpsw_init_host_port(priv);
+	cpsw_slave_open(&cpsw->slaves[priv->emac_port - 1], priv);
+
+	/* initialize shared resources for every ndev */
+	if (!cpsw->usage_count) {
+		ret = cpsw_fill_rx_channels(priv);
+		if (ret < 0)
+			goto err_cleanup;
+
+		if (cpts_register(cpsw->cpts))
+			dev_err(priv->dev, "error registering cpts device\n");
+
+		napi_enable(&cpsw->napi_rx);
+		napi_enable(&cpsw->napi_tx);
+
+		if (cpsw->tx_irq_disabled) {
+			cpsw->tx_irq_disabled = false;
+			enable_irq(cpsw->irqs_table[1]);
+		}
+
+		if (cpsw->rx_irq_disabled) {
+			cpsw->rx_irq_disabled = false;
+			enable_irq(cpsw->irqs_table[0]);
+		}
+	}
+
+	cpsw_restore(priv);
+
+	/* Enable Interrupt pacing if configured */
+	if (cpsw->coal_intvl != 0) {
+		struct ethtool_coalesce coal;
+
+		coal.rx_coalesce_usecs = cpsw->coal_intvl;
+		cpsw_set_coalesce(ndev, &coal);
+	}
+
+	cpdma_ctlr_start(cpsw->dma);
+	cpsw_intr_enable(cpsw);
+	cpsw->usage_count++;
+
+	return 0;
+
+err_cleanup:
+	cpdma_ctlr_stop(cpsw->dma);
+	cpsw_slave_stop(&cpsw->slaves[priv->emac_port - 1], priv);
+	pm_runtime_put_sync(cpsw->dev);
+	netif_carrier_off(priv->ndev);
+	return ret;
+}
+
+static int cpsw_ndo_stop(struct net_device *ndev)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+
+	cpsw_info(priv, ifdown, "shutting down cpsw device\n");
+	__hw_addr_ref_unsync_dev(&ndev->mc, ndev, cpsw_purge_all_mc);
+	netif_tx_stop_all_queues(priv->ndev);
+	netif_carrier_off(priv->ndev);
+
+	if (cpsw->usage_count <= 1) {
+		napi_disable(&cpsw->napi_rx);
+		napi_disable(&cpsw->napi_tx);
+		cpts_unregister(cpsw->cpts);
+		cpsw_intr_disable(cpsw);
+		cpdma_ctlr_stop(cpsw->dma);
+		cpsw_ale_stop(cpsw->ale);
+	}
+	cpsw_slave_stop(&cpsw->slaves[priv->emac_port - 1], priv);
+
+	if (cpsw_need_resplit(cpsw))
+		cpsw_split_res(cpsw);
+
+	cpsw->usage_count--;
+	pm_runtime_put_sync(cpsw->dev);
+	return 0;
+}
+
+static netdev_tx_t cpsw_ndo_start_xmit(struct sk_buff *skb,
+				       struct net_device *ndev)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	struct cpts *cpts = cpsw->cpts;
+	struct netdev_queue *txq;
+	struct cpdma_chan *txch;
+	int ret, q_idx;
+
+	if (skb_padto(skb, CPSW_MIN_PACKET_SIZE)) {
+		cpsw_err(priv, tx_err, "packet pad failed\n");
+		ndev->stats.tx_dropped++;
+		return NET_XMIT_DROP;
+	}
+
+	if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
+	    priv->tx_ts_enabled && cpts_can_timestamp(cpts, skb))
+		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+
+	q_idx = skb_get_queue_mapping(skb);
+	if (q_idx >= cpsw->tx_ch_num)
+		q_idx = q_idx % cpsw->tx_ch_num;
+
+	txch = cpsw->txv[q_idx].ch;
+	txq = netdev_get_tx_queue(ndev, q_idx);
+	skb_tx_timestamp(skb);
+	ret = cpdma_chan_submit(txch, skb, skb->data, skb->len,
+				priv->emac_port);
+	if (unlikely(ret != 0)) {
+		cpsw_err(priv, tx_err, "desc submit failed\n");
+		goto fail;
+	}
+
+	/* If there is no more tx desc left free then we need to
+	 * tell the kernel to stop sending us tx frames.
+	 */
+	if (unlikely(!cpdma_check_free_tx_desc(txch))) {
+		netif_tx_stop_queue(txq);
+
+		/* Barrier, so that stop_queue visible to other cpus */
+		smp_mb__after_atomic();
+
+		if (cpdma_check_free_tx_desc(txch))
+			netif_tx_wake_queue(txq);
+	}
+
+	return NETDEV_TX_OK;
+fail:
+	ndev->stats.tx_dropped++;
+	netif_tx_stop_queue(txq);
+
+	/* Barrier, so that stop_queue visible to other cpus */
+	smp_mb__after_atomic();
+
+	if (cpdma_check_free_tx_desc(txch))
+		netif_tx_wake_queue(txq);
+
+	return NETDEV_TX_BUSY;
+}
+
+static int cpsw_ndo_set_mac_address(struct net_device *ndev, void *p)
+{
+	struct sockaddr *addr = (struct sockaddr *)p;
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int slave_no = cpsw_slave_index(cpsw, priv);
+	int flags = 0;
+	u16 vid = 0;
+	int ret;
+
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	ret = pm_runtime_get_sync(cpsw->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(cpsw->dev);
+		return ret;
+	}
+
+	vid = cpsw->slaves[slave_no].port_vlan;
+	flags = ALE_VLAN | ALE_SECURE;
+
+	cpsw_ale_del_ucast(cpsw->ale, priv->mac_addr, HOST_PORT_NUM,
+			   flags, vid);
+	cpsw_ale_add_ucast(cpsw->ale, addr->sa_data, HOST_PORT_NUM,
+			   flags, vid);
+
+	ether_addr_copy(priv->mac_addr, addr->sa_data);
+	ether_addr_copy(ndev->dev_addr, priv->mac_addr);
+	cpsw_set_slave_mac(&cpsw->slaves[slave_no], priv);
+
+	pm_runtime_put(cpsw->dev);
+
+	return 0;
+}
+
+static int cpsw_ndo_vlan_rx_kill_vid(struct net_device *ndev,
+				     __be16 proto, u16 vid)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int ret;
+	int i;
+
+	if (cpsw->bridge_mask)
+		dev_warn(cpsw->dev, "ndo del vlan is called in switch mode\n");
+
+	if (vid == cpsw->data.default_vlan)
+		return 0;
+
+	ret = pm_runtime_get_sync(cpsw->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(cpsw->dev);
+		return ret;
+	}
+
+	if (!cpsw->br_members)
+		for (i = 0; i < cpsw->data.slaves; i++) {
+			if (cpsw->slaves[i].ndev &&
+			    vid == cpsw->slaves[i].port_vlan)
+				goto err;
+		}
+
+	dev_info(priv->dev, "removing vlanid %d from vlan filter\n", vid);
+	ret = cpsw_ale_del_vlan(cpsw->ale, vid, 0);
+	ret |= cpsw_ale_del_ucast(cpsw->ale, priv->mac_addr,
+				  HOST_PORT_NUM, ALE_VLAN, vid);
+	ret |= cpsw_ale_del_mcast(cpsw->ale, priv->ndev->broadcast,
+				  0, ALE_VLAN, vid);
+	ret |= cpsw_ale_flush_multicast(cpsw->ale, 0, vid);
+err:
+	pm_runtime_put(cpsw->dev);
+	return ret;
+}
+
+static int cpsw_ndo_get_phys_port_name(struct net_device *ndev, char *name,
+				       size_t len)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	int err;
+
+	err = snprintf(name, len, "p%d", priv->emac_port);
+
+	if (err >= len)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct net_device_ops cpsw_netdev_ops = {
+	.ndo_open		= cpsw_ndo_open,
+	.ndo_stop		= cpsw_ndo_stop,
+	.ndo_start_xmit		= cpsw_ndo_start_xmit,
+	.ndo_set_mac_address	= cpsw_ndo_set_mac_address,
+	.ndo_do_ioctl		= cpsw_ndo_ioctl,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_tx_timeout		= cpsw_ndo_tx_timeout,
+	.ndo_set_rx_mode	= cpsw_ndo_set_rx_mode,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller	= cpsw_ndo_poll_controller,
+#endif
+	.ndo_vlan_rx_add_vid	= cpsw_ndo_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= cpsw_ndo_vlan_rx_kill_vid,
+	.ndo_get_phys_port_name = cpsw_ndo_get_phys_port_name,
+};
+
+static void cpsw_get_drvinfo(struct net_device *ndev,
+			     struct ethtool_drvinfo *info)
+{
+	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
+	struct platform_device	*pdev = to_platform_device(cpsw->dev);
+
+	strlcpy(info->driver, "cpsw-switch", sizeof(info->driver));
+	strlcpy(info->version, "2.0", sizeof(info->version));
+	strlcpy(info->bus_info, pdev->name, sizeof(info->bus_info));
+}
+
+static int cpsw_set_pauseparam(struct net_device *ndev,
+			       struct ethtool_pauseparam *pause)
+{
+	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
+	struct cpsw_priv *priv = netdev_priv(ndev);
+
+	priv->rx_pause = pause->rx_pause ? true : false;
+	priv->tx_pause = pause->tx_pause ? true : false;
+
+	return phy_restart_aneg(cpsw->slaves[priv->emac_port - 1].phy);
+}
+
+static int cpsw_set_channels(struct net_device *ndev,
+			     struct ethtool_channels *chs)
+{
+	return cpsw_set_channels_common(ndev, chs, cpsw_rx_handler);
+}
+
+static const struct ethtool_ops cpsw_ethtool_ops = {
+	.get_drvinfo		= cpsw_get_drvinfo,
+	.get_msglevel		= cpsw_get_msglevel,
+	.set_msglevel		= cpsw_set_msglevel,
+	.get_link		= ethtool_op_get_link,
+	.get_ts_info		= cpsw_get_ts_info,
+	.get_coalesce		= cpsw_get_coalesce,
+	.set_coalesce		= cpsw_set_coalesce,
+	.get_sset_count		= cpsw_get_sset_count,
+	.get_strings		= cpsw_get_strings,
+	.get_ethtool_stats	= cpsw_get_ethtool_stats,
+	.get_pauseparam		= cpsw_get_pauseparam,
+	.set_pauseparam		= cpsw_set_pauseparam,
+	.get_wol		= cpsw_get_wol,
+	.set_wol		= cpsw_set_wol,
+	.get_regs_len		= cpsw_get_regs_len,
+	.get_regs		= cpsw_get_regs,
+	.begin			= cpsw_ethtool_op_begin,
+	.complete		= cpsw_ethtool_op_complete,
+	.get_channels		= cpsw_get_channels,
+	.set_channels		= cpsw_set_channels,
+	.get_link_ksettings	= cpsw_get_link_ksettings,
+	.set_link_ksettings	= cpsw_set_link_ksettings,
+	.get_eee		= cpsw_get_eee,
+	.set_eee		= cpsw_set_eee,
+	.nway_reset		= cpsw_nway_reset,
+	.get_ringparam		= cpsw_get_ringparam,
+	.set_ringparam		= cpsw_set_ringparam,
+};
+
+static int cpsw_probe_dt(struct cpsw_common *cpsw)
+{
+	struct device_node *node = cpsw->dev->of_node, *tmp_node, *port_np;
+	struct cpsw_platform_data *data = &cpsw->data;
+	struct device *dev = cpsw->dev;
+	int ret;
+	u32 prop;
+
+	if (!node)
+		return -EINVAL;
+
+	tmp_node = of_get_child_by_name(node, "ports");
+	if (!tmp_node)
+		return -ENOENT;
+	data->slaves = of_get_child_count(tmp_node);
+	if (data->slaves < CPSW_SLAVE_PORTS_NUM)
+		return -ENOENT;
+	of_node_put(tmp_node);
+
+	data->active_slave = 0;
+	data->channels = CPSW_MAX_QUEUES;
+	data->ale_entries = CPSW_ALE_NUM_ENTRIES;
+	data->dual_emac = 1;
+	data->bd_ram_size = CPSW_BD_RAM_SIZE;
+	data->mac_control = 0;
+
+	data->slave_data = devm_kcalloc(dev, CPSW_SLAVE_PORTS_NUM,
+					sizeof(struct cpsw_slave_data),
+					GFP_KERNEL);
+	if (!data->slave_data)
+		return -ENOMEM;
+
+	/* Populate all the child nodes here...
+	 */
+	ret = devm_of_platform_populate(dev);
+	/* We do not want to force this, as in some cases may not have child */
+	if (ret)
+		dev_warn(dev, "Doesn't have any child node\n");
+
+	tmp_node = of_get_child_by_name(node, "ports");
+	if (!tmp_node)
+		return -ENOENT;
+
+	for_each_child_of_node(tmp_node, port_np) {
+		struct cpsw_slave_data *slave_data;
+		const void *mac_addr;
+		u32 port_id;
+
+		ret = of_property_read_u32(port_np, "reg", &port_id);
+		if (ret < 0) {
+			dev_err(dev, "%pOF error reading port_id %d\n",
+				port_np, ret);
+			return ret;
+		}
+
+		if (!port_id || port_id > CPSW_SLAVE_PORTS_NUM) {
+			dev_err(dev, "%pOF has invalid port_id %u\n",
+				port_np, port_id);
+			return -EINVAL;
+		}
+
+		slave_data = &data->slave_data[port_id - 1];
+
+		slave_data->disabled = !of_device_is_available(port_np);
+		if (slave_data->disabled)
+			continue;
+
+		slave_data->ifphy = devm_of_phy_get(dev, port_np, NULL);
+		if (IS_ERR(slave_data->ifphy)) {
+			ret = PTR_ERR(slave_data->ifphy);
+			dev_err(dev, "%pOF: Error retrieving port phy: %d\n",
+				port_np, ret);
+			return ret;
+		}
+
+		if (of_phy_is_fixed_link(port_np)) {
+			ret = of_phy_register_fixed_link(port_np);
+			if (ret) {
+				if (ret != -EPROBE_DEFER)
+					dev_err(dev, "%pOF failed to register fixed-link phy: %d\n",
+						port_np, ret);
+				return ret;
+			}
+			slave_data->phy_node = of_node_get(port_np);
+		} else {
+			slave_data->phy_node =
+				of_parse_phandle(port_np, "phy-handle", 0);
+		}
+
+		if (!slave_data->phy_node) {
+			dev_err(dev, "%pOF no phy found\n", port_np);
+			return -ENODEV;
+		}
+
+		slave_data->phy_if = of_get_phy_mode(port_np);
+		if (slave_data->phy_if < 0) {
+			dev_err(dev, "%pOF read phy-mode err %d\n",
+				port_np, slave_data->phy_if);
+			return slave_data->phy_if;
+		}
+
+		mac_addr = of_get_mac_address(port_np);
+		if (mac_addr) {
+			ether_addr_copy(slave_data->mac_addr, mac_addr);
+		} else {
+			ret = ti_cm_get_macid(dev, port_id - 1,
+					      slave_data->mac_addr);
+			if (ret)
+				return ret;
+		}
+
+		if (of_property_read_u32(port_np, "dual_emac_res_vlan",
+					 &prop)) {
+			dev_err(dev, "%pOF Missing dual_emac_res_vlan in DT.\n",
+				port_np);
+			slave_data->dual_emac_res_vlan = port_id;
+			dev_err(dev, "%pOF Using %d as Reserved VLAN\n",
+				port_np, slave_data->dual_emac_res_vlan);
+		} else {
+			slave_data->dual_emac_res_vlan = prop;
+		}
+	}
+	of_node_put(tmp_node);
+
+	return 0;
+}
+
+static void cpsw_remove_dt(struct cpsw_common *cpsw)
+{
+	struct cpsw_platform_data *data = &cpsw->data;
+	int i = 0;
+
+	for (i = 0; i < cpsw->data.slaves; i++) {
+		struct cpsw_slave_data *slave_data = &data->slave_data[i];
+		struct device_node *port_np = slave_data->phy_node;
+
+		if (port_np) {
+			if (of_phy_is_fixed_link(port_np))
+				of_phy_deregister_fixed_link(port_np);
+
+			of_node_put(port_np);
+		}
+	}
+}
+
+static int cpsw_create_ports(struct cpsw_common *cpsw)
+{
+	struct cpsw_platform_data *data = &cpsw->data;
+	struct device *dev = cpsw->dev;
+	struct net_device *ndev, *napi_ndev = NULL;
+	struct cpsw_priv *priv;
+	int ret = 0, i = 0;
+
+	for (i = 0; i < cpsw->data.slaves; i++) {
+		struct cpsw_slave_data *slave_data = &data->slave_data[i];
+
+		if (slave_data->disabled)
+			continue;
+
+		ndev = devm_alloc_etherdev_mqs(dev, sizeof(struct cpsw_priv),
+					       CPSW_MAX_QUEUES,
+					       CPSW_MAX_QUEUES);
+		if (!ndev) {
+			dev_err(dev, "error allocating net_device\n");
+			return -ENOMEM;
+		}
+
+		priv = netdev_priv(ndev);
+		priv->cpsw = cpsw;
+		priv->ndev = ndev;
+		priv->dev  = dev;
+		priv->msg_enable = netif_msg_init(debug_level, CPSW_DEBUG);
+		priv->emac_port = i + 1;
+
+		if (is_valid_ether_addr(slave_data->mac_addr)) {
+			ether_addr_copy(priv->mac_addr, slave_data->mac_addr);
+			dev_info(cpsw->dev, "cpsw: Detected MACID = %pM\n",
+				 priv->mac_addr);
+		} else {
+			eth_random_addr(slave_data->mac_addr);
+			dev_info(cpsw->dev, "cpsw: Random MACID = %pM\n",
+				 priv->mac_addr);
+		}
+		ether_addr_copy(ndev->dev_addr, slave_data->mac_addr);
+		ether_addr_copy(priv->mac_addr, slave_data->mac_addr);
+
+		cpsw->slaves[i].ndev = ndev;
+
+		ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER |
+				  NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_NETNS_LOCAL;
+
+		ndev->netdev_ops = &cpsw_netdev_ops;
+		ndev->ethtool_ops = &cpsw_ethtool_ops;
+		SET_NETDEV_DEV(ndev, dev);
+
+		if (!napi_ndev) {
+			netif_napi_add(ndev, &cpsw->napi_rx,
+				       cpsw->quirk_irq ?
+				       cpsw_rx_poll : cpsw_rx_mq_poll,
+				       CPSW_POLL_WEIGHT);
+			netif_tx_napi_add(ndev, &cpsw->napi_tx,
+					  cpsw->quirk_irq ?
+					  cpsw_tx_poll : cpsw_tx_mq_poll,
+					  CPSW_POLL_WEIGHT);
+		}
+
+		/* register the network device */
+		ret = register_netdev(ndev);
+		if (ret) {
+			dev_err(dev, "cpsw: err registering net device%d\n", i);
+			cpsw->slaves[i].ndev = NULL;
+			return ret;
+		}
+		napi_ndev = ndev;
+	}
+
+	return ret;
+}
+
+static void cpsw_unregister_ports(struct cpsw_common *cpsw)
+{
+	struct cpsw_platform_data *data = &cpsw->data;
+	int i = 0;
+
+	for (i = 0; i < cpsw->data.slaves; i++) {
+		struct cpsw_slave_data *slave_data = &data->slave_data[i];
+
+		if (slave_data->disabled || !cpsw->slaves[i].ndev)
+			continue;
+		if (cpsw->slaves[i].ndev)
+			unregister_netdev(cpsw->slaves[i].ndev);
+	}
+}
+
+static bool cpsw_port_dev_check(const struct net_device *dev)
+{
+	return dev->netdev_ops == &cpsw_netdev_ops;
+}
+
+static void cpsw_fdb_offload_notify(struct net_device *ndev,
+				    struct switchdev_notifier_fdb_info *rcv)
+{
+	struct switchdev_notifier_fdb_info info;
+
+	info.addr = rcv->addr;
+	info.vid = rcv->vid;
+	info.offloaded = true;
+	call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED,
+				 ndev, &info.info, NULL);
+}
+
+static void cpsw_switchdev_event_work(struct work_struct *work)
+{
+	struct cpsw_switchdev_event_work *switchdev_work =
+		container_of(work, struct cpsw_switchdev_event_work, work);
+	struct cpsw_priv *priv = switchdev_work->priv;
+	struct switchdev_notifier_fdb_info *fdb;
+	struct cpsw_common *cpsw = priv->cpsw;
+	int port = priv->emac_port;
+
+	rtnl_lock();
+	switch (switchdev_work->event) {
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+		fdb = &switchdev_work->fdb_info;
+
+		if (!fdb->added_by_user)
+			break;
+		if (memcmp(priv->mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
+			port = HOST_PORT_NUM;
+
+		dev_dbg(cpsw->dev, "cpsw_fdb_add: MACID = %pM vid = %u flags = %u %u -- port %d\n",
+			fdb->addr, fdb->vid, fdb->added_by_user,
+			fdb->offloaded, port);
+
+		cpsw_ale_add_ucast(cpsw->ale, (u8 *)fdb->addr, port,
+				   fdb->vid ? ALE_VLAN : 0, fdb->vid);
+		cpsw_fdb_offload_notify(priv->ndev, fdb);
+		break;
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		fdb = &switchdev_work->fdb_info;
+
+		if (!fdb->added_by_user)
+			break;
+		if (memcmp(priv->mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
+			port = HOST_PORT_NUM;
+
+		dev_dbg(cpsw->dev, "cpsw_fdb_del: MACID = %pM vid = %u flags = %u %u -- port %d\n",
+			fdb->addr, fdb->vid, fdb->added_by_user,
+			fdb->offloaded, port);
+
+		cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port,
+				   fdb->vid ? ALE_VLAN : 0, fdb->vid);
+		break;
+	default:
+		break;
+	}
+	rtnl_unlock();
+
+	kfree(switchdev_work->fdb_info.addr);
+	kfree(switchdev_work);
+	dev_put(priv->ndev);
+}
+
+/* called under rcu_read_lock() */
+static int cpsw_switchdev_event(struct notifier_block *unused,
+				unsigned long event, void *ptr)
+{
+	struct net_device *ndev = switchdev_notifier_info_to_dev(ptr);
+	struct switchdev_notifier_fdb_info *fdb_info = ptr;
+	struct cpsw_switchdev_event_work *switchdev_work;
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	int err;
+
+	if (event == SWITCHDEV_PORT_ATTR_SET) {
+		err = switchdev_handle_port_attr_set(ndev, ptr,
+						     cpsw_port_dev_check,
+						     cpsw_port_attr_set);
+		return notifier_from_errno(err);
+	}
+
+	if (!cpsw_port_dev_check(ndev))
+		return NOTIFY_DONE;
+
+	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
+	if (WARN_ON(!switchdev_work))
+		return NOTIFY_BAD;
+
+	INIT_WORK(&switchdev_work->work, cpsw_switchdev_event_work);
+	switchdev_work->priv = priv;
+	switchdev_work->event = event;
+
+	switch (event) {
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		memcpy(&switchdev_work->fdb_info, ptr,
+		       sizeof(switchdev_work->fdb_info));
+		switchdev_work->fdb_info.addr = kzalloc(ETH_ALEN, GFP_ATOMIC);
+		if (!switchdev_work->fdb_info.addr)
+			goto err_addr_alloc;
+		ether_addr_copy((u8 *)switchdev_work->fdb_info.addr,
+				fdb_info->addr);
+		dev_hold(ndev);
+		break;
+	default:
+		kfree(switchdev_work);
+		return NOTIFY_DONE;
+	}
+
+	queue_work(system_long_wq, &switchdev_work->work);
+
+	return NOTIFY_DONE;
+
+err_addr_alloc:
+	kfree(switchdev_work);
+	return NOTIFY_BAD;
+}
+
+static struct notifier_block cpsw_switchdev_notifier = {
+	.notifier_call = cpsw_switchdev_event,
+};
+
+static int cpsw_switchdev_blocking_event(struct notifier_block *unused,
+					 unsigned long event, void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	int err;
+
+	switch (event) {
+	case SWITCHDEV_PORT_OBJ_ADD:
+		err = switchdev_handle_port_obj_add(dev, ptr,
+						    cpsw_port_dev_check,
+						    cpsw_port_obj_add);
+		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_OBJ_DEL:
+		err = switchdev_handle_port_obj_del(dev, ptr,
+						    cpsw_port_dev_check,
+						    cpsw_port_obj_del);
+		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = switchdev_handle_port_attr_set(dev, ptr,
+						     cpsw_port_dev_check,
+						     cpsw_port_attr_set);
+		return notifier_from_errno(err);
+	default:
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block cpsw_switchdev_bl_notifier = {
+	.notifier_call = cpsw_switchdev_blocking_event,
+};
+
+static void cpsw_netdevice_port_link(struct net_device *ndev,
+				     struct net_device *br_ndev)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int vlan = cpsw->data.default_vlan;
+	struct cpsw_slave *slave;
+	int i;
+
+	priv->hw_bridge_dev = br_ndev;
+	cpsw->bridge_mask |= BIT(priv->emac_port);
+
+	/* enable full switch mode only if both ports attached
+	 * to the same bridge
+	 */
+	if (cpsw->bridge_mask == (ALE_PORT_1 | ALE_PORT_2)) {
+		struct cpsw_priv *priv1 = netdev_priv(cpsw->slaves[0].ndev);
+		struct cpsw_priv *priv2 = netdev_priv(cpsw->slaves[1].ndev);
+
+		if (priv1->hw_bridge_dev == priv2->hw_bridge_dev)
+			cpsw->br_members = cpsw->bridge_mask;
+	}
+
+	if (!cpsw->br_members)
+		return;
+
+	dev_dbg(cpsw->dev, "Enable full switch mode\n");
+	cpsw_ale_control_set(cpsw->ale, HOST_PORT_NUM,
+			     ALE_PORT_STATE, ALE_PORT_STATE_DISABLE);
+
+	for (i = 0; i < cpsw->data.slaves; i++) {
+		slave = &cpsw->slaves[i];
+		__hw_addr_ref_unsync_dev(&slave->ndev->mc, ndev,
+					 cpsw_purge_all_mc);
+	}
+
+	cpsw_ale_control_set(cpsw->ale, 0, ALE_CLEAR, 1);
+	cpsw_ale_control_get(cpsw->ale, 0, ALE_AGEOUT);
+
+	for (i = 0; i < cpsw->data.slaves; i++) {
+		slave = &cpsw->slaves[i];
+		priv = netdev_priv(slave->ndev);
+		slave->port_vlan = vlan;
+
+		cpsw_port_add_switch_def_ale_entries(priv, slave);
+	}
+
+	cpsw_init_host_port_switch(priv);
+	cpsw_ale_control_set(cpsw->ale, HOST_PORT_NUM,
+			     ALE_PORT_STATE, ALE_PORT_STATE_FORWARD);
+}
+
+static void cpsw_netdevice_port_unlink(struct net_device *ndev)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	struct cpsw_slave *slave;
+	int i;
+
+	priv->hw_bridge_dev = NULL;
+	cpsw->bridge_mask &= ~BIT(priv->emac_port);
+	cpsw->br_members = 0;
+
+	dev_dbg(cpsw->dev, "Disable full switch mode\n");
+
+	cpsw_ale_control_set(cpsw->ale, HOST_PORT_NUM,
+			     ALE_PORT_STATE, ALE_PORT_STATE_DISABLE);
+
+	cpsw_ale_control_set(cpsw->ale, 0, ALE_CLEAR, 1);
+	cpsw_ale_control_get(cpsw->ale, 0, ALE_AGEOUT);
+
+	cpsw_init_host_port_dual_mac(priv);
+
+	for (i = 0; i < cpsw->data.slaves; i++) {
+		slave = &cpsw->slaves[i];
+		priv = netdev_priv(slave->ndev);
+		slave->port_vlan = slave->data->dual_emac_res_vlan;
+		// add default vlans and ALE entries
+		cpsw_port_add_dual_emac_def_ale_entries(priv, slave);
+	}
+	cpsw_ale_control_set(cpsw->ale, HOST_PORT_NUM,
+			     ALE_PORT_STATE, ALE_PORT_STATE_FORWARD);
+}
+
+/* netdev notifier */
+static int cpsw_netdevice_event(struct notifier_block *unused,
+				unsigned long event, void *ptr)
+{
+	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
+	struct netdev_notifier_changeupper_info *info;
+	struct netlink_ext_ack *extack;
+
+	if (!cpsw_port_dev_check(ndev))
+		return 0;
+
+	switch (event) {
+	case NETDEV_CHANGEUPPER:
+		info = ptr;
+		extack = netdev_notifier_info_to_extack(&info->info);
+
+		if (netif_is_bridge_master(info->upper_dev)) {
+			if (info->linking)
+				cpsw_netdevice_port_link(ndev, info->upper_dev);
+			else
+				cpsw_netdevice_port_unlink(ndev);
+		}
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block cpsw_netdevice_nb __read_mostly = {
+	.notifier_call = cpsw_netdevice_event,
+};
+
+static int cpsw_register_notifiers(struct cpsw_common *cpsw)
+{
+	int ret = 0;
+
+	ret = register_netdevice_notifier(&cpsw_netdevice_nb);
+	if (ret) {
+		dev_err(cpsw->dev, "can't register netdevice notifier\n");
+		return ret;
+	}
+
+	ret = register_switchdev_notifier(&cpsw_switchdev_notifier);
+	if (ret) {
+		dev_err(cpsw->dev, "can't register switchdev notifier\n");
+		goto unreg_netdevice;
+	}
+
+	ret = register_switchdev_blocking_notifier(&cpsw_switchdev_bl_notifier);
+	if (ret) {
+		dev_err(cpsw->dev, "Failed to register switchdev blocking notifier\n");
+		goto unreg_notifier;
+	}
+
+	return ret;
+
+unreg_notifier:
+	unregister_switchdev_notifier(&cpsw_switchdev_notifier);
+unreg_netdevice:
+	unregister_netdevice_notifier(&cpsw_netdevice_nb);
+	return ret;
+}
+
+static void cpsw_unregister_notifiers(struct cpsw_common *cpsw)
+{
+	unregister_switchdev_blocking_notifier(&cpsw_switchdev_bl_notifier);
+	unregister_switchdev_notifier(&cpsw_switchdev_notifier);
+	unregister_netdevice_notifier(&cpsw_netdevice_nb);
+}
+
+static const struct of_device_id cpsw_of_mtable[] = {
+	{ .compatible = "ti,cpsw-switch"},
+	{ .compatible = "ti,am335x-cpsw-switch"},
+	{ .compatible = "ti,am4372-cpsw-switch"},
+	{ .compatible = "ti,dra7-cpsw-switch"},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, cpsw_of_mtable);
+
+static const struct soc_device_attribute cpsw_soc_devices[] = {
+	{ .family = "AM33xx", .revision = "ES1.0"},
+	{ /* sentinel */ }
+};
+
+static int cpsw_probe(struct platform_device *pdev)
+{
+	const struct soc_device_attribute *soc;
+	struct device *dev = &pdev->dev;
+	struct resource *ss_res;
+	struct cpsw_common *cpsw;
+	struct gpio_descs *mode;
+	void __iomem *ss_regs;
+	int ret = 0, ch;
+	struct clk *clk;
+	int irq;
+
+	cpsw = devm_kzalloc(dev, sizeof(struct cpsw_common), GFP_KERNEL);
+	if (!cpsw)
+		return -ENOMEM;
+
+	cpsw->dev = dev;
+
+	cpsw->slaves = devm_kcalloc(dev,
+				    CPSW_SLAVE_PORTS_NUM,
+				    sizeof(struct cpsw_slave),
+				    GFP_KERNEL);
+	if (!cpsw->slaves)
+		return -ENOMEM;
+
+	mode = devm_gpiod_get_array_optional(dev, "mode", GPIOD_OUT_LOW);
+	if (IS_ERR(mode)) {
+		ret = PTR_ERR(mode);
+		dev_err(dev, "gpio request failed, ret %d\n", ret);
+		return ret;
+	}
+
+	clk = devm_clk_get(dev, "fck");
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		dev_err(dev, "fck is not found %d\n", ret);
+		return ret;
+	}
+	cpsw->bus_freq_mhz = clk_get_rate(clk) / 1000000;
+
+	ss_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ss_regs = devm_ioremap_resource(dev, ss_res);
+	if (IS_ERR(ss_regs)) {
+		ret = PTR_ERR(ss_regs);
+		return ret;
+	}
+	cpsw->regs = ss_regs;
+
+	irq = platform_get_irq_byname(pdev, "rx");
+	if (irq < 0)
+		return irq;
+	cpsw->irqs_table[0] = irq;
+
+	irq = platform_get_irq_byname(pdev, "tx");
+	if (irq < 0)
+		return irq;
+	cpsw->irqs_table[1] = irq;
+
+	platform_set_drvdata(pdev, cpsw);
+	/* This may be required here for child devices. */
+	pm_runtime_enable(dev);
+
+	/* Need to enable clocks with runtime PM api to access module
+	 * registers
+	 */
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		pm_runtime_disable(dev);
+		return ret;
+	}
+
+	ret = cpsw_probe_dt(cpsw);
+	if (ret)
+		goto clean_dt_ret;
+
+	soc = soc_device_match(cpsw_soc_devices);
+	if (soc)
+		cpsw->quirk_irq = 1;
+
+	cpsw->rx_packet_max = rx_packet_max;
+	cpsw->descs_pool_size = descs_pool_size;
+
+	ret = cpsw_init_common(cpsw, ss_regs, ale_ageout,
+			       (u32 __force)ss_res->start + CPSW2_BD_OFFSET,
+			       descs_pool_size);
+	if (ret)
+		goto clean_dt_ret;
+
+	cpsw->wr_regs = cpsw->version == CPSW_VERSION_1 ?
+			ss_regs + CPSW1_WR_OFFSET :
+			ss_regs + CPSW2_WR_OFFSET;
+
+	ch = cpsw->quirk_irq ? 0 : 7;
+	cpsw->txv[0].ch = cpdma_chan_create(cpsw->dma, ch, cpsw_tx_handler, 0);
+	if (IS_ERR(cpsw->txv[0].ch)) {
+		dev_err(dev, "error initializing tx dma channel\n");
+		ret = PTR_ERR(cpsw->txv[0].ch);
+		goto clean_cpts;
+	}
+
+	cpsw->rxv[0].ch = cpdma_chan_create(cpsw->dma, 0, cpsw_rx_handler, 1);
+	if (IS_ERR(cpsw->rxv[0].ch)) {
+		dev_err(dev, "error initializing rx dma channel\n");
+		ret = PTR_ERR(cpsw->rxv[0].ch);
+		goto clean_cpts;
+	}
+	cpsw_split_res(cpsw);
+
+	/* setup netdevs */
+	ret = cpsw_create_ports(cpsw);
+	if (ret)
+		goto clean_unregister_netdev;
+
+	/* Grab RX and TX IRQs. Note that we also have RX_THRESHOLD and
+	 * MISC IRQs which are always kept disabled with this driver so
+	 * we will not request them.
+	 *
+	 * If anyone wants to implement support for those, make sure to
+	 * first request and append them to irqs_table array.
+	 */
+
+	ret = devm_request_irq(dev, cpsw->irqs_table[0], cpsw_rx_interrupt,
+			       0, dev_name(dev), cpsw);
+	if (ret < 0) {
+		dev_err(dev, "error attaching irq (%d)\n", ret);
+		goto clean_unregister_netdev;
+	}
+
+	ret = devm_request_irq(dev, cpsw->irqs_table[1], cpsw_tx_interrupt,
+			       0, dev_name(dev), cpsw);
+	if (ret < 0) {
+		dev_err(dev, "error attaching irq (%d)\n", ret);
+		goto clean_unregister_netdev;
+	}
+
+	ret = cpsw_register_notifiers(cpsw);
+	if (ret)
+		goto clean_unregister_netdev;
+
+	dev_notice(dev, "initialized device (regs %pa, pool size %d) dual_emac %d\n",
+		   &ss_res->start, descs_pool_size, cpsw->data.dual_emac);
+
+	pm_runtime_put(dev);
+
+	return 0;
+
+clean_unregister_netdev:
+	cpsw_unregister_ports(cpsw);
+clean_cpts:
+	cpts_release(cpsw->cpts);
+	cpdma_ctlr_destroy(cpsw->dma);
+clean_dt_ret:
+	cpsw_remove_dt(cpsw);
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+	return ret;
+}
+
+static int cpsw_remove(struct platform_device *pdev)
+{
+	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
+	int ret;
+
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(&pdev->dev);
+		return ret;
+	}
+
+	cpsw_unregister_notifiers(cpsw);
+	cpsw_unregister_ports(cpsw);
+
+	cpts_release(cpsw->cpts);
+	cpdma_ctlr_destroy(cpsw->dma);
+	cpsw_remove_dt(cpsw);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver cpsw_driver = {
+	.driver = {
+		.name	 = "cpsw-switch",
+		.of_match_table = cpsw_of_mtable,
+	},
+	.probe = cpsw_probe,
+	.remove = cpsw_remove,
+};
+
+module_platform_driver(cpsw_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("TI CPSW switchdev Ethernet driver");
diff --git a/drivers/net/ethernet/ti/cpsw_priv.c b/drivers/net/ethernet/ti/cpsw_priv.c
index a53547e9c04d..62ba53f9bf8a 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.c
+++ b/drivers/net/ethernet/ti/cpsw_priv.c
@@ -397,6 +397,7 @@ int cpsw_init_common(struct cpsw_common *cpsw, void __iomem *ss_regs,
 	struct cpsw_platform_data *data;
 	struct cpdma_params dma_params;
 	struct device *dev = cpsw->dev;
+	struct device_node *cpts_node;
 	void __iomem *cpts_regs;
 	int ret = 0, i;
 
@@ -491,11 +492,16 @@ int cpsw_init_common(struct cpsw_common *cpsw, void __iomem *ss_regs,
 		return -ENOMEM;
 	}
 
-	cpsw->cpts = cpts_create(cpsw->dev, cpts_regs, cpsw->dev->of_node);
+	cpts_node = of_get_child_by_name(cpsw->dev->of_node, "cpts");
+	if (!cpts_node)
+		cpts_node = cpsw->dev->of_node;
+
+	cpsw->cpts = cpts_create(cpsw->dev, cpts_regs, cpts_node);
 	if (IS_ERR(cpsw->cpts)) {
 		ret = PTR_ERR(cpsw->cpts);
 		cpdma_ctlr_destroy(cpsw->dma);
 	}
+	of_node_put(cpts_node);
 
 	return ret;
 }
diff --git a/drivers/net/ethernet/ti/cpsw_priv.h b/drivers/net/ethernet/ti/cpsw_priv.h
index 19d1da91862e..98817e14c878 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.h
+++ b/drivers/net/ethernet/ti/cpsw_priv.h
@@ -54,6 +54,7 @@ do {								\
 
 #define HOST_PORT_NUM		0
 #define CPSW_ALE_PORTS_NUM	3
+#define CPSW_SLAVE_PORTS_NUM	2
 #define SLIVER_SIZE		0x40
 
 #define CPSW1_HOST_PORT_OFFSET	0x028
@@ -65,6 +66,7 @@ do {								\
 #define CPSW1_CPTS_OFFSET	0x500
 #define CPSW1_ALE_OFFSET	0x600
 #define CPSW1_SLIVER_OFFSET	0x700
+#define CPSW1_WR_OFFSET		0x900
 
 #define CPSW2_HOST_PORT_OFFSET	0x108
 #define CPSW2_SLAVE_OFFSET	0x200
@@ -76,6 +78,7 @@ do {								\
 #define CPSW2_ALE_OFFSET	0xd00
 #define CPSW2_SLIVER_OFFSET	0xd80
 #define CPSW2_BD_OFFSET		0x2000
+#define CPSW2_WR_OFFSET		0x1200
 
 #define CPDMA_RXTHRESH		0x0c0
 #define CPDMA_RXFREE		0x0e0
@@ -113,12 +116,15 @@ do {								\
 #define IRQ_NUM			2
 #define CPSW_MAX_QUEUES		8
 #define CPSW_CPDMA_DESCS_POOL_SIZE_DEFAULT 256
+#define CPSW_ALE_AGEOUT_DEFAULT		10 /* sec */
+#define CPSW_ALE_NUM_ENTRIES		1024
 #define CPSW_FIFO_QUEUE_TYPE_SHIFT	16
 #define CPSW_FIFO_SHAPE_EN_SHIFT	16
 #define CPSW_FIFO_RATE_EN_SHIFT		20
 #define CPSW_TC_NUM			4
 #define CPSW_FIFO_SHAPERS_NUM		(CPSW_TC_NUM - 1)
 #define CPSW_PCT_MASK			0x7f
+#define CPSW_BD_RAM_SIZE		0x2000
 
 #define CPSW_RX_VLAN_ENCAP_HDR_PRIO_SHIFT	29
 #define CPSW_RX_VLAN_ENCAP_HDR_PRIO_MSK		GENMASK(2, 0)
@@ -278,6 +284,7 @@ struct cpsw_slave_data {
 	u8		mac_addr[ETH_ALEN];
 	u16		dual_emac_res_vlan;	/* Reserved VLAN for DualEMAC */
 	struct phy	*ifphy;
+	bool 		disabled;
 };
 
 struct cpsw_platform_data {
@@ -285,9 +292,9 @@ struct cpsw_platform_data {
 	u32	ss_reg_ofs;	/* Subsystem control register offset */
 	u32	channels;	/* number of cpdma channels (symmetric) */
 	u32	slaves;		/* number of slave cpgmac ports */
-	u32	active_slave; /* time stamping, ethtool and SIOCGMIIPHY slave */
+	u32	active_slave;/* time stamping, ethtool and SIOCGMIIPHY slave */
 	u32	ale_entries;	/* ale table size */
-	u32	bd_ram_size;  /*buffer descriptor ram size */
+	u32	bd_ram_size;	/*buffer descriptor ram size */
 	u32	mac_control;	/* Mac control register */
 	u16	default_vlan;	/* Def VLAN for ALE lookup in VLAN aware mode*/
 	bool	dual_emac;	/* Enable Dual EMAC mode */
@@ -346,6 +353,8 @@ struct cpsw_common {
 	int				rx_ch_num, tx_ch_num;
 	int				speed;
 	int				usage_count;
+	u8				br_members;
+	u8				bridge_mask;
 };
 
 struct cpsw_priv {
@@ -362,10 +371,31 @@ struct cpsw_priv {
 	int				rx_ts_enabled;
 	u32 emac_port;
 	struct cpsw_common *cpsw;
+	struct net_device *hw_bridge_dev;
 };
 
 #define ndev_to_cpsw(ndev) (((struct cpsw_priv *)netdev_priv(ndev))->cpsw)
 #define napi_to_cpsw(napi)	container_of(napi, struct cpsw_common, napi)
+
+#ifdef CONFIG_TI_CPSW_SWITCHDEV
+#define for_each_slave(priv, func, arg...)				\
+	do {								\
+		struct cpsw_common *cpsw = (priv)->cpsw;		\
+		(func)((cpsw)->slaves + (priv)->emac_port - 1, ##arg);	\
+	} while (0)
+
+/* struct cpsw_common is not needed, kept here for compatibility
+ * reasons witrh the old driver
+ */
+static inline int cpsw_slave_index(struct cpsw_common *cpsw,
+				   struct cpsw_priv *priv)
+{
+	if (priv->emac_port == HOST_PORT_NUM)
+		return -1;
+
+	return priv->emac_port - 1;
+}
+#else
 #define for_each_slave(priv, func, arg...)				\
 	do {								\
 		struct cpsw_slave *slave;				\
@@ -383,6 +413,7 @@ struct cpsw_priv {
 #define cpsw_slave_index(cpsw, priv)				\
 		((cpsw->data.dual_emac) ? priv->emac_port :	\
 		cpsw->data.active_slave)
+#endif
 
 static inline int cpsw_get_slave_port(u32 slave_num)
 {
-- 
2.17.1

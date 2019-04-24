From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH v3 net-next 05/11] net: ethernet: ti: cpsw: add switchdev API for cpsw driver
Date: Thu, 25 Apr 2019 01:24:21 +0300
Message-ID: <1556144667-27997-6-git-send-email-grygorii.strashko@ti.com>
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

Add switchdev API operations that will be used on the new cpsw driver.
Supported:
 - SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS
 - SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS: BR_MCAST_FLOOD
 - SWITCHDEV_ATTR_ID_PORT_STP_STATE
 - SWITCHDEV_OBJ_ID_PORT_VLAN
 - SWITCHDEV_OBJ_ID_PORT_MDB
 - SWITCHDEV_OBJ_ID_HOST_MDB

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw_switchdev.c | 394 +++++++++++++++++++++++
 drivers/net/ethernet/ti/cpsw_switchdev.h |  22 ++
 2 files changed, 416 insertions(+)
 create mode 100644 drivers/net/ethernet/ti/cpsw_switchdev.c
 create mode 100644 drivers/net/ethernet/ti/cpsw_switchdev.h

diff --git a/drivers/net/ethernet/ti/cpsw_switchdev.c b/drivers/net/ethernet/ti/cpsw_switchdev.c
new file mode 100644
index 000000000000..ff1d96463eca
--- /dev/null
+++ b/drivers/net/ethernet/ti/cpsw_switchdev.c
@@ -0,0 +1,394 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Texas Instruments switchdev Driver
+ *
+ * Copyright (C) 2019 Texas Instruments
+ *
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/if_bridge.h>
+#include <net/switchdev.h>
+#include "cpsw.h"
+#include "cpsw_ale.h"
+#include "cpsw_priv.h"
+
+static int cpsw_port_stp_state_set(struct cpsw_priv *priv,
+				   struct switchdev_trans *trans, u8 state)
+{
+	struct cpsw_common *cpsw = priv->cpsw;
+	u8 cpsw_state;
+	int ret = 0;
+
+	if (switchdev_trans_ph_prepare(trans))
+		return 0;
+
+	switch (state) {
+	case BR_STATE_FORWARDING:
+		cpsw_state = ALE_PORT_STATE_FORWARD;
+		break;
+	case BR_STATE_LEARNING:
+		cpsw_state = ALE_PORT_STATE_LEARN;
+		break;
+	case BR_STATE_DISABLED:
+		cpsw_state = ALE_PORT_STATE_DISABLE;
+		break;
+	case BR_STATE_LISTENING:
+	case BR_STATE_BLOCKING:
+		cpsw_state = ALE_PORT_STATE_BLOCK;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	ret = cpsw_ale_control_set(cpsw->ale, priv->emac_port,
+				   ALE_PORT_STATE, cpsw_state);
+	dev_dbg(priv->dev, "ale state: %u\n", cpsw_state);
+
+	return ret;
+}
+
+static int cpsw_port_attr_br_flags_set(struct cpsw_priv *priv,
+				       struct switchdev_trans *trans,
+				       struct net_device *orig_dev,
+				       unsigned long brport_flags)
+{
+	struct cpsw_common *cpsw = priv->cpsw;
+	bool unreg_mcast_add = false;
+
+	if (switchdev_trans_ph_prepare(trans))
+		return 0;
+
+	if (brport_flags & BR_MCAST_FLOOD)
+		unreg_mcast_add = true;
+	dev_dbg(priv->dev, "BR_MCAST_FLOOD: %d port %u\n",
+		unreg_mcast_add, priv->emac_port);
+
+	cpsw_ale_set_unreg_mcast(cpsw->ale, BIT(priv->emac_port),
+				 unreg_mcast_add);
+
+	return 0;
+}
+
+static int cpsw_port_attr_br_flags_pre_set(struct net_device *netdev,
+					   struct switchdev_trans *trans,
+					   unsigned long flags)
+{
+	if (flags & ~(BR_LEARNING | BR_MCAST_FLOOD))
+		return -EINVAL;
+
+	return 0;
+}
+
+int cpsw_port_attr_set(struct net_device *ndev,
+		       const struct switchdev_attr *attr,
+		       struct switchdev_trans *trans)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	int ret;
+
+	dev_dbg(priv->dev, "attr: id %u port: %u\n", attr->id, priv->emac_port);
+
+	switch (attr->id) {
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		ret = cpsw_port_attr_br_flags_pre_set(ndev, trans,
+						      attr->u.brport_flags);
+		break;
+	case SWITCHDEV_ATTR_ID_PORT_STP_STATE:
+		ret = cpsw_port_stp_state_set(priv, trans, attr->u.stp_state);
+		dev_dbg(priv->dev, "stp state: %u\n", attr->u.stp_state);
+		break;
+	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
+		ret = cpsw_port_attr_br_flags_set(priv, trans, attr->orig_dev,
+						  attr->u.brport_flags);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+static u16 cpsw_get_pvid(struct cpsw_priv *priv)
+{
+	struct cpsw_common *cpsw = priv->cpsw;
+	u32 __iomem *port_vlan_reg;
+	u32 pvid;
+
+	if (priv->emac_port) {
+		int reg = CPSW2_PORT_VLAN;
+
+		if (cpsw->version == CPSW_VERSION_1)
+			reg = CPSW1_PORT_VLAN;
+		pvid = slave_read(cpsw->slaves + (priv->emac_port - 1), reg);
+	} else {
+		port_vlan_reg = &cpsw->host_port_regs->port_vlan;
+		pvid = readl(port_vlan_reg);
+	}
+
+	pvid = pvid & 0xfff;
+
+	return pvid;
+}
+
+static void cpsw_set_pvid(struct cpsw_priv *priv, u16 vid, bool cfi, u32 cos)
+{
+	struct cpsw_common *cpsw = priv->cpsw;
+	void __iomem *port_vlan_reg;
+	u32 pvid;
+
+	pvid = vid;
+	pvid |= cfi ? BIT(12) : 0;
+	pvid |= (cos & 0x7) << 13;
+
+	if (priv->emac_port) {
+		int reg = CPSW2_PORT_VLAN;
+
+		if (cpsw->version == CPSW_VERSION_1)
+			reg = CPSW1_PORT_VLAN;
+		/* no barrier */
+		slave_write(cpsw->slaves + (priv->emac_port - 1), pvid, reg);
+	} else {
+		/* CPU port */
+		port_vlan_reg = &cpsw->host_port_regs->port_vlan;
+		writel(pvid, port_vlan_reg);
+	}
+}
+
+static int cpsw_port_vlan_add(struct cpsw_priv *priv, bool untag, bool pvid,
+			      u16 vid, struct net_device *orig_dev)
+{
+	bool cpu_port = netif_is_bridge_master(orig_dev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int unreg_mcast_mask = 0;
+	int reg_mcast_mask = 0;
+	int untag_mask = 0;
+	int port_mask;
+	int ret = 0;
+	u32 flags;
+
+	if (cpu_port) {
+		port_mask = BIT(HOST_PORT_NUM);
+		flags = orig_dev->flags;
+		unreg_mcast_mask = port_mask;
+	} else {
+		port_mask = BIT(priv->emac_port);
+		flags = priv->ndev->flags;
+	}
+
+	if (flags & IFF_MULTICAST)
+		reg_mcast_mask = port_mask;
+
+	if (untag)
+		untag_mask = port_mask;
+
+	ret = cpsw_ale_vlan_add_modify(cpsw->ale, vid, port_mask, untag_mask,
+				       reg_mcast_mask, unreg_mcast_mask);
+	if (ret) {
+		dev_err(priv->dev, "Unable to add vlan\n");
+		return ret;
+	}
+
+	if (cpu_port)
+		cpsw_ale_add_ucast(cpsw->ale, priv->mac_addr,
+				   HOST_PORT_NUM, ALE_VLAN, vid);
+	if (!pvid)
+		return ret;
+
+	cpsw_set_pvid(priv, vid, 0, 0);
+
+	dev_dbg(priv->dev, "VID add: %u dev: %s port: %u\n", vid,
+		priv->ndev->name, priv->emac_port);
+
+	return ret;
+}
+
+static int cpsw_port_vlan_del(struct cpsw_priv *priv, u16 vid,
+			      struct net_device *orig_dev)
+{
+	bool cpu_port = netif_is_bridge_master(orig_dev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int port_mask;
+	int ret = 0;
+
+	if (cpu_port)
+		port_mask = BIT(HOST_PORT_NUM);
+	else
+		port_mask = BIT(priv->emac_port);
+
+	ret = cpsw_ale_vlan_del_modify(cpsw->ale, vid, port_mask);
+	if (ret != 0)
+		return ret;
+
+	/* We don't care for the return value here, error is returned only if
+	 * the unicast entry is not present
+	 */
+	if (cpu_port)
+		cpsw_ale_del_ucast(cpsw->ale, priv->mac_addr,
+				   HOST_PORT_NUM, ALE_VLAN, vid);
+
+	if (vid == cpsw_get_pvid(priv))
+		cpsw_set_pvid(priv, 0, 0, 0);
+
+	/* We don't care for the return value here, error is returned only if
+	 * the multicast entry is not present
+	 */
+	cpsw_ale_del_mcast(cpsw->ale, priv->ndev->broadcast,
+			   0, ALE_VLAN, vid);
+
+	dev_dbg(priv->dev, "VID del: %u dev: %s port: %u\n", vid,
+		priv->ndev->name, priv->emac_port);
+
+	return ret;
+}
+
+static int cpsw_port_vlans_add(struct cpsw_priv *priv,
+			       const struct switchdev_obj_port_vlan *vlan,
+			       struct switchdev_trans *trans)
+{
+	bool untag = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
+	struct net_device *orig_dev = vlan->obj.orig_dev;
+	bool cpu_port = netif_is_bridge_master(orig_dev);
+	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
+	u16 vid;
+
+	if (cpu_port && !(vlan->flags & BRIDGE_VLAN_INFO_BRENTRY))
+		return 0;
+
+	if (switchdev_trans_ph_prepare(trans))
+		return 0;
+
+	for (vid = vlan->vid_begin; vid <= vlan->vid_end; vid++) {
+		int err;
+
+		err = cpsw_port_vlan_add(priv, untag, pvid, vid, orig_dev);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int cpsw_port_vlans_del(struct cpsw_priv *priv,
+			       const struct switchdev_obj_port_vlan *vlan)
+
+{
+	struct net_device *orig_dev = vlan->obj.orig_dev;
+	u16 vid;
+
+	for (vid = vlan->vid_begin; vid <= vlan->vid_end; vid++) {
+		int err;
+
+		err = cpsw_port_vlan_del(priv, vid, orig_dev);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int cpsw_port_mdb_add(struct cpsw_priv *priv,
+			     struct switchdev_obj_port_mdb *mdb,
+			     struct switchdev_trans *trans)
+
+{
+	struct net_device *orig_dev = mdb->obj.orig_dev;
+	bool cpu_port = netif_is_bridge_master(orig_dev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int port_mask;
+	int err;
+
+	if (switchdev_trans_ph_prepare(trans))
+		return 0;
+
+	if (cpu_port)
+		port_mask = BIT(HOST_PORT_NUM);
+	else
+		port_mask = BIT(priv->emac_port);
+
+	err = cpsw_ale_mcast_add_modify(cpsw->ale, mdb->addr, port_mask,
+					ALE_VLAN, mdb->vid, 0);
+
+	dev_dbg(priv->dev, "MDB add: %pM dev: %s vid %u port: %u\n", mdb->addr,
+		priv->ndev->name, mdb->vid, priv->emac_port);
+
+	return err;
+}
+
+static int cpsw_port_mdb_del(struct cpsw_priv *priv,
+			     struct switchdev_obj_port_mdb *mdb)
+
+{
+	struct net_device *orig_dev = mdb->obj.orig_dev;
+	bool cpu_port = netif_is_bridge_master(orig_dev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int del_mask;
+	int err;
+
+	if (cpu_port)
+		del_mask = BIT(HOST_PORT_NUM);
+	else
+		del_mask = BIT(priv->emac_port);
+	err = cpsw_ale_mcast_del_modify(cpsw->ale, mdb->addr, del_mask,
+					ALE_VLAN, mdb->vid);
+	dev_dbg(priv->dev, "MDB del: %pM dev: %s vid %u port: %u\n", mdb->addr,
+		priv->ndev->name, mdb->vid, priv->emac_port);
+
+	return err;
+}
+
+int cpsw_port_obj_add(struct net_device *ndev, const struct switchdev_obj *obj,
+		      struct switchdev_trans *trans,
+		      struct netlink_ext_ack *extack)
+{
+	struct switchdev_obj_port_vlan *vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
+	struct switchdev_obj_port_mdb *mdb = SWITCHDEV_OBJ_PORT_MDB(obj);
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	int err = 0;
+
+	dev_dbg(priv->dev, "obj_add: id %u port: %u\n",
+		obj->id, priv->emac_port);
+
+	switch (obj->id) {
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		err = cpsw_port_vlans_add(priv, vlan, trans);
+		break;
+	case SWITCHDEV_OBJ_ID_PORT_MDB:
+	case SWITCHDEV_OBJ_ID_HOST_MDB:
+		err = cpsw_port_mdb_add(priv, mdb, trans);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+int cpsw_port_obj_del(struct net_device *ndev,
+		      const struct switchdev_obj *obj)
+{
+	struct switchdev_obj_port_vlan *vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
+	struct switchdev_obj_port_mdb *mdb = SWITCHDEV_OBJ_PORT_MDB(obj);
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	int err = 0;
+
+	dev_dbg(priv->dev, "obj_del: id %u port: %u\n",
+		obj->id, priv->emac_port);
+
+	switch (obj->id) {
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		err = cpsw_port_vlans_del(priv, vlan);
+		break;
+	case SWITCHDEV_OBJ_ID_PORT_MDB:
+	case SWITCHDEV_OBJ_ID_HOST_MDB:
+		err = cpsw_port_mdb_del(priv, mdb);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
diff --git a/drivers/net/ethernet/ti/cpsw_switchdev.h b/drivers/net/ethernet/ti/cpsw_switchdev.h
new file mode 100644
index 000000000000..7d6b368127a0
--- /dev/null
+++ b/drivers/net/ethernet/ti/cpsw_switchdev.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Texas Instruments Ethernet Switch Driver
+ */
+
+#ifndef DRIVERS_NET_ETHERNET_TI_CPSW_SWITCHDEV_H_
+#define DRIVERS_NET_ETHERNET_TI_CPSW_SWITCHDEV_H_
+
+#include <net/switchdev.h>
+
+void cpsw_port_switchdev_init(struct net_device *ndev);
+int cpsw_port_obj_add(struct net_device *ndev, const struct switchdev_obj *obj,
+		      struct switchdev_trans *trans,
+		      struct netlink_ext_ack *extack);
+
+int cpsw_port_obj_del(struct net_device *ndev,
+		      const struct switchdev_obj *obj);
+int cpsw_port_attr_set(struct net_device *ndev,
+		       const struct switchdev_attr *attr,
+		       struct switchdev_trans *trans);
+
+#endif /* DRIVERS_NET_ETHERNET_TI_CPSW_SWITCHDEV_H_ */
-- 
2.17.1

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v2 net-next 4/4] net: ethernet: ti: cpsw: fix vlan configuration while down/up
Date: Thu,  8 Nov 2018 22:27:57 +0200
Message-ID: <20181108202757.30110-5-ivan.khoronzhuk@linaro.org>
References: <20181108202757.30110-1-ivan.khoronzhuk@linaro.org>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181108202757.30110-1-ivan.khoronzhuk@linaro.org>
Sender: netdev-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com, bjorn@mork.no, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

The vlan configuration is not restored after interface donw/up sequence
(if dual-emac - both interfaces). Tested on am572x EVM.

Steps to check:
~# ip link add link eth1 name eth1.100 type vlan id 100
~# ifconfig eth0 down
~# ifconfig eth1 down

Try to remove vid and observe warning:
~# ip link del eth1.100
[  739.526757] net eth1: removing vlanid 100 from vlan filter
[  739.533322] failed to kill vid 0081/100 for device eth1

This patch fixes it, restoring only vlan ALE entries and all other
unicast/multicast entries are restored by system calling rx_mode ndo.

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 0b18634d336c..9434fd5a5477 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -565,6 +565,9 @@ static const struct cpsw_stats cpsw_gstrings_ch_stats[] = {
 				(func)(slave++, ##arg);			\
 	} while (0)
 
+static int cpsw_ndo_vlan_rx_add_vid(struct net_device *ndev,
+				    __be16 proto, u16 vid);
+
 static inline int cpsw_get_slave_port(u32 slave_num)
 {
 	return slave_num + 1;
@@ -1951,9 +1954,23 @@ static void cpsw_mqprio_resume(struct cpsw_slave *slave, struct cpsw_priv *priv)
 	slave_write(slave, tx_prio_map, tx_prio_rg);
 }
 
+static int cpsw_restore_vlans(struct net_device *vdev, int vid, void *arg)
+{
+	struct cpsw_priv *priv = arg;
+
+	if (!vdev)
+		return 0;
+
+	cpsw_ndo_vlan_rx_add_vid(priv->ndev, 0, vid);
+	return 0;
+}
+
 /* restore resources after port reset */
 static void cpsw_restore(struct cpsw_priv *priv)
 {
+	/* restore vlan configurations */
+	vlan_for_each(priv->ndev, cpsw_restore_vlans, priv);
+
 	/* restore MQPRIO offload */
 	for_each_slave(priv, cpsw_mqprio_resume, priv);
 
-- 
2.17.1

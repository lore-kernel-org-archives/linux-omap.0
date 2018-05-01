From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] net: ethernet: ti: cpsw: fix packet leaking in dual_mac mode
Date: Tue, 1 May 2018 12:41:22 -0500
Message-ID: <20180501174122.11323-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

In dual_mac mode packets arrived on one port should not be forwarded by
switch hw to another port. Only Linux Host can forward packets between
ports. The below test case (reported in [1]) shows that packet arrived on
one port can be leaked to anoter (reproducible with dual port evms):
 - connect port 1 (eth0) to linux Host 0 and run tcpdump or Wireshark
 - connect port 2 (eth1) to linux Host 1 with vlan 1 configured
 - ping <IPx> from Host 1 through vlan 1 interface.
ARP packets will be seen on Host 0.

Issue happens because dual_mac mode is implemnted using two vlans: 1 (Port
1+Port 0) and 2 (Port 2+Port 0), so there are vlan records created for for
each vlan. By default, the ALE will find valid vlan record in its table
when vlan 1 tagged packet arrived on Port 2 and so forwards packet to all
ports which are vlan 1 members (like Port.

To avoid such behaviorr the ALE VLAN ID Ingress Check need to be enabled
for each external CPSW port (ALE_PORTCTLn.VID_INGRESS_CHECK) so ALE will
drop ingress packets if Rx port is not VLAN member.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 5047f4b..46500a2 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1340,6 +1340,8 @@ static inline void cpsw_add_dual_emac_def_ale_entries(
 	cpsw_ale_add_ucast(cpsw->ale, priv->mac_addr,
 			   HOST_PORT_NUM, ALE_VLAN |
 			   ALE_SECURE, slave->port_vlan);
+	cpsw_ale_control_set(cpsw->ale, slave_port,
+			     ALE_PORT_DROP_UNKNOWN_VLAN, 1);
 }
 
 static void soft_reset_slave(struct cpsw_slave *slave)
-- 
2.10.5

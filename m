From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH v3 net-next 04/11] net: ethernet: ti: cpsw: allow untagged traffic on host port
Date: Thu, 25 Apr 2019 01:24:20 +0300
Message-ID: <1556144667-27997-5-git-send-email-grygorii.strashko@ti.com>
References: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Now untagged vlan traffic is not supported on Host P0 port. This patch adds
in ALE context bitmap of VLANs for which Host P0 port bit set in Force
Untagged Packet Egress bitmask in VLANs ALE entries, and adds corresponding
check in VLAN incapsulation header parsing function cpsw_rx_vlan_encap().

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c     | 17 ++++++++---------
 drivers/net/ethernet/ti/cpsw_ale.c | 24 +++++++++++++++++++++---
 drivers/net/ethernet/ti/cpsw_ale.h |  5 +++++
 3 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 2998a45e01e8..86e23468c51f 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -329,17 +329,16 @@ static void cpsw_rx_vlan_encap(struct sk_buff *skb)
 	/* Ignore vid 0 and pass packet as is */
 	if (!vid)
 		return;
-	/* Ignore default vlans in dual mac mode */
-	if (cpsw->data.dual_emac &&
-	    vid == cpsw->slaves[priv->emac_port].port_vlan)
-		return;
 
-	prio = (rx_vlan_encap_hdr >>
-		CPSW_RX_VLAN_ENCAP_HDR_PRIO_SHIFT) &
-		CPSW_RX_VLAN_ENCAP_HDR_PRIO_MSK;
+	/* Untag P0 packets if set for vlan */
+	if (!cpsw_ale_get_vlan_p0_untag(cpsw->ale, vid)) {
+		prio = (rx_vlan_encap_hdr >>
+			CPSW_RX_VLAN_ENCAP_HDR_PRIO_SHIFT) &
+			CPSW_RX_VLAN_ENCAP_HDR_PRIO_MSK;
 
-	vtag = (prio << VLAN_PRIO_SHIFT) | vid;
-	__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vtag);
+		vtag = (prio << VLAN_PRIO_SHIFT) | vid;
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vtag);
+	}
 
 	/* strip vlan tag for VLAN-tagged packet */
 	if (pkt_type == CPSW_RX_VLAN_ENCAP_HDR_PKT_VLAN_TAG) {
diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index add3f6e4917b..529768484115 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -5,6 +5,8 @@
  * Copyright (C) 2012 Texas Instruments
  *
  */
+#include <linux/bitmap.h>
+#include <linux/if_vlan.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -500,6 +502,17 @@ static int cpsw_ale_read_reg_unreg_mc(struct cpsw_ale *ale, u16 vid, bool unreg)
 	return ret;
 }
 
+void cpsw_ale_set_vlan_untag(struct cpsw_ale *ale, u32 *ale_entry,
+			     u16 vid, int untag_mask)
+{
+	cpsw_ale_set_vlan_untag_force(ale_entry,
+				      untag_mask, ale->vlan_field_bits);
+	if (untag_mask & ALE_PORT_HOST)
+		bitmap_set(ale->p0_untag_vid_mask, vid, 1);
+	else
+		bitmap_clear(ale->p0_untag_vid_mask, vid, 1);
+}
+
 int cpsw_ale_add_vlan(struct cpsw_ale *ale, u16 vid, int port, int untag,
 		      int reg_mcast, int unreg_mcast)
 {
@@ -512,8 +525,8 @@ int cpsw_ale_add_vlan(struct cpsw_ale *ale, u16 vid, int port, int untag,
 
 	cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_VLAN);
 	cpsw_ale_set_vlan_id(ale_entry, vid);
+	cpsw_ale_set_vlan_untag(ale, ale_entry, vid, untag);
 
-	cpsw_ale_set_vlan_untag_force(ale_entry, untag, ale->vlan_field_bits);
 	if (!ale->params.nu_switch_ale) {
 		cpsw_ale_set_vlan_reg_mcast(ale_entry, reg_mcast,
 					    ale->vlan_field_bits);
@@ -552,8 +565,8 @@ int cpsw_ale_del_vlan(struct cpsw_ale *ale, u16 vid, int port_mask)
 	cpsw_ale_read(ale, idx, ale_entry);
 
 	if (port_mask) {
-		cpsw_ale_set_vlan_untag_force(ale_entry, untag,
-					      ale->vlan_field_bits);
+		cpsw_ale_set_vlan_untag(ale, ale_entry, vid, untag);
+
 		if (!ale->params.nu_switch_ale) {
 			cpsw_ale_set_vlan_reg_mcast(ale_entry, reg_mcast,
 						    ale->vlan_field_bits);
@@ -973,6 +986,11 @@ struct cpsw_ale *cpsw_ale_create(struct cpsw_ale_params *params)
 	if (!ale)
 		return NULL;
 
+	ale->p0_untag_vid_mask =
+		devm_kmalloc_array(params->dev, BITS_TO_LONGS(VLAN_N_VID),
+				   sizeof(unsigned long),
+				   GFP_KERNEL);
+
 	ale->params = *params;
 	ale->ageout = ale->params.ale_ageout * HZ;
 
diff --git a/drivers/net/ethernet/ti/cpsw_ale.h b/drivers/net/ethernet/ti/cpsw_ale.h
index b5ac8cc7c677..4493bd8ed58f 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.h
+++ b/drivers/net/ethernet/ti/cpsw_ale.h
@@ -36,6 +36,7 @@ struct cpsw_ale {
 	u32			port_mask_bits;
 	u32			port_num_bits;
 	u32			vlan_field_bits;
+	unsigned long		*p0_untag_vid_mask;
 };
 
 enum cpsw_ale_control {
@@ -126,4 +127,8 @@ int cpsw_ale_mcast_del_modify(struct cpsw_ale *ale, u8 *addr, int port,
 void cpsw_ale_set_unreg_mcast(struct cpsw_ale *ale, int unreg_mcast_mask,
 			      bool add);
 
+static inline int cpsw_ale_get_vlan_p0_untag(struct cpsw_ale *ale, u16 vid)
+{
+	return test_bit(vid, ale->p0_untag_vid_mask);
+}
 #endif
-- 
2.17.1

From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next] net: ethernet: ti: cpsw: enable vlan rx vlan offload
Date: Thu, 15 Mar 2018 15:15:50 -0500
Message-ID: <20180315201550.21487-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

In VLAN_AWARE mode CPSW can insert VLAN header encapsulation word on Host
port 0 egress (RX) before the packet data if RX_VLAN_ENCAP bit is set in
CPSW_CONTROL register. VLAN header encapsulation word has following format:

 HDR_PKT_Priority bits 29-31 - Header Packet VLAN prio (Highest prio: 7)
 HDR_PKT_CFI 	  bits 28 - Header Packet VLAN CFI bit.
 HDR_PKT_Vid 	  bits 27-16 - Header Packet VLAN ID
 PKT_Type         bits 8-9 - Packet Type. Indicates whether the packet is
                 	VLAN-tagged, priority-tagged, or non-tagged.
	00: VLAN-tagged packet
	01: Reserved
	10: Priority-tagged packet
	11: Non-tagged packet

This feature can be used to implement TX VLAN offload in case of
VLAN-tagged packets and to insert VLAN tag in case Non-tagged packet was
received on port with PVID set. As per documentation, CPSW never modifies
packet data on Host egress (RX) and as result, without this feature
enabled, Host port will not be able to receive properly packets which
entered switch non-tagged through external Port with PVID set (when
non-tagged packet forwarded from external Port with PVID set to another
external Port - packet will be VLAN tagged properly).

Implementation details:
- on RX driver will check CPDMA status bit RX_VLAN_ENCAP BIT(19) in CPPI
descriptor to identify when VLAN header encapsulation word is present.
- PKT_Type = 0x01 or 0x02 then ignore VLAN header encapsulation word and
pass packet as is;
- if HDR_PKT_Vid = 0 then ignore VLAN header encapsulation word and pass
packet as is;
- In dual mac mode traffic is separated between ports using default port
vlans, which are not be visible to Host and so should not be reported.
Hence, check for default port vlans in dual mac mode and ignore VLAN header
encapsulation word;
- otherwise fill SKB with VLAN info using __vlan_hwaccel_put_tag();
- PKT_Type = 0x00 (VLAN-tagged) then strip out VLAN header from SKB.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c          | 67 +++++++++++++++++++++++++++++++--
 drivers/net/ethernet/ti/davinci_cpdma.c |  2 +-
 drivers/net/ethernet/ti/davinci_cpdma.h |  2 +
 3 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 1b1b78f..8af8891 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -120,14 +120,18 @@ do {								\
 #define CPDMA_RXCP		0x60
 
 #define CPSW_POLL_WEIGHT	64
+#define CPSW_RX_VLAN_ENCAP_HDR_SIZE		4
 #define CPSW_MIN_PACKET_SIZE	(VLAN_ETH_ZLEN)
-#define CPSW_MAX_PACKET_SIZE	(VLAN_ETH_FRAME_LEN + ETH_FCS_LEN)
+#define CPSW_MAX_PACKET_SIZE	(VLAN_ETH_FRAME_LEN +\
+				 ETH_FCS_LEN +\
+				 CPSW_RX_VLAN_ENCAP_HDR_SIZE)
 
 #define RX_PRIORITY_MAPPING	0x76543210
 #define TX_PRIORITY_MAPPING	0x33221100
 #define CPDMA_TX_PRIORITY_MAP	0x01234567
 
 #define CPSW_VLAN_AWARE		BIT(1)
+#define CPSW_RX_VLAN_ENCAP	BIT(2)
 #define CPSW_ALE_VLAN_AWARE	1
 
 #define CPSW_FIFO_NORMAL_MODE		(0 << 16)
@@ -148,6 +152,18 @@ do {								\
 #define CPSW_MAX_QUEUES		8
 #define CPSW_CPDMA_DESCS_POOL_SIZE_DEFAULT 256
 
+#define CPSW_RX_VLAN_ENCAP_HDR_PRIO_SHIFT	29
+#define CPSW_RX_VLAN_ENCAP_HDR_PRIO_MSK		GENMASK(2, 0)
+#define CPSW_RX_VLAN_ENCAP_HDR_VID_SHIFT	16
+#define CPSW_RX_VLAN_ENCAP_HDR_PKT_TYPE_SHIFT	8
+#define CPSW_RX_VLAN_ENCAP_HDR_PKT_TYPE_MSK	GENMASK(1, 0)
+enum {
+	CPSW_RX_VLAN_ENCAP_HDR_PKT_VLAN_TAG = 0,
+	CPSW_RX_VLAN_ENCAP_HDR_PKT_RESERV,
+	CPSW_RX_VLAN_ENCAP_HDR_PKT_PRIO_TAG,
+	CPSW_RX_VLAN_ENCAP_HDR_PKT_UNTAG,
+};
+
 static int debug_level;
 module_param(debug_level, int, 0);
 MODULE_PARM_DESC(debug_level, "cpsw debug level (NETIF_MSG bits)");
@@ -718,6 +734,49 @@ static void cpsw_tx_handler(void *token, int len, int status)
 	dev_kfree_skb_any(skb);
 }
 
+static void cpsw_rx_vlan_encap(struct sk_buff *skb)
+{
+	struct cpsw_priv *priv = netdev_priv(skb->dev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	u32 rx_vlan_encap_hdr = *((u32 *)skb->data);
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
+	/* Ignore default vlans in dual mac mode */
+	if (cpsw->data.dual_emac &&
+	    vid == cpsw->slaves[priv->emac_port].port_vlan)
+		return;
+
+	prio = (rx_vlan_encap_hdr >>
+		CPSW_RX_VLAN_ENCAP_HDR_PRIO_SHIFT) &
+		CPSW_RX_VLAN_ENCAP_HDR_PRIO_MSK;
+
+	vtag = (prio << VLAN_PRIO_SHIFT) | vid;
+	__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vtag);
+
+	/* strip vlan tag for VLAN-tagged packet */
+	if (pkt_type == CPSW_RX_VLAN_ENCAP_HDR_PKT_VLAN_TAG) {
+		memmove(skb->data + VLAN_HLEN, skb->data, 2 * ETH_ALEN);
+		skb_pull(skb, VLAN_HLEN);
+	}
+}
+
 static void cpsw_rx_handler(void *token, int len, int status)
 {
 	struct cpdma_chan	*ch;
@@ -752,6 +811,8 @@ static void cpsw_rx_handler(void *token, int len, int status)
 	if (new_skb) {
 		skb_copy_queue_mapping(new_skb, skb);
 		skb_put(skb, len);
+		if (status & CPDMA_RX_VLAN_ENCAP)
+			cpsw_rx_vlan_encap(skb);
 		cpts_rx_timestamp(cpsw->cpts, skb);
 		skb->protocol = eth_type_trans(skb, ndev);
 		netif_receive_skb(skb);
@@ -1406,7 +1467,7 @@ static void cpsw_init_host_port(struct cpsw_priv *priv)
 	cpsw_ale_control_set(cpsw->ale, HOST_PORT_NUM, ALE_VLAN_AWARE,
 			     CPSW_ALE_VLAN_AWARE);
 	control_reg = readl(&cpsw->regs->control);
-	control_reg |= CPSW_VLAN_AWARE;
+	control_reg |= CPSW_VLAN_AWARE | CPSW_RX_VLAN_ENCAP;
 	writel(control_reg, &cpsw->regs->control);
 	fifo_mode = (cpsw->data.dual_emac) ? CPSW_FIFO_DUAL_MAC_MODE :
 		     CPSW_FIFO_NORMAL_MODE;
@@ -3122,7 +3183,7 @@ static int cpsw_probe(struct platform_device *pdev)
 			cpsw->quirk_irq = true;
 	}
 
-	ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+	ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_CTAG_RX;
 
 	ndev->netdev_ops = &cpsw_netdev_ops;
 	ndev->ethtool_ops = &cpsw_ethtool_ops;
diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
index 6f9173f..31ae041 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -1164,7 +1164,7 @@ static int __cpdma_chan_process(struct cpdma_chan *chan)
 		outlen -= CPDMA_DESC_CRC_LEN;
 
 	status	= status & (CPDMA_DESC_EOQ | CPDMA_DESC_TD_COMPLETE |
-			    CPDMA_DESC_PORT_MASK);
+			    CPDMA_DESC_PORT_MASK | CPDMA_RX_VLAN_ENCAP);
 
 	chan->head = desc_from_phys(pool, desc_read(desc, hw_next));
 	chan_write(chan, cp, desc_dma);
diff --git a/drivers/net/ethernet/ti/davinci_cpdma.h b/drivers/net/ethernet/ti/davinci_cpdma.h
index fd65ce2..d399af5 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.h
+++ b/drivers/net/ethernet/ti/davinci_cpdma.h
@@ -19,6 +19,8 @@
 
 #define CPDMA_RX_SOURCE_PORT(__status__)	((__status__ >> 16) & 0x7)
 
+#define CPDMA_RX_VLAN_ENCAP BIT(19)
+
 #define CPDMA_EOI_RX_THRESH	0x0
 #define CPDMA_EOI_RX		0x1
 #define CPDMA_EOI_TX		0x2
-- 
2.10.5

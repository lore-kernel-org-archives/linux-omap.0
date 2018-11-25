From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] net: ethernet: ti: cpsw: allow to configure min tx packet size
Date: Sun, 25 Nov 2018 17:43:15 -0600
Message-ID: <20181125234315.28313-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

For proper VLAN packets forwarding CPSW driver uses min tx packet size of
64bytes (VLAN_ETH_ZLEN, excluding ETH_FCS) which was corrected by
commit 9421c9015047 ("net: ethernet: ti: cpsw: fix min eth packet size").

Unfortunately, this breaks some industrial automation protocols, as
reported by TI customers [1], which can work only with min TX packet size
from 60 byte (ecluding FCS).

Hence, introduce module boot parameter "tx_packet_min" to allow configure
min TX packet size at boot time.

[1] https://e2e.ti.com/support/arm/sitara_arm/f/791/t/701669
Fixes: 9421c9015047 ("net: ethernet: ti: cpsw: fix min eth packet size")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index ceaec56..15d563c 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -188,6 +188,10 @@ static int rx_packet_max = CPSW_MAX_PACKET_SIZE;
 module_param(rx_packet_max, int, 0);
 MODULE_PARM_DESC(rx_packet_max, "maximum receive packet size (bytes)");
 
+static int tx_packet_min = CPSW_MIN_PACKET_SIZE;
+module_param(tx_packet_min, int, 0444);
+MODULE_PARM_DESC(tx_packet_min, "minimum tx packet size (bytes)");
+
 static int descs_pool_size = CPSW_CPDMA_DESCS_POOL_SIZE_DEFAULT;
 module_param(descs_pool_size, int, 0444);
 MODULE_PARM_DESC(descs_pool_size, "Number of CPDMA CPPI descriptors in pool");
@@ -2131,7 +2135,7 @@ static netdev_tx_t cpsw_ndo_start_xmit(struct sk_buff *skb,
 	struct cpdma_chan *txch;
 	int ret, q_idx;
 
-	if (skb_padto(skb, CPSW_MIN_PACKET_SIZE)) {
+	if (skb_padto(skb, tx_packet_min)) {
 		cpsw_err(priv, tx_err, "packet pad failed\n");
 		ndev->stats.tx_dropped++;
 		return NET_XMIT_DROP;
@@ -3636,7 +3640,7 @@ static int cpsw_probe(struct platform_device *pdev)
 
 	dma_params.num_chan		= data->channels;
 	dma_params.has_soft_reset	= true;
-	dma_params.min_packet_size	= CPSW_MIN_PACKET_SIZE;
+	dma_params.min_packet_size	= tx_packet_min;
 	dma_params.desc_mem_size	= data->bd_ram_size;
 	dma_params.desc_align		= 16;
 	dma_params.has_ext_regs		= true;
-- 
2.10.5

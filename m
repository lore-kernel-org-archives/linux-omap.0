From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] net: ethernet: ti: cpsw: fix min eth packet size
Date: Wed, 15 Nov 2017 09:46:35 -0600
Message-ID: <20171115154635.26642-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Now CPSW driver configures min eth packet size to 60 octets (ETH_ZLEN)
which works in most of cases, but when port VLAN is configured on some
switch port, it also can be configured to force all egress packets to be
VLAN untagged. And in this case, CPSW driver will pad small packets to 60
octets, but final packet size on port egress can became less than 60 octets
due to VLAN tag removal and packet will be dropped.

Hence, fix it by accounting VLAN header in CPSW min eth packet size. While
here, use proper defines for CPSW_MAX_PACKET_SIZE also, instead of open
coding.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 05d77fc..0c7c7a1 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -119,8 +119,8 @@ do {								\
 #define CPDMA_RXCP		0x60
 
 #define CPSW_POLL_WEIGHT	64
-#define CPSW_MIN_PACKET_SIZE	60
-#define CPSW_MAX_PACKET_SIZE	(1500 + 14 + 4 + 4)
+#define CPSW_MIN_PACKET_SIZE	(VLAN_ETH_ZLEN)
+#define CPSW_MAX_PACKET_SIZE	(VLAN_ETH_FRAME_LEN + ETH_FCS_LEN)
 
 #define RX_PRIORITY_MAPPING	0x76543210
 #define TX_PRIORITY_MAPPING	0x33221100
-- 
2.10.5

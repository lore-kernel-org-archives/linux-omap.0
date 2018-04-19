From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v2] net: ethernet: ti: cpsw: fix tx vlan priority mapping
Date: Thu, 19 Apr 2018 22:49:09 +0300
Message-ID: <1524167349-11004-1-git-send-email-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com
Cc: davem@davemloft.net, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

The CPDMA_TX_PRIORITY_MAP in real is vlan pcp field priority mapping
register and basically replaces vlan pcp field for tagged packets.
So, set it to be 1:1 mapping. Otherwise, it will cause unexpected
change of egress vlan tagged packets, like prio 2 -> prio 5.

Fixes: e05107e6b747 ("net: ethernet: ti: cpsw: add multi queue support")
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
Based on net/master

 drivers/net/ethernet/ti/cpsw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 3037127..74f8284 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -129,7 +129,7 @@ do {								\
 
 #define RX_PRIORITY_MAPPING	0x76543210
 #define TX_PRIORITY_MAPPING	0x33221100
-#define CPDMA_TX_PRIORITY_MAP	0x01234567
+#define CPDMA_TX_PRIORITY_MAP	0x76543210
 
 #define CPSW_VLAN_AWARE		BIT(1)
 #define CPSW_RX_VLAN_ENCAP	BIT(2)
-- 
2.7.4

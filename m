From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 04/11] net: ethernet: ti: cpsw: move mac_hi/lo defines in cpsw.h
Date: Wed, 22 Nov 2017 15:25:50 -0600
Message-ID: <20171122212557.9998-5-grygorii.strashko@ti.com>
References: <20171122212557.9998-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171122212557.9998-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Move mac_hi/lo defines in common header cpsw.h and re-use
them for netcp_ethss.c.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c        | 4 ----
 drivers/net/ethernet/ti/cpsw.h        | 4 ++++
 drivers/net/ethernet/ti/netcp_ethss.c | 5 +----
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 2c50596..f914589 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -978,10 +978,6 @@ static inline void soft_reset(const char *module, void __iomem *reg)
 	WARN(readl_relaxed(reg) & 1, "failed to soft-reset %s\n", module);
 }
 
-#define mac_hi(mac)	(((mac)[0] << 0) | ((mac)[1] << 8) |	\
-			 ((mac)[2] << 16) | ((mac)[3] << 24))
-#define mac_lo(mac)	(((mac)[4] << 0) | ((mac)[5] << 8))
-
 static void cpsw_set_slave_mac(struct cpsw_slave *slave,
 			       struct cpsw_priv *priv)
 {
diff --git a/drivers/net/ethernet/ti/cpsw.h b/drivers/net/ethernet/ti/cpsw.h
index a325f555..cf111db 100644
--- a/drivers/net/ethernet/ti/cpsw.h
+++ b/drivers/net/ethernet/ti/cpsw.h
@@ -17,6 +17,10 @@
 #include <linux/if_ether.h>
 #include <linux/phy.h>
 
+#define mac_hi(mac)	(((mac)[0] << 0) | ((mac)[1] << 8) |	\
+			 ((mac)[2] << 16) | ((mac)[3] << 24))
+#define mac_lo(mac)	(((mac)[4] << 0) | ((mac)[5] << 8))
+
 void cpsw_phy_sel(struct device *dev, phy_interface_t phy_mode, int slave);
 int ti_cm_get_macid(struct device *dev, int slave, u8 *mac_addr);
 
diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 4ad8216..1ff0ade 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -27,6 +27,7 @@
 #include <linux/net_tstamp.h>
 #include <linux/ethtool.h>
 
+#include "cpsw.h"
 #include "cpsw_ale.h"
 #include "netcp.h"
 #include "cpts.h"
@@ -2047,10 +2048,6 @@ static const struct ethtool_ops keystone_ethtool_ops = {
 	.get_ts_info		= keystone_get_ts_info,
 };
 
-#define mac_hi(mac)	(((mac)[0] << 0) | ((mac)[1] << 8) |	\
-			 ((mac)[2] << 16) | ((mac)[3] << 24))
-#define mac_lo(mac)	(((mac)[4] << 0) | ((mac)[5] << 8))
-
 static void gbe_set_slave_mac(struct gbe_slave *slave,
 			      struct gbe_intf *gbe_intf)
 {
-- 
2.10.5

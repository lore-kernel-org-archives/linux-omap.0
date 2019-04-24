From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH v3 net-next 08/11] net: ethernet: ti: cpsw: fix build of cpsw drivers
Date: Thu, 25 Apr 2019 01:24:24 +0300
Message-ID: <1556144667-27997-9-git-send-email-grygorii.strashko@ti.com>
References: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Now there is dependency between CPSW switchdev and CPSW legacy drivers
related to for_each_slave() and cpsw_slave_index() - they can be compiled
both, but one of them will be not functional depending in Kconfig settings
due to duffrences in Slave indexes calculation.

To fix this make for_each_slave() local (it's used now only by legacy
driver) and convert cpsw_slave_index() to be a fucntion pointer which is
assigned in probe. Driver to start is defined by DT.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c      | 27 ++++++++++++++++++
 drivers/net/ethernet/ti/cpsw_new.c  | 14 ++++++++++
 drivers/net/ethernet/ti/cpsw_priv.c |  2 ++
 drivers/net/ethernet/ti/cpsw_priv.h | 43 +----------------------------
 4 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 86e23468c51f..46febf13524c 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -60,6 +60,31 @@ static int descs_pool_size = CPSW_CPDMA_DESCS_POOL_SIZE_DEFAULT;
 module_param(descs_pool_size, int, 0444);
 MODULE_PARM_DESC(descs_pool_size, "Number of CPDMA CPPI descriptors in pool");
 
+#define for_each_slave(priv, func, arg...)				\
+	do {								\
+		struct cpsw_slave *slave;				\
+		struct cpsw_common *cpsw = (priv)->cpsw;		\
+		int n;							\
+		if (cpsw->data.dual_emac)				\
+			(func)((cpsw)->slaves + priv->emac_port, ##arg);\
+		else							\
+			for (n = cpsw->data.slaves,			\
+					slave = cpsw->slaves;		\
+					n; n--)				\
+				(func)(slave++, ##arg);			\
+	} while (0)
+
+static int cpsw_slave_index_priv(struct cpsw_common *cpsw,
+				 struct cpsw_priv *priv)
+{
+	return cpsw->data.dual_emac ? priv->emac_port : cpsw->data.active_slave;
+}
+
+static int cpsw_get_slave_port(u32 slave_num)
+{
+	return slave_num + 1;
+}
+
 static int cpsw_ndo_vlan_rx_add_vid(struct net_device *ndev,
 				    __be16 proto, u16 vid);
 
@@ -1791,6 +1816,8 @@ static int cpsw_probe(struct platform_device *pdev)
 	if (!cpsw)
 		return -ENOMEM;
 
+	cpsw_slave_index = cpsw_slave_index_priv;
+
 	cpsw->dev = dev;
 
 	mode = devm_gpiod_get_array_optional(dev, "mode", GPIOD_OUT_LOW);
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 4ea28f722136..f27fb319bf3d 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -55,6 +55,18 @@ struct cpsw_switchdev_event_work {
 	unsigned long event;
 };
 
+/* struct cpsw_common is not needed, kept here for compatibility
+ * reasons witrh the old driver
+ */
+static int cpsw_slave_index_priv(struct cpsw_common *cpsw,
+				 struct cpsw_priv *priv)
+{
+	if (priv->emac_port == HOST_PORT_NUM)
+		return -1;
+
+	return priv->emac_port - 1;
+}
+
 static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
 {
 	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
@@ -1696,6 +1708,8 @@ static int cpsw_probe(struct platform_device *pdev)
 	if (!cpsw)
 		return -ENOMEM;
 
+	cpsw_slave_index = cpsw_slave_index_priv;
+
 	cpsw->dev = dev;
 
 	cpsw->slaves = devm_kcalloc(dev,
diff --git a/drivers/net/ethernet/ti/cpsw_priv.c b/drivers/net/ethernet/ti/cpsw_priv.c
index 62ba53f9bf8a..d7087650ac6d 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.c
+++ b/drivers/net/ethernet/ti/cpsw_priv.c
@@ -22,6 +22,8 @@
 #include "cpsw_sl.h"
 #include "davinci_cpdma.h"
 
+int (*cpsw_slave_index)(struct cpsw_common *cpsw, struct cpsw_priv *priv);
+
 void cpsw_intr_enable(struct cpsw_common *cpsw)
 {
 	writel_relaxed(0xFF, &cpsw->wr_regs->tx_en);
diff --git a/drivers/net/ethernet/ti/cpsw_priv.h b/drivers/net/ethernet/ti/cpsw_priv.h
index 98817e14c878..c9f5528f41e4 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.h
+++ b/drivers/net/ethernet/ti/cpsw_priv.h
@@ -377,48 +377,7 @@ struct cpsw_priv {
 #define ndev_to_cpsw(ndev) (((struct cpsw_priv *)netdev_priv(ndev))->cpsw)
 #define napi_to_cpsw(napi)	container_of(napi, struct cpsw_common, napi)
 
-#ifdef CONFIG_TI_CPSW_SWITCHDEV
-#define for_each_slave(priv, func, arg...)				\
-	do {								\
-		struct cpsw_common *cpsw = (priv)->cpsw;		\
-		(func)((cpsw)->slaves + (priv)->emac_port - 1, ##arg);	\
-	} while (0)
-
-/* struct cpsw_common is not needed, kept here for compatibility
- * reasons witrh the old driver
- */
-static inline int cpsw_slave_index(struct cpsw_common *cpsw,
-				   struct cpsw_priv *priv)
-{
-	if (priv->emac_port == HOST_PORT_NUM)
-		return -1;
-
-	return priv->emac_port - 1;
-}
-#else
-#define for_each_slave(priv, func, arg...)				\
-	do {								\
-		struct cpsw_slave *slave;				\
-		struct cpsw_common *cpsw = (priv)->cpsw;		\
-		int n;							\
-		if (cpsw->data.dual_emac)				\
-			(func)((cpsw)->slaves + priv->emac_port, ##arg);\
-		else							\
-			for (n = cpsw->data.slaves,			\
-					slave = cpsw->slaves;		\
-					n; n--)				\
-				(func)(slave++, ##arg);			\
-	} while (0)
-
-#define cpsw_slave_index(cpsw, priv)				\
-		((cpsw->data.dual_emac) ? priv->emac_port :	\
-		cpsw->data.active_slave)
-#endif
-
-static inline int cpsw_get_slave_port(u32 slave_num)
-{
-	return slave_num + 1;
-}
+extern int (*cpsw_slave_index)(struct cpsw_common *cpsw, struct cpsw_priv *priv);
 
 struct addr_sync_ctx {
 	struct net_device *ndev;
-- 
2.17.1

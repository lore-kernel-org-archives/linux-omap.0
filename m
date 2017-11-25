From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH] net: ethernet: davinci_emac: Deduplicate bus_find_device() by
 name matching
Date: Sat, 25 Nov 2017 12:18:19 +0100
Message-ID: <4cc7d22afdb1d511cef489b3c6b498270bd5caff.1511608500.git.lukas@wunner.de>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

No need to reinvent the wheel, we have bus_find_device_by_name().

Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/net/ethernet/ti/davinci_emac.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 4bb561856af5..f58c0c620356 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1385,11 +1385,6 @@ static int emac_devioctl(struct net_device *ndev, struct ifreq *ifrq, int cmd)
 		return -EOPNOTSUPP;
 }
 
-static int match_first_device(struct device *dev, void *data)
-{
-	return !strncmp(dev_name(dev), "davinci_mdio", 12);
-}
-
 /**
  * emac_dev_open - EMAC device open
  * @ndev: The DaVinci EMAC network adapter
@@ -1489,8 +1484,8 @@ static int emac_dev_open(struct net_device *ndev)
 
 	/* use the first phy on the bus if pdata did not give us a phy id */
 	if (!phydev && !priv->phy_id) {
-		phy = bus_find_device(&mdio_bus_type, NULL, NULL,
-				      match_first_device);
+		phy = bus_find_device_by_name(&mdio_bus_type, NULL,
+					      "davinci_mdio");
 		if (phy) {
 			priv->phy_id = dev_name(phy);
 			if (!priv->phy_id || !*priv->phy_id)
-- 
2.11.0

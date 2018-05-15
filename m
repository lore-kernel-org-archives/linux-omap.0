From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net-next v2 2/2] drivers: net: Remove device_node checks with of_mdiobus_register()
Date: Tue, 15 May 2018 16:56:19 -0700
Message-ID: <20180515235619.27773-3-f.fainelli@gmail.com>
References: <20180515235619.27773-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180515235619.27773-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@savoirfairelinux.com>, "David S. Miller" <davem@davemloft.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, Fugang Duan <fugang.duan@nxp.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, Jose Abreu <joabreu@synopsys.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Woojung Huh <woojung.huh@microchip.com>, Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Tobias Jordan <Tobias.Jordan@elektrobit.com>Russell King <r>
List-Id: linux-omap@vger.kernel.org

A number of drivers have the following pattern:

if (np)
	of_mdiobus_register()
else
	mdiobus_register()

which the implementation of of_mdiobus_register() now takes care of.
Remove that pattern in drivers that strictly adhere to it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/bcm_sf2.c                         |  8 ++------
 drivers/net/dsa/mv88e6xxx/chip.c                  |  5 +----
 drivers/net/ethernet/cadence/macb_main.c          | 12 +++---------
 drivers/net/ethernet/freescale/fec_main.c         |  8 ++------
 drivers/net/ethernet/marvell/mvmdio.c             |  5 +----
 drivers/net/ethernet/renesas/sh_eth.c             | 11 +++--------
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c |  5 +----
 drivers/net/ethernet/ti/davinci_mdio.c            |  8 +++-----
 drivers/net/phy/mdio-gpio.c                       |  6 +-----
 drivers/net/phy/mdio-mscc-miim.c                  |  6 +-----
 drivers/net/usb/lan78xx.c                         |  7 ++-----
 11 files changed, 20 insertions(+), 61 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index ac621f44237a..02e8982519ce 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -450,12 +450,8 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
 	priv->slave_mii_bus->parent = ds->dev->parent;
 	priv->slave_mii_bus->phy_mask = ~priv->indir_phy_mask;
 
-	if (dn)
-		err = of_mdiobus_register(priv->slave_mii_bus, dn);
-	else
-		err = mdiobus_register(priv->slave_mii_bus);
-
-	if (err)
+	err = of_mdiobus_register(priv->slave_mii_bus, dn);
+	if (err && dn)
 		of_node_put(dn);
 
 	return err;
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index b23c11d9f4b2..2bb3f03ee1cb 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2454,10 +2454,7 @@ static int mv88e6xxx_mdio_register(struct mv88e6xxx_chip *chip,
 			return err;
 	}
 
-	if (np)
-		err = of_mdiobus_register(bus, np);
-	else
-		err = mdiobus_register(bus);
+	err = of_mdiobus_register(bus, np);
 	if (err) {
 		dev_err(chip->dev, "Cannot register MDIO bus (%d)\n", err);
 		mv88e6xxx_g2_irq_mdio_free(chip, bus);
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b4c9268100bb..3e93df5d4e3b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -591,16 +591,10 @@ static int macb_mii_init(struct macb *bp)
 	dev_set_drvdata(&bp->dev->dev, bp->mii_bus);
 
 	np = bp->pdev->dev.of_node;
+	if (pdata)
+		bp->mii_bus->phy_mask = pdata->phy_mask;
 
-	if (np) {
-		err = of_mdiobus_register(bp->mii_bus, np);
-	} else {
-		if (pdata)
-			bp->mii_bus->phy_mask = pdata->phy_mask;
-
-		err = mdiobus_register(bp->mii_bus);
-	}
-
+	err = of_mdiobus_register(bp->mii_bus, np);
 	if (err)
 		goto err_out_free_mdiobus;
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index d4604bc8eb5b..f3e43db0d6cb 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2052,13 +2052,9 @@ static int fec_enet_mii_init(struct platform_device *pdev)
 	fep->mii_bus->parent = &pdev->dev;
 
 	node = of_get_child_by_name(pdev->dev.of_node, "mdio");
-	if (node) {
-		err = of_mdiobus_register(fep->mii_bus, node);
+	err = of_mdiobus_register(fep->mii_bus, node);
+	if (node)
 		of_node_put(node);
-	} else {
-		err = mdiobus_register(fep->mii_bus);
-	}
-
 	if (err)
 		goto err_out_free_mdiobus;
 
diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 0495487f7b42..c5dac6bd2be4 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -348,10 +348,7 @@ static int orion_mdio_probe(struct platform_device *pdev)
 		goto out_mdio;
 	}
 
-	if (pdev->dev.of_node)
-		ret = of_mdiobus_register(bus, pdev->dev.of_node);
-	else
-		ret = mdiobus_register(bus);
+	ret = of_mdiobus_register(bus, pdev->dev.of_node);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Cannot register MDIO bus (%d)\n", ret);
 		goto out_mdio;
diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 5970d9e5ddf1..8dd41e08a6c6 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -3025,15 +3025,10 @@ static int sh_mdio_init(struct sh_eth_private *mdp,
 		 pdev->name, pdev->id);
 
 	/* register MDIO bus */
-	if (dev->of_node) {
-		ret = of_mdiobus_register(mdp->mii_bus, dev->of_node);
-	} else {
-		if (pd->phy_irq > 0)
-			mdp->mii_bus->irq[pd->phy] = pd->phy_irq;
-
-		ret = mdiobus_register(mdp->mii_bus);
-	}
+	if (pd->phy_irq > 0)
+		mdp->mii_bus->irq[pd->phy] = pd->phy_irq;
 
+	ret = of_mdiobus_register(mdp->mii_bus, dev->of_node);
 	if (ret)
 		goto out_free_bus;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index f5f37bfa1d58..5df1a608e566 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -233,10 +233,7 @@ int stmmac_mdio_register(struct net_device *ndev)
 	new_bus->phy_mask = mdio_bus_data->phy_mask;
 	new_bus->parent = priv->device;
 
-	if (mdio_node)
-		err = of_mdiobus_register(new_bus, mdio_node);
-	else
-		err = mdiobus_register(new_bus);
+	err = of_mdiobus_register(new_bus, mdio_node);
 	if (err != 0) {
 		dev_err(dev, "Cannot register the MDIO bus\n");
 		goto bus_register_fail;
diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index 98a1c97fb95e..8ac72831af05 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -429,12 +429,10 @@ static int davinci_mdio_probe(struct platform_device *pdev)
 	 * defined to support backward compatibility with DTs which assume that
 	 * Davinci MDIO will always scan the bus for PHYs detection.
 	 */
-	if (dev->of_node && of_get_child_count(dev->of_node)) {
+	if (dev->of_node && of_get_child_count(dev->of_node))
 		data->skip_scan = true;
-		ret = of_mdiobus_register(data->bus, dev->of_node);
-	} else {
-		ret = mdiobus_register(data->bus);
-	}
+
+	ret = of_mdiobus_register(data->bus, dev->of_node);
 	if (ret)
 		goto bail_out;
 
diff --git a/drivers/net/phy/mdio-gpio.c b/drivers/net/phy/mdio-gpio.c
index b501221819e1..4e4c8daf44c3 100644
--- a/drivers/net/phy/mdio-gpio.c
+++ b/drivers/net/phy/mdio-gpio.c
@@ -179,11 +179,7 @@ static int mdio_gpio_probe(struct platform_device *pdev)
 	if (!new_bus)
 		return -ENODEV;
 
-	if (pdev->dev.of_node)
-		ret = of_mdiobus_register(new_bus, pdev->dev.of_node);
-	else
-		ret = mdiobus_register(new_bus);
-
+	ret = of_mdiobus_register(new_bus, pdev->dev.of_node);
 	if (ret)
 		mdio_gpio_bus_deinit(&pdev->dev);
 
diff --git a/drivers/net/phy/mdio-mscc-miim.c b/drivers/net/phy/mdio-mscc-miim.c
index 8c689ccfdbca..badbc99bedd3 100644
--- a/drivers/net/phy/mdio-mscc-miim.c
+++ b/drivers/net/phy/mdio-mscc-miim.c
@@ -151,11 +151,7 @@ static int mscc_miim_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (pdev->dev.of_node)
-		ret = of_mdiobus_register(bus, pdev->dev.of_node);
-	else
-		ret = mdiobus_register(bus);
-
+	ret = of_mdiobus_register(bus, pdev->dev.of_node);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Cannot register MDIO bus (%d)\n", ret);
 		return ret;
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 91761436709a..8dff87ec6d99 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1843,12 +1843,9 @@ static int lan78xx_mdio_init(struct lan78xx_net *dev)
 	}
 
 	node = of_get_child_by_name(dev->udev->dev.of_node, "mdio");
-	if (node) {
-		ret = of_mdiobus_register(dev->mdiobus, node);
+	ret = of_mdiobus_register(dev->mdiobus, node);
+	if (node)
 		of_node_put(node);
-	} else {
-		ret = mdiobus_register(dev->mdiobus);
-	}
 	if (ret) {
 		netdev_err(dev->net, "can't register MDIO bus\n");
 		goto exit1;
-- 
2.14.1

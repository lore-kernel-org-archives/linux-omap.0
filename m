From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v3 10/18] net: davinci_emac: use nvmem to retrieve the mac address
Date: Thu, 28 Jun 2018 16:32:36 +0200
Message-ID: <20180628143244.4561-11-brgl@bgdev.pl>
References: <20180628143244.4561-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180628143244.4561-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

All users which store the MAC address in EEPROM now register relevant
nvmem cells. Switch to retrieving the MAC address over the nvmem
framework. If we can't get the nvmem cell then fall back to using
the device tree.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/ethernet/ti/davinci_emac.c | 33 +++++++++++++++++++-------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 17cfe093b8cf..7608169e643f 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -68,6 +68,8 @@
 #include <linux/of_net.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mtd/mtd.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-consumer.h>
 #include <asm/irq.h>
 #include <asm/page.h>
 
@@ -1696,7 +1698,6 @@ davinci_emac_of_get_pdata(struct platform_device *pdev, struct emac_priv *priv)
 	const struct of_device_id *match;
 	const struct emac_platform_data *auxdata;
 	struct emac_platform_data *pdata = NULL;
-	const u8 *mac_addr;
 
 	if (!IS_ENABLED(CONFIG_OF) || !pdev->dev.of_node)
 		return dev_get_platdata(&pdev->dev);
@@ -1708,12 +1709,6 @@ davinci_emac_of_get_pdata(struct platform_device *pdev, struct emac_priv *priv)
 	np = pdev->dev.of_node;
 	pdata->version = EMAC_VERSION_2;
 
-	if (!is_valid_ether_addr(pdata->mac_addr)) {
-		mac_addr = of_get_mac_address(np);
-		if (mac_addr)
-			ether_addr_copy(pdata->mac_addr, mac_addr);
-	}
-
 	of_property_read_u32(np, "ti,davinci-ctrl-reg-offset",
 			     &pdata->ctrl_reg_offset);
 
@@ -1783,10 +1778,12 @@ static int davinci_emac_probe(struct platform_device *pdev)
 	struct cpdma_params dma_params;
 	struct clk *emac_clk;
 	unsigned long emac_bus_frequency;
-#ifdef CONFIG_MTD
+	const void *mac_addr;
 	size_t mac_addr_len;
+#ifdef CONFIG_MTD
 	struct mtd_info *mtd;
 #endif /* CONFIG_MTD */
+	struct nvmem_cell *cell;
 
 	/* obtain emac clock from kernel */
 	emac_clk = devm_clk_get(&pdev->dev, NULL);
@@ -1830,8 +1827,26 @@ static int davinci_emac_probe(struct platform_device *pdev)
 	}
 #endif /* CONFIG_MTD */
 
+	cell = nvmem_cell_get(&pdev->dev, "mac-address");
+	if (!IS_ERR(cell)) {
+		mac_addr = nvmem_cell_read(cell, &mac_addr_len);
+		if (!IS_ERR(mac_addr)) {
+			if (is_valid_ether_addr(mac_addr)) {
+				dev_info(&pdev->dev,
+					 "Read MAC addr from EEPROM: %pM\n",
+					 mac_addr);
+				ether_addr_copy(priv->mac_addr, mac_addr);
+			}
+			kfree(mac_addr);
+		}
+		nvmem_cell_put(cell);
+	} else {
+		mac_addr = of_get_mac_address(np);
+		if (mac_addr)
+			ether_addr_copy(priv->mac_addr, mac_addr);
+	}
+
 	/* MAC addr and PHY mask , RMII enable info from platform_data */
-	memcpy(priv->mac_addr, pdata->mac_addr, ETH_ALEN);
 	priv->phy_id = pdata->phy_id;
 	priv->rmii_en = pdata->rmii_en;
 	priv->version = pdata->version;
-- 
2.17.1

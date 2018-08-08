From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 16/28] net: davinci_emac: use eth_platform_get_mac_address()
Date: Wed,  8 Aug 2018 17:31:38 +0200
Message-ID: <20180808153150.23444-17-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180808153150.23444-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.co>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support nvmem in eth_platform_get_mac_address() and all boards
have the mac-address cells defined. Stop getting the MAC from pdata
and use the dedicated helper.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/ethernet/ti/davinci_emac.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index f270beebb428..5d01bad4baa5 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1700,7 +1700,6 @@ davinci_emac_of_get_pdata(struct platform_device *pdev, struct emac_priv *priv)
 	const struct of_device_id *match;
 	const struct emac_platform_data *auxdata;
 	struct emac_platform_data *pdata = NULL;
-	const u8 *mac_addr;
 
 	if (!IS_ENABLED(CONFIG_OF) || !pdev->dev.of_node)
 		return dev_get_platdata(&pdev->dev);
@@ -1712,12 +1711,6 @@ davinci_emac_of_get_pdata(struct platform_device *pdev, struct emac_priv *priv)
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
 
@@ -1819,8 +1812,11 @@ static int davinci_emac_probe(struct platform_device *pdev)
 		goto err_free_netdev;
 	}
 
+	rc = eth_platform_get_mac_address(&pdev->dev, priv->mac_addr);
+	if (rc == -EPROBE_DEFER)
+		return -EPROBE_DEFER; /* We'll get the MAC address later. */
+
 	/* MAC addr and PHY mask , RMII enable info from platform_data */
-	memcpy(priv->mac_addr, pdata->mac_addr, ETH_ALEN);
 	priv->phy_id = pdata->phy_id;
 	priv->rmii_en = pdata->rmii_en;
 	priv->version = pdata->version;
-- 
2.18.0

From: =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
Subject: [PATCH 4/4] net: davinci_emac: Drop nvmem_get_mac_address usage
Date: Sat, 27 Apr 2019 01:06:42 +0200
Message-ID: <1556320002-26213-5-git-send-email-ynezz@true.cz>
References: <1556320002-26213-1-git-send-email-ynezz@true.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556320002-26213-1-git-send-email-ynezz@true.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Alban Bedel <albeu@free.fr>, =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

of_get_mac_address now uses NVMEM under the hood, so it's not necessary
to call it manually anymore.

Signed-off-by: Petr Štetiar <ynezz@true.cz>
---
 drivers/net/ethernet/ti/davinci_emac.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 57450b1..c1a5526 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1912,15 +1912,11 @@ static int davinci_emac_probe(struct platform_device *pdev)
 		ether_addr_copy(ndev->dev_addr, priv->mac_addr);
 
 	if (!is_valid_ether_addr(priv->mac_addr)) {
-		/* Try nvmem if MAC wasn't passed over pdata or DT. */
-		rc = nvmem_get_mac_address(&pdev->dev, priv->mac_addr);
-		if (rc) {
-			/* Use random MAC if still none obtained. */
-			eth_hw_addr_random(ndev);
-			memcpy(priv->mac_addr, ndev->dev_addr, ndev->addr_len);
-			dev_warn(&pdev->dev, "using random MAC addr: %pM\n",
-				 priv->mac_addr);
-		}
+		/* Use random MAC if still none obtained. */
+		eth_hw_addr_random(ndev);
+		memcpy(priv->mac_addr, ndev->dev_addr, ndev->addr_len);
+		dev_warn(&pdev->dev, "using random MAC addr: %pM\n",
+			 priv->mac_addr);
 	}
 
 	ndev->netdev_ops = &emac_netdev_ops;
-- 
1.9.1

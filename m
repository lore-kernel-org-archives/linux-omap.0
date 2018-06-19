From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 3/3] net: davinci_emac: match the mdio device against its compatible if possible
Date: Tue, 19 Jun 2018 18:09:50 +0200
Message-ID: <20180619160950.6283-4-brgl@bgdev.pl>
References: <20180619160950.6283-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180619160950.6283-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Rob Herring <robh@kernel.org>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Device tree based systems without of_dev_auxdata will have the mdio
device named differently than "davinci_mdio(.0)". In this case use the
device's compatible string for matching.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/ethernet/ti/davinci_emac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index a1a6445b5a7e..c28a35bb852f 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1387,6 +1387,10 @@ static int emac_devioctl(struct net_device *ndev, struct ifreq *ifrq, int cmd)
 
 static int match_first_device(struct device *dev, void *data)
 {
+	if (dev->of_node)
+		return of_device_is_compatible(dev->of_node,
+					       "ti,davinci_mdio");
+
 	return !strncmp(dev_name(dev), "davinci_mdio", 12);
 }
 
-- 
2.17.1

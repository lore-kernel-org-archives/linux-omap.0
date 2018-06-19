From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 2/3] net: phy: set the of_node in the mdiodev's struct device
Date: Tue, 19 Jun 2018 18:09:49 +0200
Message-ID: <20180619160950.6283-3-brgl@bgdev.pl>
References: <20180619160950.6283-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180619160950.6283-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Rob Herring <robh@kernel.org>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Copy the of_node over from mii_bus's struct device. This is needed
for device-tree systems to be able to check the mdio device's
compatible string.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/phy/phy_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index bd0f339f69fd..a92d5ee61813 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -411,6 +411,7 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, int phy_id,
 	mdiodev->dev.parent = &bus->dev;
 	mdiodev->dev.bus = &mdio_bus_type;
 	mdiodev->dev.type = &mdio_bus_phy_type;
+	mdiodev->dev.of_node = bus->dev.of_node;
 	mdiodev->bus = bus;
 	mdiodev->bus_match = phy_bus_match;
 	mdiodev->addr = addr;
-- 
2.17.1

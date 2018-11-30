From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [net-next][PATCH 3/4] of: net: kill of_get_nvmem_mac_address()
Date: Fri, 30 Nov 2018 09:20:59 +0100
Message-ID: <20181130082100.6241-4-brgl@bgdev.pl>
References: <20181130082100.6241-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130082100.6241-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, "David S . Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-omap@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We've switched all users to nvmem_get_mac_address(). Remove the now
dead code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/of/of_net.c    | 39 ---------------------------------------
 include/linux/of_net.h |  6 ------
 2 files changed, 45 deletions(-)

diff --git a/drivers/of/of_net.c b/drivers/of/of_net.c
index 53189d4022a6..810ab0fbcccb 100644
--- a/drivers/of/of_net.c
+++ b/drivers/of/of_net.c
@@ -81,42 +81,3 @@ const void *of_get_mac_address(struct device_node *np)
 	return of_get_mac_addr(np, "address");
 }
 EXPORT_SYMBOL(of_get_mac_address);
-
-/**
- * Obtain the MAC address from an nvmem provider named 'mac-address' through
- * device tree.
- * On success, copies the new address into memory pointed to by addr and
- * returns 0. Returns a negative error code otherwise.
- * @np:		Device tree node containing the nvmem-cells phandle
- * @addr:	Pointer to receive the MAC address using ether_addr_copy()
- */
-int of_get_nvmem_mac_address(struct device_node *np, void *addr)
-{
-	struct nvmem_cell *cell;
-	const void *mac;
-	size_t len;
-	int ret;
-
-	cell = of_nvmem_cell_get(np, "mac-address");
-	if (IS_ERR(cell))
-		return PTR_ERR(cell);
-
-	mac = nvmem_cell_read(cell, &len);
-
-	nvmem_cell_put(cell);
-
-	if (IS_ERR(mac))
-		return PTR_ERR(mac);
-
-	if (len < ETH_ALEN || !is_valid_ether_addr(mac)) {
-		ret = -EINVAL;
-	} else {
-		ether_addr_copy(addr, mac);
-		ret = 0;
-	}
-
-	kfree(mac);
-
-	return ret;
-}
-EXPORT_SYMBOL(of_get_nvmem_mac_address);
diff --git a/include/linux/of_net.h b/include/linux/of_net.h
index 90d81ee9e6a0..9cd72aab76fe 100644
--- a/include/linux/of_net.h
+++ b/include/linux/of_net.h
@@ -13,7 +13,6 @@
 struct net_device;
 extern int of_get_phy_mode(struct device_node *np);
 extern const void *of_get_mac_address(struct device_node *np);
-extern int of_get_nvmem_mac_address(struct device_node *np, void *addr);
 extern struct net_device *of_find_net_device_by_node(struct device_node *np);
 #else
 static inline int of_get_phy_mode(struct device_node *np)
@@ -26,11 +25,6 @@ static inline const void *of_get_mac_address(struct device_node *np)
 	return NULL;
 }
 
-static inline int of_get_nvmem_mac_address(struct device_node *np, void *addr)
-{
-	return -ENODEV;
-}
-
 static inline struct net_device *of_find_net_device_by_node(struct device_node *np)
 {
 	return NULL;
-- 
2.19.1

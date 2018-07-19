From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v3 2/3] net: add support for nvmem to eth_platform_get_mac_address()
Date: Thu, 19 Jul 2018 17:32:42 +0200
Message-ID: <20180719153243.20944-3-brgl@bgdev.pl>
References: <20180719153243.20944-1-brgl@bgdev.pl>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180719153243.20944-1-brgl@bgdev.pl>
Sender: netdev-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Many non-DT platforms read the MAC address from EEPROM. Usually it's
either done with callbacks defined in board files or from SoC-specific
ethernet drivers.

In order to generalize this, try to read the MAC from nvmem in
eth_platform_get_mac_address() using a standard lookup name:
"mac-address".

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 net/ethernet/eth.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index cf54cdf042b7..98bc280b8a62 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -54,6 +54,7 @@
 #include <linux/if_ether.h>
 #include <linux/of_net.h>
 #include <linux/pci.h>
+#include <linux/nvmem-consumer.h>
 #include <net/dst.h>
 #include <net/arp.h>
 #include <net/sock.h>
@@ -559,6 +560,39 @@ static int mac_address_from_arch(u8 *mac_addr)
 	return 0;
 }
 
+static int mac_address_from_nvmem(struct device *dev, u8 *mac_addr)
+{
+	const unsigned char *addr;
+	struct nvmem_cell *cell;
+	size_t alen;
+	int rv = 0;
+
+	cell = nvmem_cell_get(dev, "mac-address");
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	addr = nvmem_cell_read(cell, &alen);
+	if (IS_ERR(addr)) {
+		rv = PTR_ERR(addr);
+		goto put_nvmem;
+	}
+
+	if (alen != ETH_ALEN || !is_valid_ether_addr(addr)) {
+		rv = -ENODEV;
+		goto free_addr;
+	}
+
+	ether_addr_copy(mac_addr, addr);
+
+free_addr:
+	kfree(addr);
+
+put_nvmem:
+	nvmem_cell_put(cell);
+
+	return rv;
+}
+
 int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 {
 	int rv;
@@ -571,6 +605,10 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 	if (!rv)
 		return 0;
 
+	rv = mac_address_from_nvmem(dev, mac_addr);
+	if (!rv)
+		return 0;
+
 	return -ENODEV;
 }
 EXPORT_SYMBOL(eth_platform_get_mac_address);
-- 
2.17.1

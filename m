From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 2/5] net: add an info message to eth_platform_get_mac_address()
Date: Wed, 18 Jul 2018 18:10:32 +0200
Message-ID: <20180718161035.7005-3-brgl@bgdev.pl>
References: <20180718161035.7005-1-brgl@bgdev.pl>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180718161035.7005-1-brgl@bgdev.pl>
Sender: netdev-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Many drivers that read the MAC address from EEPROM or MTD emit a log
message when they succeed. Since this function is meant to be reused
in those drivers instead of reimplementing the same operation
everywhere, add an info message when we successfully read the MAC
address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 net/ethernet/eth.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index da8530879e1e..2a2173324d9e 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -530,15 +530,24 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 	struct device_node *dp = dev_is_pci(dev) ?
 			pci_device_to_OF_node(to_pci_dev(dev)) : dev->of_node;
 	const unsigned char *addr = NULL;
+	const char *from = NULL;
 
-	if (dp)
+	if (dp) {
 		addr = of_get_mac_address(dp);
-	if (!addr)
+		if (addr)
+			from = "device tree";
+	}
+
+	if (!addr) {
 		addr = arch_get_platform_mac_address();
+		if (addr)
+			from = "arch callback";
+	}
 
 	if (!addr)
 		return -ENODEV;
 
+	dev_info(dev, "read MAC address from %s\n", from);
 	ether_addr_copy(mac_addr, addr);
 	return 0;
 }
-- 
2.17.1

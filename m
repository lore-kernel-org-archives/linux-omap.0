From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 2/3] net: add support for nvmem to eth_platform_get_mac_address()
Date: Thu, 19 Jul 2018 10:20:27 +0200
Message-ID: <20180719082028.26116-3-brgl@bgdev.pl>
References: <20180719082028.26116-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180719082028.26116-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
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
 net/ethernet/eth.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 39af03894598..af3b4b1b77eb 100644
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
@@ -527,8 +528,11 @@ unsigned char * __weak arch_get_platform_mac_address(void)
 
 int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 {
+	unsigned char addrbuf[ETH_ALEN];
 	const unsigned char *addr;
+	struct nvmem_cell *nvmem;
 	struct device_node *dp;
+	size_t alen;
 
 	if (dev_is_pci(dev))
 		dp = pci_device_to_OF_node(to_pci_dev(dev));
@@ -541,6 +545,29 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 	if (!addr)
 		addr = arch_get_platform_mac_address();
 
+	if (!addr) {
+		nvmem = nvmem_cell_get(dev, "mac-address");
+		if (IS_ERR(nvmem) && PTR_ERR(nvmem) == -EPROBE_DEFER)
+			/* We may have a lookup registered for MAC address but
+			 * the corresponding nvmem provider hasn't been
+			 * registered yet.
+			 */
+			return -EPROBE_DEFER;
+
+		if (!IS_ERR(nvmem)) {
+			addr = nvmem_cell_read(nvmem, &alen);
+			if (!IS_ERR(addr)) {
+				if (alen == ETH_ALEN)
+					ether_addr_copy(addrbuf, addr);
+
+				kfree(addr);
+				addr = alen == ETH_ALEN ? addrbuf : NULL;
+			}
+
+			nvmem_cell_put(nvmem);
+		}
+	}
+
 	if (!addr || !is_valid_ether_addr(addr))
 		return -ENODEV;
 
-- 
2.17.1

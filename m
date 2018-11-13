From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 10/25] net: ethernet: provide nvmem_get_mac_address()
Date: Tue, 13 Nov 2018 15:01:18 +0100
Message-ID: <20181113140133.17385-11-brgl@bgdev.pl>
References: <20181113140133.17385-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181113140133.17385-1-brgl@bgdev.pl>
Sender: netdev-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Nicolas Ferre <nicolas.ferre@microchip.com>, "David S . Miller" <davem@davemloft.net>, Grygorii Strashko <grygorii.strashko@ti.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org, netdev@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We already have of_get_nvmem_mac_address() but some non-DT systems want
to read the MAC address from NVMEM too. Implement a generalized routine
that takes struct device as argument.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/etherdevice.h |  1 +
 net/ethernet/eth.c          | 38 +++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 572e11bb8696..2c0af7b00715 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -32,6 +32,7 @@
 struct device;
 int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr);
 unsigned char *arch_get_platform_mac_address(void);
+int nvmem_get_mac_address(struct device *dev, void *addrbuf);
 u32 eth_get_headlen(void *data, unsigned int max_len);
 __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev);
 extern const struct header_ops eth_header_ops;
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index fd8faa0dfa61..df38593d1bb4 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -47,6 +47,7 @@
 #include <linux/inet.h>
 #include <linux/ip.h>
 #include <linux/netdevice.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/errno.h>
@@ -548,3 +549,40 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 	return 0;
 }
 EXPORT_SYMBOL(eth_platform_get_mac_address);
+
+/**
+ * Obtain the MAC address from an nvmem cell named 'mac-address' associated
+ * with given device.
+ *
+ * @dev:	Device with which the mac-address cell is associated.
+ * @addrbuf:	Buffer to which the MAC address will be copied on success.
+ *
+ * Returns 0 on success or a negative error number on failure.
+ */
+int nvmem_get_mac_address(struct device *dev, void *addrbuf)
+{
+	struct nvmem_cell *cell;
+	const void *mac;
+	size_t len;
+
+	cell = nvmem_cell_get(dev, "mac-address");
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	mac = nvmem_cell_read(cell, &len);
+	nvmem_cell_put(cell);
+
+	if (IS_ERR(mac))
+		return PTR_ERR(mac);
+
+	if (len != ETH_ALEN || !is_valid_ether_addr(mac)) {
+		kfree(mac);
+		return -EINVAL;
+	}
+
+	ether_addr_copy(addrbuf, mac);
+	kfree(mac);
+
+	return 0;
+}
+EXPORT_SYMBOL(nvmem_get_mac_address);
-- 
2.19.1

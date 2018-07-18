From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 5/5] net: add MTD support to eth_platform_get_mac_address()
Date: Wed, 18 Jul 2018 18:10:35 +0200
Message-ID: <20180718161035.7005-6-brgl@bgdev.pl>
References: <20180718161035.7005-1-brgl@bgdev.pl>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180718161035.7005-1-brgl@bgdev.pl>
Sender: netdev-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

MTD doesn't support nvmem yet. Some platforms use MTD to read the MAC
address from SPI flash. If we want this function to generalize reading
the MAC address, we need to separately try to use MTD.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 net/ethernet/eth.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index adf5bd03851f..f7dbd2cff7f9 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -55,6 +55,7 @@
 #include <linux/of_net.h>
 #include <linux/pci.h>
 #include <linux/nvmem-consumer.h>
+#include <linux/mtd/mtd.h>
 #include <net/dst.h>
 #include <net/arp.h>
 #include <net/sock.h>
@@ -573,6 +574,25 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 		}
 	}
 
+#ifdef CONFIG_MTD
+	/* NOTE: this should go away as soon as MTD gets nvmem support. */
+	if (!addr) {
+		struct mtd_info *mtd;
+		int rv;
+
+		mtd = get_mtd_device_nm("MAC-Address");
+		if (!IS_ERR(mtd)) {
+			rv = mtd_read(mtd, 0, ETH_ALEN, &alen, addrbuf);
+			if (rv == 0) {
+				from = "MTD";
+				addr = addrbuf;
+			}
+
+			put_mtd_device(mtd);
+		}
+	}
+#endif /* CONFIG_MTD */
+
 	if (!addr || !is_valid_ether_addr(addr))
 		return -ENODEV;
 
-- 
2.17.1

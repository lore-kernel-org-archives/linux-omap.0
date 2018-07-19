From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 1/3] net: fortify eth_platform_get_mac_address()
Date: Thu, 19 Jul 2018 10:20:26 +0200
Message-ID: <20180719082028.26116-2-brgl@bgdev.pl>
References: <20180719082028.26116-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180719082028.26116-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We'll soon have more sources from which to read the MAC address in this
routine. Make sure the address is correct before returning it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 net/ethernet/eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index ee28440f57c5..39af03894598 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -541,7 +541,7 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 	if (!addr)
 		addr = arch_get_platform_mac_address();
 
-	if (!addr)
+	if (!addr || !is_valid_ether_addr(addr))
 		return -ENODEV;
 
 	ether_addr_copy(mac_addr, addr);
-- 
2.17.1

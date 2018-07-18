From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 1/5] net: visually shrink eth_platform_get_mac_address()
Date: Wed, 18 Jul 2018 18:10:31 +0200
Message-ID: <20180718161035.7005-2-brgl@bgdev.pl>
References: <20180718161035.7005-1-brgl@bgdev.pl>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180718161035.7005-1-brgl@bgdev.pl>
Sender: netdev-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Initialize the variables with proper values so that we save a few
lines of code before we extend this function in the follow-up patches.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 net/ethernet/eth.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index ee28440f57c5..da8530879e1e 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -527,15 +527,10 @@ unsigned char * __weak arch_get_platform_mac_address(void)
 
 int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 {
-	const unsigned char *addr;
-	struct device_node *dp;
+	struct device_node *dp = dev_is_pci(dev) ?
+			pci_device_to_OF_node(to_pci_dev(dev)) : dev->of_node;
+	const unsigned char *addr = NULL;
 
-	if (dev_is_pci(dev))
-		dp = pci_device_to_OF_node(to_pci_dev(dev));
-	else
-		dp = dev->of_node;
-
-	addr = NULL;
 	if (dp)
 		addr = of_get_mac_address(dp);
 	if (!addr)
-- 
2.17.1

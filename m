From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [net-next][PATCH 2/4] net: cadence: switch to using nvmem_get_mac_address()
Date: Fri, 30 Nov 2018 09:20:58 +0100
Message-ID: <20181130082100.6241-3-brgl@bgdev.pl>
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

We now have a generalized helper routine to read the MAC address from
nvmem which takes struct device as argument. The nvmem subsystem will
then try device tree first before all other potential providers.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1d86b4d5645a..d9a208f7bb40 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4055,7 +4055,7 @@ static int macb_probe(struct platform_device *pdev)
 	if (mac) {
 		ether_addr_copy(bp->dev->dev_addr, mac);
 	} else {
-		err = of_get_nvmem_mac_address(np, bp->dev->dev_addr);
+		err = nvmem_get_mac_address(&pdev->dev, bp->dev->dev_addr);
 		if (err) {
 			if (err == -EPROBE_DEFER)
 				goto err_out_free_netdev;
-- 
2.19.1

From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] net: davinci: fix building davinci mdio code without CONFIG_OF
Date: Mon, 28 May 2018 17:50:20 +0200
Message-ID: <20180528155059.2736080-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Grygorii Strashko <grygorii.strashko@ti.com>, Sekhar Nori <nsekhar@ti.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Test-building this driver on targets without CONFIG_OF revealed a build
failure:

drivers/net/ethernet/ti/davinci_mdio.c: In function 'davinci_mdio_probe':
drivers/net/ethernet/ti/davinci_mdio.c:380:9: error: implicit declaration of function 'davinci_mdio_probe_dt'; did you mean 'davinci_mdio_probe'? [-Werror=implicit-function-declaration]

This adjusts the #ifdef logic in the driver to make it build in
all configurations.

Fixes: 2652113ff043 ("net: ethernet: ti: Allow most drivers with COMPILE_TEST")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/ti/davinci_mdio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index 8ac72831af05..a98aedae1b41 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -321,7 +321,6 @@ static int davinci_mdio_write(struct mii_bus *bus, int phy_id,
 	return ret;
 }
 
-#if IS_ENABLED(CONFIG_OF)
 static int davinci_mdio_probe_dt(struct mdio_platform_data *data,
 			 struct platform_device *pdev)
 {
@@ -339,7 +338,6 @@ static int davinci_mdio_probe_dt(struct mdio_platform_data *data,
 
 	return 0;
 }
-#endif
 
 #if IS_ENABLED(CONFIG_OF)
 static const struct davinci_mdio_of_param of_cpsw_mdio_data = {
@@ -374,7 +372,7 @@ static int davinci_mdio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	if (dev->of_node) {
+	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
 		const struct of_device_id	*of_id;
 
 		ret = davinci_mdio_probe_dt(&data->pdata, pdev);
-- 
2.9.0

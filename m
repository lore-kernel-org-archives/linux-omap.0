From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] net: ti: cpsw: include gpio/consumer.h
Date: Wed, 30 May 2018 23:51:54 +0200
Message-ID: <20180530215212.1151415-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: linux-gpio@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On platforms that don't always enable CONFIG_GPIOLIB, we run into
a build failure:

drivers/net/ethernet/ti/cpsw.c: In function 'cpsw_probe':
drivers/net/ethernet/ti/cpsw.c:3006:9: error: implicit declaration of function 'devm_gpiod_get_array_optional' [-Werror=implicit-function-declaration]
  mode = devm_gpiod_get_array_optional(&pdev->dev, "mode", GPIOD_OUT_LOW);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/ti/cpsw.c:3006:59: error: 'GPIOD_OUT_LOW' undeclared (first use in this function); did you mean 'GPIOF_INIT_LOW'?
  mode = devm_gpiod_get_array_optional(&pdev->dev, "mode", GPIOD_OUT_LOW);

Since we cannot rely on this to be visible from gpio.h, we have to include
gpio/consumer.h directly.

Fixes: 2652113ff043 ("net: ethernet: ti: Allow most drivers with COMPILE_TEST")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/ti/cpsw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 643cd2d9dfb6..534596ce00d3 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -29,7 +29,7 @@
 #include <linux/workqueue.h>
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
-- 
2.9.0

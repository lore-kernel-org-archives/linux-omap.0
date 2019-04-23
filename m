From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next 13/19] net: ethernet: ti: davinci_mdio: use devm_ioremap()
Date: Tue, 23 Apr 2019 16:09:04 +0300
Message-ID: <1556024950-20752-14-git-send-email-grygorii.strashko@ti.com>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

The Davinci MDIO in most of the case implemented as module inside of TI
CPSW subsystem and fully depends on CPSW to be enabled, but historically
it's implemented as separate Platform device/driver and defined in DT files
in two ways:
- as standalone node
- as child node of CPSW subsystem.

In later case it's required to split CPSW subsystem "reg" property to
exclude MDIO I/O range which is not useful.

Hence, replace devm_ioremap_resource() with devm_ioremap() to allow define
full I/O range in parent CPSW subsystem without spliting.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/davinci_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index 309dddf4a6f4..741770abd73a 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -397,7 +397,7 @@ static int davinci_mdio_probe(struct platform_device *pdev)
 	data->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->regs = devm_ioremap_resource(dev, res);
+	data->regs = devm_ioremap(dev, res->start, resource_size(res));
 	if (IS_ERR(data->regs))
 		return PTR_ERR(data->regs);
 
-- 
2.17.1

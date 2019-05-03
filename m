From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH net-next] drivers: net: davinci_mdio: fix return value check in davinci_mdio_probe()
Date: Fri, 3 May 2019 11:18:59 +0000
Message-ID: <20190503111859.1023-1-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Florian Fainelli <f.fainelli@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>, Fugang Duan <fugang.duan@nxp.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

In case of error, the function devm_ioremap() returns NULL pointer not
ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Fixes: 03f66f067560 ("net: ethernet: ti: davinci_mdio: use devm_ioremap()")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/ethernet/ti/davinci_mdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index 11642721c123..38b7f6d35759 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -398,8 +398,8 @@ static int davinci_mdio_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	data->regs = devm_ioremap(dev, res->start, resource_size(res));
-	if (IS_ERR(data->regs))
-		return PTR_ERR(data->regs);
+	if (!data->regs)
+		return -ENOMEM;
 
 	davinci_mdio_init_clk(data);

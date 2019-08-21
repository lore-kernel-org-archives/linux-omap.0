From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: ethernet: ti: use devm_platform_ioremap_resource() to simplify code
Date: Wed, 21 Aug 2019 20:48:50 +0800
Message-ID: <20190821124850.9592-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, grygorii.strashko@ti.com, ivan.khoronzhuk@linaro.org, andrew@lunn.ch, ynezz@true.cz
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-omap@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-omap@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/ti/cpsw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 32a8974..5401095 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -2764,7 +2764,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	struct net_device		*ndev;
 	struct cpsw_priv		*priv;
 	void __iomem			*ss_regs;
-	struct resource			*res, *ss_res;
+	struct resource			*ss_res;
 	struct gpio_descs		*mode;
 	const struct soc_device_attribute *soc;
 	struct cpsw_common		*cpsw;
@@ -2798,8 +2798,7 @@ static int cpsw_probe(struct platform_device *pdev)
 		return PTR_ERR(ss_regs);
 	cpsw->regs = ss_regs;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	cpsw->wr_regs = devm_ioremap_resource(dev, res);
+	cpsw->wr_regs = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(cpsw->wr_regs))
 		return PTR_ERR(cpsw->wr_regs);
 
-- 
2.7.4

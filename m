From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: ethernet: ti: cpsw: Fix inconsistent IS_ERR and PTR_ERR in cpsw_probe()
Date: Mon, 29 Apr 2019 13:56:50 +0000
Message-ID: <20190429135650.72794-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: YueHaibing <yuehaibing@huawei.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Change the call to PTR_ERR to access the value just tested by IS_ERR.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/ti/cpsw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index c3cba46fac9d..e37680654a13 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -2381,7 +2381,7 @@ static int cpsw_probe(struct platform_device *pdev)
 
 	clk = devm_clk_get(dev, "fck");
 	if (IS_ERR(clk)) {
-		ret = PTR_ERR(mode);
+		ret = PTR_ERR(clk);
 		dev_err(dev, "fck is not found %d\n", ret);
 		return ret;
 	}

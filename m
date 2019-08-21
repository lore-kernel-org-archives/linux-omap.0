From: Antoine Tenart <antoine.tenart@bootlin.com>
Subject: [PATCH net] net: cpsw: fix NULL pointer exception in the probe error path
Date: Wed, 21 Aug 2019 16:41:23 +0200
Message-ID: <20190821144123.22248-1-antoine.tenart@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, grygorii.strashko@ti.com
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com
List-Id: linux-omap@vger.kernel.org

In certain cases when the probe function fails the error path calls
cpsw_remove_dt() before calling platform_set_drvdata(). This is an
issue as cpsw_remove_dt() uses platform_get_drvdata() to retrieve the
cpsw_common data and leds to a NULL pointer exception. This patches
fixes it by calling platform_set_drvdata() earlier in the probe.

Fixes: 83a8471ba255 ("net: ethernet: ti: cpsw: refactor probe to group common hw initialization")
Reported-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/ti/cpsw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 32a89744972d..a46b8b2e44e1 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -2775,6 +2775,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	if (!cpsw)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, cpsw);
 	cpsw->dev = dev;
 
 	mode = devm_gpiod_get_array_optional(dev, "mode", GPIOD_OUT_LOW);
@@ -2879,7 +2880,6 @@ static int cpsw_probe(struct platform_device *pdev)
 		goto clean_cpts;
 	}
 
-	platform_set_drvdata(pdev, cpsw);
 	priv = netdev_priv(ndev);
 	priv->cpsw = cpsw;
 	priv->ndev = ndev;
-- 
2.21.0

From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] net: ethernet: cpsw: drop IRQF_DISABLED
Date: Fri, 2 Aug 2013 10:44:10 +0300
Message-ID: <1375429450-25454-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

IRQF_DISABLED is a no-op by now and should be
removed.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 05a1674..22a7a43 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1867,7 +1867,7 @@ static int cpsw_probe(struct platform_device *pdev)
 
 	while ((res = platform_get_resource(priv->pdev, IORESOURCE_IRQ, k))) {
 		for (i = res->start; i <= res->end; i++) {
-			if (request_irq(i, cpsw_interrupt, IRQF_DISABLED,
+			if (request_irq(i, cpsw_interrupt, 0,
 					dev_name(&pdev->dev), priv)) {
 				dev_err(priv->dev, "error attaching irq\n");
 				goto clean_ale_ret;
-- 
1.8.3.4.840.g6a90778

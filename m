From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/5] drivers: bus: omap_l3: Remove the platform driver's remove function
Date: Tue, 4 Mar 2014 11:01:49 +0200
Message-ID: <1393923710-10377-5-git-send-email-peter.ujfalusi@ti.com>
References: <1393923710-10377-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393923710-10377-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

It is NOP after the devm_* conversion.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti>
---
 drivers/bus/omap_l3_noc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index 2bbc87bdea2b..ed428ada44f7 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -177,11 +177,6 @@ static int omap4_l3_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int omap4_l3_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
 #if defined(CONFIG_OF)
 static const struct of_device_id l3_noc_match[] = {
 	{.compatible = "ti,omap4-l3-noc", },
@@ -194,7 +189,6 @@ MODULE_DEVICE_TABLE(of, l3_noc_match);
 
 static struct platform_driver omap4_l3_driver = {
 	.probe		= omap4_l3_probe,
-	.remove		= omap4_l3_remove,
 	.driver		= {
 		.name		= "omap_l3_noc",
 		.owner		= THIS_MODULE,
-- 
1.9.0

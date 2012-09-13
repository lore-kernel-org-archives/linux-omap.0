From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH] can: c_can: Move pm_runtime_enable/disable calls to common code
Date: Thu, 13 Sep 2012 12:58:12 +0530
Message-ID: <1347521292-28751-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Sender: linux-can-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, khilman@deeprootsystems.com
Cc: linux-can@vger.kernel.org, linux-omap@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>
List-Id: linux-omap@vger.kernel.org

Move pm_runtime_enable/disable calls to c_can.c driver. Current
implementation is such that platform driver is doing pm_runtime
enable/disable and core driver is doing put_sync/get_sync.

PM runtime calls should be invoked if there is a valid device
pointer from platform driver so moving enable/disable calls
to core driver.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
Incorporated Kevin's comments on "can: c_can: Add runtime PM
support to Bosch C_CAN/D_CAN controller" patch.

This patch is tested on AM335x-EVM and cleanly applies on
linux-can master

 drivers/net/can/c_can/c_can.c          |   18 +++++++++++++++++-
 drivers/net/can/c_can/c_can_platform.c |    5 -----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index aa6c5eb..e472975 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -1155,10 +1155,23 @@ static const struct net_device_ops c_can_netdev_ops = {
 
 int register_c_can_dev(struct net_device *dev)
 {
+	int ret;
+	struct c_can_priv *priv = netdev_priv(dev);
+
+	if (priv->device)
+		pm_runtime_enable(priv->device);
+
 	dev->flags |= IFF_ECHO;	/* we support local echo */
 	dev->netdev_ops = &c_can_netdev_ops;
 
-	return register_candev(dev);
+	ret = register_candev(dev);
+	if (ret) {
+		if (priv->device)
+			pm_runtime_disable(priv->device);
+		return ret;
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(register_c_can_dev);
 
@@ -1170,6 +1183,9 @@ void unregister_c_can_dev(struct net_device *dev)
 	c_can_enable_all_interrupts(priv, DISABLE_ALL_INTERRUPTS);
 
 	unregister_candev(dev);
+
+	if (priv->device)
+		pm_runtime_disable(priv->device);
 }
 EXPORT_SYMBOL_GPL(unregister_c_can_dev);
 
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index c351975..491101a 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -32,7 +32,6 @@
 #include <linux/clk.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/pm_runtime.h>
 #include <linux/pinctrl/consumer.h>
 
 #include <linux/can/dev.h>
@@ -185,8 +184,6 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 		goto exit_free_device;
 	}
 
-	pm_runtime_enable(&pdev->dev);
-
 	dev->irq = irq;
 	priv->base = addr;
 	priv->device = &pdev->dev;
@@ -209,7 +206,6 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 
 exit_clear_drvdata:
 	platform_set_drvdata(pdev, NULL);
-	pm_runtime_disable(&pdev->dev);
 exit_free_device:
 	free_c_can_dev(dev);
 exit_iounmap:
@@ -239,7 +235,6 @@ static int __devexit c_can_plat_remove(struct platform_device *pdev)
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(mem->start, resource_size(mem));
 
-	pm_runtime_disable(&pdev->dev);
 	clk_put(priv->priv);
 
 	return 0;
-- 
1.7.0.4


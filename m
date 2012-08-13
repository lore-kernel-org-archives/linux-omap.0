From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v6] can: c_can: Add runtime PM support to Bosch C_CAN/D_CAN controller
Date: Mon, 13 Aug 2012 12:19:59 +0530
Message-ID: <1344840599-19545-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42330 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752526Ab2HMGuT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Aug 2012 02:50:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: linux-omap@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>

Add Runtime PM support to C_CAN/D_CAN controller. The runtime PM
APIs control clocks for C_CAN/D_CAN IP and prevent access to the
register of C_CAN/D_CAN IP when clock is turned off.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
This patch has been tested on AM335X EVM. Due to lack of hardware
I am not able to test c_can functionality. I appreciate if anyone
can test c_can functionality with this patch.

This patch is based on "can-next/master" 

Changes from v5:
	- Incorporated Marc's commets on v5
	  * changed runtime pm calls in c_can driver to handle
	    the drivers which are not using platform drivers.
	  * added device pointer protection in c_can driver if
	    not passed from platform/pci driver.

Changes from v4:
	- Incorporated Vaibhav H review comments on v4.
	  * Moved pm_runtime put/get_sync calls to appropriate positions.
	- This patch is from "Add DT support to C_CAN/D_CAN controller"
	  patch series. Rest of the patches in this series were applied
	  so this v5 contains only this patch.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 drivers/net/can/c_can/c_can.c          |   25 ++++++++++++++++++++++++-
 drivers/net/can/c_can/c_can.h          |    1 +
 drivers/net/can/c_can/c_can_platform.c |    6 ++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 4c538e3..64344b8 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -34,6 +34,8 @@
 #include <linux/if_ether.h>
 #include <linux/list.h>
 #include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include <linux/platform_device.h>
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
@@ -201,6 +203,18 @@ static const struct can_bittiming_const c_can_bittiming_const = {
 	.brp_inc = 1,
 };
 
+static inline void c_can_pm_runtime_get_sync(struct device *dev)
+{
+	if (dev)
+		pm_runtime_get_sync(dev);
+}
+
+static inline void c_can_pm_runtime_put_sync(struct device *dev)
+{
+	if (dev)
+		pm_runtime_put_sync(dev);
+}
+
 static inline int get_tx_next_msg_obj(const struct c_can_priv *priv)
 {
 	return (priv->tx_next & C_CAN_NEXT_MSG_OBJ_MASK) +
@@ -673,11 +687,15 @@ static int c_can_get_berr_counter(const struct net_device *dev,
 	unsigned int reg_err_counter;
 	struct c_can_priv *priv = netdev_priv(dev);
 
+	c_can_pm_runtime_get_sync(priv->device);
+
 	reg_err_counter = priv->read_reg(priv, C_CAN_ERR_CNT_REG);
 	bec->rxerr = (reg_err_counter & ERR_CNT_REC_MASK) >>
 				ERR_CNT_REC_SHIFT;
 	bec->txerr = reg_err_counter & ERR_CNT_TEC_MASK;
 
+	c_can_pm_runtime_put_sync(priv->device);
+
 	return 0;
 }
 
@@ -1053,11 +1071,13 @@ static int c_can_open(struct net_device *dev)
 	int err;
 	struct c_can_priv *priv = netdev_priv(dev);
 
+	c_can_pm_runtime_get_sync(priv->device);
+
 	/* open the can device */
 	err = open_candev(dev);
 	if (err) {
 		netdev_err(dev, "failed to open can device\n");
-		return err;
+		goto exit_open_fail;
 	}
 
 	/* register interrupt handler */
@@ -1079,6 +1099,8 @@ static int c_can_open(struct net_device *dev)
 
 exit_irq_fail:
 	close_candev(dev);
+exit_open_fail:
+	c_can_pm_runtime_put_sync(priv->device);
 	return err;
 }
 
@@ -1091,6 +1113,7 @@ static int c_can_close(struct net_device *dev)
 	c_can_stop(dev);
 	free_irq(dev->irq, dev);
 	close_candev(dev);
+	c_can_pm_runtime_put_sync(priv->device);
 
 	return 0;
 }
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 4e56baa..1437a6d 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -153,6 +153,7 @@ struct c_can_priv {
 	struct can_priv can;	/* must be the first member */
 	struct napi_struct napi;
 	struct net_device *dev;
+	struct device *device;
 	int tx_object;
 	int current_status;
 	int last_status;
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index d0a66cf..197683b 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -32,6 +32,7 @@
 #include <linux/clk.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/can/dev.h>
 
@@ -177,8 +178,11 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 		goto exit_free_device;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+
 	dev->irq = irq;
 	priv->base = addr;
+	priv->device = &pdev->dev;
 	priv->can.clock.freq = clk_get_rate(clk);
 	priv->priv = clk;
 
@@ -198,6 +202,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 
 exit_free_device:
 	platform_set_drvdata(pdev, NULL);
+	pm_runtime_disable(&pdev->dev);
 	free_c_can_dev(dev);
 exit_iounmap:
 	iounmap(addr);
@@ -226,6 +231,7 @@ static int __devexit c_can_plat_remove(struct platform_device *pdev)
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(mem->start, resource_size(mem));
 
+	pm_runtime_disable(&pdev->dev);
 	clk_put(priv->priv);
 
 	return 0;
-- 
1.7.9.5


From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v5] can: c_can: Add runtime PM support to Bosch C_CAN/D_CAN controller
Date: Tue, 7 Aug 2012 16:50:57 +0530
Message-ID: <1344338457-595-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Sender: linux-can-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: linux-omap@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>
List-Id: linux-omap@vger.kernel.org

Add Runtime PM support to C_CAN/D_CAN controller. The runtime PM
APIs control clocks for C_CAN/D_CAN IP and prevent access to the
register of C_CAN/D_CAN IP when clock is turned off.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
This patch has been tested on AM335X EVM. Due to lack of hardware
I am not able to test c_can functionality. I appreciate if anyone
can test c_can functionality with this patch.

This patch is based on "can-next/master" 

Changes from v4:
	- Incorporated Vaibhav H review comments on v4.
	  * Moved pm_runtime put/get_sync calls to appropriate positions.
	- This patch is from "Add DT support to C_CAN/D_CAN controller"
	  patch series. Rest of the patches in this series were applied
	  so this v5 contains only this patch.

 drivers/net/can/c_can/c_can.c          |    8 ++++++++
 drivers/net/can/c_can/c_can.h          |    1 +
 drivers/net/can/c_can/c_can_platform.c |   11 +++++++++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index eea6608..ca1151d 100644
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
@@ -673,6 +675,8 @@ static int c_can_get_berr_counter(const struct net_device *dev,
 	unsigned int reg_err_counter;
 	struct c_can_priv *priv = netdev_priv(dev);
 
+	pm_runtime_get_sync(&priv->pdev->dev);
+
 	reg_err_counter = priv->read_reg(priv, C_CAN_ERR_CNT_REG);
 	bec->rxerr = (reg_err_counter & ERR_CNT_REC_MASK) >>
 				ERR_CNT_REC_SHIFT;
@@ -1053,6 +1057,8 @@ static int c_can_open(struct net_device *dev)
 	int err;
 	struct c_can_priv *priv = netdev_priv(dev);
 
+	pm_runtime_get_sync(&priv->pdev->dev);
+
 	/* open the can device */
 	err = open_candev(dev);
 	if (err) {
@@ -1079,6 +1085,7 @@ static int c_can_open(struct net_device *dev)
 
 exit_irq_fail:
 	close_candev(dev);
+	pm_runtime_put_sync(&priv->pdev->dev);
 	return err;
 }
 
@@ -1091,6 +1098,7 @@ static int c_can_close(struct net_device *dev)
 	c_can_stop(dev);
 	free_irq(dev->irq, dev);
 	close_candev(dev);
+	pm_runtime_put_sync(&priv->pdev->dev);
 
 	return 0;
 }
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 4e56baa..ef84439 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -153,6 +153,7 @@ struct c_can_priv {
 	struct can_priv can;	/* must be the first member */
 	struct napi_struct napi;
 	struct net_device *dev;
+	struct platform_device *pdev;
 	int tx_object;
 	int current_status;
 	int last_status;
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index d0a66cf..cbb1184 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -32,6 +32,7 @@
 #include <linux/clk.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/can/dev.h>
 
@@ -177,7 +178,11 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 		goto exit_free_device;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+
 	dev->irq = irq;
+	priv->pdev = pdev;
 	priv->base = addr;
 	priv->can.clock.freq = clk_get_rate(clk);
 	priv->priv = clk;
@@ -192,12 +197,16 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 		goto exit_free_device;
 	}
 
+	pm_runtime_put_sync(&pdev->dev);
+
 	dev_info(&pdev->dev, "%s device registered (regs=%p, irq=%d)\n",
 		 KBUILD_MODNAME, priv->base, dev->irq);
 	return 0;
 
 exit_free_device:
 	platform_set_drvdata(pdev, NULL);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	free_c_can_dev(dev);
 exit_iounmap:
 	iounmap(addr);
@@ -226,6 +235,8 @@ static int __devexit c_can_plat_remove(struct platform_device *pdev)
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(mem->start, resource_size(mem));
 
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	clk_put(priv->priv);
 
 	return 0;
-- 
1.7.9.5


From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3] can: c_can: Add d_can raminit support
Date: Wed, 21 Nov 2012 10:31:22 +0100
Message-ID: <1353490282-10853-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Sender: linux-can-owner@vger.kernel.org
To: linux-can@vger.kernel.org, anilkumar@ti.com
Cc: wg@grandegger.com, swarren@wwwdotorg.org, tony@atomide.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, grant.likely@secretlab.ca, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

From: AnilKumar Ch <anilkumar@ti.com>

Add D_CAN raminit support to C_CAN driver to enable D_CAN RAM,
which holds all the message objects during transmission or
receiving of data. This initialization/de-initialization should
be done in synchronous with D_CAN clock.

In case of AM335X-EVM (current user of D_CAN driver) message RAM is
controlled through control module register for both instances. So
control module register details is required to initialization or
de-initialization of message RAM according to instance number.

Control module memory resource is obtained from D_CAN dt node and
instance number obtained from device tree aliases node.

This patch was tested on AM335x-EVM along with pinctrl data addition
patch, d_can dt aliases addition and control module data addition.
pinctrl data addition is not added to am335x-evm.dts (only supports
CPLD profile#0) because d_can1 is supported under CPLD profile#1.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
[mkl: fix instance for non DT in probe, cleaned up raminit]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

compile time tested only - please test on real HW.

changes since v2
- rename member in c_can_priv to raminit
  (to be consistent with the rest of the driver)
- cleaned up c_can_hw_raminit()
- fix priv->instance for non DT platforms in c_can_plat_probe()

regards, Marc

 drivers/net/can/c_can/c_can.c          |   12 ++++++++++++
 drivers/net/can/c_can/c_can.h          |    3 +++
 drivers/net/can/c_can/c_can_platform.c |   28 +++++++++++++++++++++++++++-
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index e5180df..5233b8f 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -233,6 +233,12 @@ static inline void c_can_pm_runtime_put_sync(const struct c_can_priv *priv)
 		pm_runtime_put_sync(priv->device);
 }
 
+static inline void c_can_reset_ram(const struct c_can_priv *priv, bool enable)
+{
+	if (priv->raminit)
+		priv->raminit(priv, enable);
+}
+
 static inline int get_tx_next_msg_obj(const struct c_can_priv *priv)
 {
 	return (priv->tx_next & C_CAN_NEXT_MSG_OBJ_MASK) +
@@ -1090,6 +1096,7 @@ static int c_can_open(struct net_device *dev)
 	struct c_can_priv *priv = netdev_priv(dev);
 
 	c_can_pm_runtime_get_sync(priv);
+	c_can_reset_ram(priv, true);
 
 	/* open the can device */
 	err = open_candev(dev);
@@ -1118,6 +1125,7 @@ static int c_can_open(struct net_device *dev)
 exit_irq_fail:
 	close_candev(dev);
 exit_open_fail:
+	c_can_reset_ram(priv, false);
 	c_can_pm_runtime_put_sync(priv);
 	return err;
 }
@@ -1131,6 +1139,8 @@ static int c_can_close(struct net_device *dev)
 	c_can_stop(dev);
 	free_irq(dev->irq, dev);
 	close_candev(dev);
+
+	c_can_reset_ram(priv, false);
 	c_can_pm_runtime_put_sync(priv);
 
 	return 0;
@@ -1188,6 +1198,7 @@ int c_can_power_down(struct net_device *dev)
 
 	c_can_stop(dev);
 
+	c_can_reset_ram(priv, false);
 	c_can_pm_runtime_put_sync(priv);
 
 	return 0;
@@ -1206,6 +1217,7 @@ int c_can_power_up(struct net_device *dev)
 	WARN_ON(priv->type != BOSCH_D_CAN);
 
 	c_can_pm_runtime_get_sync(priv);
+	c_can_reset_ram(priv, true);
 
 	/* Clear PDR and INIT bits */
 	val = priv->read_reg(priv, C_CAN_CTRL_EX_REG);
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index e5ed41d..d2e1c21 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -169,6 +169,9 @@ struct c_can_priv {
 	void *priv;		/* for board-specific data */
 	u16 irqstatus;
 	enum c_can_dev_id type;
+	u32 __iomem *raminit_ctrlreg;
+	unsigned int instance;
+	void (*raminit) (const struct c_can_priv *priv, bool enable);
 };
 
 struct net_device *alloc_c_can_dev(void);
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index ee14161..75c3f47 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -38,6 +38,8 @@
 
 #include "c_can.h"
 
+#define CAN_RAMINIT_START_MASK(i)	(1 << (i))
+
 /*
  * 16-bit c_can registers can be arranged differently in the memory
  * architecture of different implementations. For example: 16-bit
@@ -68,6 +70,18 @@ static void c_can_plat_write_reg_aligned_to_32bit(struct c_can_priv *priv,
 	writew(val, priv->base + 2 * priv->regs[index]);
 }
 
+static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
+{
+	u32 val;
+
+	val = readl(priv->raminit_ctrlreg);
+	if (enable)
+		val |= CAN_RAMINIT_START_MASK(priv->instance);
+	else
+		val &= ~CAN_RAMINIT_START_MASK(priv->instance);
+	writel(val, priv->raminit_ctrlreg);
+}
+
 static struct platform_device_id c_can_id_table[] = {
 	[BOSCH_C_CAN_PLATFORM] = {
 		.name = KBUILD_MODNAME,
@@ -99,7 +113,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	const struct platform_device_id *id;
 	struct pinctrl *pinctrl;
-	struct resource *mem;
+	struct resource *mem, *res;
 	int irq;
 	struct clk *clk;
 
@@ -178,6 +192,18 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
 		priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
 		priv->write_reg = c_can_plat_write_reg_aligned_to_16bit;
+
+		if (pdev->dev.of_node)
+			priv->instance = of_alias_get_id(pdev->dev.of_node, "d_can");
+		else
+			priv->instance = pdev->id;
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		priv->raminit_ctrlreg =	devm_request_and_ioremap(&pdev->dev, res);
+		if (!priv->raminit_ctrlreg || priv->instance < 0)
+			dev_info(&pdev->dev, "control memory is not used for raminit\n");
+		else
+			priv->raminit = c_can_hw_raminit;
 		break;
 	default:
 		ret = -EINVAL;
-- 
1.7.10.4


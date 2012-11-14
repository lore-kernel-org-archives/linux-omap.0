From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 1/3] can: c_can: Add d_can raminit support
Date: Wed, 14 Nov 2012 23:38:23 +0530
Message-ID: <1352916505-12343-2-git-send-email-anilkumar@ti.com>
References: <1352916505-12343-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35505 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422887Ab2KNSJD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 13:09:03 -0500
In-Reply-To: <1352916505-12343-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de
Cc: swarren@wwwdotorg.org, linux-can@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, AnilKumar Ch <anilkumar@ti.com>

Add D_CAN raminit support to C_CAN driver to enable D_CAN RAM,
which holds all the message objects during transmission or
receiving of data. This initialization/de-initialization should
be done in synchronous with D_CAN clock.

In case of AM335X-EVM (active user of D_CAN driver) message RAM is
controlled through control module register for both instances. So
control module register details is required to initialization or
de-initialization of message RAM according to instance number.

Control module memory resource is obtained from D_CAN dt node and
instance number obtained from device tree aliases node.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 drivers/net/can/c_can/c_can.c          |   12 +++++++++++
 drivers/net/can/c_can/c_can.h          |    3 +++
 drivers/net/can/c_can/c_can_platform.c |   34 +++++++++++++++++++++++++++++++-
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index e5180df..c15830c 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -233,6 +233,12 @@ static inline void c_can_pm_runtime_put_sync(const struct c_can_priv *priv)
 		pm_runtime_put_sync(priv->device);
 }
 
+static inline void c_can_reset_ram(const struct c_can_priv *priv, bool enable)
+{
+	if (priv->ram_init)
+		priv->ram_init(priv, enable);
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
index e5ed41d..419de5c 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -169,6 +169,9 @@ struct c_can_priv {
 	void *priv;		/* for board-specific data */
 	u16 irqstatus;
 	enum c_can_dev_id type;
+	u32 __iomem *raminit_ctrlreg;
+	unsigned int instance;
+	void (*ram_init) (const struct c_can_priv *priv, bool enable);
 };
 
 struct net_device *alloc_c_can_dev(void);
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index ee141613..2e61d69 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -38,6 +38,8 @@
 
 #include "c_can.h"
 
+#define CAN_RAMINIT_START_MASK(i)	(1 << (i))
+
 /*
  * 16-bit c_can registers can be arranged differently in the memory
  * architecture of different implementations. For example: 16-bit
@@ -68,6 +70,24 @@ static void c_can_plat_write_reg_aligned_to_32bit(struct c_can_priv *priv,
 	writew(val, priv->base + 2 * priv->regs[index]);
 }
 
+static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
+{
+	u32 val;
+
+	if (!priv->raminit_ctrlreg || (priv->instance < 0))
+		return;
+
+	val = readl(priv->raminit_ctrlreg);
+	if (enable) {
+		val &= ~CAN_RAMINIT_START_MASK(priv->instance);
+		val |= CAN_RAMINIT_START_MASK(priv->instance);
+		writel(val, priv->raminit_ctrlreg);
+	} else {
+		val &= ~CAN_RAMINIT_START_MASK(priv->instance);
+		writel(val, priv->raminit_ctrlreg);
+	}
+}
+
 static struct platform_device_id c_can_id_table[] = {
 	[BOSCH_C_CAN_PLATFORM] = {
 		.name = KBUILD_MODNAME,
@@ -99,7 +119,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	const struct platform_device_id *id;
 	struct pinctrl *pinctrl;
-	struct resource *mem;
+	struct resource *mem, *res;
 	int irq;
 	struct clk *clk;
 
@@ -178,6 +198,18 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
 		priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
 		priv->write_reg = c_can_plat_write_reg_aligned_to_16bit;
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		priv->raminit_ctrlreg =
+				devm_request_and_ioremap(&pdev->dev, res);
+		if (!priv->raminit_ctrlreg)
+			dev_warn(&pdev->dev, "failed to obtain control memory\n");
+
+		if (pdev->dev.of_node)
+			pdev->id = of_alias_get_id(pdev->dev.of_node, "d_can");
+
+		priv->instance = pdev->id;
+		priv->ram_init = c_can_hw_raminit;
 		break;
 	default:
 		ret = -EINVAL;
-- 
1.7.9.5


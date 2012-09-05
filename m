From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v2 4/4] can: c_can: Add d_can suspend resume support
Date: Wed, 5 Sep 2012 16:42:44 +0530
Message-ID: <1346843564-25343-5-git-send-email-anilkumar@ti.com>
References: <1346843564-25343-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1346843564-25343-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de
Cc: tony@atomide.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, AnilKumar Ch <anilkumar@ti.com>
List-Id: linux-omap@vger.kernel.org

Adds suspend resume support to DCAN driver which enables
DCAN power down mode bit (PDR). Then DCAN will ack the local
power-down mode by setting PDA bit in STATUS register.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 drivers/net/can/c_can/c_can.c          |   82 ++++++++++++++++++++++++++++++++
 drivers/net/can/c_can/c_can.h          |    8 ++++
 drivers/net/can/c_can/c_can_platform.c |   62 ++++++++++++++++++++++++
 3 files changed, 152 insertions(+)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index c175410..c601136 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -46,6 +46,9 @@
 #define IF_ENUM_REG_LEN		11
 #define C_CAN_IFACE(reg, iface)	(C_CAN_IF1_##reg + (iface) * IF_ENUM_REG_LEN)
 
+/* control extension register D_CAN specific */
+#define CONTROL_EX_PDR		BIT(8)
+
 /* control register */
 #define CONTROL_TEST		BIT(7)
 #define CONTROL_CCE		BIT(6)
@@ -65,6 +68,7 @@
 #define TEST_BASIC		BIT(2)
 
 /* status register */
+#define STATUS_PDA		BIT(10)
 #define STATUS_BOFF		BIT(7)
 #define STATUS_EWARN		BIT(6)
 #define STATUS_EPASS		BIT(5)
@@ -164,6 +168,9 @@
 /* minimum timeout for checking BUSY status */
 #define MIN_TIMEOUT_VALUE	6
 
+/* Wait for ~1 sec for INIT bit */
+#define INIT_WAIT_MS		1000
+
 /* napi related */
 #define C_CAN_NAPI_WEIGHT	C_CAN_MSG_OBJ_RX_NUM
 
@@ -1154,6 +1161,81 @@ struct net_device *alloc_c_can_dev(void)
 }
 EXPORT_SYMBOL_GPL(alloc_c_can_dev);
 
+#ifdef CONFIG_PM
+int c_can_power_down(struct net_device *dev)
+{
+	u32 val;
+	unsigned long time_out;
+	struct c_can_priv *priv = netdev_priv(dev);
+
+	if (!(dev->flags & IFF_UP))
+		return 0;
+
+	BUG_ON(priv->type != BOSCH_D_CAN);
+
+	/* set PDR value so the device goes to power down mode */
+	val = priv->read_reg(priv, C_CAN_CTRL_EX_REG);
+	val |= CONTROL_EX_PDR;
+	priv->write_reg(priv, C_CAN_CTRL_EX_REG, val);
+
+	/* Wait for the PDA bit to get set */
+	time_out = jiffies + msecs_to_jiffies(INIT_WAIT_MS);
+	while (!(priv->read_reg(priv, C_CAN_STS_REG) & STATUS_PDA) &&
+				time_after(time_out, jiffies))
+		cpu_relax();
+
+	if (time_after(jiffies, time_out))
+		return -ETIMEDOUT;
+
+	c_can_stop(dev);
+
+	/* De-initialize DCAN RAM */
+	c_can_reset_ram(priv, false);
+	c_can_pm_runtime_put_sync(priv);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(c_can_power_down);
+
+int c_can_power_up(struct net_device *dev)
+{
+	u32 val;
+	unsigned long time_out;
+	struct c_can_priv *priv = netdev_priv(dev);
+
+	if (!(dev->flags & IFF_UP))
+		return 0;
+
+	BUG_ON(priv->type != BOSCH_D_CAN);
+
+	c_can_pm_runtime_get_sync(priv);
+	/* Initialize DCAN RAM */
+	c_can_reset_ram(priv, true);
+
+	/* Clear PDR and INIT bits */
+	val = priv->read_reg(priv, C_CAN_CTRL_EX_REG);
+	val &= ~CONTROL_EX_PDR;
+	priv->write_reg(priv, C_CAN_CTRL_EX_REG, val);
+	val = priv->read_reg(priv, C_CAN_CTRL_REG);
+	val &= ~CONTROL_INIT;
+	priv->write_reg(priv, C_CAN_CTRL_REG, val);
+
+	/* Wait for the PDA bit to get clear */
+	time_out = jiffies + msecs_to_jiffies(INIT_WAIT_MS);
+	while ((priv->read_reg(priv, C_CAN_STS_REG) & STATUS_PDA) &&
+				time_after(time_out, jiffies))
+		cpu_relax();
+
+	if (time_after(jiffies, time_out))
+		return -ETIMEDOUT;
+
+	c_can_start(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(c_can_power_up);
+#endif
+
 void free_c_can_dev(struct net_device *dev)
 {
 	free_candev(dev);
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 5f6339c..ca149eb 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -24,6 +24,7 @@
 
 enum reg {
 	C_CAN_CTRL_REG = 0,
+	C_CAN_CTRL_EX_REG,
 	C_CAN_STS_REG,
 	C_CAN_ERR_CNT_REG,
 	C_CAN_BTR_REG,
@@ -104,6 +105,7 @@ static const u16 reg_map_c_can[] = {
 
 static const u16 reg_map_d_can[] = {
 	[C_CAN_CTRL_REG]	= 0x00,
+	[C_CAN_CTRL_EX_REG]	= 0x02,
 	[C_CAN_STS_REG]		= 0x04,
 	[C_CAN_ERR_CNT_REG]	= 0x08,
 	[C_CAN_BTR_REG]		= 0x0C,
@@ -166,6 +168,7 @@ struct c_can_priv {
 	unsigned int tx_echo;
 	void *priv;		/* for board-specific data */
 	u16 irqstatus;
+	enum c_can_dev_id type;
 	unsigned int instance;
 	void (*ram_init) (unsigned int instance, bool enable);
 };
@@ -175,4 +178,9 @@ void free_c_can_dev(struct net_device *dev);
 int register_c_can_dev(struct net_device *dev);
 void unregister_c_can_dev(struct net_device *dev);
 
+#ifdef CONFIG_PM
+int c_can_power_up(struct net_device *dev);
+int c_can_power_down(struct net_device *dev);
+#endif
+
 #endif /* C_CAN_H */
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index c6963b2..68c186b 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -202,6 +202,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 	priv->device = &pdev->dev;
 	priv->can.clock.freq = clk_get_rate(clk);
 	priv->priv = clk;
+	priv->type = id->driver_data;
 
 	platform_set_drvdata(pdev, dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
@@ -255,6 +256,65 @@ static int __devexit c_can_plat_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int c_can_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	int ret;
+	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct c_can_priv *priv = netdev_priv(ndev);
+
+	if (priv->type != BOSCH_D_CAN) {
+		dev_warn(&pdev->dev, "Not supported\n");
+		return 0;
+	}
+
+	if (netif_running(ndev)) {
+		netif_stop_queue(ndev);
+		netif_device_detach(ndev);
+	}
+
+	ret = c_can_power_down(ndev);
+	if (ret) {
+		netdev_err(ndev, "failed to enter power down mode\n");
+		return ret;
+	}
+
+	priv->can.state = CAN_STATE_SLEEPING;
+
+	return 0;
+}
+
+static int c_can_resume(struct platform_device *pdev)
+{
+	int ret;
+	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct c_can_priv *priv = netdev_priv(ndev);
+
+	if (priv->type != BOSCH_D_CAN) {
+		dev_warn(&pdev->dev, "Not supported\n");
+		return 0;
+	}
+
+	ret = c_can_power_up(ndev);
+	if (ret) {
+		netdev_err(ndev, "Still in power down mode\n");
+		return ret;
+	}
+
+	priv->can.state = CAN_STATE_ERROR_ACTIVE;
+
+	if (netif_running(ndev)) {
+		netif_device_attach(ndev);
+		netif_start_queue(ndev);
+	}
+
+	return 0;
+}
+#else
+#define c_can_suspend NULL
+#define c_can_resume NULL
+#endif
+
 static struct platform_driver c_can_plat_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
@@ -263,6 +323,8 @@ static struct platform_driver c_can_plat_driver = {
 	},
 	.probe = c_can_plat_probe,
 	.remove = __devexit_p(c_can_plat_remove),
+	.suspend = c_can_suspend,
+	.resume = c_can_resume,
 	.id_table = c_can_id_table,
 };
 
-- 
1.7.9.5


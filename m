From: yegorslists@googlemail.com
Subject: [PATCH v3 3/3] can: ti_hecc: Add DT support for TI HECC module
Date: Wed, 15 Feb 2017 15:48:45 +0100
Message-ID: <1487170125-10815-4-git-send-email-yegorslists@googlemail.com>
References: <1487170125-10815-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1487170125-10815-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, tony@atomide.com, mkl@pengutronix.de, andrej.skvortzov@gmail.com, hs@denx.de, anton.a.glukhov@gmail.com, Yegor Yefremov <yegorslists@googlemail.com>
List-Id: linux-omap@vger.kernel.org

From: Yegor Yefremov <yegorslists@googlemail.com>

These patch set adds device tree support for TI HECC module.

Signed-off-by: Anton Glukhov <anton.a.glukhov@gmail.com>
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 drivers/net/can/ti_hecc.c | 157 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 112 insertions(+), 45 deletions(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 6749b18..63056f3 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -46,6 +46,8 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
@@ -57,6 +59,12 @@
 MODULE_VERSION(HECC_MODULE_VERSION);
 #define DRV_DESC "TI High End CAN Controller Driver " HECC_MODULE_VERSION
 
+#define HECC_BASE_SIZE		0x80
+#define HECC_RAM_OFFSET		0x3000
+#define HECC_RAM_SIZE		0x180
+#define MBX_OFFSET		0x2000
+#define MBX_SIZE		0x200
+
 /* TX / RX Mailbox Configuration */
 #define HECC_MAX_MAILBOXES	32	/* hardware mailboxes - do not change */
 #define MAX_TX_PRIO		0x3F	/* hardware value - do not change */
@@ -214,10 +222,9 @@ struct ti_hecc_priv {
 	struct net_device *ndev;
 	struct clk *clk;
 	void __iomem *base;
-	u32 scc_ram_offset;
-	u32 hecc_ram_offset;
-	u32 mbx_offset;
-	u32 int_line;
+	void __iomem *hecc_ram;
+	void __iomem *mbx;
+	bool int_line;
 	spinlock_t mbx_lock; /* CANME register needs protection */
 	u32 tx_head;
 	u32 tx_tail;
@@ -242,20 +249,18 @@ static inline int get_tx_head_prio(struct ti_hecc_priv *priv)
 
 static inline void hecc_write_lam(struct ti_hecc_priv *priv, u32 mbxno, u32 val)
 {
-	__raw_writel(val, priv->base + priv->hecc_ram_offset + mbxno * 4);
+	__raw_writel(val, priv->hecc_ram + mbxno * 4);
 }
 
 static inline void hecc_write_mbx(struct ti_hecc_priv *priv, u32 mbxno,
 	u32 reg, u32 val)
 {
-	__raw_writel(val, priv->base + priv->mbx_offset + mbxno * 0x10 +
-			reg);
+	__raw_writel(val, priv->mbx + mbxno * 0x10 + reg);
 }
 
 static inline u32 hecc_read_mbx(struct ti_hecc_priv *priv, u32 mbxno, u32 reg)
 {
-	return __raw_readl(priv->base + priv->mbx_offset + mbxno * 0x10 +
-			reg);
+	return __raw_readl(priv->mbx + mbxno * 0x10 + reg);
 }
 
 static inline void hecc_write(struct ti_hecc_priv *priv, u32 reg, u32 val)
@@ -872,56 +877,121 @@ static const struct net_device_ops ti_hecc_netdev_ops = {
 	.ndo_change_mtu		= can_change_mtu,
 };
 
+static const struct of_device_id ti_hecc_dt_ids[] = {
+	{
+		.compatible = "ti,am3517-hecc",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ti_hecc_dt_ids);
+
+static struct ti_hecc_platform_data *
+hecc_of_get_pdata(struct platform_device *pdev)
+{
+	struct ti_hecc_platform_data *pdata;
+	struct device_node *np = pdev->dev.of_node;
+
+	if (!IS_ENABLED(CONFIG_OF) || !np)
+		return dev_get_platdata(&pdev->dev);
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	pdata->int_line = of_property_read_bool(np, "ti,use-hecc1int");
+
+	return pdata;
+}
+
 static int ti_hecc_probe(struct platform_device *pdev)
 {
 	struct net_device *ndev = (struct net_device *)0;
 	struct ti_hecc_priv *priv;
-	struct ti_hecc_platform_data *pdata;
-	struct resource *mem, *irq;
-	void __iomem *addr;
+	struct ti_hecc_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct resource temp_res, *res, *irq;
 	int err = -ENODEV;
 
-	pdata = dev_get_platdata(&pdev->dev);
+	pdata = hecc_of_get_pdata(pdev);
 	if (!pdata) {
-		dev_err(&pdev->dev, "No platform data\n");
-		goto probe_exit;
+		dev_err(&pdev->dev, "Platform data missing\n");
+		return -EINVAL;
 	}
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem) {
-		dev_err(&pdev->dev, "No mem resources\n");
-		goto probe_exit;
+	ndev = alloc_candev(sizeof(struct ti_hecc_priv), HECC_MAX_TX_MBOX);
+	if (!ndev) {
+		dev_err(&pdev->dev, "alloc_candev failed\n");
+		return -ENOMEM;
+	}
+	priv = netdev_priv(ndev);
+
+	/* handle hecc memory */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hecc");
+	if (!res) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!res) {
+			dev_err(&pdev->dev, "can't get IORESOURCE_MEM hecc\n");
+			return -EINVAL;
+		}
+
+		temp_res.start = res->start;
+		temp_res.end = temp_res.start + HECC_BASE_SIZE - 1;
+		res = &temp_res;
+	}
+
+	priv->base = devm_ioremap_resource(&pdev->dev, res);
+	if (!priv->base) {
+		dev_err(&pdev->dev, "hecc ioremap failed\n");
+		return -ENOMEM;
+	}
+
+	/* handle hecc-ram memory */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hecc-ram");
+	if (!res) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!res) {
+			dev_err(&pdev->dev, "can't get IORESOURCE_MEM hecc-ram\n");
+			return -EINVAL;
+		}
+
+		temp_res.start = res->start + HECC_RAM_OFFSET;
+		temp_res.end = temp_res.start + HECC_RAM_SIZE - 1;
+		res = &temp_res;
+	}
+
+	priv->hecc_ram = devm_ioremap_resource(&pdev->dev, res);
+	if (!priv->hecc_ram) {
+		dev_err(&pdev->dev, "hecc-ram ioremap failed\n");
+		return -ENOMEM;
+	}
+
+	/* handle mbx memory */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mbx");
+	if (!res) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!res) {
+			dev_err(&pdev->dev, "can't get IORESOURCE_MEM mbx\n");
+			return -EINVAL;
+		}
+
+		temp_res.start = res->start + MBX_OFFSET;
+		temp_res.end = temp_res.start + MBX_SIZE - 1;
+		res = &temp_res;
 	}
+
+	priv->mbx = devm_ioremap_resource(&pdev->dev, res);
+	if (!priv->mbx) {
+		dev_err(&pdev->dev, "mbx ioremap failed\n");
+		return -ENOMEM;
+	}
+
 	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!irq) {
 		dev_err(&pdev->dev, "No irq resource\n");
 		goto probe_exit;
 	}
-	if (!request_mem_region(mem->start, resource_size(mem), pdev->name)) {
-		dev_err(&pdev->dev, "HECC region already claimed\n");
-		err = -EBUSY;
-		goto probe_exit;
-	}
-	addr = ioremap(mem->start, resource_size(mem));
-	if (!addr) {
-		dev_err(&pdev->dev, "ioremap failed\n");
-		err = -ENOMEM;
-		goto probe_exit_free_region;
-	}
 
-	ndev = alloc_candev(sizeof(struct ti_hecc_priv), HECC_MAX_TX_MBOX);
-	if (!ndev) {
-		dev_err(&pdev->dev, "alloc_candev failed\n");
-		err = -ENOMEM;
-		goto probe_exit_iounmap;
-	}
 
-	priv = netdev_priv(ndev);
 	priv->ndev = ndev;
-	priv->base = addr;
-	priv->scc_ram_offset = pdata->scc_ram_offset;
-	priv->hecc_ram_offset = pdata->hecc_ram_offset;
-	priv->mbx_offset = pdata->mbx_offset;
 	priv->int_line = pdata->int_line;
 	priv->transceiver_switch = pdata->transceiver_switch;
 
@@ -971,10 +1041,6 @@ static int ti_hecc_probe(struct platform_device *pdev)
 	clk_put(priv->clk);
 probe_exit_candev:
 	free_candev(ndev);
-probe_exit_iounmap:
-	iounmap(addr);
-probe_exit_free_region:
-	release_mem_region(mem->start, resource_size(mem));
 probe_exit:
 	return err;
 }
@@ -1045,6 +1111,7 @@ static int ti_hecc_resume(struct platform_device *pdev)
 static struct platform_driver ti_hecc_driver = {
 	.driver = {
 		.name    = DRV_NAME,
+		.of_match_table = ti_hecc_dt_ids,
 	},
 	.probe = ti_hecc_probe,
 	.remove = ti_hecc_remove,
-- 
2.1.4


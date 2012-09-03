From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 1/4] can: c_can: Adopt pinctrl support
Date: Mon, 3 Sep 2012 17:22:16 +0530
Message-ID: <1346673139-14540-2-git-send-email-anilkumar@ti.com>
References: <1346673139-14540-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1346673139-14540-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de
Cc: tony@atomide.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, AnilKumar Ch <anilkumar@ti.com>
List-Id: linux-omap@vger.kernel.org

Adopt pinctrl support to c_can driver based on c_can device
pointer, pinctrl driver configure SoC pins to d_can mode
according to definitions provided in .dts file.

In device specific device tree file 'pinctrl-names = "default";'
and 'pinctrl-0 = <&d_can1_pins>;' needs to add to configure pins
from c_can driver. d_can1_pins node contains the pinmux/config
details of d_can L/H pins.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 drivers/net/can/c_can/c_can_platform.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 90801c4..c351975 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -33,6 +33,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <linux/can/dev.h>
 
@@ -98,6 +99,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 	struct c_can_priv *priv;
 	const struct of_device_id *match;
 	const struct platform_device_id *id;
+	struct pinctrl *pinctrl;
 	struct resource *mem;
 	int irq;
 	struct clk *clk;
@@ -114,6 +116,11 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 		id = platform_get_device_id(pdev);
 	}
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl))
+		dev_warn(&pdev->dev,
+			"failed to configure pins from driver\n");
+
 	/* get the appropriate clk */
 	clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
-- 
1.7.9.5


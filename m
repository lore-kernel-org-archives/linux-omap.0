From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv8 11/22] i2c: omap: switch to platform_get_irq()
Date: Wed, 12 Sep 2012 16:28:05 +0530
Message-ID: <1347447496-16793-12-git-send-email-shubhrajyoti@ti.com>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1347447496-16793-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

that's a nice helper from drivers core which
will give us the exact IRQ number, instead
of a pointer to an IRQ resource.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index bac1f11..0da8169 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -993,11 +993,12 @@ omap_i2c_probe(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*dev;
 	struct i2c_adapter	*adap;
-	struct resource		*mem, *irq;
+	struct resource		*mem;
 	struct omap_i2c_bus_platform_data *pdata = pdev->dev.platform_data;
 	struct device_node	*node = pdev->dev.of_node;
 	const struct of_device_id *match;
 	irq_handler_t isr;
+	int irq;
 	int r;
 
 	/* NOTE: driver uses the static register mapping */
@@ -1006,10 +1007,11 @@ omap_i2c_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "no mem resource?\n");
 		return -ENODEV;
 	}
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq) {
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq resource?\n");
-		return -ENODEV;
+		return irq;
 	}
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(struct omap_i2c_dev), GFP_KERNEL);
@@ -1043,7 +1045,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	}
 
 	dev->dev = &pdev->dev;
-	dev->irq = irq->start;
+	dev->irq = irq;
 
 	platform_set_drvdata(pdev, dev);
 	init_completion(&dev->cmd_complete);
-- 
1.7.5.4

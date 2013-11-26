From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 04/17] spi/qspi: parse control module register.
Date: Tue, 26 Nov 2013 13:05:00 +0530
Message-ID: <1385451313-1875-5-git-send-email-sourav.poddar@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385451313-1875-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

In qspi controller, we need to switch to memory mapped operations.
These switching depends on

1. For DRA7x: qspi register bit and control module register.
2. For AM437x: qspi register bit.

Hence add support for parsing control module register and provide a
flag "ctrl_mod" which can be used for conditional execution of
control module part.

Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-ti-qspi.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 67aa905..776e93d 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -46,6 +46,7 @@ struct ti_qspi {
 
 	struct spi_master	*master;
 	void __iomem            *base;
+	void __iomem            *ctrl_base;
 	struct clk		*fclk;
 	struct device           *dev;
 
@@ -54,6 +55,8 @@ struct ti_qspi {
 	u32 spi_max_frequency;
 	u32 cmd;
 	u32 dc;
+
+	bool ctrl_mod;
 };
 
 #define QSPI_PID			(0x0)
@@ -437,7 +440,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 {
 	struct  ti_qspi *qspi;
 	struct spi_master *master;
-	struct resource         *r;
+	struct resource         *r, *res_ctrl;
 	struct device_node *np = pdev->dev.of_node;
 	u32 max_freq;
 	int ret = 0, num_cs, irq;
@@ -471,6 +474,9 @@ static int ti_qspi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	res_ctrl = platform_get_resource_byname(pdev,
+			IORESOURCE_MEM, "qspi_ctrlmod");
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq resource?\n");
@@ -485,6 +491,15 @@ static int ti_qspi_probe(struct platform_device *pdev)
 		goto free_master;
 	}
 
+	if (res_ctrl) {
+		qspi->ctrl_mod = true;
+		qspi->ctrl_base = devm_ioremap_resource(&pdev->dev, res_ctrl);
+		if (IS_ERR(qspi->ctrl_base)) {
+			ret = PTR_ERR(qspi->ctrl_base);
+			goto free_master;
+		}
+	}
+
 	ret = devm_request_irq(&pdev->dev, irq, ti_qspi_isr, 0,
 			dev_name(&pdev->dev), qspi);
 	if (ret < 0) {
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

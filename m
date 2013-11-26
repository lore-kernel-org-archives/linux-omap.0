From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 05/17] spi/qspi: parse memory map register.
Date: Tue, 26 Nov 2013 13:05:01 +0530
Message-ID: <1385451313-1875-6-git-send-email-sourav.poddar@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385451313-1875-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Parse memory map register from device tree.

Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-ti-qspi.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 776e93d..39aefd7 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -47,6 +47,7 @@ struct ti_qspi {
 	struct spi_master	*master;
 	void __iomem            *base;
 	void __iomem            *ctrl_base;
+	void __iomem            *mmap_base;
 	struct clk		*fclk;
 	struct device           *dev;
 
@@ -440,7 +441,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 {
 	struct  ti_qspi *qspi;
 	struct spi_master *master;
-	struct resource         *r, *res_ctrl;
+	struct resource         *r, *res_ctrl, *res_mmap;
 	struct device_node *np = pdev->dev.of_node;
 	u32 max_freq;
 	int ret = 0, num_cs, irq;
@@ -477,6 +478,9 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	res_ctrl = platform_get_resource_byname(pdev,
 			IORESOURCE_MEM, "qspi_ctrlmod");
 
+	res_mmap = platform_get_resource_byname(pdev,
+			IORESOURCE_MEM, "qspi_mmap");
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq resource?\n");
@@ -500,6 +504,14 @@ static int ti_qspi_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (res_mmap) {
+		qspi->mmap_base = devm_ioremap_resource(&pdev->dev, res_mmap);
+		if (IS_ERR(qspi->mmap_base)) {
+			ret = PTR_ERR(qspi->mmap_base);
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

From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2 02/10] spi/qspi: parse register by name.
Date: Fri, 6 Dec 2013 19:54:43 +0530
Message-ID: <1386339891-32717-3-git-send-email-sourav.poddar@ti.com>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: broonie@kernel.org, linux-spi@vger.kernel.org, computersforpeace@gmail.com, marex@denx.de
Cc: devicetree@vger.kernel.org, balbi@ti.com, linux-mtd@lists.infradead.org, bcousson@baylibre.com, Sourav Poddar <sourav.poddar@ti.com>, linux-omap@vger.kernel.org, dwmw2@infradead.org
List-Id: linux-omap@vger.kernel.org

Modify the qspi driver to parse reg information by name.
If "reg names" is not found, then revert back to normal
get resource.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
v1->v2:
- if __byname variant is not found, go for standard 
  api. If both are not found, then the resource is considered
  to be optional and is not required for the given SOC.
 drivers/spi/spi-ti-qspi.c |   53 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 033ef8d..a0cee08 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -46,6 +46,8 @@ struct ti_qspi {
 
 	struct spi_master	*master;
 	void __iomem            *base;
+	void __iomem            *ctrl_base;
+	void __iomem            *mmap_base;
 	struct clk		*fclk;
 	struct device           *dev;
 
@@ -54,6 +56,8 @@ struct ti_qspi {
 	u32 spi_max_frequency;
 	u32 cmd;
 	u32 dc;
+
+	bool ctrl_mod;
 };
 
 #define QSPI_PID			(0x0)
@@ -437,7 +441,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 {
 	struct  ti_qspi *qspi;
 	struct spi_master *master;
-	struct resource         *r;
+	struct resource         *r, *res_ctrl, *res_mmap;
 	struct device_node *np = pdev->dev.of_node;
 	u32 max_freq;
 	int ret = 0, num_cs, irq;
@@ -465,7 +469,35 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	qspi->master = master;
 	qspi->dev = &pdev->dev;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_base");
+	if (r == NULL) {
+		r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (r == NULL) {
+			dev_err(&pdev->dev, "missing platform data\n");
+			return -ENODEV;
+		}
+	}
+
+	res_mmap = platform_get_resource_byname(pdev,
+			IORESOURCE_MEM, "qspi_mmap");
+	if (res_mmap == NULL) {
+		res_mmap = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (res_mmap == NULL) {
+			dev_err(&pdev->dev,
+				"memory mapped resource not required\n");
+			return -ENODEV;
+		}
+	}
+
+	res_ctrl = platform_get_resource_byname(pdev,
+			IORESOURCE_MEM, "qspi_ctrlmod");
+	if (res_ctrl == NULL) {
+		res_ctrl = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+		if (res_ctrl == NULL) {
+			dev_dbg(&pdev->dev,
+				"control module resources not required\n");
+		}
+	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -481,6 +513,23 @@ static int ti_qspi_probe(struct platform_device *pdev)
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


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

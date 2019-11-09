From: Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH] mfd: ti_am335x_tscadc: Fix static checker warning
Date: Sat, 9 Nov 2019 10:36:18 +0530
Message-ID: <20191109050618.20637-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>, Dan Murphy <dmurphy@ti.com>
List-Id: linux-omap@vger.kernel.org

It is possible that platform_get_resource() might return NULL and
therefore code needs to check for this condition before
de-referencing the pointer.
Therefore move the de-referencing of 'res' pointer after
devm_ioremap_resource() which would have checked the validity of the
pointer

Reported-by: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index fd111296b959..926c289cb040 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -182,11 +182,11 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 		tscadc->irq = err;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	tscadc->tscadc_phys_base = res->start;
 	tscadc->tscadc_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(tscadc->tscadc_base))
 		return PTR_ERR(tscadc->tscadc_base);
 
+	tscadc->tscadc_phys_base = res->start;
 	tscadc->regmap = devm_regmap_init_mmio(&pdev->dev,
 			tscadc->tscadc_base, &tscadc_regmap_config);
 	if (IS_ERR(tscadc->regmap)) {
-- 
2.24.0

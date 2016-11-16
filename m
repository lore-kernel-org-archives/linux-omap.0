From: Luis Henriques <henrix@camandro.org>
Subject: [PATCH] thermal: ti-soc-thermal: add missing clk_put()
Date: Wed, 16 Nov 2016 22:15:22 +0000
Message-ID: <20161116221522.22359-1-henrix@camandro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Henriques <henrix@camandro.org>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following Coccinelle error:

./drivers/thermal/ti-soc-thermal/ti-bandgap.c:1441:1-7: \
	ERROR: missing clk_put; clk_get on line 1290 \
	and execution via conditional on line 1298

Signed-off-by: Luis Henriques <henrix@camandro.org>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 06ea9766a70a..ba9c302454fb 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -1298,7 +1298,7 @@ int ti_bandgap_probe(struct platform_device *pdev)
 	if (IS_ERR(bgp->div_clk)) {
 		dev_err(&pdev->dev, "failed to request div_ts_ck clock ref\n");
 		ret = PTR_ERR(bgp->div_clk);
-		goto free_irqs;
+		goto put_fclock;
 	}
 
 	for (i = 0; i < bgp->conf->sensor_count; i++) {
@@ -1430,8 +1430,9 @@ int ti_bandgap_probe(struct platform_device *pdev)
 	if (TI_BANDGAP_HAS(bgp, CLK_CTRL))
 		clk_disable_unprepare(bgp->fclock);
 put_clks:
-	clk_put(bgp->fclock);
 	clk_put(bgp->div_clk);
+put_fclock:
+	clk_put(bgp->fclock);
 free_irqs:
 	if (TI_BANDGAP_HAS(bgp, TSHUT)) {
 		free_irq(gpio_to_irq(bgp->tshut_gpio), NULL);

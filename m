From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v1 02/14] clk: twl6040: Register the clock as of_clk_provider
Date: Mon, 30 May 2016 11:55:10 +0300
Message-ID: <20160530085522.30398-3-peter.ujfalusi@ti.com>
References: <20160530085522.30398-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160530085522.30398-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mturquette@baylibre.com, sboyd@codeaurora.org, tony@atomide.com, lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: t-kristo@ti.com, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

In order ot be able to use the pdmclk clock via DT it need to be registered
as of_clk_provide.
Since the twl6040 clock driver does not have it's own DT node, use the
parent's node for registering.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/clk/clk-twl6040.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-twl6040.c b/drivers/clk/clk-twl6040.c
index e167e0bbaff5..6a2dbe6a1627 100644
--- a/drivers/clk/clk-twl6040.c
+++ b/drivers/clk/clk-twl6040.c
@@ -95,7 +95,8 @@ static int twl6040_clk_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, clkdata);
 
-	return 0;
+	return of_clk_add_provider(pdev->dev.parent->of_node,
+				   of_clk_src_simple_get, clkdata->clk);
 }
 
 static struct platform_driver twl6040_clk_driver = {
-- 
2.8.3

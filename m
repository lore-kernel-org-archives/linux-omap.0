From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] clk: ti: dra7-atl: Remove pm_runtime_irq_safe()
Date: Thu, 14 Nov 2019 12:17:18 +0200
Message-ID: <20191114101718.20619-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com, mturquette@baylibre.com
Cc: sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

This is not needed for anything, and prevents proper PM transitions for
parent devices which is bad in case of ti-sysc; this effectively kills
PM completely. Thus, remove the flag.

Suggested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/clk/ti/clk-dra7-atl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
index f65e16c4f3c4..8d4c08b034bd 100644
--- a/drivers/clk/ti/clk-dra7-atl.c
+++ b/drivers/clk/ti/clk-dra7-atl.c
@@ -233,7 +233,6 @@ static int of_dra7_atl_clk_probe(struct platform_device *pdev)
 	cinfo->iobase = of_iomap(node, 0);
 	cinfo->dev = &pdev->dev;
 	pm_runtime_enable(cinfo->dev);
-	pm_runtime_irq_safe(cinfo->dev);
 
 	pm_runtime_get_sync(cinfo->dev);
 	atl_write(cinfo, DRA7_ATL_PCLKMUX_REG(0), DRA7_ATL_PCLKMUX);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

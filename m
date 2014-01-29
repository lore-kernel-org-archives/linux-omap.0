From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/2] clk: ti: am335x: remove unecessary cpu0 clk node
Date: Wed, 29 Jan 2014 12:19:16 -0600
Message-ID: <1391019557-22313-2-git-send-email-nm@ti.com>
References: <1391019557-22313-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1391019557-22313-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Mike Turquette <mturquette@linaro.org>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

cpu0 clock node has no functionality, since cpufreq-cpu0 is already
capable of picking up the clock from dts.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/clk/ti/clk-33xx.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/ti/clk-33xx.c b/drivers/clk/ti/clk-33xx.c
index 776ee45..028b337 100644
--- a/drivers/clk/ti/clk-33xx.c
+++ b/drivers/clk/ti/clk-33xx.c
@@ -34,7 +34,6 @@ static struct ti_dt_clk am33xx_clks[] = {
 	DT_CLK(NULL, "dpll_core_m5_ck", "dpll_core_m5_ck"),
 	DT_CLK(NULL, "dpll_core_m6_ck", "dpll_core_m6_ck"),
 	DT_CLK(NULL, "dpll_mpu_ck", "dpll_mpu_ck"),
-	DT_CLK("cpu0", NULL, "dpll_mpu_ck"),
 	DT_CLK(NULL, "dpll_mpu_m2_ck", "dpll_mpu_m2_ck"),
 	DT_CLK(NULL, "dpll_ddr_ck", "dpll_ddr_ck"),
 	DT_CLK(NULL, "dpll_ddr_m2_ck", "dpll_ddr_m2_ck"),
-- 
1.7.9.5

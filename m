From: Adam Ford <aford173@gmail.com>
Subject: [PATCH] clk: ti: omap3: Fix am3517 mdio clock alias
Date: Sat, 23 Jun 2018 06:09:12 -0500
Message-ID: <20180623110912.20633-1-aford173@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: t-kristo@ti.com, linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, Adam Ford <aford173@gmail.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

A previous patch removed OMAP clock aliases that were perceived
to be unnecessary.  Unfortunately, it broke the ethernet on the
am3517-evm.  This patch renables the MDIO clock.

Fixes: 0ed266d7ae5e ("clk: ti: omap3: cleanup unnecessary clock aliases")
Cc: stable@vger.kernel.org #4.16+

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/clk/ti/clk-3xxx.c b/drivers/clk/ti/clk-3xxx.c
index 8aa5f5793835..f84734bd0aa7 100644
--- a/drivers/clk/ti/clk-3xxx.c
+++ b/drivers/clk/ti/clk-3xxx.c
@@ -254,6 +254,8 @@ static struct ti_dt_clk omap36xx_am35xx_omap3430es2plus_clks[] = {
 };
 
 static struct ti_dt_clk am35xx_clks[] = {
+	DT_CLK("davinci_emac.0", NULL, "emac_ick"),
+	DT_CLK("davinci_mdio.0", NULL, "emac_fck"),
 	DT_CLK(NULL, "hsotgusb_ick", "hsotgusb_ick_am35xx"),
 	DT_CLK(NULL, "hsotgusb_fck", "hsotgusb_fck_am35xx"),
 	DT_CLK(NULL, "uart4_ick", "uart4_ick_am35xx"),
-- 
2.17.1

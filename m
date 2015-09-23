From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] clk: ti: fix dual-registration of uart4_ick
Date: Wed, 23 Sep 2015 15:48:34 +0100
Message-ID: <1443019714-12926-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: t-kristo@ti.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
Cc: linux-kernel@lists.codethink.co.uk, stable@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>
List-Id: linux-omap@vger.kernel.org

On the OMAP AM3517 platform the uart4_ick gets registered
twice, causing any power managment to /dev/ttyO3 to fail
when trying to wake the device up.

This solves the following oops:

[] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa09e008
[] PC is at serial_omap_pm+0x48/0x15c
[] LR is at _raw_spin_unlock_irqrestore+0x30/0x5c

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/clk/ti/clk-3xxx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/ti/clk-3xxx.c b/drivers/clk/ti/clk-3xxx.c
index 5e12f32..2e7ef1f 100644
--- a/drivers/clk/ti/clk-3xxx.c
+++ b/drivers/clk/ti/clk-3xxx.c
@@ -374,7 +374,6 @@ static struct ti_dt_clk omap3xxx_clks[] = {
 	DT_CLK(NULL, "gpio2_ick", "gpio2_ick"),
 	DT_CLK(NULL, "wdt3_ick", "wdt3_ick"),
 	DT_CLK(NULL, "uart3_ick", "uart3_ick"),
-	DT_CLK(NULL, "uart4_ick", "uart4_ick"),
 	DT_CLK(NULL, "gpt9_ick", "gpt9_ick"),
 	DT_CLK(NULL, "gpt8_ick", "gpt8_ick"),
 	DT_CLK(NULL, "gpt7_ick", "gpt7_ick"),
-- 
2.5.1


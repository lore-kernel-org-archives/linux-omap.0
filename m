From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH v2] clk: ti: fix dual-registration of uart4_ick
Date: Tue, 29 Sep 2015 15:01:08 +0100
Message-ID: <1443535268-22586-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@lists.codethink.co.uk
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, stable@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

On the OMAP AM3517 platform the uart4_ick gets registered
twice, causing any power managment to /dev/ttyO3 to fail
when trying to wake the device up.

This solves the following oops:

[] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa09e008
[] PC is at serial_omap_pm+0x48/0x15c
[] LR is at _raw_spin_unlock_irqrestore+0x30/0x5c

Cc: stable@vger.kernel.org
Cc: mturquette@baylibre.com
Cc: sboyd@codeaurora.org
Cc: linux-clk@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Cc: t-kristo@ti.com
Cc: linux-kernel@lists.codethink.co.uk
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
v2:
	- fix omap36xx series clock registration for uart4
---
 drivers/clk/ti/clk-3xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clk-3xxx.c b/drivers/clk/ti/clk-3xxx.c
index 5e12f32..8d94b97 100644
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
@@ -523,6 +522,7 @@ static struct ti_dt_clk am35xx_clks[] = {
 static struct ti_dt_clk omap36xx_clks[] = {
 	DT_CLK(NULL, "omap_192m_alwon_fck", "omap_192m_alwon_fck"),
 	DT_CLK(NULL, "uart4_fck", "uart4_fck"),
+	DT_CLK(NULL, "uart4_ick", "uart4_ick"),
 	{ .node_name = NULL },
 };
 
-- 
2.5.3

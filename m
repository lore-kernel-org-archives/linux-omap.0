From: Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.19.y-ckt 049/155] clk: ti: fix dual-registration of uart4_ick
Date: Thu, 12 Nov 2015 15:16:43 -0800
Message-ID: <1447370309-357-50-git-send-email-kamal@canonical.com>
References: <1447370309-357-1-git-send-email-kamal@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447370309-357-1-git-send-email-kamal@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@lists.ubuntu.com
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Ben Dooks <ben.dooks@codethink.co.uk>, Tero Kristo <t-kristo@ti.com>, Kamal Mostafa <kamal@canonical.com>
List-Id: linux-omap@vger.kernel.org

3.19.8-ckt10 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Dooks <ben.dooks@codethink.co.uk>

commit 19e79687de22f23bcfb5e79cce3daba20af228d1 upstream.

On the OMAP AM3517 platform the uart4_ick gets registered
twice, causing any power management to /dev/ttyO3 to fail
when trying to wake the device up.

This solves the following oops:

[] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa09e008
[] PC is at serial_omap_pm+0x48/0x15c
[] LR is at _raw_spin_unlock_irqrestore+0x30/0x5c

Fixes: aafd900cab87 ("CLK: TI: add omap3 clock init file")
Cc: mturquette@baylibre.com
Cc: sboyd@codeaurora.org
Cc: linux-clk@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Cc: linux-kernel@lists.codethink.co.uk
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 drivers/clk/ti/clk-3xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clk-3xxx.c b/drivers/clk/ti/clk-3xxx.c
index 0d1750a..088930c 100644
--- a/drivers/clk/ti/clk-3xxx.c
+++ b/drivers/clk/ti/clk-3xxx.c
@@ -170,7 +170,6 @@ static struct ti_dt_clk omap3xxx_clks[] = {
 	DT_CLK(NULL, "gpio2_ick", "gpio2_ick"),
 	DT_CLK(NULL, "wdt3_ick", "wdt3_ick"),
 	DT_CLK(NULL, "uart3_ick", "uart3_ick"),
-	DT_CLK(NULL, "uart4_ick", "uart4_ick"),
 	DT_CLK(NULL, "gpt9_ick", "gpt9_ick"),
 	DT_CLK(NULL, "gpt8_ick", "gpt8_ick"),
 	DT_CLK(NULL, "gpt7_ick", "gpt7_ick"),
@@ -313,6 +312,7 @@ static struct ti_dt_clk am35xx_clks[] = {
 static struct ti_dt_clk omap36xx_clks[] = {
 	DT_CLK(NULL, "omap_192m_alwon_fck", "omap_192m_alwon_fck"),
 	DT_CLK(NULL, "uart4_fck", "uart4_fck"),
+	DT_CLK(NULL, "uart4_ick", "uart4_ick"),
 	{ .node_name = NULL },
 };
 
-- 
1.9.1

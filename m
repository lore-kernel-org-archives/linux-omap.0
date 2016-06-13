From: Tero Kristo <t-kristo@ti.com>
Subject: [RESEND PATCHv2 21/28] clk: ti: am33xx: fix timer3/6 init time setup for module clocks
Date: Mon, 13 Jun 2016 22:04:55 +0300
Message-ID: <1465844702-12200-22-git-send-email-t-kristo@ti.com>
References: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

timer*_fck are going to be renamed as timer*_mod_ck:s. Fix the init
time configuration of timer3/timer6 to take this into account, and
lookup for the module clock in case the lookup for fck fails.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk-33xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/ti/clk-33xx.c b/drivers/clk/ti/clk-33xx.c
index 43847bc..2343a22 100644
--- a/drivers/clk/ti/clk-33xx.c
+++ b/drivers/clk/ti/clk-33xx.c
@@ -66,9 +66,15 @@ int __init am33xx_dt_clk_init(void)
 
 	clk1 = ti_clk_get("sys_clkin_ck");
 	clk2 = ti_clk_get("timer3_fck");
+	if (IS_ERR(clk2))
+		clk2 = ti_clk_get("timer3_mod_ck");
+
 	clk_set_parent(clk2, clk1);
 
 	clk2 = ti_clk_get("timer6_fck");
+	if (IS_ERR(clk2))
+		clk2 = ti_clk_get("timer6_mod_ck");
+
 	clk_set_parent(clk2, clk1);
 	/*
 	 * The On-Chip 32K RC Osc clock is not an accurate clock-source as per
-- 
1.9.1


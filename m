From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 25/30] clk: ti: am33xx: fix init time clock setup
Date: Mon, 11 Apr 2016 11:19:16 +0300
Message-ID: <1460362761-4842-26-git-send-email-t-kristo@ti.com>
References: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Some of the clock names have changed, so replace these with the new ones.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk-33xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ti/clk-33xx.c b/drivers/clk/ti/clk-33xx.c
index 43847bc..5228f48 100644
--- a/drivers/clk/ti/clk-33xx.c
+++ b/drivers/clk/ti/clk-33xx.c
@@ -65,10 +65,10 @@ int __init am33xx_dt_clk_init(void)
 	 */
 
 	clk1 = ti_clk_get("sys_clkin_ck");
-	clk2 = ti_clk_get("timer3_fck");
+	clk2 = ti_clk_get("timer3_mod_ck");
 	clk_set_parent(clk2, clk1);
 
-	clk2 = ti_clk_get("timer6_fck");
+	clk2 = ti_clk_get("timer6_mod_ck");
 	clk_set_parent(clk2, clk1);
 	/*
 	 * The On-Chip 32K RC Osc clock is not an accurate clock-source as per
-- 
1.7.9.5


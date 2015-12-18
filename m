From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC 9/9] clk: ti: omap4: update clock aliases to reflect new module clocks
Date: Fri, 18 Dec 2015 15:59:01 +0200
Message-ID: <1450447141-29936-10-git-send-email-t-kristo@ti.com>
References: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The clock data in DT has been updated, and the clock aliases must be
updated to match.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk-44xx.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/ti/clk-44xx.c b/drivers/clk/ti/clk-44xx.c
index 7a8b51b..81cd26e 100644
--- a/drivers/clk/ti/clk-44xx.c
+++ b/drivers/clk/ti/clk-44xx.c
@@ -164,17 +164,17 @@ static struct ti_dt_clk omap44xx_clks[] = {
 	DT_CLK(NULL, "smartreflex_core_fck", "smartreflex_core_fck"),
 	DT_CLK(NULL, "smartreflex_iva_fck", "smartreflex_iva_fck"),
 	DT_CLK(NULL, "smartreflex_mpu_fck", "smartreflex_mpu_fck"),
-	DT_CLK(NULL, "dmt1_clk_mux", "dmt1_clk_mux"),
-	DT_CLK(NULL, "cm2_dm10_mux", "cm2_dm10_mux"),
-	DT_CLK(NULL, "cm2_dm11_mux", "cm2_dm11_mux"),
-	DT_CLK(NULL, "cm2_dm2_mux", "cm2_dm2_mux"),
-	DT_CLK(NULL, "cm2_dm3_mux", "cm2_dm3_mux"),
-	DT_CLK(NULL, "cm2_dm4_mux", "cm2_dm4_mux"),
-	DT_CLK(NULL, "timer5_sync_mux", "timer5_sync_mux"),
-	DT_CLK(NULL, "timer6_sync_mux", "timer6_sync_mux"),
-	DT_CLK(NULL, "timer7_sync_mux", "timer7_sync_mux"),
-	DT_CLK(NULL, "timer8_sync_mux", "timer8_sync_mux"),
-	DT_CLK(NULL, "cm2_dm9_mux", "cm2_dm9_mux"),
+	DT_CLK(NULL, "timer1_mod_ck", "timer1_mod_ck"),
+	DT_CLK(NULL, "timer10_mod_ck", "timer10_mod_ck"),
+	DT_CLK(NULL, "timer11_mod_ck", "timer11_mod_ck"),
+	DT_CLK(NULL, "timer2_mod_ck", "timer2_mod_ck"),
+	DT_CLK(NULL, "timer3_mod_ck", "timer3_mod_ck"),
+	DT_CLK(NULL, "timer4_mod_ck", "timer4_mod_ck"),
+	DT_CLK(NULL, "timer5_mod_ck", "timer5_mod_ck"),
+	DT_CLK(NULL, "timer6_mod_ck", "timer6_mod_ck"),
+	DT_CLK(NULL, "timer7_mod_ck", "timer7_mod_ck"),
+	DT_CLK(NULL, "timer8_mod_ck", "timer8_mod_ck"),
+	DT_CLK(NULL, "timer9_mod_ck", "timer9_mod_ck"),
 	DT_CLK(NULL, "usb_host_fs_fck", "usb_host_fs_fck"),
 	DT_CLK("usbhs_omap", "fs_fck", "usb_host_fs_fck"),
 	DT_CLK(NULL, "utmi_p1_gfclk", "utmi_p1_gfclk"),
-- 
1.7.9.5


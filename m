From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 07/27] clk: ti: omap4: cleanup unnecessary clock aliases
Date: Mon, 30 Oct 2017 15:04:25 +0200
Message-ID: <1509368685-29112-8-git-send-email-t-kristo@ti.com>
References: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Most of the clock aliases are no longer needed, only leave the
timer_32k_ck one in place which is required by OMAP timer code.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk-44xx.c | 45 ---------------------------------------------
 1 file changed, 45 deletions(-)

diff --git a/drivers/clk/ti/clk-44xx.c b/drivers/clk/ti/clk-44xx.c
index 2005f03..9470e09 100644
--- a/drivers/clk/ti/clk-44xx.c
+++ b/drivers/clk/ti/clk-44xx.c
@@ -697,52 +697,7 @@
 };
 
 static struct ti_dt_clk omap44xx_clks[] = {
-	DT_CLK("smp_twd", NULL, "mpu_periphclk"),
-	DT_CLK("omapdss_dss", "ick", "dss_fck"),
-	DT_CLK("usbhs_omap", "fs_fck", "usb_host_fs_fck"),
-	DT_CLK("usbhs_omap", "hs_fck", "usb_host_hs_fck"),
-	DT_CLK("musb-omap2430", "ick", "usb_otg_hs_ick"),
-	DT_CLK("usbhs_omap", "usbtll_ick", "usb_tll_hs_ick"),
-	DT_CLK("usbhs_tll", "usbtll_ick", "usb_tll_hs_ick"),
-	DT_CLK("omap_i2c.1", "ick", "dummy_ck"),
-	DT_CLK("omap_i2c.2", "ick", "dummy_ck"),
-	DT_CLK("omap_i2c.3", "ick", "dummy_ck"),
-	DT_CLK("omap_i2c.4", "ick", "dummy_ck"),
-	DT_CLK(NULL, "mailboxes_ick", "dummy_ck"),
-	DT_CLK("omap_hsmmc.0", "ick", "dummy_ck"),
-	DT_CLK("omap_hsmmc.1", "ick", "dummy_ck"),
-	DT_CLK("omap_hsmmc.2", "ick", "dummy_ck"),
-	DT_CLK("omap_hsmmc.3", "ick", "dummy_ck"),
-	DT_CLK("omap_hsmmc.4", "ick", "dummy_ck"),
-	DT_CLK("omap-mcbsp.1", "ick", "dummy_ck"),
-	DT_CLK("omap-mcbsp.2", "ick", "dummy_ck"),
-	DT_CLK("omap-mcbsp.3", "ick", "dummy_ck"),
-	DT_CLK("omap-mcbsp.4", "ick", "dummy_ck"),
-	DT_CLK("omap2_mcspi.1", "ick", "dummy_ck"),
-	DT_CLK("omap2_mcspi.2", "ick", "dummy_ck"),
-	DT_CLK("omap2_mcspi.3", "ick", "dummy_ck"),
-	DT_CLK("omap2_mcspi.4", "ick", "dummy_ck"),
-	DT_CLK(NULL, "uart1_ick", "dummy_ck"),
-	DT_CLK(NULL, "uart2_ick", "dummy_ck"),
-	DT_CLK(NULL, "uart3_ick", "dummy_ck"),
-	DT_CLK(NULL, "uart4_ick", "dummy_ck"),
-	DT_CLK("usbhs_omap", "usbhost_ick", "dummy_ck"),
-	DT_CLK("usbhs_omap", "usbtll_fck", "dummy_ck"),
-	DT_CLK("usbhs_tll", "usbtll_fck", "dummy_ck"),
-	DT_CLK("omap_wdt", "ick", "dummy_ck"),
 	DT_CLK(NULL, "timer_32k_ck", "sys_32k_ck"),
-	DT_CLK("4a318000.timer", "timer_sys_ck", "sys_clkin_ck"),
-	DT_CLK("48032000.timer", "timer_sys_ck", "sys_clkin_ck"),
-	DT_CLK("48034000.timer", "timer_sys_ck", "sys_clkin_ck"),
-	DT_CLK("48036000.timer", "timer_sys_ck", "sys_clkin_ck"),
-	DT_CLK("4803e000.timer", "timer_sys_ck", "sys_clkin_ck"),
-	DT_CLK("48086000.timer", "timer_sys_ck", "sys_clkin_ck"),
-	DT_CLK("48088000.timer", "timer_sys_ck", "sys_clkin_ck"),
-	DT_CLK("40138000.timer", "timer_sys_ck", "syc_clk_div_ck"),
-	DT_CLK("4013a000.timer", "timer_sys_ck", "syc_clk_div_ck"),
-	DT_CLK("4013c000.timer", "timer_sys_ck", "syc_clk_div_ck"),
-	DT_CLK("4013e000.timer", "timer_sys_ck", "syc_clk_div_ck"),
-	DT_CLK(NULL, "cpufreq_ck", "dpll_mpu_ck"),
 	{ .node_name = NULL },
 };
 
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 3/4] clk: ti: 43xx: add debugss clocks to DT_CLK() table
Date: Fri, 23 Jan 2015 17:11:43 -0600
Message-ID: <1422054704-14915-4-git-send-email-balbi@ti.com>
References: <1422054704-14915-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42058 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753451AbbAWXMQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Jan 2015 18:12:16 -0500
In-Reply-To: <1422054704-14915-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org, Felipe Balbi <balbi@ti.com>

without these entries, omap_hwmod will not be
able to find debugss clocks.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/clk/ti/clk-43xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/ti/clk-43xx.c b/drivers/clk/ti/clk-43xx.c
index 3795fce8a830..46a597c815c9 100644
--- a/drivers/clk/ti/clk-43xx.c
+++ b/drivers/clk/ti/clk-43xx.c
@@ -83,6 +83,12 @@ static struct ti_dt_clk am43xx_clks[] = {
 	DT_CLK(NULL, "gfx_fck_div_ck", "gfx_fck_div_ck"),
 	DT_CLK(NULL, "timer_32k_ck", "clkdiv32k_ick"),
 	DT_CLK(NULL, "timer_sys_ck", "sys_clkin_ck"),
+	DT_CLK(NULL, "trace_clk_div_ck", "trace_clk_div_ck"),
+	DT_CLK(NULL, "trace_pm_clk_mux_ck", "trace_pm_clk_mux_ck"),
+	DT_CLK(NULL, "dbg_sysclk_ck", "dbg_sysclk_ck"),
+	DT_CLK(NULL, "dbg_clka_ck", "dbg_clka_ck"),
+	DT_CLK(NULL, "dbg_clkb_ck", "dbg_clkb_ck"),
+	DT_CLK(NULL, "dbg_clkc_ck", "dbg_clkc_ck"),
 	DT_CLK(NULL, "sysclk_div", "sysclk_div"),
 	DT_CLK(NULL, "disp_clk", "disp_clk"),
 	DT_CLK(NULL, "clk_32k_mosc_ck", "clk_32k_mosc_ck"),
-- 
2.3.0-rc1


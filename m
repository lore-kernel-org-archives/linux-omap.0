From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/2] CLK: TI: OMAP4: remove 'dss_fck' alias
Date: Fri, 19 Dec 2014 11:18:03 +0200
Message-ID: <1418980683-26825-2-git-send-email-tomi.valkeinen@ti.com>
References: <1418980683-26825-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37641 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752226AbaLSJSh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Dec 2014 04:18:37 -0500
In-Reply-To: <1418980683-26825-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

'dss_fck' clock was recently removed, but a clock alias for it was left.
This causes a warning:

ti_dt_clocks_register: failed to lookup clock node dss_fck

Remove the unneeded clock alias.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/clk/ti/clk-44xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/ti/clk-44xx.c b/drivers/clk/ti/clk-44xx.c
index 35a0f01bbaf4..b1169e87e2d4 100644
--- a/drivers/clk/ti/clk-44xx.c
+++ b/drivers/clk/ti/clk-44xx.c
@@ -126,7 +126,6 @@ static struct ti_dt_clk omap44xx_clks[] = {
 	DT_CLK(NULL, "dss_tv_clk", "dss_tv_clk"),
 	DT_CLK(NULL, "dss_dss_clk", "dss_dss_clk"),
 	DT_CLK(NULL, "dss_48mhz_clk", "dss_48mhz_clk"),
-	DT_CLK(NULL, "dss_fck", "dss_fck"),
 	DT_CLK(NULL, "fdif_fck", "fdif_fck"),
 	DT_CLK(NULL, "gpio1_dbclk", "gpio1_dbclk"),
 	DT_CLK(NULL, "gpio2_dbclk", "gpio2_dbclk"),
-- 
2.2.0


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/2] CLK: TI: remove 'ick' alias for 'omapdss_dss' device
Date: Fri, 19 Dec 2014 11:18:02 +0200
Message-ID: <1418980683-26825-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39717 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336AbaLSJSe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Dec 2014 04:18:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

The omapdss_dss driver has not used 'ick' clock for a long time, and
thus the clock alias for 'ick' is not needed and can be removed.

On OMAP4 the 'dss_fck' clock was recently removed, and as 'ick' was an
alias for 'dss_fck', it causes a warning:

ti_dt_clocks_register: failed to lookup clock node dss_fck

This patch removes that warning.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/clk/ti/clk-2xxx.c | 1 -
 drivers/clk/ti/clk-3xxx.c | 2 --
 drivers/clk/ti/clk-44xx.c | 1 -
 3 files changed, 4 deletions(-)

diff --git a/drivers/clk/ti/clk-2xxx.c b/drivers/clk/ti/clk-2xxx.c
index c808ab3d2bb2..e3656851b2e0 100644
--- a/drivers/clk/ti/clk-2xxx.c
+++ b/drivers/clk/ti/clk-2xxx.c
@@ -48,7 +48,6 @@ static struct ti_dt_clk omap2xxx_clks[] = {
 	DT_CLK(NULL, "gfx_3d_fck", "gfx_3d_fck"),
 	DT_CLK(NULL, "gfx_2d_fck", "gfx_2d_fck"),
 	DT_CLK(NULL, "gfx_ick", "gfx_ick"),
-	DT_CLK("omapdss_dss", "ick", "dss_ick"),
 	DT_CLK(NULL, "dss_ick", "dss_ick"),
 	DT_CLK(NULL, "dss1_fck", "dss1_fck"),
 	DT_CLK(NULL, "dss2_fck", "dss2_fck"),
diff --git a/drivers/clk/ti/clk-3xxx.c b/drivers/clk/ti/clk-3xxx.c
index 0d1750a8aea4..2ff8b60f62f3 100644
--- a/drivers/clk/ti/clk-3xxx.c
+++ b/drivers/clk/ti/clk-3xxx.c
@@ -265,7 +265,6 @@ static struct ti_dt_clk omap3430es1_clks[] = {
 	DT_CLK(NULL, "ssi_ick", "ssi_ick_3430es1"),
 	DT_CLK(NULL, "usb_l4_ick", "usb_l4_ick"),
 	DT_CLK(NULL, "dss1_alwon_fck", "dss1_alwon_fck_3430es1"),
-	DT_CLK("omapdss_dss", "ick", "dss_ick_3430es1"),
 	DT_CLK(NULL, "dss_ick", "dss_ick_3430es1"),
 	{ .node_name = NULL },
 };
@@ -284,7 +283,6 @@ static struct ti_dt_clk omap36xx_am35xx_omap3430es2plus_clks[] = {
 	DT_CLK(NULL, "mmchs3_ick", "mmchs3_ick"),
 	DT_CLK(NULL, "mmchs3_fck", "mmchs3_fck"),
 	DT_CLK(NULL, "dss1_alwon_fck", "dss1_alwon_fck_3430es2"),
-	DT_CLK("omapdss_dss", "ick", "dss_ick_3430es2"),
 	DT_CLK(NULL, "dss_ick", "dss_ick_3430es2"),
 	DT_CLK(NULL, "usbhost_120m_fck", "usbhost_120m_fck"),
 	DT_CLK(NULL, "usbhost_48m_fck", "usbhost_48m_fck"),
diff --git a/drivers/clk/ti/clk-44xx.c b/drivers/clk/ti/clk-44xx.c
index 02517a8206bd..35a0f01bbaf4 100644
--- a/drivers/clk/ti/clk-44xx.c
+++ b/drivers/clk/ti/clk-44xx.c
@@ -127,7 +127,6 @@ static struct ti_dt_clk omap44xx_clks[] = {
 	DT_CLK(NULL, "dss_dss_clk", "dss_dss_clk"),
 	DT_CLK(NULL, "dss_48mhz_clk", "dss_48mhz_clk"),
 	DT_CLK(NULL, "dss_fck", "dss_fck"),
-	DT_CLK("omapdss_dss", "ick", "dss_fck"),
 	DT_CLK(NULL, "fdif_fck", "fdif_fck"),
 	DT_CLK(NULL, "gpio1_dbclk", "gpio1_dbclk"),
 	DT_CLK(NULL, "gpio2_dbclk", "gpio2_dbclk"),
-- 
2.2.0


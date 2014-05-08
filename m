From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/3] clk: ti: add 'ti,round-rate' flag
Date: Thu, 8 May 2014 12:06:47 +0300
Message-ID: <1399540009-6953-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51781 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753088AbaEHJHH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 May 2014 05:07:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

The current DPLL code does not try to round the clock rate, and instead
returns an error if the requested clock rate cannot be produced exactly
by the DPLL.

It could be argued that this is a bug, but as the current drivers may
depend on that behavior, a new flag 'ti,round-rate' is added which
enables clock rate rounding.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 Documentation/devicetree/bindings/clock/ti/dpll.txt | 2 ++
 drivers/clk/ti/dpll.c                               | 3 +++
 include/linux/clk/ti.h                              | 1 +
 3 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/ti/dpll.txt b/Documentation/devicetree/bindings/clock/ti/dpll.txt
index 30bfdb7c9f18..7912d876e858 100644
--- a/Documentation/devicetree/bindings/clock/ti/dpll.txt
+++ b/Documentation/devicetree/bindings/clock/ti/dpll.txt
@@ -48,6 +48,8 @@ Optional properties:
 	- ti,low-power-stop : DPLL supports low power stop mode, gating output
 	- ti,low-power-bypass : DPLL output matches rate of parent bypass clock
 	- ti,lock : DPLL locks in programmed rate
+- ti,round-rate : if not set, the dpll will return an error if asked for a
+                  clock rate that it cannot produce exactly.
 
 Examples:
 	dpll_core_ck: dpll_core_ck@44e00490 {
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 7e498a44f97d..c5858c46b58c 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -265,6 +265,9 @@ static void __init of_ti_dpll_setup(struct device_node *node,
 	if (dpll_mode)
 		dd->modes = dpll_mode;
 
+	if (of_property_read_bool(node, "ti,round-rate"))
+		clk_hw->flags |= DPLL_USE_ROUNDED_RATE;
+
 	ti_clk_register_dpll(&clk_hw->hw, node);
 	return;
 
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 4a21a872dbbd..79e8a7876457 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -155,6 +155,7 @@ struct clk_hw_omap {
 #define INVERT_ENABLE		(1 << 4)	/* 0 enables, 1 disables */
 #define CLOCK_CLKOUTX2		(1 << 5)
 #define MEMMAP_ADDRESSING	(1 << 6)
+#define DPLL_USE_ROUNDED_RATE	(1 << 7)	/* dpll's round_rate() returns rounded rate */
 
 /* CM_CLKEN_PLL*.EN* bit values - not all are available for every DPLL */
 #define DPLL_LOW_POWER_STOP	0x1
-- 
1.9.1


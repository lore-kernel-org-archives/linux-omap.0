From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 2/3] clk: ti: amx3xx: limit the maximum frequency of DPLLs based on spec
Date: Wed, 16 Mar 2016 21:54:56 +0200
Message-ID: <1458158097-21137-3-git-send-email-t-kristo@ti.com>
References: <1458158097-21137-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1458158097-21137-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-omap@vger.kernel.org

AM33xx/AM43xx devices use the same DPLL IP blocks, which only support
maximum rate of 1GHz [1] for the default and 2GHz for the low-jitter type
DPLLs [2]. Reflect this limitation in the DPLL init code by adding the
max-rate parameter based on the DPLL types.

[1] Functional, integration & test specification for GS70 ADPLLS, Rev 1.0-01
[2] Functional, integration & test specification for GS70 ADPLLLJ, Rev 0.8-02

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/clk/ti/dpll.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 5519b38..4caadb9 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -642,6 +642,7 @@ static void __init of_ti_am3_no_gate_dpll_setup(struct device_node *node)
 		.max_multiplier = 2047,
 		.max_divider = 128,
 		.min_divider = 1,
+		.max_rate = 1000000000,
 		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	};
 
@@ -661,6 +662,7 @@ static void __init of_ti_am3_jtype_dpll_setup(struct device_node *node)
 		.max_divider = 256,
 		.min_divider = 2,
 		.flags = DPLL_J_TYPE,
+		.max_rate = 2000000000,
 		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	};
 
@@ -679,6 +681,7 @@ static void __init of_ti_am3_no_gate_jtype_dpll_setup(struct device_node *node)
 		.max_multiplier = 2047,
 		.max_divider = 128,
 		.min_divider = 1,
+		.max_rate = 2000000000,
 		.flags = DPLL_J_TYPE,
 		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	};
@@ -699,6 +702,7 @@ static void __init of_ti_am3_dpll_setup(struct device_node *node)
 		.max_multiplier = 2047,
 		.max_divider = 128,
 		.min_divider = 1,
+		.max_rate = 1000000000,
 		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	};
 
@@ -716,6 +720,7 @@ static void __init of_ti_am3_core_dpll_setup(struct device_node *node)
 		.max_multiplier = 2047,
 		.max_divider = 128,
 		.min_divider = 1,
+		.max_rate = 1000000000,
 		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	};
 
-- 
1.7.9.5


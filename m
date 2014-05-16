From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/3] clk: dpll: support OMAP5 MPU DPLL that need special handling for higher frequencies
Date: Fri, 16 May 2014 05:45:59 -0500
Message-ID: <1400237160-25125-3-git-send-email-nm@ti.com>
References: <1400237160-25125-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1400237160-25125-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Paul <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

MPU DPLL on OMAP5, DRA75x, DRA72x has a limitation on the maximum
frequency it can be locked at. Duty Cycle Correction circuit is used
to recover a correct duty cycle for achieving higher frequencies
(hardware internally switches output to M3 output(CLKOUTHIF) from M2
output (CLKOUT)).

So provide support to setup required data to handle Duty cycle by
the setting up the minimum frequency for DPLL. 1.4GHz is common
for all these devices and is based on Technical Reference Manual
information for OMAP5432((SWPU282U) chapter 3.6.3.3.1 "DPLLs Output
Clocks Parameters", and equivalent information from DRA75x, DRA72x
documentation(SPRUHP2E, SPRUHI2P).

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/clock/ti/dpll.txt          |    1 +
 drivers/clk/ti/dpll.c                              |   21 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/ti/dpll.txt b/Documentation/devicetree/bindings/clock/ti/dpll.txt
index 30bfdb7..a4d0723 100644
--- a/Documentation/devicetree/bindings/clock/ti/dpll.txt
+++ b/Documentation/devicetree/bindings/clock/ti/dpll.txt
@@ -24,6 +24,7 @@ Required properties:
 		"ti,omap4-dpll-core-clock",
 		"ti,omap4-dpll-m4xen-clock",
 		"ti,omap4-dpll-j-type-clock",
+		"ti,omap5-mpu-dpll-clock",
 		"ti,am3-dpll-no-gate-clock",
 		"ti,am3-dpll-j-type-clock",
 		"ti,am3-dpll-no-gate-j-type-clock",
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 7e498a4..c06e94a 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -396,6 +396,27 @@ static void __init of_ti_omap4_dpll_setup(struct device_node *node)
 CLK_OF_DECLARE(ti_omap4_dpll_clock, "ti,omap4-dpll-clock",
 	       of_ti_omap4_dpll_setup);
 
+static void __init of_ti_omap5_mpu_dpll_setup(struct device_node *node)
+{
+	const struct dpll_data dd = {
+		.idlest_mask = 0x1,
+		.enable_mask = 0x7,
+		.autoidle_mask = 0x7,
+		.mult_mask = 0x7ff << 8,
+		.div1_mask = 0x7f,
+		.max_multiplier = 2047,
+		.max_divider = 128,
+		.dcc_mask = BIT(22),
+		.dcc_rate = 1400000000, /* DCC beyond 1.4GHz */
+		.min_divider = 1,
+		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
+	};
+
+	of_ti_dpll_setup(node, &dpll_ck_ops, &dd, DPLL_HAS_AUTOIDLE);
+}
+CLK_OF_DECLARE(of_ti_omap5_mpu_dpll_clock, "ti,omap5-mpu-dpll-clock",
+	       of_ti_omap5_mpu_dpll_setup);
+
 static void __init of_ti_omap4_core_dpll_setup(struct device_node *node)
 {
 	const struct dpll_data dd = {
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

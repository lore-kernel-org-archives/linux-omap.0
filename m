From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 3/3] arm: omap_hwmod disable ick autoidling when a hwmod requires that
Date: Sat, 10 Nov 2018 21:31:15 +0100
Message-ID: <20181110203115.13335-4-andreas@kemnade.info>
References: <20181110203115.13335-1-andreas@kemnade.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181110203115.13335-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
Cc: Andreas Kemnade <andreas@kemnade.info>
List-Id: linux-omap@vger.kernel.org

Deny autoidle for hwmods with the OCPIF_SWSUP_IDLE flag,
that makes hwmods working properly which cannot handle
autoidle properly in lower power states.
Affected is e. g. the omap_hdq.
Since an ick might have mulitple users, autoidle is disabled
when an individual user requires that rather than in
_setup_iclk_autoidle. dss_ick is an example for that.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 Comments to v1 to this patch were worked into a new 2/3
---
 arch/arm/mach-omap2/omap_hwmod.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 083dcd9942ce..3a86ba414973 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1002,8 +1002,10 @@ static int _enable_clocks(struct omap_hwmod *oh)
 		clk_enable(oh->_clk);
 
 	list_for_each_entry(os, &oh->slave_ports, node) {
-		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
+		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE)) {
+			omap2_clk_deny_idle(os->_clk);
 			clk_enable(os->_clk);
+		}
 	}
 
 	/* The opt clocks are controlled by the device driver. */
@@ -1055,8 +1057,10 @@ static int _disable_clocks(struct omap_hwmod *oh)
 		clk_disable(oh->_clk);
 
 	list_for_each_entry(os, &oh->slave_ports, node) {
-		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
+		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE)) {
 			clk_disable(os->_clk);
+			omap2_clk_allow_idle(os->_clk);
+		}
 	}
 
 	if (oh->flags & HWMOD_OPT_CLKS_NEEDED)
@@ -2425,9 +2429,13 @@ static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
 			continue;
 
 		if (os->flags & OCPIF_SWSUP_IDLE) {
-			/* XXX omap_iclk_deny_idle(c); */
+			/*
+			 * we might have multiple users of one iclk with
+			 * different requirements, disable autoidle when
+			 * the module is enabled, e.g. dss iclk
+			 */
 		} else {
-			/* XXX omap_iclk_allow_idle(c); */
+			/* we are enabling autoidle afterwards anyways */
 			clk_enable(os->_clk);
 		}
 	}
-- 
2.11.0

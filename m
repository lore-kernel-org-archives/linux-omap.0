From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 2/2] arm: omap_hwmod disable ick autoidling when a hwmod requires that
Date: Thu,  4 Oct 2018 22:38:17 +0200
Message-ID: <20181004203817.22101-3-andreas@kemnade.info>
References: <20181004203817.22101-1-andreas@kemnade.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004203817.22101-1-andreas@kemnade.info>
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
 arch/arm/mach-omap2/omap_hwmod.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index bb641e6c93d0..0078b0e1d242 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -986,8 +986,10 @@ static int _enable_clocks(struct omap_hwmod *oh)
 		clk_enable(oh->_clk);
 
 	list_for_each_entry(os, &oh->slave_ports, node) {
-		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
+		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE)) {
+			omap2_clk_deny_idle(os->_clk);
 			clk_enable(os->_clk);
+		}
 	}
 
 	/* The opt clocks are controlled by the device driver. */
@@ -1039,8 +1041,10 @@ static int _disable_clocks(struct omap_hwmod *oh)
 		clk_disable(oh->_clk);
 
 	list_for_each_entry(os, &oh->slave_ports, node) {
-		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
+		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE)) {
 			clk_disable(os->_clk);
+			omap2_clk_allow_idle(os->_clk);
+		}
 	}
 
 	if (oh->flags & HWMOD_OPT_CLKS_NEEDED)
@@ -2410,9 +2414,13 @@ static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
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

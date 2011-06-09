From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 8/8] OMAP: clock: Enable clockdomain only for optional clocks
Date: Thu, 9 Jun 2011 16:24:13 +0530
Message-ID: <1307616853-28395-9-git-send-email-rnayak@ti.com>
References: <1307616853-28395-1-git-send-email-rnayak@ti.com>
 <1307616853-28395-2-git-send-email-rnayak@ti.com>
 <1307616853-28395-3-git-send-email-rnayak@ti.com>
 <1307616853-28395-4-git-send-email-rnayak@ti.com>
 <1307616853-28395-5-git-send-email-rnayak@ti.com>
 <1307616853-28395-6-git-send-email-rnayak@ti.com>
 <1307616853-28395-7-git-send-email-rnayak@ti.com>
 <1307616853-28395-8-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49955 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757233Ab1FIKye (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jun 2011 06:54:34 -0400
In-Reply-To: <1307616853-28395-8-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Optional clocks have a requirement to have the clockdomain
force enabled (SW_WKUP) before the optional clock itself
is enabled.
Since optional clocks are currently handled directly by
drivers using the clock framework, this needs to be handled
at the clock framework. This sequence is already handled
in the omap_hwmod framework for the essential/main
clocks.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 2828d29..ff71ff7 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -286,6 +286,7 @@ void omap2_clk_disable(struct clk *clk)
 int omap2_clk_enable(struct clk *clk)
 {
 	int ret;
+	int hwsup = 0;
 
 	pr_debug("clock: %s: incrementing usecount\n", clk->name);
 
@@ -304,6 +305,17 @@ int omap2_clk_enable(struct clk *clk)
 			goto oce_err1;
 		}
 	}
+	/*
+	 * TODO: This is needed here only as long as drivers use
+	 * clock framework to enable optional clocks. For all the
+	 * essential clocks, this sequence is handled in the
+	 * omap_hwmod framework.
+	 */
+	/* Enable the clockdomain, if its an optional clock */
+	if ((clk->flags & CLOCK_OPTCLK) && (clk->clkdm)) {
+		hwsup = clkdm_is_idle(clk->clkdm);
+		clkdm_wakeup(clk->clkdm);
+	}
 
 	if (clk->ops && clk->ops->enable) {
 		trace_clock_enable(clk->name, 1, smp_processor_id());
@@ -315,6 +327,9 @@ int omap2_clk_enable(struct clk *clk)
 		}
 	}
 
+	if ((clk->flags & CLOCK_OPTCLK) && (clk->clkdm) && hwsup)
+		clkdm_allow_idle(clk->clkdm);
+
 	return 0;
 
 oce_err2:
-- 
1.7.0.4


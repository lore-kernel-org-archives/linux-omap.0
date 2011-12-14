From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 2/6] omap: clk: .round_rate for propagating to parents
Date: Tue, 13 Dec 2011 20:31:24 -0800
Message-ID: <1323837088-2469-3-git-send-email-mturquette@ti.com>
References: <1323837088-2469-1-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:36944 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754145Ab1LNEej (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 23:34:39 -0500
Received: by mail-yw0-f42.google.com with SMTP id m16so1014838yhm.15
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 20:34:38 -0800 (PST)
In-Reply-To: <1323837088-2469-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, tony@atomide.com, b-cousson@ti.com, rnayak@ti.com, jeremy.kerr@canonical.com, paul@pwsan.com, broonie@opensource.wolfsonmicro.com, tglx@linutronix.de, linus.walleij@stericsson.com, amit.kucheria@linaro.org, dsaxena@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, grant.likely@secretlab.ca, sboyd@quicinc.com, shawn.guo@freescale.com, skannan@quicinc.com, magnus.damm@gmail.com, arnd.bergmann@linaro.org, eric.miao@linaro.org, richard.zhao@linaro.org, mturquette@linaro.org, mturquette@ti.com, andrew@lunn.ch

This patch introduces omap2_passthrough_round_rate which is a new
.round_rate that works with the generic struct clk_ops defined in
include/linux/clk.h.

The purpose of this .round_rate is to allow an OMAP clk to make no
changes to its own dividers (if applicable) and instead defer the rate
change up to the clk's parent.

Not-signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/clkt_clksel.c |    8 ++++++++
 arch/arm/mach-omap2/clock.h       |    2 ++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap2/clkt_clksel.c
index ad3befb..0f151ce 100644
--- a/arch/arm/mach-omap2/clkt_clksel.c
+++ b/arch/arm/mach-omap2/clkt_clksel.c
@@ -438,6 +438,14 @@ long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate,
 	return omap2_clksel_round_rate_div(oclk, target_rate, &new_div);
 }
 
+long omap2_passthrough_round_rate(struct clk *clk, unsigned long target_rate,
+		unsigned long *parent_rate)
+{
+	*parent_rate = target_rate;
+
+	return clk->rate;
+}
+
 /**
  * omap2_clksel_set_rate() - program clock rate in hardware
  * @clk: struct clk * to program rate
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index e03060e..05f8a00 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -86,6 +86,8 @@ struct clk *omap2_init_clksel_parent(struct clk *clk);
 unsigned long omap2_clksel_recalc(struct clk *clk);
 long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate,
 		unsigned long *parent_rate);
+long omap2_passthrough_round_rate(struct clk *clk, unsigned long target_rate,
+		unsigned long *parent_rate);
 int omap2_clksel_set_rate(struct clk *clk, unsigned long rate);
 int omap2_clksel_set_parent(struct clk *clk, struct clk *new_parent);
 
-- 
1.7.5.4


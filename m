From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 34/43] ARM: OMAP2+: clock: add support for regmap
Date: Fri, 25 Oct 2013 18:57:28 +0300
Message-ID: <1382716658-6964-35-git-send-email-t-kristo@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41076 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab3JYQA7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Oct 2013 12:00:59 -0400
In-Reply-To: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Using regmap is required for isolating the actual memory access from
the clock code. Now, the driver providing the support for the clock IP
block can provide a regmap for this purpose.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c |   20 ++++++++++++++++++++
 arch/arm/mach-omap2/clock.h |    3 +++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 223f432b..560c49b 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -57,6 +57,26 @@ static bool clkdm_control = true;
 
 static LIST_HEAD(clk_hw_omap_clocks);
 
+void omap2_clk_writel(u32 val, struct clk_hw_omap *clk, void __iomem *reg)
+{
+	if (clk->regmap)
+		regmap_write(clk->regmap, (u32)reg, val);
+	else
+		__raw_writel(val, reg);
+}
+
+u32 omap2_clk_readl(struct clk_hw_omap *clk, void __iomem *reg)
+{
+	u32 val;
+
+	if (clk->regmap)
+		regmap_read(clk->regmap, (u32)reg, &val);
+	else
+		val = __raw_readl(reg);
+
+	return val;
+}
+
 /*
  * Used for clocks that have the same value as the parent clock,
  * divided by some factor
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index d1b227e..a166683 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -252,6 +252,9 @@ void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
 			       const char *core_ck_name,
 			       const char *mpu_ck_name);
 
+u32 omap2_clk_readl(struct clk_hw_omap *clk, void __iomem *reg);
+void omap2_clk_writel(u32 val, struct clk_hw_omap *clk, void __iomem *reg);
+
 extern u16 cpu_mask;
 
 extern const struct clkops clkops_omap2_dflt_wait;
-- 
1.7.9.5


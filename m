From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv13 30/40] ARM: OMAP2+: clock: add support for indexed memmaps
Date: Thu, 9 Jan 2014 16:00:41 +0200
Message-ID: <1389276051-1326-31-git-send-email-t-kristo@ti.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389276051-1326-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Using indexed memmaps is required for isolating the actual memory access
from the clock code. Now, the driver providing the support for the clock IP
block provides the low level routines for reading/writing clock registers
also.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/clock.c |   26 +++++++++++++++++++++++++-
 arch/arm/mach-omap2/clock.h |    5 +++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 238be3f..be53bb2 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -26,7 +26,6 @@
 #include <linux/clk-private.h>
 #include <asm/cpu.h>
 
-
 #include <trace/events/power.h>
 
 #include "soc.h"
@@ -56,6 +55,31 @@ u16 cpu_mask;
 static bool clkdm_control = true;
 
 static LIST_HEAD(clk_hw_omap_clocks);
+void __iomem *clk_memmaps[CLK_MAX_MEMMAPS];
+
+void omap2_clk_writel(u32 val, struct clk_hw_omap *clk, void __iomem *reg)
+{
+	if (clk->flags & MEMMAP_ADDRESSING) {
+		struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
+		writel_relaxed(val, clk_memmaps[r->index] + r->offset);
+	} else {
+		writel_relaxed(val, reg);
+	}
+}
+
+u32 omap2_clk_readl(struct clk_hw_omap *clk, void __iomem *reg)
+{
+	u32 val;
+
+	if (clk->flags & MEMMAP_ADDRESSING) {
+		struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
+		val = readl_relaxed(clk_memmaps[r->index] + r->offset);
+	} else {
+		val = readl_relaxed(reg);
+	}
+
+	return val;
+}
 
 /*
  * Used for clocks that have the same value as the parent clock,
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index cbe5ff7..bda767a 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -254,6 +254,9 @@ void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
 			       const char *core_ck_name,
 			       const char *mpu_ck_name);
 
+u32 omap2_clk_readl(struct clk_hw_omap *clk, void __iomem *reg);
+void omap2_clk_writel(u32 val, struct clk_hw_omap *clk, void __iomem *reg);
+
 extern u16 cpu_mask;
 
 extern const struct clkops clkops_omap2_dflt_wait;
@@ -288,6 +291,8 @@ extern const struct clksel_rate div_1_3_rates[];
 extern const struct clksel_rate div_1_4_rates[];
 extern const struct clksel_rate div31_1to31_rates[];
 
+extern void __iomem *clk_memmaps[];
+
 extern int am33xx_clk_init(void);
 
 extern int omap2_clkops_enable_clkdm(struct clk_hw *hw);
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

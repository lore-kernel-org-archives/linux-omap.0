From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 02/11] ARM: OMAP3: clock: add API to enable/disable autoidle for a single clock
Date: Fri, 11 Oct 2013 19:15:32 +0300
Message-ID: <1381508141-15244-3-git-send-email-t-kristo@ti.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54092 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845Ab3JKQQW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 12:16:22 -0400
In-Reply-To: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@linaro.org, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

Some drivers require direct access to the autoidle functionality of the
interface clocks. Added clock APIs for these, so that the drivers do not
need to access CM registers directly.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c |   38 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock.h |    2 ++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 0c38ca9..c7c5d31 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -543,6 +543,44 @@ int omap2_clk_disable_autoidle_all(void)
 }
 
 /**
+ * omap2_clk_deny_idle - disable autoidle on an OMAP clock
+ * @clk: struct clk * to disable autoidle for
+ *
+ * Disable autoidle on an OMAP clock.
+ */
+int omap2_clk_deny_idle(struct clk *clk)
+{
+	struct clk_hw_omap *c;
+
+	if (__clk_get_flags(clk) & CLK_IS_BASIC)
+		return -EINVAL;
+
+	c = to_clk_hw_omap(__clk_get_hw(clk));
+	if (c->ops && c->ops->deny_idle)
+		c->ops->deny_idle(c);
+	return 0;
+}
+
+/**
+ * omap2_clk_allow_idle - enable autoidle on an OMAP clock
+ * @clk: struct clk * to enable autoidle for
+ *
+ * Enable autoidle on an OMAP clock.
+ */
+int omap2_clk_allow_idle(struct clk *clk)
+{
+	struct clk_hw_omap *c;
+
+	if (__clk_get_flags(clk) & CLK_IS_BASIC)
+		return -EINVAL;
+
+	c = to_clk_hw_omap(__clk_get_hw(clk));
+	if (c->ops && c->ops->allow_idle)
+		c->ops->allow_idle(c);
+	return 0;
+}
+
+/**
  * omap2_clk_enable_init_clocks - prepare & enable a list of clocks
  * @clk_names: ptr to an array of strings of clock names to enable
  * @num_clocks: number of clock names in @clk_names
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 7aa32cd..82916cc 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -411,6 +411,8 @@ void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk,
 void omap2_init_clk_hw_omap_clocks(struct clk *clk);
 int omap2_clk_enable_autoidle_all(void);
 int omap2_clk_disable_autoidle_all(void);
+int omap2_clk_allow_idle(struct clk *clk);
+int omap2_clk_deny_idle(struct clk *clk);
 void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks);
 int omap2_clk_switch_mpurate_at_boot(const char *mpurate_ck_name);
 void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
-- 
1.7.9.5


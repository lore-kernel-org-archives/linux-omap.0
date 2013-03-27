From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V2] ARM: AM33XX: Add missing .clkdm_name to clkdiv32k_ick clock
Date: Wed, 27 Mar 2013 15:34:26 +0530
Message-ID: <1364378666-23641-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58500 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753895Ab3C0KEj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 06:04:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

It is required to enable respective clock-domain before
enabling any clock/module inside that clock-domain.

During common-clock migration, .clkdm_name field got missed
for "clkdiv32k_ick" clock, which leaves "clk_24mhz_clkdm"
unused; so it will be disabled even if childs of this clock-domain
is enabled, which keeps child modules in idle mode.

This fixes the kernel crash observed on AM335xEVM-SK platform,
where clkdiv32_ick clock is being used as a gpio debounce clock
and since clkdiv32k_ick is in idle mode it leads to below crash -

Crash Log:
==========
[    2.598347] Unhandled fault: external abort on non-linefetch (0x1028) at
0xfa1ac150
[    2.606434] Internal error: : 1028 [#1] SMP ARM
[    2.611207] Modules linked in:
[    2.614449] CPU: 0    Not tainted  (3.8.4-01382-g1f449cd-dirty #4)
[    2.620973] PC is at _set_gpio_debounce+0x60/0x104
[    2.626025] LR is at clk_enable+0x30/0x3c

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
Change from V1 (no code change):
	- Commit description updated as per Rajendra and Paul's
	  comment.

 arch/arm/mach-omap2/cclock33xx_data.c |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock33xx_data.c b/arch/arm/mach-omap2/cclock33xx_data.c
index 476b820..8327721 100644
--- a/arch/arm/mach-omap2/cclock33xx_data.c
+++ b/arch/arm/mach-omap2/cclock33xx_data.c
@@ -446,9 +446,29 @@ DEFINE_CLK_GATE(cefuse_fck, "sys_clkin_ck", &sys_clkin_ck, 0x0,
  */
 DEFINE_CLK_FIXED_FACTOR(clkdiv32k_ck, "clk_24mhz", &clk_24mhz, 0x0, 1, 732);

-DEFINE_CLK_GATE(clkdiv32k_ick, "clkdiv32k_ck", &clkdiv32k_ck, 0x0,
-		AM33XX_CM_PER_CLKDIV32K_CLKCTRL, AM33XX_MODULEMODE_SWCTRL_SHIFT,
-		0x0, NULL);
+static struct clk clkdiv32k_ick;
+
+static const char *clkdiv32k_ick_parent_names[] = {
+	"clkdiv32k_ck",
+};
+
+static const struct clk_ops clkdiv32k_ick_ops = {
+	.enable         = &omap2_dflt_clk_enable,
+	.disable        = &omap2_dflt_clk_disable,
+	.is_enabled     = &omap2_dflt_clk_is_enabled,
+	.init           = &omap2_init_clk_clkdm,
+};
+
+static struct clk_hw_omap clkdiv32k_ick_hw = {
+	.hw	= {
+		.clk	= &clkdiv32k_ick,
+	},
+	.enable_reg	= AM33XX_CM_PER_CLKDIV32K_CLKCTRL,
+	.enable_bit	= AM33XX_MODULEMODE_SWCTRL_SHIFT,
+	.clkdm_name	= "clk_24mhz_clkdm",
+};
+
+DEFINE_STRUCT_CLK(clkdiv32k_ick, clkdiv32k_ick_parent_names, clkdiv32k_ick_ops);

 /* "usbotg_fck" is an additional clock and not really a modulemode */
 DEFINE_CLK_GATE(usbotg_fck, "dpll_per_ck", &dpll_per_ck, 0x0,
--
1.7.0.4


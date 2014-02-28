From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 07/12] CLK: TI: interface: add support for omap2430 specific interface clock
Date: Fri, 28 Feb 2014 11:22:59 +0200
Message-ID: <1393579384-23440-8-git-send-email-t-kristo@ti.com>
References: <1393579384-23440-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40367 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495AbaB1JY2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Feb 2014 04:24:28 -0500
In-Reply-To: <1393579384-23440-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

OMAP2430 I2CHS modules require specific hardware ops to be used, so added
a new compatible string for this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/clock/ti/interface.txt     |    2 ++
 arch/arm/mach-omap2/clock.h                        |    1 -
 drivers/clk/ti/interface.c                         |    7 +++++++
 include/linux/clk/ti.h                             |    1 +
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/ti/interface.txt b/Documentation/devicetree/bindings/clock/ti/interface.txt
index 064e8ca..3111a40 100644
--- a/Documentation/devicetree/bindings/clock/ti/interface.txt
+++ b/Documentation/devicetree/bindings/clock/ti/interface.txt
@@ -21,6 +21,8 @@ Required properties:
   "ti,omap3-dss-interface-clock" - interface clock with DSS specific HW handling
   "ti,omap3-ssi-interface-clock" - interface clock with SSI specific HW handling
   "ti,am35xx-interface-clock" - interface clock with AM35xx specific HW handling
+  "ti,omap2430-interface-clock" - interface clock with OMAP2430 specific HW
+				  handling
 - #clock-cells : from common clock binding; shall be set to 0
 - clocks : link to phandle of parent clock
 - reg : base address for the control register
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 7b7a03c..bb67238 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -265,7 +265,6 @@ extern const struct clk_hw_omap_ops clkhwops_omap3430es2_hsotgusb_wait;
 extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait;
 extern const struct clk_hw_omap_ops clkhwops_apll54;
 extern const struct clk_hw_omap_ops clkhwops_apll96;
-extern const struct clk_hw_omap_ops clkhwops_omap2430_i2chs_wait;
 
 /* clksel_rate blocks shared between OMAP44xx and AM33xx */
 extern const struct clksel_rate div_1_0_rates[];
diff --git a/drivers/clk/ti/interface.c b/drivers/clk/ti/interface.c
index 320a2b1..4b1c336 100644
--- a/drivers/clk/ti/interface.c
+++ b/drivers/clk/ti/interface.c
@@ -123,3 +123,10 @@ static void __init of_ti_am35xx_interface_clk_setup(struct device_node *node)
 }
 CLK_OF_DECLARE(ti_am35xx_interface_clk, "ti,am35xx-interface-clock",
 	       of_ti_am35xx_interface_clk_setup);
+
+static void __init of_ti_omap2430_interface_clk_setup(struct device_node *node)
+{
+	_of_ti_interface_clk_setup(node, &clkhwops_omap2430_i2chs_wait);
+}
+CLK_OF_DECLARE(ti_omap2430_interface_clk, "ti,omap2430-interface-clock",
+	       of_ti_omap2430_interface_clk_setup);
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index ddac0d0..4a05d97 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -308,6 +308,7 @@ static inline void of_ti_clk_deny_autoidle_all(void) { }
 #endif
 
 extern const struct clk_hw_omap_ops clkhwops_omap2xxx_dpll;
+extern const struct clk_hw_omap_ops clkhwops_omap2430_i2chs_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
 extern const struct clk_hw_omap_ops clkhwops_wait;
-- 
1.7.9.5


From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: Query regarding clk framework - from .set_rate api
Date: Mon, 1 Apr 2013 10:30:13 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC3E7C3@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57931 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757526Ab3DAKaa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 06:30:30 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "mturquette@linaro.org" <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Hi Rajendra/Paul/Mike,

I am debugging the issue reported by Michal on AM33xx clock tree
In the context of LCDC driver functionality-

http://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg36102.html

Where, the clk_set_rate() seems to be not working, and that's true
with the current implementation of OMAP/AM33xx clock tree,
as the CLK_SET_RATE_PARENT flag is not set to any of the clock nodes.

Please note that I am using DEFINE_STRUCT_CLK() macro for defining clocks
And which doesn't allow you to specify the flags.

Below is the propagation scenario under discussion:

DISP_DPLL (dpll_disp_ck) ->>
     dpll_disp_m2_ck ->>
           lcd_clk_mux_sel ->>
                 lcd_gclk


Just to make sure that propagation works fine, I hacked the code and 
tested it on AM335x BeagleBone platform without any issues.

Can I create a patch modifying DEFINE_STRUCT_CLK() macro to take
Another argument '.flags" and change all clock-trees accrordingly??

Diff Starts here:
=====================

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 7baede1..51fc78b 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -11,6 +11,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/clk-private.h>
 #include <linux/io.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
@@ -100,6 +101,7 @@ exit:
 static void __init omap_generic_init(void)
 {
        struct device_node *np;
+       struct clk *clk;

        omap_sdrc_init(NULL, NULL);

@@ -115,6 +117,15 @@ static void __init omap_generic_init(void)

        if (of_machine_is_compatible("ti,omap5"))
                omap_sata_init();
+
+       clk = clk_get(NULL, "lcd_gclk");
+       if (IS_ERR(clk))
+               printk("Can not get lcd_gclk clock\n");
+
+       printk("%s:%d gclk_rate - %lu\n", __func__, __LINE__, clk_get_rate(clk));
+       clk_set_rate(clk, 300000000);
+       printk("%s:%d clk_rate - %lu\n", __func__, __LINE__, clk_get_rate(clk));
+       clk_put(clk);
 }

 #ifdef CONFIG_SOC_OMAP2420
diff --git a/arch/arm/mach-omap2/cclock33xx_data.c b/arch/arm/mach-omap2/cclock33xx_data.c
index e674e01..d4552db 100644
--- a/arch/arm/mach-omap2/cclock33xx_data.c
+++ b/arch/arm/mach-omap2/cclock33xx_data.c
@@ -284,7 +284,7 @@ DEFINE_STRUCT_CLK(dpll_disp_ck, dpll_core_ck_parents, dpll_ddr_ck_ops);
  * TODO: Add clksel here (sys_clkin, CORE_CLKOUTM6, PER_CLKOUTM2
  * and ALT_CLK1/2)
  */
-DEFINE_CLK_DIVIDER(dpll_disp_m2_ck, "dpll_disp_ck", &dpll_disp_ck, 0x0,
+DEFINE_CLK_DIVIDER(dpll_disp_m2_ck, "dpll_disp_ck", &dpll_disp_ck, CLK_SET_RATE_PARENT,
                   AM33XX_CM_DIV_M2_DPLL_DISP, AM33XX_DPLL_CLKOUT_DIV_SHIFT,
                   AM33XX_DPLL_CLKOUT_DIV_WIDTH, CLK_DIVIDER_ONE_BASED, NULL);

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 836311f..3830e5b 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -64,6 +64,7 @@ struct clockdomain;
                .parent_names = _parent_array_name,             \
                .num_parents = ARRAY_SIZE(_parent_array_name),  \
                .ops = &_clkops_name,                           \
+               .flags = CLK_SET_RATE_PARENT,                   \
        };

 #define DEFINE_STRUCT_CLK_HW_OMAP(_name, _clkdm_name)          \


Thanks,
Vaibhav


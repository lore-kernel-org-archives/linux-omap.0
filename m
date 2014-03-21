From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 0/4] clk: dt: add support for default rate/parent
Date: Fri, 21 Mar 2014 10:02:25 +0200
Message-ID: <532BF211.30203@ti.com>
References: <1392282048-6284-1-git-send-email-t-kristo@ti.com> <53172239.3030705@ti.com> <20140320212308.21989.36094@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53371 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755671AbaCUICw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Mar 2014 04:02:52 -0400
In-Reply-To: <20140320212308.21989.36094@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 03/20/2014 11:23 PM, Mike Turquette wrote:
> Quoting Tero Kristo (2014-03-05 05:10:17)
>> Ping.
>>
>> Mike, any feedback on this?
>
> Hi Tero,
>
> Have you seen Sylwester's approach[1]? I prefer it since it is more
> device-oriented and less "centralized". The clock consumer enumerates
> the default parent or rate of a consumed clock. This can be made to work
> like your approach by having the clock driver consume these clocks and
> set them up with default rates or parents. What do you think?

Just saw the patches yesterday. I think that approach would work in most 
cases, however I guess there might be cases where you need to setup the 
rate/parent of a clock very early in boot (basically when you are 
registering the clock itself) to avoid any race issues with drivers (or 
the clock framework itself) coming in and using a clock that is not 
properly setup yet. But well, I guess these can be handled by some init 
time tweaks.

I just converted the OMAP4 code to the format provided by Sylwester's 
patches and it seems to work fine. The patch should be changed 
eventually to probe at the time when the CM/PRM instances are probed. 
Inlined here as reference:

 From 1b05e03bbd3fb5a4f5192444e7d4365f177c1756 Mon Sep 17 00:00:00 2001
From: Tero Kristo <t-kristo@ti.com>
Date: Fri, 21 Mar 2014 09:52:47 +0200
Subject: [PATCH] CLK: TI: OMAP4: setup default clocks / rates using the 
clock
  consumer approach

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
  arch/arm/boot/dts/omap4.dtsi |    8 ++++++++
  drivers/clk/ti/clk-44xx.c    |   44 
------------------------------------------
  drivers/clk/ti/clk.c         |   41 
+++++++++++++++++++++++++++++++++++++++
  3 files changed, 49 insertions(+), 44 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index d3f8a6e..4826168 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -88,6 +88,14 @@
  		};
  	};

+	default-clocks {
+		compatible = "ti,default-clocks";
+		clocks = <&abe_dpll_refclk_mux_ck>, <&dpll_usb_ck>,
+			<&dpll_abe_ck>;
+		clock-parents = <&sys_32k_ck>;
+		clock-rates = <0>, <960000000>, <98304000>;
+	};
+
  	/*
  	 * XXX: Use a flat representation of the OMAP4 interconnect.
  	 * The real OMAP interconnect network is quite complex.
diff --git a/drivers/clk/ti/clk-44xx.c b/drivers/clk/ti/clk-44xx.c
index ae00218..dfafb96 100644
--- a/drivers/clk/ti/clk-44xx.c
+++ b/drivers/clk/ti/clk-44xx.c
@@ -16,21 +16,6 @@
  #include <linux/clkdev.h>
  #include <linux/clk/ti.h>

-/*
- * OMAP4 ABE DPLL default frequency. In OMAP4460 TRM version V, section
- * "3.6.3.2.3 CM1_ABE Clock Generator" states that the "DPLL_ABE_X2_CLK
- * must be set to 196.608 MHz" and hence, the DPLL locked frequency is
- * half of this value.
- */
-#define OMAP4_DPLL_ABE_DEFFREQ				98304000
-
-/*
- * OMAP4 USB DPLL default frequency. In OMAP4430 TRM version V, section
- * "3.6.3.9.5 DPLL_USB Preferred Settings" shows that the preferred
- * locked frequency for the USB DPLL is 960MHz.
- */
-#define OMAP4_DPLL_USB_DEFFREQ				960000000
-
  static struct ti_dt_clk omap44xx_clks[] = {
  	DT_CLK(NULL, "extalt_clkin_ck", "extalt_clkin_ck"),
  	DT_CLK(NULL, "pad_clks_src_ck", "pad_clks_src_ck"),
@@ -281,36 +266,7 @@ static struct ti_dt_clk omap44xx_clks[] = {

  int __init omap4xxx_dt_clk_init(void)
  {
-	int rc;
-	struct clk *abe_dpll_ref, *abe_dpll, *sys_32k_ck, *usb_dpll;
-
  	ti_dt_clocks_register(omap44xx_clks);
-
  	omap2_clk_disable_autoidle_all();
-
-	/*
-	 * Lock USB DPLL on OMAP4 devices so that the L3INIT power
-	 * domain can transition to retention state when not in use.
-	 */
-	usb_dpll = clk_get_sys(NULL, "dpll_usb_ck");
-	rc = clk_set_rate(usb_dpll, OMAP4_DPLL_USB_DEFFREQ);
-	if (rc)
-		pr_err("%s: failed to configure USB DPLL!\n", __func__);
-
-	/*
-	 * On OMAP4460 the ABE DPLL fails to turn on if in idle low-power
-	 * state when turning the ABE clock domain. Workaround this by
-	 * locking the ABE DPLL on boot.
-	 * Lock the ABE DPLL in any case to avoid issues with audio.
-	 */
-	abe_dpll_ref = clk_get_sys(NULL, "abe_dpll_refclk_mux_ck");
-	sys_32k_ck = clk_get_sys(NULL, "sys_32k_ck");
-	rc = clk_set_parent(abe_dpll_ref, sys_32k_ck);
-	abe_dpll = clk_get_sys(NULL, "dpll_abe_ck");
-	if (!rc)
-		rc = clk_set_rate(abe_dpll, OMAP4_DPLL_ABE_DEFFREQ);
-	if (rc)
-		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
-
  	return 0;
  }
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index b1a6f71..469fd4e 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -21,6 +21,8 @@
  #include <linux/of.h>
  #include <linux/of_address.h>
  #include <linux/list.h>
+#include <linux/of_platform.h>
+#include <linux/module.h>

  #undef pr_fmt
  #define pr_fmt(fmt) "%s: " fmt, __func__
@@ -165,3 +167,41 @@ void ti_dt_clk_init_provider(struct device_node 
*parent, int index)
  		kfree(retry);
  	}
  }
+
+static int ti_clk_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int ti_clk_remove(struct platform_device *dev)
+{
+	return 0;
+}
+
+static const struct of_device_id ti_clk_match[] = {
+	{ .compatible = "ti,default-clocks" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ti_clk_match);
+
+static struct platform_driver ti_clk_driver = {
+	.probe		= ti_clk_probe,
+	.remove		= ti_clk_remove,
+	.driver		= {
+		.name	= "ti-clk",
+		.of_match_table = of_match_ptr(ti_clk_match),
+	},
+};
+
+static int __init ti_clk_init(void)
+{
+	return platform_driver_register(&ti_clk_driver);
+}
+
+static void __exit ti_clk_exit(void)
+{
+	platform_driver_unregister(&ti_clk_driver);
+}
+
+module_init(ti_clk_init);
+module_exit(ti_clk_exit);
-- 
1.7.9.5

From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 4/4] clk: ti: omap4: set default-parents and default-rates using DT
Date: Thu, 13 Feb 2014 11:00:48 +0200
Message-ID: <1392282048-6284-5-git-send-email-t-kristo@ti.com>
References: <1392282048-6284-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34518 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475AbaBMJBh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Feb 2014 04:01:37 -0500
In-Reply-To: <1392282048-6284-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Setup dpll_usb_ck and dpll_abe_ck using DT properties instead of hardcoding
the parents and rates in kernel.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |   12 ++++++++++++
 drivers/clk/ti/clk-44xx.c    |   42 ------------------------------------------
 2 files changed, 12 insertions(+), 42 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index d3f8a6e..282ce66 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -761,3 +761,15 @@
 };
 
 /include/ "omap44xx-clocks.dtsi"
+
+&dpll_usb_ck {
+	default-rate = <960000000>;
+};
+
+&dpll_abe_ck {
+	default-rate = <98304000>;
+};
+
+&abe_dpll_refclk_mux_ck {
+	ti,default-parent = <&sys_32k_ck>;
+};
diff --git a/drivers/clk/ti/clk-44xx.c b/drivers/clk/ti/clk-44xx.c
index ae00218..bc14a49 100644
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
@@ -281,36 +266,9 @@ static struct ti_dt_clk omap44xx_clks[] = {
 
 int __init omap4xxx_dt_clk_init(void)
 {
-	int rc;
-	struct clk *abe_dpll_ref, *abe_dpll, *sys_32k_ck, *usb_dpll;
-
 	ti_dt_clocks_register(omap44xx_clks);
 
 	omap2_clk_disable_autoidle_all();
 
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
-- 
1.7.9.5


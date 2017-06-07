From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/6] ARM: dts: omap44xx-clocks: Set IVA DPLL and its output clock rates
Date: Wed, 7 Jun 2017 16:27:25 -0500
Message-ID: <20170607212730.33002-2-s-anna@ti.com>
References: <20170607212730.33002-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170607212730.33002-1-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Subhajit Paul <subhajit_paul-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The IVA DPLL is not an essential DPLL for the functionality of a
bootloader and is usually not configured (e.g. older u-boots configure
it only if CONFIG_SYS_CLOCKS_ENABLE_ALL is enabled and u-boots newer
than 2014.01 do not even have an option), and this results in incorrect
operating frequencies when trying to use a DSP or IVAHD, whose root
clocks are derived from this DPLL. Use the DT standard properties
"assigned-clocks" and "assigned-clock-rates" to set the IVA DPLL clock
rate and the rates for its derivative clocks at boot time to properly
initialize/lock this DPLL. The DPLL will automatically transition
into a low-power stop mode when the associated output clocks are
not utilized or gated automatically.

The reset values of the dividers M4 & M5 (functional clocks for DSP and
IVAHD respectively) are identical to each other, but are different at
each OPP. The reset values also do not match a specific OPP. So, the
derived output clocks from the IVA DPLL have to be initialized as well
to avoid initializing these divider outputs to incorrect frequencies.

The clock rates are chosen based on the OPP100 values as defined in the
OMAP4430 ES2.x Public TRM vAP, section "3.6.3.8.7 DPLL_IVA Preferred
Settings". The DPLL locked frequency is 1862.4 MHz (value for
DPLL_IVA_X2_CLK), so the dpll_iva_ck clock rate used is half of
this value.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap44xx-clocks.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap44xx-clocks.dtsi b/arch/arm/boot/dts/omap44xx-clocks.dtsi
index 9573b37fbaa7..9cb205b87835 100644
--- a/arch/arm/boot/dts/omap44xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap44xx-clocks.dtsi
@@ -357,6 +357,8 @@
 		compatible = "ti,omap4-dpll-clock";
 		clocks = <&sys_clkin_ck>, <&iva_hsd_byp_clk_mux_ck>;
 		reg = <0x01a0>, <0x01a4>, <0x01ac>, <0x01a8>;
+		assigned-clocks = <&dpll_iva_ck>;
+		assigned-clock-rates = <931200000>;
 	};
 
 	dpll_iva_x2_ck: dpll_iva_x2_ck {
@@ -374,6 +376,8 @@
 		reg = <0x01b8>;
 		ti,index-starts-at-one;
 		ti,invert-autoidle-bit;
+		assigned-clocks = <&dpll_iva_m4x2_ck>;
+		assigned-clock-rates = <465600000>;
 	};
 
 	dpll_iva_m5x2_ck: dpll_iva_m5x2_ck@1bc {
@@ -385,6 +389,8 @@
 		reg = <0x01bc>;
 		ti,index-starts-at-one;
 		ti,invert-autoidle-bit;
+		assigned-clocks = <&dpll_iva_m5x2_ck>;
+		assigned-clock-rates = <266100000>;
 	};
 
 	dpll_mpu_ck: dpll_mpu_ck@160 {
-- 
2.12.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
